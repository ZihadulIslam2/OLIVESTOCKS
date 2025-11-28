import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class DividendLinearPercentIndicator extends StatelessWidget {
  final double width;
  final double height;
  final double percent; // Value between 0.0 and 1.0
  final Color backgroundColor;
  final Color progressColor;
  final Radius barRadius;
  final bool animate;
  final int animationDuration;
  final TextStyle? textStyle;
  final double? leadingPadding;
  final double? trailingPadding;
  final Alignment? alignment;
  final String? label;

  const DividendLinearPercentIndicator({
    super.key,
    this.width = 200,
    this.height = 13.0,
    required this.percent,
    this.backgroundColor = Colors.grey,
    this.progressColor = Colors.green,
    this.barRadius = const Radius.circular(16),
    this.animate = true,
    this.animationDuration = 1000,
    this.textStyle,
    this.leadingPadding,
    this.trailingPadding,
    this.alignment,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    final percentageText = '${(percent * 100).toStringAsFixed(0)}%';

    return Padding(
      padding: EdgeInsets.only(
        left: leadingPadding ?? 0,
        right: trailingPadding ?? 0,
      ),
      child: Align(
        alignment: alignment ?? Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: const Text(
                'Very Bullish',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 2),
            if (label != null)
              Text(
                label!,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),

            Row(
              children: [
                Expanded(
                  child: LinearPercentIndicator(
                    width: width,
                    lineHeight: height,
                    percent: percent.clamp(0.0, 1.0),
                    backgroundColor: backgroundColor,
                    progressColor: progressColor,
                    barRadius: barRadius,
                    animation: animate,
                    animationDuration: animationDuration,
                  ),
                ),
              ],
            ),
            Center(
              child: Text(
                'Very Bullish',
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}