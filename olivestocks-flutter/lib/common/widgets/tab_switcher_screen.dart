import 'package:flutter/material.dart';

class TabSwitcherScreen extends StatelessWidget {
  final List<String> tabs;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  const TabSwitcherScreen({
    super.key,
    required this.tabs,
    required this.selectedIndex,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Row(
        children: List.generate(tabs.length, (index) {
          final bool isSelected = index == selectedIndex;
          return Padding(
            padding: const EdgeInsets.only(right: 4.0),
            child: ChoiceChip(
              showCheckmark: false,
              label: Text(tabs[index], style: TextStyle(color: isSelected ? Colors.white : Colors.black, fontSize: 10)),
              labelPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              selected: isSelected,
              selectedColor: Colors.green,
              backgroundColor: Colors.green.shade50,
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
              ),
              onSelected: (_) => onSelected(index),
              shape: StadiumBorder(),
            ),
          );
        }),
      ),
    );
  }
}