import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/data/analyst_data.dart';
import '../../../../common/widgets/default_circular_percent_widget.dart';
import '../../../../portfolio_allocation/presentation/screens/protfolio_health_index.dart';
import '../../../../portfolio_allocation/presentation/widgets/custom_circular_percent_widget.dart';
import '../../../portfolio/controller/portfolio_controller.dart';

class PerformanceWidget extends StatelessWidget {
  PerformanceWidget({super.key});

  String trimPercentage(String? input) {
    if (input == null) return '0';
    return input.replaceAll('%', '').trim();
  }

  // Helper method to parse and format average return
  Map<String, dynamic> formatAverageReturn(String? averageReturn) {
    if (averageReturn == null) return {'text': '0%', 'color': Colors.black};

    // Remove % sign and parse the value
    String cleanValue = averageReturn.replaceAll('%', '').trim();
    double? value = double.tryParse(cleanValue);

    if (value == null) return {'text': '0%', 'color': Colors.black};

    if (value > 0) {
      return {
        'text': '+${value.toStringAsFixed(2)}%',
        'color': Colors.green
      };
    } else if (value < 0) {
      return {
        'text': '${value.toStringAsFixed(2)}%',
        'color': Colors.red
      };
    } else {
      return {
        'text': '0.00%',
        'color': Colors.black
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<PortfolioController>(
      builder: (portfolioController) {
        if (portfolioController.isPerformanceLoading) {
          return Center(child: CircularProgressIndicator());
        }

        // Safely get portfolio name
        String name = '';
        for (final portfolio in portfolioController.portfolios) {
          if (portfolio.id == portfolioController.selectedPortfolioId) {
            name = portfolio.name ?? '';
            break;
          }
        }

        // Safely get performance data
        final performance = portfolioController.performanceResponseModel;
        final rankings = performance?.rankings;
        final successRate = rankings?.successRate ?? '0%';
        final averageReturn = rankings?.averageReturn ?? '0%';

        // Format average return with color and sign
        final averageReturnFormatted = formatAverageReturn(averageReturn);

        // Parse success rate for progress display
        double successRateValue = double.parse(trimPercentage(successRate)) / 100;

        return Container(
          height: size.height * .3,
          width: size.width * .9,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 1,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Performance',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        Icon(Icons.info_outline, color: Colors.red, size: 18),
                      ],
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => Get.to(ProtfolioHealthIndex()),
                          child: Text(
                            'See More',
                            style: TextStyle(fontSize: 12, color: Colors.green),
                          ),
                        ),
                        Icon(Icons.chevron_right_outlined, color: Colors.green),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 185,
                      width: 154,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.green),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Text('Success Rate', style: TextStyle(fontSize: 12)),
                            SizedBox(height: 10),
                            CustomCircularPercentWidget(
                              percent: performance.rankings?.successRate?.length ?? 0,
                              size: 60,
                            ),
                            SizedBox(height: 20),
                            Text(
                              '0 out of 3 profitable transactions',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Container(
                      height: 185,
                      width: 154,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.green),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Text('Average Return', style: TextStyle(fontSize: 12)),
                            SizedBox(height: 31),
                            Text(
                              averageReturnFormatted['text'],
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: averageReturnFormatted['color'],
                              ),
                            ),
                            SizedBox(height: 31),
                            Text(
                              '0 out of 3 profitable transactions',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}