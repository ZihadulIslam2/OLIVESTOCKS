import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import '../../features/portfolio/controller/portfolio_controller.dart';

class CashFlowChartWidget extends StatefulWidget {
  final String symbol;

  const CashFlowChartWidget({super.key, required this.symbol});

  @override
  State<CashFlowChartWidget> createState() => _CashFlowChartWidgetState();
}

class _CashFlowChartWidgetState extends State<CashFlowChartWidget> {
  @override
  void initState() {
    Get.find<PortfolioController>().getCashFlowChart(widget.symbol);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PortfolioController>(builder: (portfolioController) {
      final cashFlows = portfolioController.cashFlowChartResponseModel!.cashFlows;

      if (cashFlows == null || cashFlows.isEmpty) {
        return const Center(child: Text("No data available"));
      }

      final sortedCashFlows = List.from(cashFlows)
        ..sort((a, b) => a.year!.compareTo(b.year!));

      final recentCashFlows = sortedCashFlows.length > 10
          ? sortedCashFlows.sublist(sortedCashFlows.length - 10)
          : sortedCashFlows;

      final latestYear = recentCashFlows.last;
      final totalCashFlow = latestYear.operatingCashFlow! +
          latestYear.investingCashFlow!.toDouble() +
          latestYear.financingCashFlow!.toDouble();

      final gaugeValue = latestYear.operatingCashFlow! /
          (latestYear.operatingCashFlow!.abs() +
              latestYear.investingCashFlow!.abs() +
              latestYear.financingCashFlow!.abs());

      return !portfolioController.isCashFlowChartLoading
          ? Column(
        children: [
          // Bar Chart
          SizedBox(
            height: 300,
            child: BarChart(
              BarChartData(
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 60, // Increased space for labels
                      interval: calculateInterval(recentCashFlows),
                      getTitlesWidget: (double value, TitleMeta meta) {
                        final text = formatNumber(value);
                        return Text(
                          text,
                          style: const TextStyle(
                              fontSize: 12, color: Colors.black54),
                          textAlign: TextAlign.right,
                        );
                      },
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 1,
                      getTitlesWidget: (double value, TitleMeta meta) {
                        final index = value.toInt();
                        if (index < 0 || index >= recentCashFlows.length) {
                          return const SizedBox();
                        }
                        return Padding(
                          padding: const EdgeInsets.only(top: 6.0),
                          child: Text(
                            '${recentCashFlows[index].year}',
                            style: const TextStyle(fontSize: 10),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                barGroups: recentCashFlows.asMap().entries.map((entry) {
                  final index = entry.key;
                  final data = entry.value;

                  return BarChartGroupData(x: index, barRods: [
                    BarChartRodData(
                      toY: data.operatingCashFlow!,
                      color: Colors.green,
                      width: 15,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ]);
                }).toList(),
                gridData: FlGridData(show: false),
                borderData: FlBorderData(show: false),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Animated Gauge + Texts
          Column(
            children: [
              const Text(
                'Operating Cash Flow Health',
                style:
                TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              AnimatedGauge(gaugeValue: gaugeValue),
              Text(
                "Latest Year: ${latestYear.year}",
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
              Text(
                "Operating: \$${(latestYear.operatingCashFlow! / 1000).toStringAsFixed(2)}B",
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text(
                "Total Cash Flow: \$${(totalCashFlow / 1000).toStringAsFixed(2)}B",
                style: const TextStyle(fontSize: 14),
              ),
            ],
          )
        ],
      )
          : const Center(child: CircularProgressIndicator());
    });

  }

  // Helper to format big numbers with suffixes
  String formatNumber(double value) {
    if (value.abs() >= 1e9) {
      return '${(value / 1e9).toStringAsFixed(1)}B';
    } else if (value.abs() >= 1e6) {
      return '${(value / 1e6).toStringAsFixed(1)}M';
    } else if (value.abs() >= 1e3) {
      return '${(value / 1e3).toStringAsFixed(1)}K';
    }
    return value.toStringAsFixed(0);
  }

  // Calculate interval for left axis labels based on max value
  double calculateInterval(List recentCashFlows) {
    final maxVal = recentCashFlows
        .map((e) => e.operatingCashFlow!.abs())
        .reduce((a, b) => a > b ? a : b);
    return (maxVal / 4).ceilToDouble();
  }
}

// Animated Gauge Widget
class AnimatedGauge extends StatefulWidget {
  final double gaugeValue;

  const AnimatedGauge({Key? key, required this.gaugeValue}) : super(key: key);

  @override
  State<AnimatedGauge> createState() => _AnimatedGaugeState();
}

class _AnimatedGaugeState extends State<AnimatedGauge> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _needleAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _needleAnimation = Tween<double>(begin: 0, end: widget.gaugeValue).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutCubic,
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _needleAnimation,
      builder: (context, child) {
        return SizedBox(
          height: 200,
          child: SfRadialGauge(
            axes: <RadialAxis>[
              RadialAxis(
                minimum: 0,
                maximum: 1,
                pointers: <GaugePointer>[
                  NeedlePointer(value: _needleAnimation.value),
                ],
                ranges: <GaugeRange>[
                  GaugeRange(startValue: 0, endValue: 0.33, color: Colors.red),
                  GaugeRange(startValue: 0.33, endValue: 0.66, color: Colors.yellow),
                  GaugeRange(startValue: 0.66, endValue: 1, color: Colors.green),
                ],
                annotations: <GaugeAnnotation>[
                  GaugeAnnotation(
                    widget: Text(
                      '${(_needleAnimation.value * 100).toStringAsFixed(1)}%',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    angle: 90,
                    positionFactor: 0.5,
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

}
