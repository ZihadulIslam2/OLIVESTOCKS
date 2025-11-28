import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../experts/domain/market_item.dart';
import '../../../../../markets/presentations/screens/single_stock_market.dart';

class MarketHeaderCards extends StatelessWidget {
  const MarketHeaderCards({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final List<MarketItem> data = [
      MarketItem(
        title: 'US 500 Futures',
        price: '5,121.23',
        change: '+0.22 (+0.00%)',
        isPositive: true,
      ),
      MarketItem(
        title: 'NASDAQ 100',
        price: '17,890.11',
        change: '-15.67 (-0.09%)',
        isPositive: false,
      ),
      MarketItem(
        title: 'Dow Jones',
        price: '38,150.45',
        change: '+112.34 (+0.29%)',
        isPositive: true,
      ),
      MarketItem(
        title: 'Gold Futures',
        price: '2,340.78',
        change: '-5.12 (-0.22%)',
        isPositive: false,
      ),
      MarketItem(
        title: 'Bitcoin',
        price: '64,350.99',
        change: '+12.65 (+1.90%)',
        isPositive: true,
      ),
    ];

    return Container(
      height: size.height * 0.1, // set height to fit the card content
       // set height to fit the card content
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: data.length,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (context, index) {
          final item = data[index];
          return GestureDetector(
            onTap: (){
              Get.to(SingleStockMarket(symbol: data[index].title,));
            },
            child: Container(
              width: size.width * 0.35,
              margin: const EdgeInsets.only(right: 5),
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: Row(
                    children: [

                       Container(
                        width: 3,
                        height: size.height * 0.7,
                        decoration: BoxDecoration(
                          color: item.isPositive ? Colors.green : Colors.red,
                        ),
                      ),

                      const SizedBox(width: 7),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            item.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(height: 0),
                          Row(
                            children: [
                              Text(
                                item.price,
                                style: TextStyle(
                                  fontSize: 13,
                                  color:  Colors.black ,
                                ),
                              ),
                              const SizedBox(width: 4),
                              const Icon(Icons.info_outline, size: 12),

                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item.change,
                            style: TextStyle(
                              color: item.isPositive ? Colors.green : Colors.red,
                              fontSize: 12,
                            ),
                          ),
                        ],
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
