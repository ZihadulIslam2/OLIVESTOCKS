import 'package:flutter/material.dart';

class CircularPercentWidget extends StatelessWidget {
  final double percent; // 0 to 100

  const CircularPercentWidget({super.key, required this.percent});

  @override
  Widget build(BuildContext context) {
    double progressValue = percent / 100;

    return SizedBox(
      width: 60,
      height: 60,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            height: 50,
            width: 50,
            child: CircularProgressIndicator(
              value: progressValue,
              strokeWidth: 6,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
              backgroundColor: Colors.grey.shade300,
            ),
          ),
          Text(
            '$percent%',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}