import 'package:flutter/material.dart';

class CustomCircularPercentWidget extends StatelessWidget {
  final double currentValue;
  final double maxValue;
  final int selectedSortTab;

  const CustomCircularPercentWidget({
    super.key,
    required this.currentValue,
    required this.maxValue,
    this.selectedSortTab = 0,
  });

  @override
  Widget build(BuildContext context) {
    double percent = (currentValue / maxValue).clamp(0.0, 1.0) * 100;
    double progressValue = percent / 100;
    int percentInt = currentValue.round();

    return SizedBox(
      width: 80,
      height: 80,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            height: 70,
            width: 70,
            child: CircularProgressIndicator(
              value: progressValue,
              strokeWidth: 6,
              valueColor: AlwaysStoppedAnimation<Color>(
                selectedSortTab == 1 ? Colors.white : Colors.green,
              ),
              backgroundColor: selectedSortTab == 1
                  ? Colors.white
                  : Colors.grey.shade300,
            ),
          ),
          Text(
            selectedSortTab == 1 ? '${percent.toStringAsFixed(1)}%' : '$percentInt'+'\nRating',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: selectedSortTab == 1 ? Colors.white : Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}
