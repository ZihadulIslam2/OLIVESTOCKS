import 'package:flutter/material.dart';

class SortTabBar extends StatelessWidget {
  const SortTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Analyst", style: TextStyle(fontWeight: FontWeight.bold)),
          Text("Average Return", style: TextStyle(fontWeight: FontWeight.bold)),
          Text("Success Rate", style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
