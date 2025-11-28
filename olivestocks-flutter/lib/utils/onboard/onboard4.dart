import 'package:flutter/material.dart';

import '../dimensions.dart';

class Onboard4 extends StatelessWidget {
  const Onboard4({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  Container(
      height: size.height,
      width: size.width,
      child: Column(
        children: [
          SizedBox(height: size.height * .12,),
          Text('Pay Securely with', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 30),),
          Text('Multiple Options!', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 30),),
          SizedBox(height: size.height * .1,),
          Container(
            height: size.height* .23,
            width: size.width,
            child: Center(
              child: Image.asset('assets/Onboard4.png'),
            ),
          ),
          SizedBox(height: size.height * .075,),
          Container(
            height: size.height* .2,
            width: size.width,
            child: Column(
              children: [
                Text('Secure & Easy Payments', style: TextStyle(fontWeight: FontWeight.w600, color: Dimensions.secondaryColor, fontSize: 20),),
                Text('Enjoy seamless and secure payments', style: TextStyle(fontWeight: FontWeight.w400, color: Colors.black.withOpacity(.7), fontSize: 18),),
                Text('via credit/debit cards, UPI, and', style: TextStyle(fontWeight: FontWeight.w400, color: Colors.black.withOpacity(.7), fontSize: 18),),
                Text('wallets.', style: TextStyle(fontWeight: FontWeight.w400, color: Colors.black.withOpacity(.7), fontSize: 18),),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
