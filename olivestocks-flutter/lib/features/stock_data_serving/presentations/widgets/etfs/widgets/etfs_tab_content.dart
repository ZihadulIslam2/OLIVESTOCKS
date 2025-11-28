import 'package:flutter/material.dart';

class ETFsTabContent extends StatelessWidget {
  const ETFsTabContent({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> data = List.generate(
      6,
      (index) => {
        'etf': 'SPY',
        'volume': '32.14M',
        'price': '\$502.10',
        'change': '+0.87%',
        'isPositive': true,
      },
    );

    return SingleChildScrollView(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Most Traded ETFs',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ...data.map((etf) => ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(etf['etf']),
                subtitle: Text('Volume: ${etf['volume']}'),
                trailing: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(etf['price']),
                    Text(
                      etf['change'],
                      style: TextStyle(
                        color: etf['isPositive'] ? Colors.green : Colors.red,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
