
// import 'package:flutter/material.dart';
// import 'package:rafimssarwa/Screens/markets_stocks_and_etfs/etfs/';


// class CustomEtfsCard extends StatelessWidget {
//   final String title;
//   final List<Etfs> etfs;

//   const CustomEtfsCard({super.key, required this.title, required this.etfs});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 2,
//       margin: const EdgeInsets.all(8),
//       child: Padding(
//         padding: const EdgeInsets.all(12),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
//             const SizedBox(height: 10),
//             Table(
//               columnWidths: const {
//                 0: FlexColumnWidth(3),
//                 1: FlexColumnWidth(2),
//                 2: FlexColumnWidth(2),
//               },
//               children: [
//                 const TableRow(children: [
//                   Text('ETF', style: TextStyle(fontWeight: FontWeight.bold)),
//                   Text('Value 1', style: TextStyle(fontWeight: FontWeight.bold)),
//                   Text('Value 2', style: TextStyle(fontWeight: FontWeight.bold)),
//                 ]),
//                 ...etfs.map((etf) => TableRow(children: [
//                   Text(etf.etfsName),
//                   Text(etf.value1),
//                   Text(
//                     etf.value2,
//                     style: TextStyle(
//                       color: etf.isPositive ? Colors.green : Colors.red,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ])),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }