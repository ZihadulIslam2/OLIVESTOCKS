import 'package:flutter/material.dart';

class LinearPercentWidget extends StatelessWidget {
  final double buyPercent;
  final double holdPercent;
  final double sellPercent;
  final String ratingLabel;
  final Color ratingColor;

  const LinearPercentWidget({
    super.key,
    required this.buyPercent,
    required this.holdPercent,
    required this.sellPercent,
    required this.ratingLabel,
    required this.ratingColor,
  });

  @override
  Widget build(BuildContext context) {
    final total = buyPercent + holdPercent + sellPercent;
    final normalizedBuy = buyPercent / total;
    // Calculate position (0.1 to 0.9 range to keep indicator within bounds)
    final indicatorPosition = 0.1 + (normalizedBuy * 0.8);

    return SizedBox(
      width: 120,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Rating label
          Text(
            ratingLabel,
            style: TextStyle(
              color: ratingColor,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 6),

          // Progress bar with indicator
          Stack(
           clipBehavior: Clip.none, // Allow indicator to extend beyond
            children: [
              // Progress bar background
              Container(
                width: 130,
                height: 10,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFFF44336), // Red
                      Color(0xFFFF9800), // Orange
                      Colors.grey,      // Grey
                      Color(0xFF8BC34A), // Light Green
                      Color(0xFF4CAF50), // Green
                    ],
                    stops: [0.0, 0.3, 0.5, 0.7, 1.0],
                  ),
                ),
              ),

              // Triangle indicator
              Positioned(
                right: indicatorPosition * 130 - 95, // Center the triangle
                bottom:-12, // Position below progress bar
                child: Icon(
                  Icons.arrow_drop_up,
                  size: 24,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}