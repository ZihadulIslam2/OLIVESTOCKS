import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:olive_stocks_flutter/core/contants/subcription_utils.dart';
import 'package:olive_stocks_flutter/features/auth/controllers/auth_controller.dart';
import 'package:olive_stocks_flutter/features/stock_data_serving/presentations/widgets/table_model/analyst_linear_percent_widget.dart';
import '../../../../../experts/presentations/screens/olive_stock_screen.dart';
import '../../../../../markets/presentations/screens/single_stock_market.dart';
import '../../../../../markets/presentations/widgets/svg_widget.dart';
import '../../../../../portfolio/domains/analysts_top_stocks_response_model.dart';

class AnalystsTopStocksScreen extends StatefulWidget {
  const AnalystsTopStocksScreen({
    super.key,
    required this.topStocks,
    this.trendingStocks,
  });

  final List<TopStocks>? topStocks;
  final List<TrendingStocks>? trendingStocks;

  @override
  State<AnalystsTopStocksScreen> createState() =>
      _AnalystsTopStocksScreenState();
}

class _AnalystsTopStocksScreenState extends State<AnalystsTopStocksScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Center(
      child: Container(
        width: size.width * .95,
        decoration: BoxDecoration(
          color: const Color(0xffFFFFFF),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Analysts Top Stocks',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'By the best performing Analysts',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Column(
              children: [
                _buildHeaderRow(context),
                const Divider(height: 1, thickness: 1),
                _buildListContent(widget.topStocks),
              ],
            ),
            Container(
              height: size.height * .05,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              color: const Color(0xffBFBFBF),
              child: Row(
                children: [
                  const Text(
                    'See what the Best Analysts are recommending\nand why',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xff595959),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    height: 20,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () {
                        Get.to(OliveStocksPortfolioScreen());
                      },
                      child: const Text(
                        'Go Pro',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderRow(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      height: size.height * .06,
      color: const Color(0xffEAF6EC),
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Row(
        children: [
          const Text(
            "Company",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Color(0xff595959),
            ),
          ),
          const Spacer(),
          SizedBox(
            width: size.width * .54,
            child: Row(
              children: [
                const Text(
                  "Analyst\nConsensus",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Color(0xff595959),
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: size.width * .15,
                  child: const Text(
                    "Price\nTarget",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Color(0xff595959),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListContent(List<TopStocks>? topStocks) {
    Size size = MediaQuery.of(context).size;

    if (topStocks == null || topStocks.isEmpty) {
      return const SizedBox.shrink();
    }

    return GetBuilder<AuthController>(builder: (authController) {
      final subscriptionStatus =
          authController.getSingleUserResponseModel?.payment ?? "Free";

      return ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: topStocks.length,
        itemBuilder: (context, index) {
          final stock = topStocks[index];

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  height: size.height * .08,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Company
                      SizedBox(
                        width: size.width * .22,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              stock.symbol ?? '',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const Text(
                              'Microsoft', // Replace with actual company name
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Olive Tree
                      SizedBox(
                        width: size.width * .23,
                        child: OliveTreeSvg(
                          oliveColors: {
                            "financialHealth":
                            stock.olives?.financialHealth.toString() ?? '0',
                            "competitiveAdvantage": stock
                                .olives?.competitiveAdvantage
                                .toString() ??
                                '0',
                            "valuation": stock.olives?.valuation.toString() ?? '0',
                          },
                        ),
                      ),

                      // Analyst Ratings
                      SizedBox(
                        width: size.width * .30,
                        child: buildSubscriptionContent(
                          subscriptionStatus: subscriptionStatus,
                          context: context,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '\$${stock.targetMean?.toStringAsFixed(2) ?? '0.00'}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.green,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                "\▲${double.tryParse(stock.upsidePercent ?? '0')?.toStringAsFixed(2) ?? '0'}%(upside)",
                                style: const TextStyle(
                                  color: Colors.green,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(height: 1, thickness: 1),
            ],
          );
        },
      );
    });
  }
}
