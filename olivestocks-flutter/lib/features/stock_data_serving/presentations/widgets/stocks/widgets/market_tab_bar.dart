import 'package:flutter/material.dart';

class MarketTabBar extends StatelessWidget implements PreferredSizeWidget {
  const MarketTabBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return TabBar(
      labelColor: Colors.white,
      unselectedLabelColor: Colors.black,
      indicator: BoxDecoration(
        color: Colors.green.shade600,
        borderRadius: BorderRadius.circular(8),
      ),
      tabs: const [
        Tab(text: 'Stocks'),
        Tab(text: 'ETFs'),
      ],
    );
  }
}
