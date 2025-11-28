// lib/widgets/filters_widget.dart
import 'package:flutter/material.dart';

class FiltersWidget extends StatefulWidget {
  const FiltersWidget({super.key});

  @override
  State<FiltersWidget> createState() => _FiltersWidgetState();
}

class _FiltersWidgetState extends State<FiltersWidget> {
  String selectedSector = "All Sector";
  String selectedBenchmark = "None";
  String selectedPeriod = "1 Year";

  final List<String> sectorOptions = ['All Sector', 'Technology', 'Healthcare', 'Finance'];
  final List<String> benchmarkOptions = ['None', 'S&P 500', 'Dow Jones', 'NASDAQ'];
  final List<String> periodOptions = ['1 Year', '6 Months', '3 Months', '1 Month'];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: [
        _buildCustomDropdown(
          size: size,
          label: "Sector",
          value: selectedSector,
          options: sectorOptions,
          onChanged: (value) {
            setState(() => selectedSector = value);
          },
        ),
        _buildCustomDropdown(
          size: size,
          label: "Benchmark",
          value: selectedBenchmark,
          options: benchmarkOptions,
          onChanged: (value) {
            setState(() => selectedBenchmark = value);
          },
        ),
        _buildCustomDropdown(
          size: size,
          label: "Period",
          value: selectedPeriod,
          options: periodOptions,
          onChanged: (value) {
            setState(() => selectedPeriod = value);
          },
        ),
      ],
    );
  }

  Widget _buildCustomDropdown({
    required Size size,
    required String label,
    required String value,
    required List<String> options,
    required ValueChanged<String> onChanged,
  }) {
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
          value: value,
          iconEnabledColor: Colors.green,
          style: const TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.normal,
            fontSize: 12,
          ),
          onChanged: (newValue) {
            if (newValue != null) {
              onChanged(newValue);
            }
          },
          items: options.map((item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  "$label : $item",
                  style: const TextStyle(fontSize: 12,fontWeight: FontWeight.bold, color: Colors.green),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}