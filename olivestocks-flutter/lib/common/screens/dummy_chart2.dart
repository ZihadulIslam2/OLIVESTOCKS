import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../features/portfolio/controller/portfolio_controller.dart';
import '../../features/portfolio/domains/revenue_chart_response_model.dart';

class RevenueBarChart extends StatefulWidget {
  final String symbol;

  const RevenueBarChart({super.key, required this.symbol});

  @override
  State<RevenueBarChart> createState() => _RevenueBarChartState();
}

class _RevenueBarChartState extends State<RevenueBarChart> {
  List<RevenueChartResponseModel> revenueChartData = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => isLoading = true);
    Get.find<PortfolioController>().parseRevenueChartData(widget.symbol);
    revenueChartData = await Get.find<PortfolioController>().revenueChartData;
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    // if (isLoading) {
    //   return _buildLoadingState();
    // }
    if (Get.find<PortfolioController>().revenueChartData.isEmpty) {
      return _buildEmptyState();
    }
    return _buildChart(Get.find<PortfolioController>().revenueChartData);
  }


  Widget _buildEmptyState() {
    return const Center(
      child: Text(
        'No revenue data available for this symbol.',
        style: TextStyle(fontSize: 16),
      ),
    );
  }

  Widget _buildChart(List<RevenueChartResponseModel> data) {
    final displayedData = data.take(8).toList().reversed.toList();
    final size = MediaQuery.of(context).size;

    // Prepare chart data
    final periods = displayedData.map((e) {
      final date = DateTime.parse(e.period);
      return 'Q${e.quarter} ${date.year}';
    }).toList();
    final actualValues = displayedData.map((e) => e.actual).toList();
    final estimateValues = displayedData.map((e) => e.estimate).toList();
    final maxY = _calculateMaxY(actualValues, estimateValues);

    return Column(
      children: [
        _buildHeader(size),
        _buildBarChart(displayedData, periods, actualValues, estimateValues, maxY),
        _buildLegend(),
      ],
    );
  }

  Widget _buildHeader(Size size) {
    return Container(
      height: size.height * .06,
      width: size.width,
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
              'Revenue History',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)
          ),
          Text(
              'Last 8 quarters',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)
          ),
        ],
      ),
    );
  }

  Widget _buildBarChart(
      List<RevenueChartResponseModel> displayedData,
      List<String> periods,
      List<double> actualValues,
      List<double> estimateValues,
      double maxY,
      ) {
    return AspectRatio(
      aspectRatio: 1.5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BarChart(
          BarChartData(
            maxY: maxY,
            minY: 0,
            barGroups: _buildBarGroups(displayedData, actualValues, estimateValues),
            titlesData: _buildTitlesData(periods, maxY),
            gridData: FlGridData(
              show: true,
              horizontalInterval: maxY / 5,
              drawVerticalLine: false,
            ),
            borderData: FlBorderData(show: false),
            barTouchData: _buildBarTouchData(displayedData),
          ),
        ),
      ),
    );
  }

  List<BarChartGroupData> _buildBarGroups(
      List<RevenueChartResponseModel> displayedData,
      List<double> actualValues,
      List<double> estimateValues,
      ) {
    return List.generate(displayedData.length, (i) {
      return BarChartGroupData(
        x: i,
        barsSpace: 8,
        barRods: [
          BarChartRodData(
            toY: estimateValues[i],
            color: Colors.grey[400]!,
            width: 12,
            borderRadius: BorderRadius.circular(2),
          ),
          BarChartRodData(
            toY: actualValues[i],
            color: _getBarColor(displayedData[i].surprisePercent),
            width: 12,
            borderRadius: BorderRadius.circular(2),
          ),
        ],
      );
    });
  }

  FlTitlesData _buildTitlesData(List<String> periods, double maxY) {
    return FlTitlesData(
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          reservedSize: 40,
          showTitles: true,
          getTitlesWidget: (value, _) => Text(
            '${value.toStringAsFixed(value == maxY ? 0 : 1)}B',
            style: const TextStyle(fontSize: 10),
          ),
        ),
      ),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          getTitlesWidget: (value, _) {
            final index = value.toInt();
            return index < periods.length
                ? Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                periods[index],
                style: const TextStyle(fontSize: 10),
              ),
            )
                : const SizedBox.shrink();
          },
        ),
      ),
      topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
      rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
    );
  }

  BarTouchData _buildBarTouchData(List<RevenueChartResponseModel> displayedData) {
    return BarTouchData(
      enabled: true,
      touchTooltipData: BarTouchTooltipData(
        getTooltipColor: (_) => Colors.black87,
        tooltipMargin: 8,
        getTooltipItem: (group, groupIndex, rod, rodIndex) {
          final data = displayedData[groupIndex];
          final isEstimate = rodIndex == 0;
          return BarTooltipItem(
            isEstimate
                ? 'Estimate: ${data.estimate.toStringAsFixed(2)}B\n'
                : 'Actual: ${data.actual.toStringAsFixed(2)}B\n'
                'Surprise: ${data.surprisePercent.toStringAsFixed(2)}%',
            const TextStyle(color: Colors.white),
          );
        },
      ),
    );
  }

  Widget _buildLegend() {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildLegendItem(Colors.green, 'Beat Estimate'),
          const SizedBox(width: 20),
          _buildLegendItem(Colors.red, 'Missed Estimate'),
          const SizedBox(width: 20),
          _buildLegendItem(Colors.grey[400]!, 'Estimate'),
        ],
      ),
    );
  }

  Widget _buildLegendItem(Color color, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          color: color,
        ),
        const SizedBox(width: 4),
        Text(text, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  double _calculateMaxY(List<double> actualValues, List<double> estimateValues) {
    final maxActual = actualValues.isEmpty ? 0 : actualValues.reduce(max);
    final maxEstimate = estimateValues.isEmpty ? 0 : estimateValues.reduce(max);
    final calculatedMax = (maxActual > maxEstimate ? maxActual : maxEstimate) * 1.2;
    return calculatedMax > 0 ? calculatedMax : 10;
  }

  Color _getBarColor(double surprisePercent) {
    return surprisePercent >= 0 ? Colors.green : Colors.red;
  }
}