import 'package:flutter/material.dart';

class CustomDropdownFilter extends StatefulWidget {
  final String label;
  final List<String> options;
  final ValueChanged<String> onChanged;

  const CustomDropdownFilter({
    super.key,
    required this.label,
    required this.options,
    required this.onChanged,
  });

  @override
  State<CustomDropdownFilter> createState() => _CustomDropdownFilterState();
}

class _CustomDropdownFilterState extends State<CustomDropdownFilter> {
  late String selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.options.first; // Default: index 0
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.30,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.green),
        borderRadius: BorderRadius.circular(30),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isDense: true,
          isExpanded: true,
          icon: const Icon(Icons.arrow_drop_down, size: 16),
          value: selectedValue,
          iconEnabledColor: Colors.green,
          style: const TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.normal,
            fontSize: 12,
          ),
          onChanged: (newValue) {
            if (newValue != null) {
              setState(() {
                selectedValue = newValue;
              });
              widget.onChanged(newValue);
            }
          },
          items: widget.options.map((item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  "${widget.label} : $item",
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
