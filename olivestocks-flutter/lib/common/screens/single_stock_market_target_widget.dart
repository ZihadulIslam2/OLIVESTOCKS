import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../features/portfolio/controller/portfolio_controller.dart';

class SingleStockMarketTargetWidget extends StatefulWidget {
  final String symbol;

  const SingleStockMarketTargetWidget({super.key, required this.symbol});

  @override
  State<SingleStockMarketTargetWidget> createState() => _SingleStockMarketTargetWidgetState();
}

class _SingleStockMarketTargetWidgetState extends State<SingleStockMarketTargetWidget> {
  @override
  void initState() {
    Get.find<PortfolioController>().getTargetChart(widget.symbol);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PortfolioController>(
      builder: (portfolioController) {
        return !portfolioController.isTargetChartLoading
            ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDonutChart(),
            SizedBox(height: 20),
            _buildForecastBox(),
            SizedBox(height: 20),
            _buildForecastChart(),
          ],
        )
            : Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _buildDonutChart() {
    final analysts = Get.find<PortfolioController>().targetChartResponseModel!.analysts;

    final int buy = analysts?.buy ?? 0;
    final int hold = analysts?.hold ?? 0;
    final int sell = analysts?.sell ?? 0;
    final int total = analysts?.total ?? (buy + hold + sell);

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text('Analyst Ratings', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          SizedBox(
            height: 150,
            child: PieChart(
              PieChartData(
                centerSpaceRadius: 40,
                sectionsSpace: 2,
                sections: [
                  PieChartSectionData(value: buy.toDouble(), color: Colors.green, radius: 20, showTitle: false),
                  PieChartSectionData(value: hold.toDouble(), color: Colors.grey, radius: 20, showTitle: false),
                  PieChartSectionData(value: sell.toDouble(), color: Colors.red, radius: 20, showTitle: false),
                ],
              ),
            ),
          ),
          SizedBox(height: 4),
          Text('$total\nRatings', textAlign: TextAlign.center),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _legendIndicator(Colors.green, '$buy Buy'),
              _legendIndicator(Colors.grey, '$hold Hold'),
              _legendIndicator(Colors.red, '$sell Sell'),
            ],
          )
        ],
      ),
    );
  }

  Widget _legendIndicator(Color color, String text) {
    return Row(
      children: [
        Container(width: 10, height: 10, color: color),
        SizedBox(width: 6),
        Text(text),
      ],
    );
  }

  Widget _buildForecastBox() {
    final target = Get.find<PortfolioController>().targetChartResponseModel;

    final String? high = target!.targets!.high.toString();
    final String? mean = target.targets!.average.toString();
    final String? low = target.targets!.low.toString();

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${target.currentPrice}', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green)),
          Row(
            children: [
              Text('(▲${target.upside.toString()})', style: TextStyle(color: Colors.green, fontWeight: FontWeight.w500, fontSize: 16)),
            ],
          ),
          SizedBox(height: 8),
          Text(
            "Target price ranges based on analysts' predictions.",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }

  Widget _buildForecastChart() {
    final target = Get.find<PortfolioController>().targetChartResponseModel;
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('Past 12 Months',
                  style: TextStyle(
                      color: Colors.black.withOpacity(.7),
                      fontSize: 16,
                      fontWeight: FontWeight.w500)),
              Text('12 Month Forecast',
                  style: TextStyle(
                      color: Colors.black.withOpacity(.7),
                      fontSize: 16,
                      fontWeight: FontWeight.w500)),
            ],
          ),
          SizedBox(height: 20),
          SizedBox(height: 200, child: _chart()),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _labelWithColor('High ${target!.targets!.high}', Colors.green),
              _labelWithColor('Average ${target.targets!.average}', Colors.grey),
              _labelWithColor('Low ${target.targets!.low}', Colors.red),
            ],
          )
        ],
      ),
    );
  }

  Widget _labelWithColor(String label, Color color) {
    return Row(
      children: [
        Icon(Icons.circle, color: color, size: 8),
        SizedBox(width: 4),
        Text(label, style: TextStyle(fontSize: 12)),
      ],
    );
  }

  Widget _chart() {
    final target = Get.find<PortfolioController>().targetChartResponseModel;
    final labels = target!.chart?.labels ?? [];
    final pastPrices = target.chart?.pastPrices ?? [];
    final forecast = target.chart?.forecast;

    // Past 13 months
    List<FlSpot> pastSpots = List.generate(
      pastPrices.length,
          (i) => FlSpot(i.toDouble(), pastPrices[i]),
    );

    // Forecast data (next 12 months)
    List<FlSpot> avgSpots = [];
    List<FlSpot> highSpots = [];
    List<FlSpot> lowSpots = [];

    if (forecast != null) {
      for (int i = 1; i < forecast.average!.length; i++) {
        final x = (pastPrices.length - 1 + i).toDouble();
        avgSpots.add(FlSpot(x, double.parse(forecast.average![i])));
        highSpots.add(FlSpot(x, double.parse(forecast.high![i])));
        lowSpots.add(FlSpot(x, double.parse(forecast.low![i])));
      }
    }

    return LineChart(
      LineChartData(
        gridData: FlGridData(show: true),
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 1,
              reservedSize: 30, // Add reserved space for labels
              getTitlesWidget: (value, meta) {
                int index = value.toInt();
                if (index < 0 || index >= labels.length) return const SizedBox.shrink();

                // Show only every nth label if there are too many
                if (labels.length > 12 && index % 2 != 0) return const SizedBox.shrink();

                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Transform.rotate(
                    angle: -45 * (3.141592653589793 / 180), // -45 degrees in radians
                    child: Text(
                      labels[index],
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.black,
                      ),
                      overflow: TextOverflow.visible,
                      textAlign: TextAlign.right,
                    ),
                  ),
                );
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              getTitlesWidget: (value, meta) {
                return Text(value.toStringAsFixed(0));
              },
            ),
          ),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        lineBarsData: [
          LineChartBarData(
            spots: pastSpots,
            isCurved: true,
            color: Colors.blue,
            barWidth: 2,
            dotData: FlDotData(show: false),
          ),
          LineChartBarData(
            spots: highSpots,
            isCurved: true,
            color: Colors.green,
            barWidth: 2,
            dashArray: [6, 3],
            dotData: FlDotData(show: false),
          ),
          LineChartBarData(
            spots: avgSpots,
            isCurved: true,
            color: Colors.grey,
            barWidth: 2,
            dashArray: [6, 3],
            dotData: FlDotData(show: false),
          ),
          LineChartBarData(
            spots: lowSpots,
            isCurved: true,
            color: Colors.red,
            barWidth: 2,
            dashArray: [6, 3],
            dotData: FlDotData(show: false),
          ),
        ],
      ),
    );
  }
}
