import 'package:flutter/material.dart';

import '../dimensions.dart';

class Onboard1 extends StatelessWidget {
  const Onboard1({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  Container(
      height: size.height,
      width: size.width,
      child: Column(
        children: [
          SizedBox(height: size.height * .12,),
          Text('Easily Plan Your Routes', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black, fontSize: 30),),
          SizedBox(height: size.height * .1,),
          Container(
            height: size.height* .28,
            width: size.width,
            child: Center(
              child: Image.asset('assets/onBoard1.png'),
            ),
          ),
          SizedBox(height: size.height * .1,),
          Container(
            height: size.height* .2,
            width: size.width,
            child: Column(
              children: [
                Text('Create custom routes, add a stops', style: TextStyle(fontWeight: FontWeight.w400, color: Colors.black.withOpacity(.7), fontSize: 18),),
                Text('along the way, and view step-by-', style: TextStyle(fontWeight: FontWeight.w400, color: Colors.black.withOpacity(.7), fontSize: 18),),
                Text('step directions', style: TextStyle(fontWeight: FontWeight.w400, color: Colors.black.withOpacity(.7), fontSize: 18),),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
