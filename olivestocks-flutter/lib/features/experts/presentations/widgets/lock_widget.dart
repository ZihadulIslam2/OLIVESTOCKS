import 'package:flutter/material.dart';

class lockWidget extends StatelessWidget {
  const lockWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center, // This centers the lock icon
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color(0xffD9D9D9),
                borderRadius: BorderRadius.circular(4)
              ),
              height: 16,
              width: 60,
            ),
            SizedBox(height: 4),
            Container(
             decoration:  BoxDecoration(
                  color: Color(0xffD9D9D9),
                  borderRadius: BorderRadius.circular(4)
              ),
              height: 16,
              width: 80,
            )
          ],
        ),
        Positioned(
          left:10,
          right:50,
          top:0,
          bottom:0,
          child: Icon(Icons.lock, size: 20, color: Color(0xffFF5733)),
        ),
      ],
    );
  }
}