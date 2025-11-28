import 'package:flutter/material.dart';

class CustomCircularPercentWidget extends StatefulWidget {
  final int percent; // 0–100
  final double size; // The total size of the circular widget
  final Color fontColor;
  final bool isPartner;

  const CustomCircularPercentWidget({
    super.key,
    required this.percent,
    required this.size,
    this.fontColor = Colors.black,
    this.isPartner = false,
  });

  @override
  State<CustomCircularPercentWidget> createState() =>
      _CustomCircularPercentWidgetState();
}

class _CustomCircularPercentWidgetState
    extends State<CustomCircularPercentWidget> {
  @override
  Widget build(BuildContext context) {
    final double clampedPercent = widget.percent.clamp(0, 100).toDouble();
    final double progressValue = clampedPercent / 100.0;
    final double strokeWidth = widget.size * 0.08;
    final double fontSize = widget.size * 0.25;

    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: widget.size,
            height: widget.size,
            child: CircularProgressIndicator(
              strokeCap: StrokeCap.round,
              value: progressValue,
              strokeWidth: strokeWidth,
              valueColor: AlwaysStoppedAnimation<Color>(
                _getProgressColor(clampedPercent, widget.isPartner),
              ),
              backgroundColor: const Color(0xffD9D9D9),
            ),
          ),
          Text(
            '${clampedPercent.toInt()}%',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: fontSize,
              color: widget.fontColor,
            ),
          ),
        ],
      ),
    );
  }

  Color _getProgressColor(double percent, bool isPartner) {
    if (!isPartner) {
      return Colors.green;
    } else {
      return const Color(0xffF5E29E);
    }
  }
}

class PortfolioHealthIndexExample extends StatelessWidget {
  final String? averageReturnString;
  final int? successRateValue;

  const PortfolioHealthIndexExample({
    Key? key,
    this.averageReturnString,
    this.successRateValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double averageReturn =
        double.tryParse(averageReturnString ?? '0') ?? 0;

    final int successRate = (successRateValue ?? 0).clamp(0, 100);

    // Logic: If avg return positive, show success rate, else 0%
    final int percentToShow = averageReturn > 0 ? successRate : 0;

    return Center(
      child: CustomCircularPercentWidget(
        percent: percentToShow,
        size: 100,
        fontColor: Colors.black,
        isPartner: false,
      ),
    );
  }
}
