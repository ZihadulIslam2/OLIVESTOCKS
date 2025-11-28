import 'package:flutter/material.dart';

class TopLockWidget extends StatelessWidget {
  final double lockPosition;
  final Alignment boxAlignment;

  const TopLockWidget({super.key, required this.lockPosition, required this.boxAlignment});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center, // This centers the lock icon
      children: [
        Container(
          width: 136,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: boxAlignment,
                  child: Container(
                    height: 16,
                    width: 60,
                    decoration: BoxDecoration(
                      color: Color(0xffD9D9D9),
                      borderRadius: BorderRadius.circular(4)
                    ),
                  ),
                ),
                SizedBox(height: 4),
                Container(
                  height: 16,
                  width: 80,
                  decoration: BoxDecoration(
                    color: Color(0xffD9D9D9),
                    borderRadius: BorderRadius.circular(4)
                  ),
                )
              ],
            ),
          ),
        ),
        Positioned(
          left:0,
          right:lockPosition,
          top:0,
          bottom:10,
          child: Icon(Icons.lock, size: 25, color: Color(0xffFF5733)),
        ),
      ],
    );
  }
}