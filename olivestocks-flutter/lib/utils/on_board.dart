// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';
//
// import '../features/auth/presentations/screens/login_screen.dart';
// import '../features/nav/NabScreen.dart';
// import 'dimensions.dart';
// import 'onboard/onboard1.dart';
// import 'onboard/onboard2.dart';
// import 'onboard/onboard3.dart';
// import 'onboard/onboard4.dart';
// import 'onboard/onboard5.dart';
//
// class OnBoard extends StatefulWidget {
//   const OnBoard({super.key});
//
//   @override
//   State<OnBoard> createState() => _OnBoardState();
// }
//
// class _OnBoardState extends State<OnBoard> {
//
//   PageController pageController = PageController();
//
//   List<Widget> pages = [
//     Onboard1(),
//     Onboard2(),
//     Onboard3(),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       body: Container(
//
//         child: Stack(
//           children: [
//             PageView(
//               controller: pageController,
//               children: pages,
//             ),
//             Positioned(
//               bottom: 0,
//                 left: 0,
//                 child: Container(
//                   width: size.width,
//                   color: Colors.white,
//                   height: size.height * .21,
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 20),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         GestureDetector(
//                           onTap: (){
//                             if(pageController.page! == 2.0){
//                               Navigator.push(context, MaterialPageRoute(builder: (context){
//                                 return LoginScreen();
//                               }));
//                               print('object');
//                               print(pageController.page.toString());
//                             }else{
//                               pageController.nextPage(duration: Duration(milliseconds: 700), curve: Curves.easeInOut);
//                             }
//                           },
//                           child: Container(
//                             height: size.height * .063,
//                             width: size.width,
//                             decoration: BoxDecoration(
//                               color: Dimensions.primaryColor,
//                               borderRadius: BorderRadius.circular(5)
//                             ),
//                             child: Center(child: Text('Next', style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w500),)),
//                           ),
//                         ),
//                         GestureDetector(
//                           onTap: (){
//                             Navigator.push(context, MaterialPageRoute(builder: (context){
//                               return LoginScreen();
//                             }));
//
//                             // Get.to(LoginScreen());
//                           },
//                           child: Container(
//                             height: 50,
//                             width: size.width,
//                             decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(10)
//                             ),
//                             child: Center(child: Text('Skip', style: TextStyle(fontSize: 18, color: Colors.black.withOpacity(.4), fontWeight: FontWeight.w400),)),
//                           ),
//                         ),
//                         Center(
//                             child: SmoothPageIndicator(
//                                 controller: pageController,  // PageController
//                                 count:  3,
//                                 effect:  WormEffect(
//                                   dotHeight: 6,
//                                   dotWidth: 6,
//                                   activeDotColor: Dimensions.secondaryColor,
//                                     dotColor: Colors.grey.shade200
//                                 ),  // your preferred effect
//                                 onDotClicked: (index){
//                                 }
//                             )
//                         ),
//                         const SizedBox(height: 40,)
//                       ],
//                     ),
//                   ),
//                 ),
//             )
//           ],
//         )
//       ),
//     );
//   }
// }
//
