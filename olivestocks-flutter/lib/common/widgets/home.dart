import 'package:flutter/material.dart';

import '../screens/side_menu.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: const Center(
        child: Text(
          'Home Page',
          style: TextStyle(fontSize: 24),
        ),
      ),
      drawer: SizedBox(
        width: screenWidth * 0.7, // 70% of screen width
        child: const SideMenu(), // Your existing drawer widget
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Drawer Demo',
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
