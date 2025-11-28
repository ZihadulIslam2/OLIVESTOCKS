import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:olive_stocks_flutter/features/auth/presentations/screens/login_screen.dart';
import 'package:olive_stocks_flutter/payment/const.dart';

import 'helpers/dependency_injection.dart';

void main() async{
  await _setup();
  WidgetsFlutterBinding.ensureInitialized();
  await initDI();
  runApp(const MyApp());
}

Future <void> _setup()async{
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey= Constants.publishableKey;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: GetMaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          drawerTheme: DrawerThemeData(
            backgroundColor: Colors.white,
          )
        ),
        home: LoginScreen(),
      ),
    );
  }

}
