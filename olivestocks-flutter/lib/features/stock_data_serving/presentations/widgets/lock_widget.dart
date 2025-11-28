import 'package:flutter/material.dart';

class LockWidget extends StatelessWidget {
  const LockWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120, // fixed width for consistency
      height: 50, // fixed height
      child: Stack(
        alignment: Alignment.center, // lock always in the middle
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xffD9D9D9),
                  borderRadius: BorderRadius.circular(4),
                ),
                height: 16,
                width: 60,
              ),
              const SizedBox(height: 4),
              Container(
                height: 15,
                width: 80,
                decoration: BoxDecoration(
                  color: const Color(0xffD9D9D9),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ],
          ),

          // Centered lock icon
          const Icon(
            Icons.lock,
            size: 20,
            color: Color(0xffFF5733),
          ),
        ],
      ),
    );
  }
}
