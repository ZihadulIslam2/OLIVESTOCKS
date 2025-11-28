import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:olive_stocks_flutter/core/contants/subcription_utils.dart';
import 'package:olive_stocks_flutter/features/auth/controllers/auth_controller.dart';
import '../../../markets/presentations/screens/single_stock_market.dart';
import '../../../markets/presentations/widgets/svg_widget.dart';
import '../../../portfolio/controller/portfolio_controller.dart';
import '../../../portfolio/domains/olive_stocks_portfolio_response_model.dart';



class TopSmartScoreList extends StatelessWidget {
  TopSmartScoreList({super.key, required this.oliveStocks});
   List<OliveStocks>? oliveStocks;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    String formatDateTime(String isoDate) {
      try {
        final dateTime = DateTime.parse(isoDate).toLocal();
        return DateFormat('MMM d, y • h:mm a').format(dateTime);
      } catch (e) {
        return 'Invalid date';
      }
    }

    String formatAbbreviatedCurrency(String? value) {
      if (value == null || value.isEmpty) return 'N/A';

      // Remove dollar sign and commas
      String cleaned = value.replaceAll(RegExp(r'[\$,]'), '');

      double? number = double.tryParse(cleaned);
      if (number == null) return 'N/A';

      if (number >= 1e12) {
        return '\$${(number / 1e12).toStringAsFixed(2)}T';
      } else if (number >= 1e9) {
        return '\$${(number / 1e9).toStringAsFixed(2)}B';
      } else if (number >= 1e6) {
        return '\$${(number / 1e6).toStringAsFixed(2)}M';
      } else if (number >= 1e3) {
        return '\$${(number / 1e3).toStringAsFixed(2)}K';
      } else {
        return '\$${number.toStringAsFixed(2)}';
      }
    }

