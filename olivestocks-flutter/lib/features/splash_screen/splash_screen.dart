import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../common/screens/NabScreen.dart';
import '../auth/presentations/screens/login_screen.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    _moveToNextScreen();
  }

  Future<void> _moveToNextScreen() async {
    // await Future.delayed(
    //   const Duration(seconds: 2),
    // );

    if(mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(child: Image.asset('assets/images/Splash Screen.png'), ),
          // Align(
          //   alignment: Alignment.center,
          //   child: ,
          // )
        ],
      )

      // Column(
      //   children: [
      //     Image.asset('assets/images/Splash Screen.png'),
      //   ],
      // )
    );
  }
}
