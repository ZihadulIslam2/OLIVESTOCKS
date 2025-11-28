import 'package:flutter/material.dart';

class FeatureItemWidget extends StatelessWidget {
  final String title;
  final String icon;

  const FeatureItemWidget({super.key, required this.title, required this.icon});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          icon,
          height: 16,
          width: 16,
        ),
        SizedBox(width: 8),
        Column(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Color(0xff4E4E4E),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
