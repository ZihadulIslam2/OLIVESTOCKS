import 'package:flutter/material.dart';

import '../../../../common/data/analyst_data.dart';
import '../../../../common/widgets/custom_circular_percent_widget.dart';

class StockRatingDistribution extends StatelessWidget {
  const StockRatingDistribution({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final data = AnalystData.ratingDistribution;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "  Stock Rating Distribution",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
      
            Row(
              children: [
                Container(
                  width: size.width * 0.4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 12),
                      CustomCircularPercentWidget(
                        maxValue: 2000
                        ,
                        currentValue: 1450,
                      ),
                      
                      const SizedBox(height: 12),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        _buildRatingDot(color: Colors.green),
                        const SizedBox(width: 5),
                        Text("${data[1]} Buy", style: TextStyle(fontSize: 12)),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        _buildRatingDot(color: Colors.orange),
                        const SizedBox(width: 8),
                        Text("${data[2]} Hold", style: TextStyle(fontSize: 12)),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        _buildRatingDot(color: Colors.red),
                        const SizedBox(width: 8),
                        Text("${data[3]} Sell", style: TextStyle(fontSize: 12)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRatingDot({required Color color}) {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
