import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../features/portfolio/controller/portfolio_controller.dart';
import '../../features/portfolio/domains/eps_chart_response_model.dart';

class SingleStockMarketEPSWidget extends StatelessWidget {
  const SingleStockMarketEPSWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PortfolioController>(
      builder: (controller) {
        if (controller.isEPSChartLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        final data = controller.epsChartList
            .where((e) => e.period != null && e.actual != null && e.estimate != null)
            .take(30)
            .toList()
            .reversed
            .toList();

        if (data.isEmpty) {
          return const Center(child: Text("No EPS data available"));
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Earnings History',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text('Showing last ${data.length} periods'),
            ),
            const SizedBox(height: 16),
            AspectRatio(
              aspectRatio: 1.6,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ScatterChart(
                  ScatterChartData(
                    minX: 0,
                    maxX: data.length > 1 ? data.length - 1.toDouble() : 1,
                    minY: _getMinY(data),
                    maxY: _getMaxY(data),
                    gridData: const FlGridData(show: true),
                    titlesData: FlTitlesData(
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          interval: data.length > 10 ? (data.length / 5).ceilToDouble() : 1,
                          getTitlesWidget: (value, _) {
                            final i = value.toInt();
                            return (i >= 0 && i < data.length)
                                ? Text(
                              data[i].period != null
                                  ? _formatPeriodLabel(data[i].period!)
                                  : '',
                              style:  TextStyle(fontSize: 12),
                            )
                                : const Text('');
                          },
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 26,
                          interval: _calculateYInterval(data),
                          getTitlesWidget: (value, _) =>
                              Text(value.toStringAsFixed(1), style: const TextStyle(fontSize: 8)),
                        ),
                      ),
                      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    ),
                    borderData: FlBorderData(show: false),
                    scatterSpots: [
                      ...data.asMap().entries.map((e) => ScatterSpot(
                        e.key.toDouble(),
                        e.value.actual!,
                        dotPainter: FlDotCirclePainter(color: const Color(0xFF28A745), radius: 6),
                      )),
                      ...data.asMap().entries.map((e) => ScatterSpot(
                        e.key.toDouble(),
                        e.value.estimate!,
                        dotPainter: FlDotCirclePainter(color: const Color(0xFFBCE4C5), radius: 6),
                      )),
                    ],
                    scatterTouchData: ScatterTouchData(
                      enabled: true,
                      touchTooltipData: ScatterTouchTooltipData(
                        tooltipPadding: const EdgeInsets.all(10),
                        getTooltipItems: (touchedSpot) {
                          final i = touchedSpot.x.toInt();
                          if (i < 0 || i >= data.length) return null;
                          final model = data[i];
                          return ScatterTooltipItem(
                            "Period: ${_formatTooltipDate(model.period!)}\n"
                                "Estimate: \$${model.estimate!.toStringAsFixed(2)}\n"
                                "Actual: \$${model.actual!.toStringAsFixed(2)}",
                            textStyle: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildLegendItem('Estimate', const Color(0xFFBCE4C5)),
                  const SizedBox(width: 20),
                  _buildLegendItem('Actual', const Color(0xFF28A745)),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
        );
      },
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [Container(width: 12, height: 12, decoration: BoxDecoration(color: color, shape: BoxShape.circle)), const SizedBox(width: 6), Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500))],
    );
  }

  double _getMinY(List<EPSChartResponseModel> data) {
    final all = [...data.map((e) => e.actual!), ...data.map((e) => e.estimate!)];
    final min = all.reduce((a, b) => a < b ? a : b);
    return min < 0 ? min * 1.1 : min * 0.9;
  }

  double _getMaxY(List<EPSChartResponseModel> data) {
    final all = [...data.map((e) => e.actual!), ...data.map((e) => e.estimate!)];
    final max = all.reduce((a, b) => a > b ? a : b);
    return max * 1.1;
  }

  double _calculateYInterval(List<EPSChartResponseModel> data) {
    final range = _getMaxY(data) - _getMinY(data);
    final step = range / 5;
    if (step >= 1) return step.ceilToDouble();
    if (step >= 0.5) return 0.5;
    if (step >= 0.1) return (step * 10).ceilToDouble() / 10;
    return (step * 100).ceilToDouble() / 100;
  }

  String _formatPeriodLabel(String period) => DateTime.tryParse(period)?.year.toString() ?? period;

  String _formatTooltipDate(String period) {
    final d = DateTime.tryParse(period);
    if (d == null) return period;
    const m = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
    return "${m[d.month - 1]} ${d.day}, ${d.year}";
  }
}
