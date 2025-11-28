import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../experts/domain/market_item.dart';
import '../../controller/portfolio_controller.dart';


class MarketHeaderCardNew extends StatelessWidget {
  const MarketHeaderCardNew({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<PortfolioController>(
      builder: (controller) {
        return SizedBox(
          height: size.height * 0.1, // set height to fit the card content
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: controller.stockList.length,
            padding: const EdgeInsets.symmetric(horizontal: 0),
            itemBuilder: (context, index) {
              final item = controller.stockList[index];
              final isPositive = item.change >= 0;
              return Container(
                width: size.width * 0.70, // set width to fit the card content
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blueGrey.withOpacity(0.1),
                      spreadRadius: 0,
                      blurRadius: 10,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              item.name.toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                color: Colors.blue,
                              ),
                            ),
                            Text(
                              item.symbol.toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                                color: Colors.blue,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  item.currentPrice.toString(),
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                // const Icon(Icons.info_outline, size: 12),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${item.change >= 0 ? '+' : ''}${item.change.toStringAsFixed(2)} (${(item.percent * 100).toStringAsFixed(2)}%)',
                              style: TextStyle(
                                color: isPositive ? Colors.green : Colors.red,
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 10),
                        Container(
                          width: size.width * 0.16,
                          child: Image.asset('assets/new_image/marketGraph.png'),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        );
      }
    );
  }
}
