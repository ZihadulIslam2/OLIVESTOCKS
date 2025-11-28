import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import '../../features/portfolio/domains/price_chart_response_model.dart';

class StockChartWidget extends StatefulWidget {
  final PriceChartResponseModel data;

  const StockChartWidget({super.key, required this.data});

  @override
  _StockChartWidgetState createState() => _StockChartWidgetState();
}

class _StockChartWidgetState extends State<StockChartWidget> {
  String selectedRange = "1D";

  List<Chart> filterChartData(String range) {
    final allData = widget.data.data?.chart ?? [];
    if (allData.isEmpty) return [];

    final now = DateTime.now();
    late DateTime startTime;

    switch (range) {
      case '1D':
        startTime = now.subtract(const Duration(days: 1));
        break;
      case '5D':
        startTime = now.subtract(const Duration(days: 5));
        break;
      case '1M':
        startTime = DateTime(now.year, now.month - 1, 1);
        break;
      case '6M':
        startTime = DateTime(now.year, now.month - 6, now.day);
        break;
      case 'YTD':
        startTime = DateTime(now.year, 1, 1);
        break;
      default:
        return allData;
    }

    return allData
        .where((e) => DateTime.fromMillisecondsSinceEpoch(e.time ?? 0).isAfter(startTime))
        .toList();
  }

  double _getIntervalForRange(String selectedRange, int length) {
    switch (selectedRange) {
      case '1D':
      case '5D':
      case '6M':
      case 'YTD':
        return (length / 5).floorToDouble().clamp(1, double.infinity);
      case '1M':
        return (length - 1).toDouble();
      default:
        return (length / 5).floorToDouble().clamp(1, double.infinity);
    }
  }

  List<FlSpot> generatePriceSpots(List<Chart> chartData) {
    return chartData
        .asMap()
        .entries
        .map((entry) => FlSpot(entry.key.toDouble(), entry.value.close?.toDouble() ?? 0.0))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    List<Chart> allData = widget.data.data?.chart ?? [];
    List<Chart> filteredData = filterChartData(selectedRange);
    if (filteredData.isEmpty && allData.isNotEmpty) {
      filteredData = allData;
    }

    List<FlSpot> priceSpots = generatePriceSpots(filteredData);
    Size size = MediaQuery.of(context).size;

    if (filteredData.isEmpty || priceSpots.isEmpty) {
      return const Center(child: Text("No data available for this range"));
    }

    double minY = priceSpots.map((e) => e.y).reduce((a, b) => a < b ? a : b);
    double maxY = priceSpots.map((e) => e.y).reduce((a, b) => a > b ? a : b);
    if (minY == maxY) {
      minY -= 5;
      maxY += 5;
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: Row(
            children: [
              _RangeTab("1D", isSelected: selectedRange == "1D", onTap: () => setState(() => selectedRange = "1D")),
              _RangeTab("5D", isSelected: selectedRange == "5D", onTap: () => setState(() => selectedRange = "5D")),
              _RangeTab("1M", isSelected: selectedRange == "1M", onTap: () => setState(() => selectedRange = "1M")),
              _RangeTab("6M", isSelected: selectedRange == "6M", onTap: () => setState(() => selectedRange = "6M")),
              _RangeTab("YTD", isSelected: selectedRange == "YTD", onTap: () => setState(() => selectedRange = "YTD")),
              _RangeTab("More", icon: Icons.arrow_drop_down),
            ],
          ),
        ),
        SizedBox(
          height: 250,
          child: LineChart(
            LineChartData(
              minY: minY,
              maxY: maxY,
              lineTouchData: LineTouchData(
                enabled: true,
                touchTooltipData: LineTouchTooltipData(
                  getTooltipItems: (touchedSpots) {
                    return touchedSpots.map((LineBarSpot spot) {
                      return LineTooltipItem(
                        'Price: \$${spot.y.toStringAsFixed(2)}',
                        const TextStyle(color: Colors.white),
                      );
                    }).toList();
                  },
                ),
              ),
              gridData: FlGridData(show: false),
              titlesData: FlTitlesData(
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 40,
                    getTitlesWidget: (value, meta) => Text(value.toInt().toString(), style: const TextStyle(fontSize: 12)),
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: _getIntervalForRange(selectedRange, filteredData.length),
                    getTitlesWidget: (value, meta) {
                      int index = value.toInt();
                      if (index < 0 || index >= filteredData.length) return const SizedBox.shrink();

                      final time = DateTime.fromMillisecondsSinceEpoch(filteredData[index].time!);
                      final isFirst = index == 0;
                      final isLast = index == filteredData.length - 1;
                      String formatted;

                      switch (selectedRange) {
                        case '1D':
                          formatted = DateFormat('ha').format(time);
                          break;
                        case '5D':
                          formatted = DateFormat('MMM d').format(time);
                          break;
                        case '1M':
                          formatted = (isFirst || isLast) ? DateFormat('d MMM').format(time) : '';
                          break;
                        case '6M':
                          int interval = (filteredData.length / 5).floor();
                          formatted = (index % interval == 0 || isFirst || isLast) ? DateFormat('MMM yyyy').format(time) : '';
                          break;
                        case 'YTD':
                          int interval = (filteredData.length / 5).floor();
                          formatted = (index % interval == 0 || isFirst || isLast) ? DateFormat('d MMM').format(time) : '';
                          break;
                        default:
                          formatted = DateFormat('yyyy').format(time);
                          break;
                      }

                      return SideTitleWidget(
                        space: 9,
                        meta: meta,
                        child: formatted.isNotEmpty
                            ? Transform.rotate(
                          angle: -0.5,
                          alignment: Alignment.topLeft,
                          child: Text(formatted, style: const TextStyle(fontSize: 10), textAlign: TextAlign.left),
                        )
                            : SizedBox.shrink(),
                      );
                    },
                  ),
                ),
                rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              ),
              borderData: FlBorderData(show: false),
              lineBarsData: [
                LineChartBarData(
                  spots: priceSpots,
                  isCurved: false,
                  color: Colors.green,
                  barWidth: 2,
                  belowBarData: BarAreaData(
                    show: true,
                    color: Colors.green.withOpacity(0.3),
                  ),
                  dotData: FlDotData(show: false),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.0),
          child: Divider(thickness: 2),
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _InfoColumn("Open", filteredData.last.open.toString()),
              _InfoColumn("High", filteredData.last.high.toString()),
              _InfoColumn("Low", filteredData.last.low.toString()),
            ],
          ),
        ),
      ],
    );
  }
}

Widget _RangeTab(String label, {bool isSelected = false, IconData? icon, VoidCallback? onTap}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 4),
    child: GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? Colors.green.withOpacity(0.1) : null,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          children: [
            if (icon != null) Icon(icon, size: 16),
            if (icon != null) const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? Colors.green : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _InfoColumn(String title, String value) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(title, style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 16)),
      const SizedBox(height: 8),
      Text(
        value,
        style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 16, color: Colors.black54),
      ),
    ],
  );
}
