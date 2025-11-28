//
// import 'dart:math';
// import 'package:flutter/services.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:xml/xml.dart' as xml;
// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:flutter/material.dart';
// import 'package:olive_stocks_flutter/features/markets/presentations/screens/test_svg.dart';
// import '../../../../common/screens/dummy_chart2.dart';
// import '../../../../common/screens/single_stock_market_cashflow_widget.dart';
// import '../../../../common/screens/single_stock_market_eps_widget.dart';
// import '../../../../common/screens/single_stock_market_target_widget.dart';
// import '../../../portfolio/presentations/widgets/SingleStockMarketUpcomingEventsWidget.dart';
// import '../../../sanky/view/sankey_echart.dart';
// import '../widgets/single_stock_market_price_widget.dart';
// import '../widgets/vector_shape.dart';
//
// class SingleStockMarket extends StatefulWidget {
//   const SingleStockMarket({super.key});
//
//   @override
//   State<SingleStockMarket> createState() => _SingleStockMarketState();
// }
//
// class _SingleStockMarketState extends State<SingleStockMarket> {
//
//   double degreesToRadians(double degrees) {
//     return degrees * (pi / 180);
//   }
//
//   final List<String> items = [
//     'Price',
//     'Target',
//     'Cashflow',
//   ];
//
//   final List<String> items1 = [
//     'Revenue',
//     'EPS',
//     'Earning',
//   ];
//
//   String? selectedValue = 'Price';
//   String? selectedValue1 = 'Revenue';
//
//   late Future<List<Color>> _pathColorsFuture;
//
//   List<Color> _pathColors = [];
//   List<Color> _pathColorsO = [];
//
//   List<int> indexes = [0,1,2];
//   String? _svgString;
//
//   Color _parseHexColor(String hex) {
//     hex = hex.replaceAll('#', '');
//     if (hex.length == 6) hex = 'FF$hex';
//     return Color(int.parse(hex, radix: 16));
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     _pathColorsFuture = _initializeSvgPaths();
//   }
//
//   Future<List<Color>> _initializeSvgPaths() async {
//     final rawSvg = await rootBundle.loadString('assets/images/olive.svg');
//     final document = xml.XmlDocument.parse(rawSvg);
//     final paths = document.findAllElements('path').toList();
//
//     _svgString = rawSvg;
//
//     final colors = paths.map((path) {
//       final fill = path.getAttribute('fill') ?? '#000000';
//       return _parseHexColor(fill);
//     }).toList();
//
//     _pathColors = colors;
//     return colors;
//   }
//
//   Future<Widget> _buildSvgWithNewColors() async {
//     final document = xml.XmlDocument.parse(_svgString!);
//     final paths = document.findAllElements('path').toList();
//
//     for (int i = 0; i < paths.length; i++) {
//       paths[i].setAttribute('fill', '#${_pathColors[i].value.toRadixString(16).substring(2)}');
//     }
//
//     final updatedSvg = document.toXmlString(pretty: false);
//     return SvgPicture.string(updatedSvg);
//   }
//
//   void _changeColor(int index, Color color) {
//     setState(() {
//       _pathColors[index] = color;
//     });
//   }
//
//   void _changeColors(List<int> indexes, List<Color> colors) {
//     for(var d in indexes){
//       setState(() {
//         _pathColors[d] = colors[d];
//       });
//     }
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//
//       appBar: AppBar(
//         title: Text(
//           'Markets',
//           style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//         ),
//         centerTitle: false,
//         actions: [
//           Image.asset('assets/logos/search.png', height: 24, width: 24),
//           SizedBox(width: 15),
//           Image.asset('assets/logos/bag.png', height: 24, width: 24),
//           SizedBox(width: 15),
//           Image.asset('assets/logos/notification.png', height: 24, width: 24),
//           SizedBox(width: 15),
//         ],
//       ),
//
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 0.0),
//           child: Container(
//             child: Column(
//               children: [
//
//                 Container(
//                   height: 60,
//                   width: size.width,
//                   child: Padding(
//                     padding: const EdgeInsets.only(right: 50.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Container(
//                           width: size.width * .35,
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               const SizedBox(width: 30),
//                               Text(
//                                 'Apple',
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.w500,
//                                   fontSize: 20,
//                                 ),
//                               ),
//
//                               Container(
//                                 height: size.width * .12,
//                                 width: size.width * .12,
//                                 child: Image.asset(
//                                   'assets/logos/apple.png',
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Container(
//                           height: size.width * .12,
//                           width: size.width * .12,
//                           child: Image.asset('assets/logos/chad.png'),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 30),
//
//                 Container(
//                   height: size.height * .3,
//                   width: size.height * .3,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(4),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black26,
//                         spreadRadius: 2,
//                         blurRadius: 2,
//                       ),
//                     ],
//                   ),
//                   child: Stack(
//                     children: [
//                       Positioned(
//                         top: 10,
//                         left: 70,
//                         child: Text(
//                           'Strong Financial Health',
//                           style: TextStyle(
//                             fontSize: 12,
//                             fontWeight: FontWeight.w400,
//                           ),
//                         ),
//                       ),
//                       Positioned(
//                         bottom: 10,
//                         left: 70,
//                         child: Text(
//                           'Poor Financial Health',
//                           style: TextStyle(
//                             fontSize: 12,
//                             fontWeight: FontWeight.w400,
//                           ),
//                         ),
//                       ),
//                       Positioned(
//                         top: 50,
//                         left: 10,
//                         child: Transform.flip(
//                           flipY: true,
//                           flipX: true,
//                           child: RotatedBox(
//                             quarterTurns: 1,
//                             child: Text(
//                               'Low Competitive Advantage',
//                               style: TextStyle(
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.w400,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       Positioned(
//                         top: 50,
//                         right: 10,
//                         child: Transform.flip(
//                           flipY: false,
//                           flipX: false,
//                           child: RotatedBox(
//                             quarterTurns: -1,
//                             child: Text(
//                               'High Competitive Advantage',
//                               style: TextStyle(
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.w400,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//
//                       Positioned(
//                         right: (size.height * .3) / 12,
//                         bottom: (size.height * .3) / 2,
//                         child: Row(
//                           children: [
//                             Container(
//                               height: 2,
//                               width: size.width * .24,
//                               color: Colors.black,
//                             ),
//                             Transform.translate(
//                               offset: Offset(-7, 0),
//                               child: Icon(Icons.arrow_forward_ios, size: 12),
//                             ),
//                           ],
//                         ),
//                       ),
//
//                       Positioned(
//                         left: (size.height * .3) / 12,
//                         bottom: (size.height * .3) / 2,
//                         child: Transform.rotate(
//                           angle: degreesToRadians(180),
//                           child: Row(
//                             children: [
//                               Container(
//                                 height: 2,
//                                 width: size.width * .24,
//                                 color: Colors.black,
//                               ),
//                               Transform.translate(
//                                 offset: Offset(-7, 0),
//                                 child: Icon(Icons.arrow_forward_ios, size: 12),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//
//                       Positioned(
//                         left: (size.height * .3) / 3.2,
//                         top: 67,
//                         child: Transform.rotate(
//                           angle: degreesToRadians(270),
//                           child: Row(
//                             children: [
//                               Container(
//                                 height: 2,
//                                 width: size.width * .22,
//                                 color: Colors.black,
//                               ),
//                               Transform.translate(
//                                 offset: Offset(-7, 0),
//                                 child: Icon(Icons.arrow_forward_ios, size: 12),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//
//                       Positioned(
//                         left: (size.height * .3) / 3.3,
//                         bottom: 80,
//                         child: Transform.rotate(
//                           angle: degreesToRadians(90),
//                           child: Row(
//                             children: [
//                               Container(
//                                 height: 2,
//                                 width: size.width * .23,
//                                 color: Colors.black,
//                               ),
//                               Transform.translate(
//                                 offset: Offset(-7, 0),
//                                 child: Icon(Icons.arrow_forward_ios, size: 12),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//
//                       Positioned(
//                         top: 45,
//                         left: 50,
//                         child: Container(
//                           height: (size.height * .18) / 2,
//                           width: ((size.height * .16) / 2) + 10,
//                           color: Colors.transparent,
//                           child: Align(
//                             alignment: Alignment.centerLeft,
//                             child: Container(
//                               height: (size.height * .17) / 2,
//                               width: (size.height * .16) / 2,
//                               decoration: BoxDecoration(
//                                 color: Colors.lightGreen.withOpacity(.3),
//                                 borderRadius: BorderRadius.circular(10),
//                                 border: Border.all(
//                                   width: 3,
//                                   color: Colors.black,
//                                 ),
//                               ),
//                               child: Center(
//                                 child: Container(
//                                   child: Column(
//                                     children: [
//                                       Icon(Icons.offline_bolt),
//                                       Text('data'),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       Positioned(
//                         top: 45,
//                         right: 50,
//                         child: Container(
//                           height: (size.height * .18) / 2,
//                           width: ((size.height * .16) / 2) + 10,
//                           color: Colors.transparent,
//                           child: Align(
//                             alignment: Alignment.centerLeft,
//                             child: Container(
//                               height: (size.height * .17) / 2,
//                               width: (size.height * .16) / 2,
//                               decoration: BoxDecoration(
//                                 color: Colors.lightGreen.withOpacity(.3),
//                                 borderRadius: BorderRadius.circular(10),
//                                 border: Border.all(
//                                   width: 3,
//                                   color: Colors.black,
//                                 ),
//                               ),
//                               child: Center(
//                                 child: Container(
//                                   child: Column(
//                                     children: [
//                                       Icon(Icons.offline_bolt),
//                                       Text('data'),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       Positioned(
//                         bottom: 45,
//                         left: 50,
//                         child: Container(
//                           height: (size.height * .18) / 2,
//                           width: ((size.height * .16) / 2) + 10,
//                           color: Colors.transparent,
//                           child: Align(
//                             alignment: Alignment.centerLeft,
//                             child: Container(
//                               height: (size.height * .17) / 2,
//                               width: (size.height * .16) / 2,
//                               decoration: BoxDecoration(
//                                 color: Colors.lightGreen.withOpacity(.3),
//                                 borderRadius: BorderRadius.circular(10),
//                                 border: Border.all(
//                                   width: 3,
//                                   color: Colors.black,
//                                 ),
//                               ),
//                               child: Center(
//                                 child: Container(
//                                   child: Column(
//                                     children: [
//                                       Icon(Icons.offline_bolt),
//                                       Text('data'),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//
//                       Positioned(
//                         bottom: 45,
//                         right: 50,
//                         child: Container(
//                           height: (size.height * .18) / 2,
//                           width: ((size.height * .16) / 2) + 10,
//                           color: Colors.transparent,
//                           child: Align(
//                             alignment: Alignment.centerLeft,
//                             child: Container(
//                               height: (size.height * .17) / 2,
//                               width: (size.height * .16) / 2,
//                               decoration: BoxDecoration(
//                                 color: Colors.lightGreen.withOpacity(.3),
//                                 borderRadius: BorderRadius.circular(10),
//                                 border: Border.all(
//                                   width: 3,
//                                   color: Colors.black,
//                                 ),
//                               ),
//                               child: Center(
//                                 child: Container(
//                                   child: Column(
//                                     children: [
//                                       Icon(Icons.offline_bolt),
//                                       Text('data'),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//
//                 SizedBox(height: 30),
//
//                 /////////////////////////// SVG //////////////////////
//
//
//
//                 Container(
//                   height: size.height * .4,
//                   child: FutureBuilder<List<Color>>(
//                     future: _pathColorsFuture,
//                     builder: (context, snapshot) {
//                       if (snapshot.connectionState != ConnectionState.done) {
//                         return const Center(child: CircularProgressIndicator());
//                       }
//
//                       return Column(
//                         children: [
//
//                           Expanded(
//                             flex: 2,
//                             child: FutureBuilder<Widget>(
//                               future: _buildSvgWithNewColors(),
//                               builder: (context, svgSnapshot) {
//                                 if (svgSnapshot.connectionState != ConnectionState.done) {
//                                   return const Center(child: CircularProgressIndicator());
//                                 }
//                                 return svgSnapshot.data!;
//                               },
//                             ),
//                           ),
//
//                           // Expanded(
//                           //   flex: 1,
//                           //   child: ListView.builder(
//                           //     itemCount: _pathColors.length,
//                           //     itemBuilder: (context, index) {
//                           //
//                           //       return ListTile(
//                           //         leading: CircleAvatar(backgroundColor: _pathColors[index]),
//                           //         title: Text('Path #$index'),
//                           //         trailing: ElevatedButton(
//                           //           onPressed: () async {
//                           //             final pickedColor = await showDialog<Color>(
//                           //               context: context,
//                           //               builder: (context) => AlertDialog(
//                           //                 title: const Text('Pick a color'),
//                           //                 content: SingleChildScrollView(
//                           //                   child: ColorPicker(
//                           //                     pickerColor: _pathColors[index],
//                           //                     onColorChanged: (color) {},
//                           //                     onColorPicked: (color) => Navigator.of(context).pop(color),
//                           //                   ),
//                           //                 ),
//                           //               ),
//                           //             );
//                           //             if (pickedColor != null) _changeColor(index, pickedColor);
//                           //           },
//                           //           child: const Text('Change'),
//                           //         ),
//                           //       );
//                           //
//                           //     },
//                           //   ),
//                           // )
//
//                         ],
//                       );
//                     },
//                   ),
//                 ),
//
//
//
//
//
//                 SizedBox(height: 30),
//
//                 Container(
//                   height: size.height * .12,
//                   width: size.width * .9,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(4),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black26,
//                         spreadRadius: 2,
//                         blurRadius: 2,
//                       ),
//                     ],
//                   ),
//                   child: Stack(
//                     children: [
//                       Column(
//                         children: [
//                           SizedBox(height: 10),
//                           Container(
//                             child: Padding(
//                               padding: const EdgeInsets.symmetric(
//                                 horizontal: 18.0,
//                               ),
//                               child: Row(
//                                 mainAxisAlignment:
//                                 MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Container(
//                                     height: 20,
//                                     width: size.width * .21,
//                                     decoration: BoxDecoration(
//                                       border: Border.all(
//                                         width: 1,
//                                         color: Colors.black38,
//                                       ),
//                                     ),
//                                     child: Align(
//                                       alignment: Alignment.center,
//                                       child: Text(
//                                         'Under Value',
//                                         style: TextStyle(
//                                           fontSize: 11,
//                                           fontWeight: FontWeight.w500,
//                                           color: Colors.red,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   Container(
//                                     height: 20,
//                                     width: size.width * .21,
//                                     decoration: BoxDecoration(
//                                       border: Border.all(
//                                         width: 1,
//                                         color: Colors.black38,
//                                       ),
//                                     ),
//                                     child: Align(
//                                       alignment: Alignment.center,
//                                       child: Text(
//                                         'Fair Value',
//                                         style: TextStyle(
//                                           fontSize: 11,
//                                           fontWeight: FontWeight.w500,
//                                           color: Colors.red,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   Container(
//                                     height: 20,
//                                     width: size.width * .21,
//                                     decoration: BoxDecoration(
//                                       border: Border.all(
//                                         width: 1,
//                                         color: Colors.black38,
//                                       ),
//                                     ),
//                                     child: Align(
//                                       alignment: Alignment.center,
//                                       child: Text(
//                                         'Over Value',
//                                         style: TextStyle(
//                                           fontSize: 11,
//                                           fontWeight: FontWeight.w500,
//                                           color: Colors.red,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           SizedBox(height: 10),
//                           VectorShape(),
//                         ],
//                       ),
//                       Positioned(
//                         top: 80,
//                         left: size.width * .42,
//                         child: Container(
//                           height: 20,
//                           width: size.width * .3,
//                           child: Text(
//                             '\$100',
//                             style: TextStyle(
//                               fontSize: 10,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ),
//                       Positioned(
//                         top: 80,
//                         left: size.width * .64,
//                         child: Container(
//                           height: 20,
//                           width: size.width * .3,
//                           child: Text(
//                             '\$100',
//                             style: TextStyle(
//                               fontSize: 10,
//                               fontWeight: FontWeight.w400,
//                             ),
//                           ),
//                         ),
//                       ),
//                       Positioned(
//                         top: 40,
//                         left: size.width * .64,
//                         child: Container(
//                           height: 50,
//                           width: 10,
//                           child: Icon(
//                             Icons.arrow_downward_rounded,
//                             size: 30,
//                             color: Colors.red,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//
//                 SizedBox(height: 30),
//
//                 Container(
//                   height: size.height * .09,
//                   width: size.width * .4,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(4),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black26,
//                         spreadRadius: 2,
//                         blurRadius: 2,
//                       ),
//                     ],
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 5.0),
//                     child: Column(
//                       children: [
//                         Text(
//                           '50%',
//                           style: TextStyle(
//                             fontWeight: FontWeight.w500,
//                             fontSize: 16,
//                             color: Colors.green,
//                           ),
//                         ),
//                         Text(
//                           'Overvalued',
//                           style: TextStyle(
//                             fontWeight: FontWeight.w500,
//                             fontSize: 16,
//                             color: Colors.green,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//
//                 SizedBox(height: 60),
//
//                 Container(
//                   height: size.height * .1,
//                   width: size.width * .9,
//
//                   child: Column(
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Container(
//                             width: size.width * .4,
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Text(
//                                   'Apple Inc',
//                                   style: TextStyle(
//                                     fontSize: 20,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//
//                                 Text(
//                                   'NASDAO: ADBE',
//                                   style: TextStyle(
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//
//                           Container(
//                             width: size.width * .32,
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Image.asset(
//                                   'assets/images/share-06.png',height: 24,width: 24,
//                                   fit: BoxFit.cover,
//                                 ),
//                                 const SizedBox(width: 10),
//
//                                 DropdownButtonHideUnderline(
//                                   child: DropdownButton2<String>(
//                                     style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: Colors.white),
//                                     value: selectedValue,
//                                     isExpanded: true,
//                                     hint: Row(
//                                       children: [
//
//                                         SizedBox(
//                                           width: 4,
//                                         ),
//                                         Expanded(
//                                           child: Text(
//                                             selectedValue ?? 'Price',
//                                             style: TextStyle(
//                                               fontSize: 18,
//                                               fontWeight: FontWeight.bold,
//                                               color: Colors.white,
//                                             ),
//                                             overflow: TextOverflow.ellipsis,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                     items: items
//                                         .map((String item) => DropdownMenuItem<String>(
//                                       value: item,
//                                       child: Text(
//                                         item,
//                                         style: const TextStyle(
//                                           fontSize: 18,
//                                           fontWeight: FontWeight.bold,
//                                           color: Colors.white,
//                                         ),
//                                         overflow: TextOverflow.ellipsis,
//                                       ),
//                                     ))
//                                         .toList(),
//                                     onChanged: (String? value) {
//                                       setState(() {
//                                         selectedValue = value;
//                                       });
//                                     },
//
//                                     buttonStyleData: ButtonStyleData(
//                                       height: 50,
//                                       width: 120,
//                                       padding: const EdgeInsets.only(left: 14, right: 14),
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(14),
//                                         border: Border.all(
//                                           color: Colors.white,
//                                         ),
//                                         color: Color(0xff28A745),
//                                       ),
//                                       elevation: 0,
//                                     ),
//                                     iconStyleData: const IconStyleData(
//                                       icon: Icon(
//                                         Icons.arrow_forward_ios_outlined,
//                                       ),
//                                       iconSize: 14,
//                                       iconEnabledColor: Colors.white,
//                                       iconDisabledColor: Colors.white,
//                                     ),
//                                     dropdownStyleData: DropdownStyleData(
//                                       maxHeight: 200,
//                                       width: 200,
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(14),
//                                         color: Color(0xff28A745),
//                                       ),
//                                       offset: const Offset(-20, 0),
//                                       scrollbarTheme: ScrollbarThemeData(
//                                         radius: const Radius.circular(40),
//                                         thickness: MaterialStateProperty.all<double>(6),
//                                         thumbVisibility: MaterialStateProperty.all<bool>(true),
//                                       ),
//                                     ),
//                                     menuItemStyleData: const MenuItemStyleData(
//                                       height: 40,
//                                       padding: EdgeInsets.only(left: 14, right: 14),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//
//                         ],
//                       ),
//                       Divider(thickness: 1.2, color: Colors.black),
//                     ],
//                   ),
//                 ),
//                 if (selectedValue == 'Price')
//                   SingleStockMarketPriceWidget(),
//                 if (selectedValue == 'Target')
//                   SingleStockMarketTargetWidget(),
//                 if (selectedValue == 'Cashflow')
//                   SingleStockMarketCashFlowWidget(),
//                 SizedBox(height: 20),
//                 Container(
//                   height: size.height * .1,
//                   width: size.width * .9,
//                   child: Column(
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//
//                           Container(
//                             width: size.width * .4,
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Text(
//                                   'Apple Inc',
//                                   style: TextStyle(
//                                     fontSize: 20,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//
//                                 Text(
//                                   'NASDAO: ADBE',
//                                   style: TextStyle(
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//
//                           Container(
//                             width: size.width * .32,
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//
//                                 Image.asset(
//                                   'assets/images/share-06.png',height: 24,width: 24,
//                                   fit: BoxFit.cover,
//                                 ),
//
//                                 const SizedBox(width: 10),
//
//                                 DropdownButtonHideUnderline(
//                                   child: DropdownButton2<String>(
//                                     style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: Colors.white),
//                                     value: selectedValue1,
//                                     isExpanded: true,
//                                     hint: Row(
//                                       children: [
//
//                                         SizedBox(
//                                           width: 4,
//                                         ),
//
//                                         Expanded(
//                                           child: Text(
//                                             selectedValue1 ?? 'Revenue',
//                                             style: TextStyle(
//                                               fontSize: 18,
//                                               fontWeight: FontWeight.bold,
//                                               color: Colors.white,
//                                             ),
//                                             overflow: TextOverflow.ellipsis,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//
//                                     items: items1
//                                         .map((String item) => DropdownMenuItem<String>(
//                                       value: item,
//                                       child: Text(
//                                         item,
//                                         style: const TextStyle(
//                                           fontSize: 18,
//                                           fontWeight: FontWeight.bold,
//                                           color: Colors.white,
//                                         ),
//                                         overflow: TextOverflow.ellipsis,
//                                       ),
//                                     ))
//                                         .toList(),
//                                     onChanged: (String? value) {
//                                       setState(() {
//                                         selectedValue1 = value;
//                                       });
//                                     },
//
//                                     buttonStyleData: ButtonStyleData(
//                                       height: 50,
//                                       width: 120,
//                                       padding: const EdgeInsets.only(left: 14, right: 14),
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(14),
//                                         border: Border.all(
//                                           color: Colors.white,
//                                         ),
//                                         color: Color(0xff28A745),
//                                       ),
//                                       elevation: 0,
//                                     ),
//                                     iconStyleData: const IconStyleData(
//                                       icon: Icon(
//                                         Icons.arrow_forward_ios_outlined,
//                                       ),
//                                       iconSize: 18,
//                                       iconEnabledColor: Colors.white,
//                                       iconDisabledColor: Colors.white,
//                                     ),
//                                     dropdownStyleData: DropdownStyleData(
//                                       maxHeight: 200,
//                                       width: 200,
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(14),
//                                         color: Color(0xff28A745),
//                                       ),
//                                       offset: const Offset(-20, 0),
//                                       scrollbarTheme: ScrollbarThemeData(
//                                         radius: const Radius.circular(40),
//                                         thickness: MaterialStateProperty.all<double>(6),
//                                         thumbVisibility: MaterialStateProperty.all<bool>(true),
//                                       ),
//                                     ),
//                                     menuItemStyleData: const MenuItemStyleData(
//                                       height: 40,
//                                       padding: EdgeInsets.only(left: 14, right: 14),
//                                     ),
//                                   ),
//                                 ),
//
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                       Divider(thickness: 1.2, color: Colors.black),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 if(selectedValue1 == 'Revenue')
//                   RevenueBarChart(),
//                 if(selectedValue1 == 'EPS')
//                   SingleStockMarketEPSWidget(),
//                 if(selectedValue1 == 'Earning')
//                   SingleStockMarketUpcomingEventsWidget(),
//                 SizedBox(height: 20),
//                 SankeyEChart(width: size.width  , height: size.height, symbol: '',),
//                 SizedBox(height: 20),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 18.0),
//                   child: Container(
//                     // height: size.height * .6,
//                     width: size.width,
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(4),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black26,
//                           spreadRadius: 2,
//                           blurRadius: 2,
//                         ),
//                       ],
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(14.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Latest News',
//                             style: TextStyle(
//                               fontWeight: FontWeight.w700,
//                               fontSize: 18,
//                             ),
//                           ),
//                           SizedBox(height: 15),
//
//                           Column(
//                             children: List.generate(10, (context) {
//                               return SingleMarketNewsWidget();
//                             }),
//                           ),
//                           SizedBox(height: 10),
//                           Align(
//                             alignment: Alignment.center,
//                             child: Text(
//                               'Show More News',
//                               style: TextStyle(
//                                 color: Colors.green,
//                                 fontWeight: FontWeight.w500,
//                                 fontSize: 14,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//
//                 SizedBox(height: 20),
//                 SingleStockMarketDailyGainersLosers(),
//                 SizedBox(height: 20),
//                 SingleStockMarketUpcomingEventsWidget(),
//                 SizedBox(height: 60),
//
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
// }
//
//
//
//
//
//
//
//
//
//
