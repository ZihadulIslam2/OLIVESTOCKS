import 'package:flutter/material.dart';

import '../widgets/circular_percent_widget.dart';

class MyExpertsScreen extends StatelessWidget {
  const MyExpertsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 4.0,
        shadowColor: Colors.black,
        title: const Text(
          'My Experts',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.keyboard_backspace, color: Colors.black),
        ),
      ),

      body: Container(
        height: size.height,
        width: size.width,
        child: Center(
          child: Text('Coming Soon', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black, fontSize: 30),),
        ),
      ),

      // body: Padding(
      //   padding: EdgeInsets.all(screenWidth * 0.04),
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       Text(
      //         'See experts you are following',
      //         style: TextStyle(fontSize: screenWidth * 0.035, color: const Color(0xff595959),fontStyle: FontStyle.italic),
      //       ),
      //       SizedBox(height: screenHeight * 0.015),
      //       Divider(height: 1, color: const Color(0xff595959)),
      //       SizedBox(height: screenHeight * 0.015),
      //       Row(
      //         children: [
      //           SizedBox(
      //             width: screenWidth * 0.3,
      //             child: Text(
      //               'Expert',
      //               style: TextStyle(fontSize: screenWidth * 0.03, color: const Color(0xff595959)),
      //             ),
      //           ),
      //           SizedBox(
      //             width: screenWidth * 0.25,
      //             child: Text(
      //               'Success Rate',
      //               style: TextStyle(fontSize: screenWidth * 0.03, color: const Color(0xff595959)),
      //             ),
      //           ),
      //           SizedBox(
      //             width: screenWidth * 0.25,
      //             child: Text(
      //               'Average Return',
      //               style: TextStyle(fontSize: screenWidth * 0.03, color: const Color(0xff595959)),
      //             ),
      //           ),
      //         ],
      //       ),
      //       SizedBox(height: screenHeight * 0.01),
      //       Divider(height: 1, color: const Color(0xff595959)),
      //       SizedBox(height: screenHeight * 0.02),
      //       Container(
      //         child: Padding(
      //           padding: EdgeInsets.all(screenWidth * 0.03),
      //           child: Row(
      //             children: [
      //               Stack(
      //                 alignment: Alignment.bottomRight,
      //                 children: [
      //                   CircleAvatar(
      //                     radius: screenWidth * 0.08,
      //                     backgroundImage: AssetImage('assets/images/man.jpeg'),
      //                   ),
      //                   Positioned(
      //                     bottom: -screenHeight * 0.008,
      //                     right: 0,
      //                     child: Icon(Icons.star, color: Colors.green, size: screenWidth * 0.07),
      //                   ),
      //                   Positioned(
      //                     bottom: screenHeight * 0.000,
      //                     right: screenWidth * 0.020,
      //                     child: Text(
      //                       '11',
      //                       style: TextStyle(
      //                         color: Colors.white,
      //                         fontWeight: FontWeight.w400,
      //                         fontSize: screenWidth * 0.02,
      //                       ),
      //                     ),
      //                   ),
      //                 ],
      //               ),
      //               SizedBox(width: screenWidth * 0.03),
      //               Column(
      //                 crossAxisAlignment: CrossAxisAlignment.start,
      //                 children: [
      //                   Text(
      //                     'LST123',
      //                     style: TextStyle(
      //                       fontSize: screenWidth * 0.04,
      //                       fontWeight: FontWeight.bold,
      //                     ),
      //                   ),
      //                   Text(
      //                     'Hot Copper',
      //                     style: TextStyle(
      //                       fontSize: screenWidth * 0.035,
      //                       color: Colors.grey[600],
      //                     ),
      //                   ),
      //                   Row(
      //                     children: List.generate(
      //                       5,
      //                           (index) => Icon(
      //                         Icons.star,
      //                         size: screenWidth * 0.04,
      //                         color: Colors.amber,
      //                       ),
      //                     ),
      //                   ),
      //                 ],
      //               ),
      //               Spacer(),
      //               CircularPercentWidget(percent: 90,),
      //               SizedBox(width: screenWidth * 0.07),
      //               Row(
      //                 children: [
      //                   Icon(
      //                     Icons.arrow_upward,
      //                     color: Colors.green,
      //                     size: screenWidth * 0.04,
      //                   ),
      //                   Text(
      //                     '11.58%',
      //                     style: TextStyle(
      //                       color: Colors.green,
      //                       fontWeight: FontWeight.bold,
      //                       fontSize: screenWidth * 0.035,
      //                     ),
      //                   ),
      //                 ],
      //               ),
      //             ],
      //           ),
      //         ),
      //       ),
      //       Spacer(),
      //       Divider(height: 1, color: const Color(0xff28A745)),
      //       SizedBox(height: 17,),
      //   TextButton.icon(
      //     onPressed: () {},
      //     icon: Icon(
      //       Icons.add,
      //       size: screenWidth * 0.05,
      //       color: const Color(0xff28A745),
      //     ),
      //     label: Text(
      //       'Add Expert',
      //       style: TextStyle(
      //         fontSize: screenWidth * 0.04,
      //         color: const Color(0xff28A745),
      //         fontWeight: FontWeight.bold,
      //       ),
      //     ),
      //     style: TextButton.styleFrom(
      //       padding: EdgeInsets.symmetric(
      //         horizontal: screenWidth * 0.05,
      //         vertical: screenHeight * 0.015,
      //       ),
      //       backgroundColor: Colors.transparent,
      //       shape: RoundedRectangleBorder(
      //         borderRadius: BorderRadius.circular(screenWidth * 0.05),
      //
      //       ),
      //     ),
      //   ),
      //     ],
      //   ),
      // ),

    );
  }
}
