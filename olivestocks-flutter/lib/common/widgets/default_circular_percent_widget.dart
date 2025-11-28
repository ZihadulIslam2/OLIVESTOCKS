// lib/widgets/custom_circular_percent_widget.dart
import 'package:flutter/material.dart';

class CircularPercentWidget extends StatefulWidget {
  final int selectedSortTab;
  final double percent;
  final String? centerText;
  // 0 to 100

  const CircularPercentWidget({super.key, required this.percent, required this.selectedSortTab, this.centerText});

  @override
  State<CircularPercentWidget> createState() => _CircularPercentWidgetState();
}

class _CircularPercentWidgetState extends State<CircularPercentWidget> {



  @override
  Widget build(BuildContext context) {
    double percent = widget.percent;
    int selectedSortTab = widget.selectedSortTab;
    double progressValue = percent / 100;
    //
    int percentInt = percent.toInt();
   
    return SizedBox(
      width: 60,
      height: 60,
      child: Stack( 
        alignment: Alignment.center,
        children: [
          SizedBox(
            height: 50,
            width: 50,
            child: CircularProgressIndicator(
              value: progressValue,
              strokeWidth: 6,
              valueColor:  AlwaysStoppedAnimation<Color>((selectedSortTab ==1)?Colors.white:Colors.green),
              backgroundColor: selectedSortTab ==1?Colors.white: Colors.grey.shade300,
            ),
          ),
          Text(
            selectedSortTab == 1? '$percent%' : '$percentInt%',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
        ],
      ),
    ); 
  }
}


