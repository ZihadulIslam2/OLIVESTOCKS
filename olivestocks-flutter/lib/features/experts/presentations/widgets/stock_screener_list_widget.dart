import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:olive_stocks_flutter/features/experts/presentations/widgets/top_lock_widget.dart';

import '../../../../common/data/all_data.dart';
import 'linear_percent_smart_stock_widget.dart';
import 'linear_percent_widget.dart';



Widget buildStockScannerList(BuildContext context)  {

  var stockData = AllData.stockDatas;

  Size size = MediaQuery.of(context).size;
  //return TestIndicator();
  return Row(
    children: [
      Container(
        width: 136,
        child: IntrinsicHeight(
          child: Column(
            children: [
              Container(color: Color(0xffB0B0B0), height: 1, width: 1000),
              Container(
                width: 136,
                height: 31,
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
                child: Center(
                  child: const Text(
                    "Symbol",
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 11),
                  ),
                ),
              ),

              Container(color: Color(0xffB0B0B0), height: 2, width: 1000),
              Expanded(
                child: Container(
                  width: 300,
                  child: Column(
                    children: List.generate(stockData.length, (index) {
                      return Container(
                        height: 60,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                            bottom: BorderSide(color: Colors.grey.shade200),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 24,
                                width: 24,
                                child: Image.asset(
                                  stockData[index].logo,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(
                                    Icons.error,
                                    size: 20,
                                  ),
                                ),
                              ),
                              SizedBox(width: 5,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    stockData[index].symbol,
                                    style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    stockData[index].name,
                                    style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xffB0B0B0),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          )
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      //End of header
      // Scrollable Content Columns
      Expanded(
        child: SizedBox(
          // width: 800, // Should match header width
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              // width: 1000,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(color: Color(0xffB0B0B0), height: 1, width: 1323),
                  Container(
                    height: 30, // Total width of scrollable content
                    child: Row(
                      children: [
                        // Dividend Amount
                        Container(
                          width: 100,
                          child: const Center(
                            child: Text(
                              "Price",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ),
                        // Dividend Yield
                        Container(
                          width: 100,
                          child: const Center(
                            child: Text(
                              "Smart Score",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 100,
                          child: const Center(
                            child: Text(
                              "Sector",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 165,
                          child: const Center(
                            child: Text(
                              "Analyst Consensus",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ),

                        // Add more headers as needed
                        Container(
                          width: 130,
                          child: const Center(
                            child: Text(
                              "Analyst Price Target",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 120,
                          child: const Center(
                            child: Text(
                              "Market Cap",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 130,
                          child: const Center(
                            child: Text(
                              "Top Analyst Consensus",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 130,
                          child: const Center(
                            child: Text(
                              "Top Analyst Price Target",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 143,
                          child: const Center(
                            child: Text(
                              "Blogger Consensus",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 125,
                          child: const Center(
                            child: Text(
                              "Insider Signal",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 143,
                          child: const Center(
                            child: Text(
                              "Hedge Fund Signal",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 150,
                          child: const Center(
                            child: Text(
                              "News Sentiment",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 120,
                          child: const Center(
                            child: Text(
                              "Dividend Yield",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Container(color: Color(0xffB0B0B0), height: 2, width: 1658),
                  Container(
                    child: Column(
                      children: List.generate(stockData.length, (index) {
                        return Column(

                          children: [
                            Container(
                              height: 60,
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.grey.shade200,
                                  ),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 100,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          stockData[index].price,
                                          style: const TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text(
                                          stockData[index].priceChange,
                                          style: const TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.green,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Dividend Yield
                                  Container(
                                    width: 100,
                                    child: Center(
                                      child: Container(
                                        height: 22,
                                        width: 46,
                                        child: Image.asset(
                                          stockData[index].smartScore,
                                          fit: BoxFit.cover,
                                          errorBuilder: (context, error, stackTrace) =>
                                          const Icon(
                                            Icons.error,
                                            size: 10,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 100,
                                    child: Center(
                                      child: Text(
                                        stockData[index].sector,
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    //height: 108,
                                    width: size.width * .4,
                                    child: Column(
                                      children: [
                                        Container(
                                          width: size.width * 0.30,
                                          child: LinearPercentWidget2(
                                            widgetWidth: size.width*0.3,
                                            strongBuy: 60,
                                            moderateBuy: 30,
                                            hold: 40,
                                            strongSell: 10,
                                            moderateSell: 10,
                                            ratingLabel: "Moderate Buy",
                                            ratingColor: Colors.black,
                                          ),
                                        ),

                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: 130,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          stockData[index].analystPriceTarget,
                                          style: const TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text(
                                          stockData[index].analystPriceTargetChange,
                                          style: const TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.green,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: 120,
                                    child: Center(
                                      child: Text(
                                        stockData[index].marketCap,
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 130,
                                    child: Center(
                                      child: Container(
                                        height: 22,
                                        width: 46,
                                        child: Image.asset(
                                          stockData[index].topAnalystConsensus,
                                          fit: BoxFit.cover,
                                          errorBuilder: (context, error, stackTrace) =>
                                          const Icon(
                                            Icons.error,
                                            size: 10,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 116,
                                    child: Center(
                                      child: Container(
                                        height: 22,
                                        width: 46,
                                        child: Image.asset(
                                          stockData[index].topAnalystPriceTarget,
                                          fit: BoxFit.cover,
                                          errorBuilder: (context, error, stackTrace) =>
                                          const Icon(
                                            Icons.error,
                                            size: 10,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                  SizedBox(width: 15),
                                  Container(
                                    height: 108,
                                    width: 143,
                                    child: Column(
                                      children: [
                                        Text(
                                          stockData[index].newsSentiment.ratingLabel,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black,
                                          ),
                                        ),
                                        LinearPercentSmartStockWidget(
                                          widgetWidth: size.width * .29,
                                          ratingLabel: ThreeRatingLabelIndication("Bullish"),
                                          census: [
                                            AnalystConsensus(color: Color(0xFFFF5733), label: "Bullish", value: stockData[index]
                                                .newsSentiment
                                                .moderateSell,),
                                            AnalystConsensus(color: Colors.orange, label: "Neutral", value: stockData[index]
                                                .newsSentiment.strongBuy),
                                            AnalystConsensus(color: Colors.green, label: "Bearish", value: stockData[index]
                                                .newsSentiment.moderateBuy),
                                          ]
                                        ),

                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 15),
                                  Container(
                                    width: 110,
                                    child: Center(
                                      child: Container(
                                         height: 19,
                                         width: 70,
                                        child: Image.asset(
                                          stockData[index].insiderSignal,
                                          fit: BoxFit.cover,
                                          errorBuilder: (context, error, stackTrace) =>
                                          const Icon(
                                            Icons.error,
                                            size: 10,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 143,
                                    child: Center(
                                      child: Container(
                                        height: 22,
                                        width: 46,
                                        child: Image.asset(
                                          stockData[index].hedgeFundSignal,
                                          fit: BoxFit.cover,
                                          errorBuilder: (context, error, stackTrace) =>
                                          const Icon(
                                            Icons.error,
                                            size: 10,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 108,
                                    width: 150,
                                    child: Column(
                                      children: [
                                        Text(
                                          'Neutral',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black,
                                          ),
                                        ),
                                    LinearPercentSmartStockWidget(
                                      ratingLabel: FiveRatingLabelIndication("Moderate Sell"),
                                      widgetWidth: size.width * .3,
                                      census: [
                                        AnalystConsensus(color: Color(0xFFFF5733), label: "Moderate Sell", value: stockData[index]
                                            .newsSentiment
                                            .moderateSell,),
                                        AnalystConsensus(color: Colors.red, label: "Strong Sell", value: stockData[index]
                                            .newsSentiment.strongSell),
                                        AnalystConsensus(color: Colors.grey, label: "Hold", value: stockData[index]
                                            .newsSentiment.hold),
                                        AnalystConsensus(color: Color(0xFF1E7D34), label: "Strong Buy", value: stockData[index]
                                            .newsSentiment.strongBuy),
                                        AnalystConsensus(color: Colors.green, label: "Moderate Buy", value: stockData[index]
                                            .newsSentiment.moderateBuy),
                                      ]
                                      ,
                                    ),

                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: 120,
                                    child: Center(
                                      child: Text(
                                        stockData[index].dividendYield,
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ],
  );
}
