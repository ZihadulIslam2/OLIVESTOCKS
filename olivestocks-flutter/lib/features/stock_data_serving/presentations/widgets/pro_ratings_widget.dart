import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProRatingsWidget extends StatelessWidget {
  const ProRatingsWidget({
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
                borderRadius: BorderRadius.circular(2),
                color: Color(0xffD9D9D9),
              ),
              height: 16,
              width: 60,
            ),
            SizedBox(height: 4)
          ],
        ),
        Positioned(
          left:-1,
          right:-4,
          top:1,
          bottom:4,
          child: SvgPicture.asset('assets/logos/pro_red.svg',),
        ),
      ],
    );
  }
}