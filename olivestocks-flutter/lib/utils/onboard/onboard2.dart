import 'package:flutter/material.dart';

import '../dimensions.dart';

class Onboard2 extends StatelessWidget {
  const Onboard2({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  Container(
      height: size.height,
      width: size.width,
      child: Column(
        children: [
          SizedBox(height: size.height * .12,),
          Text('Test Routes!', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black, fontSize: 30),),
          SizedBox(height: size.height * .1,),
          Container(
            height: size.height* .33,
            width: size.width,
            child: Center(
              child: Image.asset('assets/onBoard2.png'),
            ),
          ),
          SizedBox(height: size.height * .1,),
          Container(
            height: size.height* .2,
            width: size.width,
            child: Column(
              children: [
                Text('Your ultimate companion for driving', style: TextStyle(fontWeight: FontWeight.w400, color: Colors.black.withOpacity(.7), fontSize: 18),),
                Text('test preparation', style: TextStyle(fontWeight: FontWeight.w400, color: Colors.black.withOpacity(.7), fontSize: 18),),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
