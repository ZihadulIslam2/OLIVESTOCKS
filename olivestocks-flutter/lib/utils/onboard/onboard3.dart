import 'package:flutter/material.dart';

import '../dimensions.dart';

class Onboard3 extends StatelessWidget {
  const Onboard3({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  Container(
      height: size.height,
      width: size.width,
      child: Column(
        children: [
          SizedBox(height: size.height * .12,),
          Text('Pass Your Driving Test', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black, fontSize: 24),),
          SizedBox(height: size.height * .1,),
          Container(
            height: size.height* .33,
            width: size.width,
            child: Center(
              child: Image.asset('assets/onBoard3.png'),
            ),
          ),
          SizedBox(height: size.height * .06,),
          Container(
            height: size.height* .2,
            width: size.width,
            child: Column(
              children: [
                Text('Let\'s help you ace your driving test', style: TextStyle(fontWeight: FontWeight.w400, color: Colors.black.withOpacity(.7), fontSize: 16),),
                Text('with tailored practice, expert advice', style: TextStyle(fontWeight: FontWeight.w400, color: Colors.black.withOpacity(.7), fontSize: 16),),
                Text('and study materials', style: TextStyle(fontWeight: FontWeight.w400, color: Colors.black.withOpacity(.7), fontSize: 18),),
              ],
            ),
          ),
          const SizedBox(height: 10,)
        ],
      ),
    );
  }
}
