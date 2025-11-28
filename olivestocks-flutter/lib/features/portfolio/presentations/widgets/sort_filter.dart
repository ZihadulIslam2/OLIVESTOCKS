// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import 'explore.dart';
//
// class SortFilterPage extends StatefulWidget {
//   final OnSendCallback onSend;
//
//   const SortFilterPage({super.key, required this.onSend});
//
//   @override
//   _SortFilterPageState createState() => _SortFilterPageState();
// }
//
// class _SortFilterPageState extends State<SortFilterPage> {
//   String selectedSort = 'Popularity';
//   String selectedGenre = 'All';
//   String selectedYear = 'All';
//
//   final genres = [
//     'All', 'Comedy', 'Action', 'Mystery', 'Slice of Life',
//     'Romance', 'Drama', 'Magic'
//   ];
//
//   final years = ['All', '2023', '2024', '2025','2026', '2027', '2028', '2029'];
//
//   Widget _buildChoiceChips({
//     required List<String> options,
//     required String selectedValue,
//     required ValueChanged<String> onSelected,
//   }) {
//     return Wrap(
//       spacing: 8,
//       runSpacing: 8,
//       children: options.map((option) {
//         final isSelected = selectedValue == option;
//         return ChoiceChip(
//           label: Text(option),
//           selected: isSelected,
//           onSelected: (_) => onSelected(option),
//           selectedColor: Colors.white,
//           backgroundColor: Colors.black,
//           shape: const StadiumBorder(
//             side: BorderSide(
//               color: Colors.white,
//               width: 1.5,
//             ),
//           ),
//           labelStyle: TextStyle(
//             color: isSelected ? Colors.black : Colors.white,
//           ),
//         );
//       }).toList(),
//     );
//   }
//
//   void _resetFilters() {
//     setState(() {
//       selectedSort = 'Popularity';
//       selectedGenre = 'All';
//       selectedYear = 'All';
//     });
//
//   }
//
//   void _applyFilters() async {
//     await widget.onSend(selectedSort, selectedGenre, selectedYear);
//     Get.back();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         elevation: 0,
//         title: const Text('Sort & Filter', style: TextStyle(color: Colors.white)),
//         leading: const BackButton(color: Colors.white),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//
//             const Text('Sort',
//                 style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 20,
//                     )),
//
//             const SizedBox(height: 8),
//             _buildChoiceChips(
//               options: ['Popularity', 'Latest Release'],
//               selectedValue: selectedSort,
//               onSelected: (value) => setState(() => selectedSort = value),
//             ),
//             const SizedBox(height: 20),
//             const Text('Genre',
//                 style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 20,
//                     )),
//             const SizedBox(height: 8),
//             _buildChoiceChips(
//               options: genres,
//               selectedValue: selectedGenre,
//               onSelected: (value) => setState(() => selectedGenre = value),
//             ),
//             const SizedBox(height: 20),
//             const Text('Release Year',
//                 style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 20,
//                     )),
//             const SizedBox(height: 8),
//
//             _buildChoiceChips(
//               options: years,
//               selectedValue: selectedYear,
//               onSelected: (value) => setState(() => selectedYear = value),
//             ),
//
//             const Spacer(),
//
//             Row(
//               children: [
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: _resetFilters,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.grey[800],
//                       shape: const StadiumBorder(),
//                       padding: const EdgeInsets.symmetric(vertical: 14),
//                     ),
//                     child: const Text('Reset',
//                         style: TextStyle(color: Colors.white, fontSize: 16)),
//                   ),
//                 ),
//                 const SizedBox(width: 16),
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: _applyFilters,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.white,
//                       shape: const StadiumBorder(),
//                       padding: const EdgeInsets.symmetric(vertical: 14),
//                     ),
//                     child: const Text('Apply',
//                         style: TextStyle(color: Colors.black, fontSize: 16)),
//                   ),
//                 ),
//               ],
//             ),
//
//           ],
//         ),
//       ),
//     );
//   }
//
// }
