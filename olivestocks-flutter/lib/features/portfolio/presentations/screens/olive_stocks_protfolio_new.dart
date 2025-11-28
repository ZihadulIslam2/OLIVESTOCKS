import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:olive_stocks_flutter/core/contants/subcription_utils.dart';
import 'package:olive_stocks_flutter/features/auth/controllers/auth_controller.dart';
import 'package:olive_stocks_flutter/features/portfolio/controller/portfolio_controller.dart';
import 'package:olive_stocks_flutter/features/stock_data_serving/presentations/widgets/circular_percent_widget.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../../experts/presentations/widgets/circular_percent_widget.dart';
import '../../../markets/presentations/widgets/single_market_news_widget.dart';
import '../../../markets/presentations/widgets/svg_widget.dart';
import '../../../news/controllers/news_controller.dart';
import '../../../news/presentations/screens/news_details_screen.dart';
import '../../domains/olive_stocks_portfolio_response_model.dart';
import '../widgets/market_header_card_new.dart';
import '../widgets/portfolio_header_widget.dart' show PortfolioHeaderCards;

class OliveStocksPortfolioNew extends StatefulWidget {
  const OliveStocksPortfolioNew({super.key});



  @override
  State<OliveStocksPortfolioNew> createState() =>
      _OliveStocksPortfolioNewState();
}

class _OliveStocksPortfolioNewState extends State<OliveStocksPortfolioNew> {

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


  @override
  void initState() {
    Get.find<PortfolioController>().getAllOliveStocksPortfolioNew();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text("Olive Stocks Portfolio"),
        actions: [],
      ),
      body: Column(
        children: [
          MarketHeaderCardNew(),

          const SizedBox(height: 10),
          Expanded(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 0),
                  child: Container(
                    margin: const EdgeInsets.only(left: 8, top: 8),
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 16,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: GetBuilder<AuthController>(builder: (authController){
                        final subscriptionStatus =
                            authController.getSingleUserResponseModel?.payment ?? "Free";
                        return GetBuilder<PortfolioController>(
                          builder: (portfolioController) {

                            return !portfolioController.isoPortfolioNewLoading ?DataTable(
                              columnSpacing: 20,
                              columns: [
                                const DataColumn(
                                  label: Text(
                                    "Company",
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const DataColumn(
                                  label: Text(
                                    "Date",
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const DataColumn(
                                  label: Text(
                                    "Sector",
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const DataColumn(
                                  label: Text(
                                    "Stock Ratting",
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const DataColumn(
                                  label: Text(
                                    "Analysis Price Terget",
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const DataColumn(
                                  label: Text(
                                    "Ratting(72 Hours)",
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const DataColumn(
                                  label: Text(
                                    "Months",
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const DataColumn(
                                  label: Text(
                                    "Market Cap",
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const DataColumn(
                                  label: Text(
                                    "Action",
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                              rows: List.generate(
                                portfolioController.oliveStocksPortfolioResponseModel!.oliveStocks!.length,
                                    (index) {
                                  final stock = portfolioController.oliveStocksPortfolioResponseModel!.oliveStocks![index];
                                  return DataRow(
                                    cells: [
                                      DataCell(
                                        buildSubscriptionContent(
                                          subscriptionStatus: subscriptionStatus, context: context,
                                          child: Row(
                                            children: [
                                              CircleAvatar(
                                                radius: 12,
                                                backgroundColor: Colors.black,
                                                child: Image.network(
                                                  stock.logo?.toString() ?? '',
                                                ),
                                              ),
                                              const SizedBox(width: 8),
                                              Text(stock.symbol?.toString() ?? ''),
                                            ],
                                          ),
                                        ),
                                      ),
                                      DataCell(
                                        Text(
                                          stock.lastRatingDate != null
                                              ? formatDateTime(stock.lastRatingDate!)
                                              : 'N/A',
                                        ),
                                      ),

                                      DataCell(Text(stock.sector?.toString() ?? '')),

                                      DataCell(
                                        Container(
                                            height: size.height * .4,
                                            width: size.width * .2,

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
                                      ),
                                      DataCell(Text(stock.analystTarget?.toString() ?? '')),
                                      DataCell(
                                        Row(
                                          children: [
                                            Container(
                                              // width: size.width * .2
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      BuyHoldSellCircularPercentWidget(
                                                        buyPercent: portfolioController.oliveStocksPortfolioResponseModel!.oliveStocks![index].ratingTrend!.buy!.toDouble(),
                                                        holdPercent:  portfolioController.oliveStocksPortfolioResponseModel!.oliveStocks![index].ratingTrend!.hold!.toDouble(),
                                                        sellPercent:  portfolioController.oliveStocksPortfolioResponseModel!.oliveStocks![index].ratingTrend!.sell!.toDouble(),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            RattingsColumn(
                                              greenText: portfolioController.oliveStocksPortfolioResponseModel!.oliveStocks![index].ratingTrend!.buy!.toString() + " Buy",
                                              yellowText:portfolioController.oliveStocksPortfolioResponseModel!.oliveStocks![index].ratingTrend!.hold!.toString() + " Hold",
                                              redText: portfolioController.oliveStocksPortfolioResponseModel!.oliveStocks![index].ratingTrend!.sell!.toString() + " sell",
                                            ),
                                            Text(''),
                                          ],
                                        ),
                                      ),
                                      DataCell(Text(stock.oneMonthReturn?.toString() ?? '')),
                                      DataCell(Text(
                                        formatAbbreviatedCurrency(stock.marketCap),
                                      )),


                                      DataCell(
                                        IconButton(
                                          icon: const Icon(
                                            Icons.notifications_outlined,
                                            color: Colors.black,
                                          ),
                                          onPressed: () {},
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ) : const Center(child: CircularProgressIndicator());
                          },
                        );
                      })
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(16),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Latest News ",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      GetBuilder<NewsController>(
                        builder: (newsController) {
                          return newsController.isLoadingNew
                              ? Container(
                            height: size.height * 0.5,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                              : ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount:
                            newsController
                                .getAllNewsResponseModel
                                .data
                                ?.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Get.to(
                                    NewsDetailsScreen(
                                      newsData:
                                      newsController
                                          .getAllNewsResponseModel
                                          .data![index],
                                    ),
                                  );
                                },
                                child: SingleMarketNewsWidget(
                                  newsData:
                                  newsController
                                      .getAllNewsResponseModel
                                      .data![index],
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PortfolioHealthIndicatorTable extends StatelessWidget {
  final int index;

  const PortfolioHealthIndicatorTable({super.key, required this.index})
      : assert(index >= 1 && index <= 10);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircularPercentIndicator(
          radius: 15.0,
          lineWidth: 4.0,
          percent: index / 10,
          center: Text(
            "$index",
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          progressColor: Colors.yellow[700]!,
          backgroundColor: Colors.grey[200]!,
          circularStrokeCap: CircularStrokeCap.round,
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}

class RattingsColumn extends StatelessWidget {
  final String greenText;
  final String yellowText;
  final String redText;

  const RattingsColumn({
    super.key,
    required this.greenText,
    required this.yellowText,
    required this.redText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              height: 10,
              width: 10,
              decoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 1),
              ),
            ),
            const SizedBox(width: 2),
            Text(
              greenText,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: 11,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Container(
              height: 10,
              width: 10,
              decoration: BoxDecoration(
                color: Colors.yellow[700],
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 1),
              ),
            ),
            const SizedBox(width: 2),
            Text(
              yellowText,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: 11,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Container(
              height: 10,
              width: 10,
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 1),
              ),
            ),
            const SizedBox(width: 2),
            Text(
              redText,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ],
    );
  }
}