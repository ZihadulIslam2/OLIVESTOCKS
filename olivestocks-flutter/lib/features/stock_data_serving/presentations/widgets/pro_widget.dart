import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProWidget extends StatelessWidget {
  const ProWidget({
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
              height: 16,
              width: 60,
              color: Color(0xffD9D9D9),
            ),
            SizedBox(height: 4),
            Container(
              height: 16,
              width: 80,
              color: Color(0xffD9D9D9),
            )
          ],
        ),
        Positioned(
          left:8,
          right:26,
          top:0,
          bottom:0,
          child: SvgPicture.asset('assets/logos/pro_red.svg',),
        ),
      ],
    );
  }
}