    return GetBuilder<AuthController>(builder: (authController){
      return GetBuilder<PortfolioController>(builder: (portfolioController){
        oliveStocks = portfolioController.oliveStocksPortfolioResponseModel?.oliveStocks;
        final subscriptionStatus = authController.getSingleUserResponseModel?.payment ?? "Free";

        return !portfolioController.isUnderRadarLoading ?Row(
          children: [
            Container(
              width: 136,
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    Container(color: Color(0xffB0B0B0), height: 1, width: 1000),
                    Container(
                      width: 136,
                      height: size.width * 0.07,
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
                        width: size.width * 0.5,
                        child: Column(
                          children: List.generate(oliveStocks!.length, (index) {
                            return GestureDetector(
                              onTap: () {
                                Get.to(SingleStockMarket(symbol: oliveStocks![index].symbol!,));
                              },
                              child: Container(
                                height: 60,
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border(
                                    bottom: BorderSide(color: Colors.grey.shade200),
                                  ),
                                ),
                                child: buildSubscriptionContent(
                                  subscriptionStatus: subscriptionStatus,
                                  context: context,
                                  child: Row(
                                    children: [
                                      Image.network(
                                        oliveStocks![index].logo!,
                                        height: 30,
                                        width: 30,
                                        errorBuilder: (context, error, stackTrace) =>
                                        const Icon(Icons.error, size: 20),
                                        fit: BoxFit.contain,
                                      ),

                                      const SizedBox(width: 8),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            oliveStocks![index].symbol!,
                                            style: const TextStyle(fontWeight: FontWeight.bold),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text(
                                            oliveStocks![index].companyName!,
                                            style: const TextStyle(fontWeight: FontWeight.w400,fontSize: 10),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      )],
                                  ),
                                ),
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
                        Container(color: Color(0xffB0B0B0), height: 1, width: 710),
                        Container(
                          height: 30, // Total width of scrollable content
                          child: Row(
                            children: [
                              // Dividend Amount
                              Container(

                                width: size.width * 0.3,
                                child: const Center(
                                  child: Text(
                                    "Olive Stocks score",
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
                                    "Our choice Since",
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
                                    "Price",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 11,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: 96,
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

                              // Add more headers as needed
                              // Container(
                              //
                              //   width: 100,
                              //   child: const Center(
                              //     child: Text(
                              //       "P/E Ratio",
                              //       style: TextStyle(
                              //         fontWeight: FontWeight.w400,
                              //         fontSize: 11,
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              Container(
                                width: 120,
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
                              // Container(
                              //
                              //   width: 100,
                              //   child: const Center(
                              //     child: Text(
                              //       "Dividend Yield",
                              //       style: TextStyle(
                              //         fontWeight: FontWeight.w400,
                              //         fontSize: 11,
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              Container(
                                width: 100,
                                child: const Center(
                                  child: Text(
                                    "Yearly Gain",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 11,
                                    ),
                                  ),
                                ),
                              ),
                              // Container(
                              //   width: 143,
                              //   child: const Center(
                              //     child: Text(
                              //       "News Sentiment",
                              //       style: TextStyle(
                              //         fontWeight: FontWeight.w400,
                              //         fontSize: 11,
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              // Container(
                              //   width: 172,
                              //   child: const Center(
                              //     child: Text(
                              //       "Investor Sentiment",
                              //       style: TextStyle(
                              //         fontWeight: FontWeight.w400,
                              //         fontSize: 11,
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              // Container(
                              //   width: 143,
                              //   child: const Center(
                              //     child: Text(
                              //       "Blogger Sentiment",
                              //       style: TextStyle(
                              //         fontWeight: FontWeight.w400,
                              //         fontSize: 11,
                              //       ),
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        ),

                        Container(color: Color(0xffB0B0B0), height: 2, width: 710),
                        Container(
                          child: Column(
                            children: List.generate(oliveStocks!.length, (index) {
                              return GestureDetector(
                                onTap: (){
                                  Get.to(SingleStockMarket(symbol: oliveStocks![index].symbol!,));
                                },
                                child: Column(
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
                                          // Dividend Amount
                                          Container(
                                              height: size.height * .6,
                                              width: size.width * .3,
                                              padding: EdgeInsets.only(top: 15),
                                              child: OliveTreeSvg(
                                                oliveColors: {
                                                  "financialHealth":
                                                  portfolioController
                                                      .oliveStocksPortfolioResponseModel!
                                                      .oliveStocks![index]
                                                      .olives!
                                                      .financialHealth!,
                                                  "competitiveAdvantage":
                                                  portfolioController
                                                      .oliveStocksPortfolioResponseModel!
                                                      .oliveStocks![index]
                                                      .olives!
                                                      .competitiveAdvantage!,
                                                  "valuation":
                                                  portfolioController
                                                      .oliveStocksPortfolioResponseModel!
                                                      .oliveStocks![index]
                                                      .olives!
                                                      .valuation!,
                                                },
                                              )
                                          ),
                                          // Dividend Yield
                                          Container(
                                            width: 100,
                                            child: Center(
                                              child: Text(
                                                formatDateTime(oliveStocks![index].lastRatingDate!),
                                                style: TextStyle(fontSize: 11, color: Colors.green),
                                              ),
                                            ),
                                          ),
                                          Container(

                                            width: 150,
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    oliveStocks![index].analystTarget!,
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                  // Text(
                                                  //   "▲27.27% (Upside)",
                                                  //   style: TextStyle(
                                                  //     fontSize: 14,
                                                  //     color: Colors.red,
                                                  //   ),
                                                  // ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: 96,
                                            child: Center(
                                              // child: TopLockWidget(lockPosition: -35, boxAlignment: Alignment.centerRight),

                                              child: Text(formatAbbreviatedCurrency(oliveStocks![index].marketCap),),

                                            ),
                                          ),
                                          // Container(
                                          //   width: 100,
                                          //   // child: Center(
                                          //   //   child: Text(
                                          //   //     stockData[index].peRatio,
                                          //   //     style: const TextStyle(fontSize: 14),
                                          //   //   ),
                                          //   // ),
                                          // ),
                                          Container(
                                            width: 120,
                                            child: Center(
                                              child: Text(
                                                oliveStocks![index].sector!,
                                                style: const TextStyle(fontSize: 14),
                                              ),
                                            ),
                                          ),
                                          // Container(
                                          //   width: 100,
                                          //   child: Center(
                                          //     // child: Text(
                                          //     //   stockData[index].dividendYield,
                                          //     //   style: const TextStyle(fontSize: 14),
                                          //     // ),
                                          //   ),
                                          // ),
                                          Container(
                                            width: 100,
                                            child: Center(
                                              child: Text(
                                                oliveStocks![index].oneMonthReturn!,
                                                style: const TextStyle(fontSize: 14,color: Colors.green),
                                              ),
                                            ),
                                          ),
                                          // Container(
                                          //   //height: 108,
                                          //   width: 143,
                                          //   // child: Column(
                                          //   //   children: [
                                          //   //     Text('Very Bullish',
                                          //   //       style: TextStyle(
                                          //   //         fontSize: 14,
                                          //   //         color: Colors.black,
                                          //   //       ),
                                          //   //     ),
                                          //   //     LinearPercentSmartStockWidget(
                                          //   //       widgetWidth: size.width * .28,
                                          //   //       ratingLabel: FiveRatingLabelIndication("Moderate Buy"),
                                          //   //       census: [
                                          //   //         AnalystConsensus(color: Color(0xFFFF5733), label: "Moderate Sell", value: stockData[index]
                                          //   //             .newsSentiment
                                          //   //             .moderateSell,),
                                          //   //         AnalystConsensus(color: Colors.red, label: "Strong Sell", value: stockData[index]
                                          //   //             .newsSentiment.strongSell),
                                          //   //         AnalystConsensus(color: Colors.grey, label: "Hold", value: stockData[index]
                                          //   //             .newsSentiment.hold),
                                          //   //         AnalystConsensus(color: Color(0xFF1E7D34), label: "Strong Buy", value: stockData[index]
                                          //   //             .newsSentiment.strongBuy),
                                          //   //         AnalystConsensus(color: Colors.green, label: "Moderate Buy", value: stockData[index]
                                          //   //             .newsSentiment.moderateBuy),
                                          //   //       ]
                                          //   //       ,
                                          //   //     ),
                                          //   //
                                          //   //   ],
                                          //   // ),
                                          // ),
                                          SizedBox(width: 15,),
                                          // Container(
                                          //   height: 108,
                                          //   width: 143,
                                          //   // child: Column(
                                          //   //   children: [
                                          //   //     Text('Neutral',
                                          //   //       style: TextStyle(
                                          //   //         fontSize: 14,
                                          //   //         color: Colors.black,
                                          //   //       ),
                                          //   //     ),
                                          //   //     LinearPercentSmartStockWidget(
                                          //   //       widgetWidth: size.width * .28,
                                          //   //       ratingLabel: FiveRatingLabelIndication("Moderate Buy"),
                                          //   //       census: [
                                          //   //         AnalystConsensus(color: Color(0xFFFF5733), label: "Moderate Sell", value: stockData[index]
                                          //   //             .newsSentiment
                                          //   //             .moderateSell,),
                                          //   //         AnalystConsensus(color: Colors.red, label: "Strong Sell", value: stockData[index]
                                          //   //             .newsSentiment.strongSell),
                                          //   //         AnalystConsensus(color: Colors.grey, label: "Hold", value: stockData[index]
                                          //   //             .newsSentiment.hold),
                                          //   //         AnalystConsensus(color: Color(0xFF1E7D34), label: "Strong Buy", value: stockData[index]
                                          //   //             .newsSentiment.strongBuy),
                                          //   //         AnalystConsensus(color: Colors.green, label: "Moderate Buy", value: stockData[index]
                                          //   //             .newsSentiment.moderateBuy),
                                          //   //       ]
                                          //   //       ,
                                          //   //     ),
                                          //   //
                                          //   //   ],
                                          //   // ),
                                          // ),
                                          SizedBox(width: 15,),
                                          // Container(
                                          //   height: 108,
                                          //   width: 143,
                                          //   // child: Column(
                                          //   //   children: [
                                          //   //     Text('Bullish',
                                          //   //       style: TextStyle(
                                          //   //         fontSize: 14,
                                          //   //         color: Colors.black,
                                          //   //       ),
                                          //   //     ),
                                          //   //     LinearPercentSmartStockWidget(
                                          //   //       widgetWidth: size.width * .28,
                                          //   //       ratingLabel: FiveRatingLabelIndication("Moderate Buy"),
                                          //   //       census: [
                                          //   //         AnalystConsensus(color: Color(0xFFFF5733), label: "Moderate Sell", value: stockData[index]
                                          //   //             .newsSentiment
                                          //   //             .moderateSell,),
                                          //   //         AnalystConsensus(color: Colors.red, label: "Strong Sell", value: stockData[index]
                                          //   //             .newsSentiment.strongSell),
                                          //   //         AnalystConsensus(color: Colors.grey, label: "Hold", value: stockData[index]
                                          //   //             .newsSentiment.hold),
                                          //   //         AnalystConsensus(color: Color(0xFF1E7D34), label: "Strong Buy", value: stockData[index]
                                          //   //             .newsSentiment.strongBuy),
                                          //   //         AnalystConsensus(color: Colors.green, label: "Moderate Buy", value: stockData[index]
                                          //   //             .newsSentiment.moderateBuy),
                                          //   //       ],
                                          //   //     ),
                                          //   //   ],
                                          //   // ),
                                          // ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
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
        ) : Center(
          child: CircularProgressIndicator(),
        );
      });
    });
  }
}

