import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../../markets/presentations/screens/single_stock_market.dart';
import '../../domains/stock_update_socket_response_model.dart';

class StockListWidget extends StatefulWidget {
  const StockListWidget({super.key});

  @override
  State<StockListWidget> createState() => _StockListWidgetState();
}

class _StockListWidgetState extends State<StockListWidget> {
  IO.Socket? socket;
  final List<StockUpdateModel> stockList = [];

  @override
  void initState() {
    super.initState();
  }

  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.1,
      color: Colors.white,
      child: stockList.isEmpty
          ? const Center(
        child: Text(
          "No Socket Data",
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      )
          : ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: stockList.length,
        itemBuilder: (context, index) {
          final item = stockList[index];
          final isPositive = item.change >= 0;

          return GestureDetector(
            onTap: () {
              Get.to(SingleStockMarket(symbol: item.symbol));
            },
            child: Container(
              width: size.width * 0.35,
              margin: const EdgeInsets.only(right: 5),
              child: Card(
                color: Colors.grey.shade100,
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: Row(
                    children: [
                      Container(
                        width: 3,
                        height: size.height * 0.07,
                        decoration: BoxDecoration(
                          color: isPositive ? Colors.green : Colors.red,
                        ),
                      ),
                      const SizedBox(width: 7),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                color: Colors.black,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 2),
                            Row(
                              children: [
                                Text(
                                  item.currentPrice.toStringAsFixed(2),
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                const Icon(Icons.info_outline, size: 12, color: Colors.black54),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${item.change >= 0 ? '+' : ''}${item.change.toStringAsFixed(2)} (${(item.percent * 100).toStringAsFixed(2)}%)',
                              style: TextStyle(
                                color: isPositive ? Colors.green : Colors.red,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
