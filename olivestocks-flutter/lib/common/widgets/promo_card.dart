import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../features/explore_plan/presentations/screens/explore_plan_screen.dart';

class PromoCard extends StatelessWidget {
  const PromoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xffFFFFFF),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Container(
              height: 134.62,
              width: 211,
              child: Center(child: Text(' Promo Card ',style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 30),))),
              // child: Image.asset('assets/images/promo.png',fit: BoxFit.cover,)),
          const SizedBox(height: 8),
          SizedBox(
            height: 18,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Get.to(ExplorePlanScreen ());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: const BorderSide(color: Colors.green, width: 1),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
              ),
              child: const Text('GO PREMIUM',style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}