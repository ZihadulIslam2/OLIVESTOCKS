import 'package:flutter/material.dart';

class ExpandableListItem extends StatefulWidget {
  const ExpandableListItem({required this.index, Key? key}) : super(key: key);

  final int index;

  @override
  _ExpandableListItemState createState() => _ExpandableListItemState();
}

class _ExpandableListItemState extends State<ExpandableListItem> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      margin: EdgeInsets.only(bottom: screenHeight * 0.01), // Dynamic margin
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(screenWidth * 0.02), // Dynamic border radius
        border: Border.all(
          color: const Color(0xffBCDEFF), // Border color
          width: screenWidth * 0.003, // Dynamic border width
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(screenWidth * 0.02), // Dynamic padding
                  child: Text(
                    'Item ${widget.index}: Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                    style: TextStyle(
                      fontSize: screenWidth * 0.03, // Dynamic font size
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Container(
                height: screenWidth * 0.09, // Dynamic height
                width: screenWidth * 0.09, // Dynamic width
                decoration: BoxDecoration(
                  color: _isExpanded ? Colors.blue : const Color(0xffBCDEFF), // Dynamic color
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  padding: EdgeInsets.zero, // Remove padding
                  onPressed: () {
                    setState(() {
                      _isExpanded = !_isExpanded;
                    });
                  },
                  icon: Icon(
                    _isExpanded ? Icons.remove : Icons.add,
                    color: const Color(0xff000000),
                  ),
                  iconSize: screenWidth * 0.05, // Dynamic icon size
                ),
              ),
            ],
          ),
          if (_isExpanded) // Show description text if expanded
            Padding(
              padding: EdgeInsets.all(screenWidth * 0.02), // Dynamic padding
              child: Text(
                'This is the detailed description for the item. It appears when the item is expanded.',
                style: TextStyle(
                  fontSize: screenWidth * 0.03, // Dynamic font size
                  color: Color(0xff737373),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
