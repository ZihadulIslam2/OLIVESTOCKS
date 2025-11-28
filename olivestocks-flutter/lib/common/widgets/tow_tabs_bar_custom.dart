import 'package:flutter/material.dart';

class TwoTabsBarCustom extends StatelessWidget {
  final String firstTabText;
  final String secondTabText;
  final int selectedIndex;
  final Function(int) onTabChanged;

  const TwoTabsBarCustom({
    super.key,
    required this.firstTabText,
    required this.secondTabText,
    required this.selectedIndex,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(

        children: [
          _buildTab(index: 0, label: firstTabText),
          const SizedBox(height: 30,),
          _buildTab(index: 1, label: secondTabText),
        ],
      ),
    );
  }

  Expanded _buildTab({required int index, required String label}) {

    final bool isSelected = selectedIndex == index;

    return Expanded(
      child: GestureDetector(
        onTap: () => onTabChanged(index),

        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? Colors.green : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),

      ),
    );
  }

}
