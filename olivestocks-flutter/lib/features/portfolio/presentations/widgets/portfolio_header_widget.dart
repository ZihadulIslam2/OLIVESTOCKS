import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../markets/presentations/screens/single_stock_market.dart';
import '../../controller/portfolio_controller.dart';

class PortfolioHeaderCards extends StatefulWidget {
   const PortfolioHeaderCards({super.key});

  @override
  State<PortfolioHeaderCards> createState() => _PortfolioHeaderCardsState();
}

class _PortfolioHeaderCardsState extends State<PortfolioHeaderCards> {


  @override
  void initState() {
    super.initState();

  }



  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GetBuilder<PortfolioController>(
        builder: (portfolioController){
          print("Building stock list with ${portfolioController.stockList.length} items");
          return Container(
            height: size.height * 0.11,
            color: Colors.white,
            child: portfolioController.stockList.isEmpty
                ? Center(
              child: Text(
                "No Socket Data",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
                : ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: portfolioController.stockList.length,
              itemBuilder: (context, index) {
                final item = portfolioController.stockList[index];
                final isPositive = item.change >= 0;

                return GestureDetector(
                  onTap: () {
                    Get.to(SingleStockMarket(symbol: item.symbol));
                  },
                  child: Container(
                    width: size.width * 0.35,
                    height: size.height * 0.15,
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
                            const SizedBox(width: 20),
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
                                  Text(
                                    item.symbol,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10,
                                      color: Colors.blue,
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
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),

                                      const SizedBox(width: 4),

                                      const Icon(Icons.info_outline, size: 12, color: Colors.black54),

                                    ],
                                  ),

                                  const SizedBox(height: 4),

                                  Text(
                                    '${item.change >= 0 ? '+' : ''}${item.change.toStringAsFixed(2)} (${((item.percent * 100) ).toStringAsFixed(2)}%)',
                                    style: TextStyle(
                                      color: isPositive ? Colors.green : Colors.red,
                                      fontSize: 10,
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
    );
  }
}
