import 'package:flutter/material.dart';

class TabSelectorRow extends StatefulWidget {
  final List<String> tabs;
  final Function(int) onSelected;
  final int selectedIndex;

  const TabSelectorRow({
    Key? key,
    required this.tabs,
    required this.onSelected,
    required this.selectedIndex,
  }) : super(key: key);

  @override
  State<TabSelectorRow> createState() => _TabSelectorRowState();
}

class _TabSelectorRowState extends State<TabSelectorRow> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        children: List.generate(widget.tabs.length, (index) {
          final isSelected = index == widget.selectedIndex;
          return Expanded(
            child: GestureDetector(
              onTap: () => widget.onSelected(index),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isSelected ? Colors.green : Colors.transparent,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Text(
                  widget.tabs[index],
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}