import 'package:flutter/material.dart';

class FilterChipsWidget extends StatefulWidget {
  final Function(Map<String, String>)? onFiltersChanged;

  const FilterChipsWidget({
    Key? key,
    this.onFiltersChanged,
  }) : super(key: key);

  @override
  State<FilterChipsWidget> createState() => _FilterChipsWidgetState();
}

class _FilterChipsWidgetState extends State<FilterChipsWidget> {
  // Current selected values
  late Map<String, String> _dropdownValues = {
    'market': 'US',
    'score': 'Any',
    'impact': 'Any',
    'action': 'Buy',
  };

  // Available options for each filter
  final Map<String, List<String>> _dropdownOptions = {
    'market': ['US', 'UK', 'EU', 'Asia'],
    'score': ['Any', 'High', 'Medium', 'Low'],
    'impact': ['Mega(Over 2)', 'Medium', 'Low', 'Any'],
    'action': ['Buy', 'Sell', 'Hold'],
  };

  // Display labels for each filter
  final Map<String, String> _dropdownLabels = {
    'market': 'Market',
    'score': 'Smart Score',
    'impact': 'Market cap',
    'action': 'Action',
  };

  // Country flags mapping
  final Map<String, String> _countryFlags = {
    'US': '🇺🇸',
    'UK': '🇬🇧',
    'EU': '🇪🇺',
    'Asia': '🌏',
  };

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        height: 38,
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Row(
          children: [
            const SizedBox(width: 8),
            _buildFilterChip('market'),
            const SizedBox(width: 8),
            _buildFilterChip('score'),
            const SizedBox(width: 8),
            _buildFilterChip('impact'),
            const SizedBox(width: 8),
            _buildFilterChip('action'),
            const SizedBox(width: 8),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String type) {
    final isMarket = type == 'market';
    final selectedValue = _dropdownValues[type]!;

    return GestureDetector(
      onTap: () => _showFilterOptions(type),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.green, width: 1.5),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "${_dropdownLabels[type]}: ",
              style: const TextStyle(
                color: Colors.green,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (isMarket)
              Padding(
                padding: const EdgeInsets.only(right: 4),
                child: Text(
                  _countryFlags[selectedValue] ?? '',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            Text(
              selectedValue,
              style: const TextStyle(
                color: Colors.green,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 2),
            const Icon(Icons.arrow_drop_down, color: Colors.green, size: 18),
          ],
        ),
      ),
    );
  }

  Future<void> _showFilterOptions(String type) async {
    final selectedValue = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "Select ${_dropdownLabels[type]}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Divider(height: 1, thickness: 1),
              ..._dropdownOptions[type]!.map((option) {
                return Column(
                  children: [
                    ListTile(
                      leading: type == 'market'
                          ? Text(_countryFlags[option] ?? '', style: const TextStyle(fontSize: 24))
                          : null,
                      title: Text(option),
                      trailing: _dropdownValues[type] == option
                          ? const Icon(Icons.check, color: Colors.green)
                          : null,
                      onTap: () => Navigator.pop(context, option),
                    ),
                    const Divider(height: 1, thickness: 1),
                  ],
                );
              }).toList(),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );

    if (selectedValue != null) {
      setState(() {
        _dropdownValues[type] = selectedValue;
      });

      if (widget.onFiltersChanged != null) {
        widget.onFiltersChanged!(_dropdownValues);
      }
    }
  }
}