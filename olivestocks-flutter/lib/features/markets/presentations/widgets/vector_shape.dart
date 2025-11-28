import 'package:flutter/material.dart';

class VectorShape extends StatelessWidget {
  const VectorShape({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * .9,
      height: 40,
      child: Container(
          width: size.width * .8,
          child: Center(
              child: Image.asset('assets/images/vector_25.png', fit: BoxFit.cover,)
          )
      ),
    );
  }
}
