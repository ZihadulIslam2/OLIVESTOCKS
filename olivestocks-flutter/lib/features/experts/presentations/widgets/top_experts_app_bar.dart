import 'package:flutter/material.dart';

class TopExpertsAppBar extends StatelessWidget {
  const TopExpertsAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text("Top Experts", style: TextStyle(color: Colors.black)),
      backgroundColor: Colors.white,
      elevation: 0,
      actions: const [
        Icon(Icons.search, color: Colors.black),
        SizedBox(width: 12),
        Icon(Icons.notifications_none, color: Colors.black),
        SizedBox(width: 12),
      ],
      iconTheme: const IconThemeData(color: Colors.black),
    );
  }
}