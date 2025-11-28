import 'package:flutter/material.dart';

class BuyHoldSellCircularPercentWidget extends StatelessWidget {
  final double buyPercent;
  final double holdPercent;
  final double sellPercent;

  const BuyHoldSellCircularPercentWidget({
    super.key,
    required this.buyPercent,
    required this.holdPercent,
    required this.sellPercent,
  });

  @override
  Widget build(BuildContext context) {
    final total = buyPercent + holdPercent + sellPercent;
    final normalizedBuy = buyPercent / total;
    final normalizedHold = holdPercent / total;
    final normalizedSell = sellPercent / total;

    return SizedBox(
      width: 35,
      height: 46,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 45,
            height: 45,
            child: CustomPaint(
              painter: _MultiColorProgressPainter(
                buyValue: normalizedBuy,
                holdValue: normalizedHold,
                sellValue: normalizedSell,
              ),
            ),
          ),
          Text(
            '${total.round()}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

class _MultiColorProgressPainter extends CustomPainter {
  final double buyValue;
  final double holdValue;
  final double sellValue;

  _MultiColorProgressPainter({
    required this.buyValue,
    required this.holdValue,
    required this.sellValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    const strokeWidth = 6.0;
    const startAngle = -0.5 * 3.1415926535897932; // -90 degrees in radians

    // Draw Buy segment (green)
    final buyPaint = Paint()
      ..color = Colors.green
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;
    final buySweepAngle = 2 * 3.1415926535897932 * buyValue;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      buySweepAngle,
      false,
      buyPaint,
    );

    // Draw Hold segment (grey)
    final holdPaint = Paint()
      ..color = Colors.yellow
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;
    final holdStartAngle = startAngle + buySweepAngle;
    final holdSweepAngle = 2 * 3.1415926535897932 * holdValue;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      holdStartAngle,
      holdSweepAngle,
      false,
      holdPaint,
    );

    // Draw Sell segment (red)
    final sellPaint = Paint()
      ..color = Colors.red
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;
    final sellStartAngle = holdStartAngle + holdSweepAngle;
    final sellSweepAngle = 2 * 3.1415926535897932 * sellValue;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      sellStartAngle,
      sellSweepAngle,
      false,
      sellPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}