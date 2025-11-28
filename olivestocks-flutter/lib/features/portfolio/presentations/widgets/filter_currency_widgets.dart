import 'package:flutter/material.dart';

class CurrencyFilterChip extends StatefulWidget {
  final Function(String)? onCurrencyChanged;

  const CurrencyFilterChip({
    Key? key,
    this.onCurrencyChanged,
  }) : super(key: key);

  @override
  State<CurrencyFilterChip> createState() => _CurrencyFilterChipState();
}

class _CurrencyFilterChipState extends State<CurrencyFilterChip> {
  String _selectedCurrency = 'USD';

  final Map<String, Map<String, String>> _currencyData = {
    'USD': {
      'flag': '🇺🇸',
      'name': '',
    },
    'GBP': {
      'flag': '🇬🇧',
      'name': '',
    },
    'EUR': {
      'flag': '🇪🇺',
      'name': '',
    },
    'JPY': {
      'flag': '🇯🇵',
      'name': '',
    },
  };

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: _showCurrencyOptions,
      child: Container(
        width: size.width* .15 ,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.green, width: 1.5),
          borderRadius: BorderRadius.circular(20),
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _currencyData[_selectedCurrency]!['flag']!,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(width: 4),
              Text(
                _selectedCurrency,
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
      ),
    );
  }

  Future<void> _showCurrencyOptions() async {
    final selectedCurrency = await showModalBottomSheet<String>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "Select Currency",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Divider(height: 1, thickness: 1),
              ..._currencyData.entries.map((entry) {
                final currencyCode = entry.key;
                final currencyData = entry.value;

                return Column(
                  children: [
                    ListTile(
                      leading: Text(
                        currencyData['flag']!,
                        style: const TextStyle(fontSize: 16),
                      ),
                      title: Text('$currencyCode  ${currencyData['name']}'),
                      trailing: _selectedCurrency == currencyCode
                          ? const Icon(Icons.check, color: Colors.green)
                          : null,
                      onTap: () => Navigator.pop(context, currencyCode),
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

    if (selectedCurrency != null) {
      setState(() {
        _selectedCurrency = selectedCurrency;
      });

      widget.onCurrencyChanged?.call(selectedCurrency);
    }
  }
}
