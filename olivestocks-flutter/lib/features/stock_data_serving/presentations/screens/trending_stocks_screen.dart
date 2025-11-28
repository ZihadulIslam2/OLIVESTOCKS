import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:olive_stocks_flutter/core/contants/subcription_utils.dart';
import 'package:olive_stocks_flutter/features/auth/controllers/auth_controller.dart';
import 'package:olive_stocks_flutter/features/portfolio/domains/tranding_stocks_response_model.dart';

import '../../../portfolio/controller/portfolio_controller.dart';
import '../../../portfolio/domains/analysts_top_stocks_response_model.dart';
import '../widgets/circular_percent_widget.dart';

class TrendingStocksScreen extends StatefulWidget {
  const TrendingStocksScreen({super.key});

  @override
  _TrendingStocksScreenState createState() => _TrendingStocksScreenState();
}

class _TrendingStocksScreenState extends State<TrendingStocksScreen> {
  String selectedMarket = "US";
  String selectedScore = "Any";
  String selectedImpact = "Any";

  @override
  void initState() {
    Get.find<PortfolioController>().getTrendingStocks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppBar(), body: _buildBody(context));
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      title: const Text(
        'Trending Stocks',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return GetBuilder<AuthController>(builder: (authController) {
      final subscriptionStatus =
          authController.getSingleUserResponseModel?.payment ?? "Free";

      return GetBuilder<PortfolioController>(
        builder: (portfolioController) {
          return !portfolioController.isTrendingLoading
              ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDescriptionText(),
              const SizedBox(height: 16),
              _buildFilterChips(),
              const SizedBox(height: 20),
              const Divider(height: 1, color: Color(0xffB0B0B0)),
              _buildHeaderRow(),
              const Divider(height: 1, color: Color(0xffB0B0B0)),
              _buildStocksList(
                context,
                portfolioController,
                subscriptionStatus, // ✅ pass it down
              ),
            ],
          )
              : const Center(child: CircularProgressIndicator());
        },
      );
    });
  }

  Widget _buildDescriptionText() {
    return const Padding(
      padding: EdgeInsets.only(left: 16, right: 16),
      child: Text(
        "Tracking insider transactions can be a valuable strategy. Insiders often have better practical insights into a company's outlook than the average investor. By following which stocks Insiders are buying or selling, you can see how those most in the know are trading. ",
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: Color(0xff000000),
        ),
      ),
    );
  }

  Widget _buildFilterChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: Row(
          children: [
            _buildMarketDropdown(),
            _buildScoreDropdown(),
            _buildImpactDropdown(),
            _buildActionDropdown(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderRow() {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: size.width * .24,
            child: const Text(
              "Company",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
          ),
          const Spacer(),
          SizedBox(
            width: size.width * .65,
            child: Row(
              children: const [
                Text(
                  "Price",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
                Spacer(),
                Text(
                  "Rating last 30 Days",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStocksList(
      BuildContext context,
      PortfolioController portfolioController,
      String subscriptionStatus, // ✅ added here
      ) {
    return Expanded(
      child: ListView.builder(
        itemCount:
        portfolioController.trendingStocksResponseModel?.trendingStocks
            ?.length,
        itemBuilder: (context, index) {
          if (index > 0 && index % 7 == 0) {
            return Column(
              children: [
                const Divider(height: 1, thickness: 1),
                _buildOliveStockProInfoSection(),
                const Divider(height: 1, thickness: 1),
              ],
            );
          }

          final stockIndex = index - (index / 7).floor();

          return Column(
            children: [
              _buildStockItem(
                context,
                stockIndex,
                portfolioController,
                subscriptionStatus, // ✅ pass down
              ),
              const Divider(height: 1, thickness: 1),
            ],
          );
        },
      ),
    );
  }

  Widget _buildStockItem(
      BuildContext context,
      int index,
      PortfolioController portfolioController,
      String subscriptionStatus, // ✅ added here
      ) {
    final stockName = "ORCL";

    return Dismissible(
      key: Key(index.toString()),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {},
      background: _buildDismissibleBackground(),
      confirmDismiss: (direction) async {
        _showBottomSheet(context, stockName);
        return false;
      },
      child: InkWell(
        onTap: () {
          print('Tapped on $stockName');
        },
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: _buildStockItemDecoration(),
            child: _buildStockItemContent(
              context,
              portfolioController,
              index,
              subscriptionStatus, // ✅ fixed usage
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDismissibleBackground() {
    return Container(
      color: const Color(0xffBCDEFF),
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      alignment: Alignment.centerLeft,
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(55),
        ),
        child: const Icon(Icons.add, color: Color(0xff2695FF), size: 35),
      ),
    );
  }

  BoxDecoration _buildStockItemDecoration() {
    return const BoxDecoration(color: Colors.transparent);
  }

  Widget _buildStockItemContent(
      BuildContext context,
      PortfolioController portfolioController,
      int index,
      String subscriptionStatus, // ✅ required
      ) {
    final trendingStocks =
        portfolioController.trendingStocksResponseModel?.trendingStocks;
    Size size = MediaQuery.of(context).size;

    if (trendingStocks == null || index >= trendingStocks.length) {
      return Container();
    }

    final stock = trendingStocks[index];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          height: 63,
          width: size.width * .20,
          child: buildSubscriptionContent(
            subscriptionStatus: subscriptionStatus,
            context: context,
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "3 days ago",
                      style: TextStyle(fontSize: 10, color: Colors.grey),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      stock.symbol ?? 'N/A',
                      style:
                      const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      "Tesla",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: size.width * .40,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '\$${stock.currentPrice.toString()}',
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        '▼\$${stock.priceChange.toString()}%',
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.green,
                        ),
                      ),
                      Text(
                        '(▼\$${stock.percentChange.toString()}%)',
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              width: size.width * .30,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BuyHoldSellCircularPercentWidget(
                        buyPercent: stock.buy!.toDouble(),
                        holdPercent: stock.hold!.toDouble(),
                        sellPercent: stock.sell!.toDouble(),
                      ),
                      const SizedBox(width: 10),
                      _buildRatingChart(portfolioController, index),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildOliveStockProInfoSection() {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Olive Stocks Pro",
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xff000000),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras odio nulla.",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff000000),
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              minimumSize: Size(size.width * 0.1, size.height * 0.01),
              backgroundColor: Color(0xff28A745),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
            child: const Text(
              'Learn More',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingChart(PortfolioController portfolioController, int index) {
    final stock = portfolioController.trendingStocksResponseModel!.trendingStocks![index];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildRatingItem(Colors.green, "${stock.buy} Buy"),
        const SizedBox(height: 3),
        _buildRatingItem(Colors.yellow, "${stock.hold} Hold"),
        const SizedBox(height: 3),
        _buildRatingItem(Colors.red, "${stock.sell} Sell"),
      ],
    );
  }

  Widget _buildRatingItem(Color color, String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(height: 10, width: 10, color: color),
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(
            fontSize: 10,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  void _showBottomSheet(BuildContext context, String stockName) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "Add $stockName To:",
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {},
                  child: const Row(
                    children: [
                      Icon(Icons.wallet_travel, color: Colors.black, size: 20),
                      SizedBox(width: 10),
                      Text("New Portfolio", style: TextStyle(color: Colors.black)),
                    ],
                  ),
                ),
              ),
              Center(
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {},
                  child: const Row(
                    children: [
                      Icon(Icons.remove_red_eye_outlined,
                          color: Colors.black, size: 20),
                      SizedBox(width: 10),
                      Text("Watchlist", style: TextStyle(color: Colors.black)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Dropdowns ----------------------
  Widget buildDropdown({
    required String label,
    required List<String> options,
    required String selectedValue,
    required Function(String) onChanged,
    Color borderColor = Colors.green,
    Color textColor = Colors.green,
  }) {
    return GestureDetector(
      onTap: () async {
        String? result = await showModalBottomSheet<String>(
          context: context,
          builder: (BuildContext context) {
            return ListView(
              shrinkWrap: true,
              children: options
                  .map((option) => ListTile(
                title: Text(option),
                onTap: () => Navigator.pop(context, option),
              ))
                  .toList(),
            );
          },
        );
        if (result != null) {
          onChanged(result);
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Container(
          height: 32,
          decoration: BoxDecoration(
            border: Border.all(color: borderColor, width: 2),
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(width: 8),
              Text("$label:", style: TextStyle(color: textColor, fontSize: 11)),
              const SizedBox(width: 8),
              Text(selectedValue,
                  style: TextStyle(color: textColor, fontSize: 11)),
              const SizedBox(width: 8),
              Icon(Icons.arrow_drop_down, color: textColor, size: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMarketDropdown() {
    return buildDropdown(
      label: "Market",
      options: ["US", "UK", "EU", "Asia"],
      selectedValue: selectedMarket,
      onChanged: (value) => setState(() => selectedMarket = value),
    );
  }

  Widget _buildScoreDropdown() {
    return buildDropdown(
      label: "Smart Score",
      options: ["Any", "High", "Medium", "Low"],
      selectedValue: selectedScore,
      onChanged: (value) => setState(() => selectedScore = value),
    );
  }

  Widget _buildImpactDropdown() {
    return buildDropdown(
      label: "Market cap",
      options: ["Mega(Over 2)", "Medium", "Low", "Any"],
      selectedValue: selectedImpact,
      onChanged: (value) => setState(() => selectedImpact = value),
    );
  }

  Widget _buildActionDropdown() {
    return buildDropdown(
      label: "Action",
      options: ["Mega(Over 2)", "Medium", "Low", "Any"],
      selectedValue: selectedImpact,
      onChanged: (value) => setState(() => selectedImpact = value),
    );
  }
}
