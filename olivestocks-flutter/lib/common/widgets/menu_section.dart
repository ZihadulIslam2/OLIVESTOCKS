import 'package:flutter/material.dart';
import 'menu_item.dart';
import 'menu_item_data.dart';

class MenuSection extends StatelessWidget {
  final String title;
  final List<MenuItemData> items;

  const MenuSection({
    super.key,
    required this.title,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        ...items.map((item) => MenuItem(data: item)).toList(),
      ],
    );
  }
}