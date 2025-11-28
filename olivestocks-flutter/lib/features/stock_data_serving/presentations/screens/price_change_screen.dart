import 'package:flutter/material.dart';

class PriceChangeCryptoScreener extends StatelessWidget {
  final List<Map<String, dynamic>> cryptoData = [
    {
      "symbol": "BTC",
      "name": "Bitcoin",
      "logo": "assets/logos/btc.png",
      "price": "\$78,908.58",
      "change": "+\$703.25 (▲0.89%)",
      "changeColor": Colors.green,
    },
    {
      "symbol": "TONCOIN",
      "name": "Toncoin",
      "logo": "assets/logos/toncoin.png",
      "price": "-",
      "change": "-",
      "changeColor": Colors.grey,
    },
    {
      "symbol": "ETH",
      "name": "Ethereum",
      "logo": "assets/logos/btc.png",
      "price": "\$2,123.56",
      "change": "-\$45.12 (▼2.03%)",
      "changeColor": Colors.red,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return _buildCryptoListView();
  }

  Widget _buildCryptoListView() {
    return ListView.separated(
      itemCount: cryptoData.length * 3, // Repeat data for demonstration
      separatorBuilder: (_, __) => const Divider(height: 1, thickness: 0.5),
      itemBuilder: (context, index) {
        return _buildCryptoRow(cryptoData[index % cryptoData.length]);
      },
    );
  }

  Widget _buildCryptoRow(Map<String, dynamic> data) {
    return Container(
      height: 60,
      child: Row(
        children: [
          Container(
            width: 136,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  offset: const Offset(0, 2),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Row(
              children: [
                Image.asset(
                  data["logo"],
                  width: 24,
                  height: 24,
                  errorBuilder:
                      (context, error, stackTrace) =>
                  const Icon(Icons.error, size: 20),
                ),
                const SizedBox(width: 8),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data["symbol"],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      data["name"],
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(data["price"], style: const TextStyle(fontSize: 14)),
                  const SizedBox(height: 4),
                  Text(
                    data["change"],
                    style: TextStyle(color: data["changeColor"], fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 60,
            child: Center(child: Text("73.98", style: TextStyle(fontSize: 14))),
          ),
        ],
      ),
    );
  }
}