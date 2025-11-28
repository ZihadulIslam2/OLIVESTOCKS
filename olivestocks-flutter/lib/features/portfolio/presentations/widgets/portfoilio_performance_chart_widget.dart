import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import '../../domains/performance_response_model.dart';

class PortfolioPerformanceChart extends StatelessWidget {
  final PerformanceChart? performanceChart;

  const PortfolioPerformanceChart({
    super.key,
    required this.performanceChart,
  });

  @override
  Widget build(BuildContext context) {
    if (performanceChart == null ||
        performanceChart!.datasets == null ||
        performanceChart!.labels == null) {
      return const SizedBox.shrink();
    }

    final labels = performanceChart!.labels!;
    final datasets = performanceChart!.datasets!;

    List<FlSpot> toSpots(List<double> data) {
      return List.generate(data.length, (i) => FlSpot(i.toDouble(), data[i]));
    }

    final List<FlSpot> portfolioSpots = toSpots(
        datasets.firstWhere((e) => e.label == "My Portfolio").data ?? []);
    final List<FlSpot> sp500Spots =
    toSpots(datasets.firstWhere((e) => e.label == "S&P 500").data ?? []);

    final double? portfolioLast =
    portfolioSpots.isNotEmpty ? portfolioSpots.last.y : null;
    final double? sp500Last = sp500Spots.isNotEmpty ? sp500Spots.last.y : null;

    final allSpots = [...portfolioSpots, ...sp500Spots];

    return Card(
      color: Colors.white,
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Row(
              children: [
                Text(
                  'Portfolio Performance',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _legendItem(
                  label: "My Portfolio",
                  color: Colors.red,
                  value: "${portfolioLast?.toStringAsFixed(2) ?? '--'}%",
                  icon: portfolioLast != null && portfolioLast < 0
                      ? Icons.arrow_drop_down
                      : Icons.arrow_drop_up,
                ),
                const SizedBox(width: 12),
                _legendItem(
                  label: "S&P 500",
                  color: Colors.green,
                  value: "${sp500Last?.toStringAsFixed(2) ?? '--'}%",
                  icon: sp500Last != null && sp500Last < 0
                      ? Icons.arrow_drop_down
                      : Icons.arrow_drop_up,
                ),
              ],
            ),
            const SizedBox(height: 24),

            if (portfolioSpots.length < 2 || sp500Spots.length < 2)
              const Text(
                'Not enough data to display chart.',
                style: TextStyle(color: Colors.grey),
              )
            else
              AspectRatio(
                aspectRatio: 1.5,
                child: LineChart(
                  LineChartData(
                    minY: allSpots.map((e) => e.y).reduce(min) - 5,
                    maxY: allSpots.map((e) => e.y).reduce(max) + 5,
                    lineBarsData: [
                      LineChartBarData(
                        spots: portfolioSpots,
                        isCurved: true,
                        color: Colors.red,
                        dotData: FlDotData(show: false),
                        belowBarData: BarAreaData(show: false),
                        barWidth: 2,
                      ),
                      LineChartBarData(
                        spots: sp500Spots,
                        isCurved: true,
                        color: Colors.green,
                        dotData: FlDotData(show: false),
                        belowBarData: BarAreaData(show: false),
                        barWidth: 2,
                      ),
                    ],
                    titlesData: FlTitlesData(
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          interval: 1,
                          getTitlesWidget: (value, _) =>
                              _bottomTitle(value, labels),
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          interval: 10,
                          reservedSize: 30,
                          getTitlesWidget: (value, _) => Text(
                            "${value.toStringAsFixed(0)}%",
                            style: const TextStyle(fontSize: 10),
                          ),
                        ),
                      ),
                      rightTitles:
                      AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      topTitles:
                      AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    ),
                    gridData: FlGridData(show: false),
                    borderData: FlBorderData(
                      show: true,
                      border: const Border(
                        left: BorderSide(),
                        bottom: BorderSide(),
                      ),
                    ),
                    extraLinesData: ExtraLinesData(horizontalLines: [
                      HorizontalLine(
                        y: 0.0,
                        color: Colors.grey.shade500,
                        dashArray: [5, 5],
                        strokeWidth: 1,
                      ),
                    ]),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  static Widget _legendItem({
    required String label,
    required Color color,
    required String value,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          Text(label, style: const TextStyle(fontSize: 10)),
          const SizedBox(width: 6),
          Icon(icon, size: 15, color: color),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 10,
              color: color,
            ),
          )
        ],
      ),
    );
  }

  static Widget _bottomTitle(double value, List<String> labels) {
    if (value.toInt() >= 0 && value.toInt() < labels.length) {
      return Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Text(
          labels[value.toInt()],
          style: const TextStyle(fontSize: 8),
        ),
      );
    }
    return const Text('');
  }
}
