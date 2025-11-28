import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  const BottomNavBar({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.green,
      unselectedItemColor: Colors.black,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.pie_chart), label: "Portfolio"),
        BottomNavigationBarItem(icon: Icon(Icons.article), label: "News"),
        BottomNavigationBarItem(icon: Icon(Icons.show_chart), label: "Markets"),
        BottomNavigationBarItem(icon: Icon(Icons.people), label: "Experts"),
        BottomNavigationBarItem(icon: Icon(Icons.menu), label: "Menu"),
      ],
    );
  }
}