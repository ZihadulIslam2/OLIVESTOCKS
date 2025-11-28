import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:olive_stocks_flutter/features/explore_plan/presentations/screens/explore_plan_screen.dart';
import 'package:olive_stocks_flutter/payment/services/stripe_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../auth/controllers/auth_controller.dart';
import '../../../markets/presentations/screens/single_stock_market.dart';
import '../../../markets/presentations/widgets/svg_widget.dart';
import '../../../portfolio/controller/portfolio_controller.dart';
import '../../../stock_data_serving/presentations/widgets/lock_widget.dart';

class ListWidgetAnalyst extends StatefulWidget {
  const ListWidgetAnalyst({super.key});

  @override
  State<ListWidgetAnalyst> createState() => _ListWidgetAnalystState();
}

class _ListWidgetAnalystState extends State<ListWidgetAnalyst> {
  bool isSubscribed = false;
  final authController = Get.find<AuthController>();
  final portfolioController = Get.find<PortfolioController>();
  SharedPreferences? sharedPreferences;

  String formatDateTime(String isoDate) {
    try {
      final dateTime = DateTime.parse(isoDate).toLocal();
      return DateFormat('MMM d, y • h:mm a').format(dateTime);
    } catch (e) {
      return 'Invalid date';
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authController = Get.find<AuthController>();
      if (authController.getSingleUserResponseModel?.data?.sId == null) {
        _initUser();
      }
    });
  }

  Future<void> _initUser() async {
    String id = await getUserId();
    if (id.isNotEmpty) {
      await Get.find<AuthController>().getSingleUser(id);
    }
  }

  Future<String> getUserId() async {
    sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences?.getString('userId') ?? '';
  }

  void _showUpgradeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Upgrade Required"),
        content: const Text("This feature is available for subscribed users only."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              Get.to(() => const ExplorePlanScreen());
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child: const Text("Upgrade Plan", style: TextStyle(color: Colors.white)),
          )
        ],
      ),
    );
  }

  /// ✅ Reusable function: show content if Premium/Ultimate, else lock
  Widget buildSubscriptionContent({
    required String? subscriptionStatus,
    required Widget child,
    required BuildContext context,
  }) {
    if (subscriptionStatus == "Premium" || subscriptionStatus == "Ultimate") {
      return child; // show actual content
    } else {
      return GestureDetector(
        onTap: () => _showUpgradeDialog(context),
        child: const LockWidget(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<StripeService>(builder: (stripeService) {
      return GetBuilder<PortfolioController>(builder: (portfolioController) {
        final stocks = portfolioController.oliveStocksPortfolioResponseModel?.oliveStocks;
        final subscriptionStatus =
            authController.getSingleUserResponseModel?.payment ?? "Free";

        if (portfolioController.isPortfolioLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        return Column(
          children: [
            _buildHeaderRow(context),
            const Divider(height: 1),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: stocks?.length ?? 0,
              itemBuilder: (context, index) {
                final stock = stocks![index];
                return Column(
                  children: [
                    InkWell(
                      onTap: () => Get.to(() => SingleStockMarket(symbol: stock.symbol!)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Company Info Column
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    formatDateTime(stock.lastRatingDate ?? ''),
                                    style: const TextStyle(fontSize: 11, color: Colors.green),
                                  ),
                                  const SizedBox(height: 4),

                                  /// ✅ Use reusable function here
                                  buildSubscriptionContent(
                                    subscriptionStatus: subscriptionStatus,
                                    context: context,
                                    child: Row(
                                      children: [
                                        Image.network(
                                          stock.logo ?? '',
                                          height: 30,
                                          width: 30,
                                          errorBuilder: (_, __, ___) =>
                                          const Icon(Icons.error, size: 20),
                                        ),
                                        const SizedBox(width: 8),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              stock.symbol ?? '',
                                              style: const TextStyle(fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              stock.companyName ?? '',
                                              style: const TextStyle(fontSize: 10),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Olive Tree & Price Target
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: size.height * 0.07,
                                  width: size.width * 0.2,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 15),
                                    child: OliveTreeSvg(
                                      oliveColors: {
                                        "financialHealth": stock.olives?.financialHealth ?? '#ccc',
                                        "competitiveAdvantage": stock.olives?.competitiveAdvantage ?? '#ccc',
                                        "valuation": stock.olives?.valuation ?? '#ccc',
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(width:30),
                                Text(
                                  stock.analystTarget ?? '',
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    const Divider(height: 1),
                  ],
                );
              },
            ),
          ],
        );
      });
    });
  }

  Widget _buildHeaderRow(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: size.width * .24,
            child: const Text("Company",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
          ),
          SizedBox(
            width: size.width * .55,
            child: Row(
              children: const [
                Text("Analyst Consensus",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                Spacer(),
                Text("Price Target",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
