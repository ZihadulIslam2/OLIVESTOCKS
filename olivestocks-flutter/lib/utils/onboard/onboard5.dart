import 'package:flutter/material.dart';

import '../dimensions.dart';

class Onboard5 extends StatelessWidget {
  const Onboard5({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  Container(
      height: size.height,
      width: size.width,
      child: Column(
        children: [
          SizedBox(height: size.height * .12,),
          Text('Sit Back & Enjoy Your', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 30),),
          Text('Journey!', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 30),),
          SizedBox(height: size.height * .12,),
          Container(
            height: size.height* .23,
            width: size.width,
            child: Center(
              child: Image.asset('assets/Onboard5.png'),
            ),
          ),
          SizedBox(height: size.height * .075,),
          Container(
            height: size.height* .2,
            width: size.width,
            child: Column(
              children: [
                Text('Enjoy a Comfortable Ride', style: TextStyle(fontWeight: FontWeight.w600, color: Dimensions.secondaryColor, fontSize: 20),),
                Text('Your comfort is our priority. Relax', style: TextStyle(fontWeight: FontWeight.w400, color: Colors.black.withOpacity(.7), fontSize: 18),),
                Text('and enjoy a safe, smooth ride', style: TextStyle(fontWeight: FontWeight.w400, color: Colors.black.withOpacity(.7), fontSize: 18),),
               ],
            ),
          ),
        ],
      ),
    );
  }
}
