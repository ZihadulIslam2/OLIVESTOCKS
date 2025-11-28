// import 'package:flutter/material.dart';
// import 'package:rafimssarwa/Screens/markets_stocks_and_etfs/table_model/upcoming_events_model.dart';

// class UpComingEvent extends StatefulWidget {
//   final List<UpFinancialInstrument>? stocks;
//   final List<UpFinancialInstrument>? etfs;
//   const UpComingEvent({
//     super.key,
//     this.stocks,
//     this.etfs,
//     }) : assert (stocks != null || etfs != null, 'Either stocks or etfs must be provided');

//   @override
//   State<UpComingEvent> createState() => _UpComingEventState();
// }

// class _UpComingEventState extends State<UpComingEvent> {
//   bool showGainers = true;
//   List<UpFinancialInstrument> get instrumentList =>
//       widget.stocks ?? widget.etfs ?? [];
//   bool get isStockList => widget.stocks != null;
//   List<UpFinancialInstrument> get displayList => showGainers
//       ? instrumentList.where((item) => item.percentageChange >= 0).toList()
//       : instrumentList.where((item) => item.percentageChange < 0).toList();

//   @override
//   Widget build(BuildContext context) {
//     final title = isStockList ? 'Top Stock Gainers/Losers' : 'Top ETF Gainers/Losers';
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             title,
//             style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 8),
//           Row(
//             children: [
//               ChoiceChip(
//                 label: const Text('Gainers'),
//                 selected: showGainers,
//                 showCheckmark: false,
//                 onSelected: (_) => setState(() => showGainers = true),
//                 selectedColor: Colors.green.shade600,
//                 labelStyle: TextStyle(
//                   color: showGainers ? Colors.white : Colors.black,
//                 ),
//               ),
//               const SizedBox(width: 8),
//               ChoiceChip(
//                 label: const Text('Losers'),
//                 selected: !showGainers,
//                 showCheckmark: false,
//                 onSelected: (_) => setState(() => showGainers = false),
//                 selectedColor: Colors.red.shade600,
//                 labelStyle: TextStyle(
//                   color: !showGainers ? Colors.white : Colors.black,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//   Widget buildTable() {
//     return DataTable(
//       columns: const [
//         DataColumn(label: Text('Name')),
//         DataColumn(label: Text('Price')),
//         DataColumn(label: Text('Change')),
//         DataColumn(label: Text('Percentage Change')),
//       ],
//       rows: displayList.map((item) {
//         return DataRow(cells: [
//           DataCell(Text(item.name)),
//           DataCell(Text(item.price.toString())),
//           DataCell(Text(item.change.toString())),
//           DataCell(Text(item.percentageChange.toString())),
//         ]);
//       }).toList(),
//     );
//   }
//   Widget buildPlaceholder() {
//     return const Center(
//       child: Text('No data available'),
//     );
//   }}