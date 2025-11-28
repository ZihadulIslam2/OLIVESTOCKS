import 'package:flutter/material.dart';

class MostTradedStocks extends StatefulWidget {
  const MostTradedStocks({super.key});

  @override
  State<MostTradedStocks> createState() => _MostTradedStocksState();
}

class _MostTradedStocksState extends State<MostTradedStocks> {
  @override
  Widget build(BuildContext context) {
    // final data = List.generate(
    //   6,
    //   (index) => {
    //     'company': 'NVDA',
    //     'volume': '50.45M',
    //     'price': '\$820.75',
    //     'change': '-7.15%',
    //     'isPositive': false,
    //   },
    // );
    final List<Map<String, dynamic>> data = List.generate(
  6,
  (index) => {
    'company': 'NVDA',
    'volume': '50.45M',
    'price': '\$820.75',
    'change': '-7.15%',
    'isPositive': false,
  },
);


    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Most Traded Stocks', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        ...data.map((stock) => ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(stock['company']!),
              subtitle: Text('Volume: ${stock['volume']}'),
              trailing: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(stock['price']!),
                  Text(
                    stock['change']!,
                    style: TextStyle(
                      color: stock['isPositive']! ? Colors.green : Colors.red,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            )),
      ],
    );
  }
}
