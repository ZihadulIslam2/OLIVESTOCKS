import 'package:flutter/material.dart';


class CustomFruitDiagram extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(

      width: 300,
      height: 160,
      child: CustomPaint(
        painter: FruitBranchPainter(),
      ),
    );
  }
}

class FruitBranchPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    // Branch
    paint.color = Colors.green.shade900;
    paint.strokeWidth = 6;
    paint.style = PaintingStyle.stroke;
    final branch = Path();
    branch.moveTo(0, 50);
    branch.quadraticBezierTo(size.width * 0.5, 20, size.width, 40);
    canvas.drawPath(branch, paint);

    // Leaves
    paint.style = PaintingStyle.fill;
    drawLeaf(canvas, Offset(30, 30), rotate: -0.5);
    drawLeaf(canvas, Offset(60, 20), rotate: -0.3);
    drawLeaf(canvas, Offset(100, 10), rotate: -0.2);

    // Fruits
    drawFruit(canvas, Offset(95, 55), Colors.green.shade700);        // Left fruit (green)
    drawFruit(canvas, Offset(125, 55), Colors.grey.shade400);        // Middle fruit (gray)
    drawFruit(canvas, Offset(155, 55), Colors.grey.shade600);        // Right fruit (darker gray)

    // Curved Arrow
    final arrowPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final arrowPath = Path();
    arrowPath.moveTo(80, 160);
    arrowPath.quadraticBezierTo(60, 100, 100, 70); // Point to green fruit
    canvas.drawPath(arrowPath, arrowPaint);

    // Arrowhead
    // final arrowHead = Path();
    // arrowHead.moveTo(100, 70);
    // arrowHead.lineTo(92, 75);
    // arrowHead.moveTo(100, 70);
    // arrowHead.lineTo(95, 78);
    //
    // canvas.drawPath(arrowHead, arrowPaint);

    // Question mark circle
    final circleOffset = Offset(size.width - 30, 20);
    paint.color = Colors.grey.shade800;
    canvas.drawCircle(circleOffset, 12, paint);

    final textPainter = TextPainter(
      text: TextSpan(text: "?", style: TextStyle(color: Colors.white, fontSize: 16)),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset(circleOffset.dx - 5, circleOffset.dy - 10));
  }

  void drawLeaf(Canvas canvas, Offset center, {double rotate = 0.0}) {
    final leafColor = Colors.green.shade800;
    final veinColor = Colors.green.shade200;

    canvas.save();

    canvas.translate(center.dx, center.dy);

    canvas.rotate(rotate);

    final leafPath = Path()
      ..moveTo(0, 0)
      ..quadraticBezierTo(15, -25, 40, 0)
      ..quadraticBezierTo(15, 25, 0, 0)
      ..close();

    // Fill the leaf
    final leafPaint = Paint()..color = leafColor;
    canvas.drawPath(leafPath, leafPaint);

    // Draw central vein (midrib)
    final veinPaint = Paint()
      ..color = veinColor
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;

    canvas.drawLine(Offset(0, 0), Offset(20, 0), veinPaint);

    canvas.restore();
  }


  void drawFruit(Canvas canvas, Offset center, Color color) {
    final fruitPaint = Paint()..color = color;
    canvas.drawOval(Rect.fromCenter(center: center, width: 20, height: 35), fruitPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;

}
