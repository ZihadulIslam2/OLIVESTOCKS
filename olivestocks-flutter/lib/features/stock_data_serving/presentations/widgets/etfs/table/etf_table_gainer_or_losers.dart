import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class EtfTableScreen extends StatelessWidget {
  final List<Map<String, String>> etfData = List.generate(8, (index) {
    return {
      'ticker': 'XYLZ',
      'title': 'Vanguard ESG US Stock ETF',
      'price': '\$${(35 + index).toStringAsFixed(2)}',
      'changePercent': '${(9 + index * 0.2).toStringAsFixed(2)}%',
      'changeValue': '+${(3.5 + index * 0.1).toStringAsFixed(2)}',
    };
  });

  EtfTableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6FDF8),
      appBar: AppBar(
        title: const Text('ETF Tracker'),
        centerTitle: true,
        backgroundColor: Colors.green.shade700,
      ),
      body: Column(
        children: [
          const TableHeader(),
          const Divider(height: 1),
          Expanded(
            child: ListView.builder(
              itemCount: etfData.length,
              itemBuilder: (context, index) {
                final etf = etfData[index];
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Color(0xFFE0E0E0)),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              etf['ticker']!,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              etf['title']!,
                              style: const TextStyle(fontSize: 12, color: Colors.grey),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          etf['price']!,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Row(
                          children: [
                            const Icon(Icons.arrow_drop_up, color: Colors.green, size: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  etf['changePercent']!,
                                  style: const TextStyle(
                                      color: Colors.green, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  etf['changeValue']!,
                                  style: const TextStyle(color: Colors.green, fontSize: 12),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(12),
            child: const Text(
              "See more",
              style: TextStyle(color: Colors.green, fontWeight: FontWeight.w500),
            ),
          )
        ],
      ),
    );
  }
}

class TableHeader extends StatelessWidget {
  const TableHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFD6F2E5),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: const [
          Expanded(flex: 4, child: Text("ETF", style: TextStyle(fontWeight: FontWeight.bold))),
          Expanded(flex: 2, child: Text("Price", style: TextStyle(fontWeight: FontWeight.bold))),
          Expanded(
              flex: 3,
              child: Text("Price\nChange",
                  style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.left)),
        ],
      ),
    );
  }
}
