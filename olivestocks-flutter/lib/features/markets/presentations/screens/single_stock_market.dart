import 'dart:math';
import 'package:olive_stocks_flutter/features/markets/presentations/screens/shanky_screen.dart';
import 'package:olive_stocks_flutter/features/portfolio/controller/portfolio_controller.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/screens/dummy_chart2.dart';
import '../../../../common/screens/single_stock_market_cashflow_widget.dart';
import '../../../../common/screens/single_stock_market_eps_widget.dart';
import '../../../../common/screens/single_stock_market_target_widget.dart';
import '../../../news/controllers/news_controller.dart';
import '../../../news/presentations/screens/deep_research_news_screen.dart';
import '../../../news/presentations/screens/news_details_screen.dart';
import '../../../portfolio/presentations/widgets/SingleStockMarketUpcomingEventsWidget.dart';
import '../../../portfolio/presentations/widgets/single_market_news_widget.dart';
import '../widgets/market_stocks_middle_widget.dart';
import '../widgets/single_stock_market_price_widget.dart';
import '../widgets/single_stock_market_upcoming_events_widget.dart';
import '../widgets/svg_widget.dart';
import '../widgets/vector_shape.dart';

class SingleStockMarket extends StatefulWidget {
  final String symbol;

  const SingleStockMarket({super.key, required this.symbol});

  @override
  State<SingleStockMarket> createState() => _SingleStockMarketState();
}

class _SingleStockMarketState extends State<SingleStockMarket> {
  double degreesToRadians(double degrees) {
    return degrees * (pi / 180);
  }

  final List<String> items = ['Price', 'Target', 'Cashflow'];

  final List<String> items1 = ['Revenue', 'EPS', 'Earning'];

  final Map<String, String> apiData = {
    "financialHealth": "green",
    "competitiveAdvantage": "green",
    "valuation": "green",
  };

  String? selectedValue = 'Price';
  String? selectedValue1 = 'Revenue';

  late Future<List<Color>> _pathColorsFuture;

  void _updateLeafColors(Map<String, String> apiData) {
    final Map<String, int> attributeIndexes = {
      "financialHealth": 3,
      "competitiveAdvantage": 5,
      "valuation": 0,
    };

    setState(() {
      for (var entry in attributeIndexes.entries) {
        final attribute = entry.key;
        final index = entry.value;
        if (index >= 0 &&
            index < _pathColors.length &&
            apiData.containsKey(attribute)) {
          _pathColors[index] =
              (apiData[attribute] == "gray")
                  ? const Color(0xFF929292)
                  : const Color(0xFF406325);
        }
      }
    });
  }

  final List<Color> _pathColors = [];

  Color _parseHexColor(String hex) {
    hex = hex.replaceAll('#', '');
    if (hex.length == 6) hex = 'FF$hex';
    return Color(int.parse(hex, radix: 16));
  }

  @override
  void initState() {
    print(widget.symbol);
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      PortfolioController controller = Get.find<PortfolioController>();
      NewsController newsController = Get.find<NewsController>();
      controller.getStockOverView(widget.symbol);
      controller.getPriceChart(widget.symbol);
      controller.parseRevenueChartData(widget.symbol);
      controller.getEPSChart(widget.symbol);
      newsController.getDeepResearch(widget.symbol);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Analyst Top Stocks',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        centerTitle: false,
        actions: [],
      ),
      body: GetBuilder<NewsController>(
        builder: (newsController) {
          return GetBuilder<PortfolioController>(
            builder: (portfolioController) {
              final newsData =
                  newsController.deepResearchNewsResponseModel.data;
              if (portfolioController.getStockOverviewResponseModel == null) {
                print('task is empty');
                return SizedBox(
                  height: size.height * 0.8,
                  width: size.width,
                  child: const Center(child: CircularProgressIndicator()),
                );
              }

              return (!portfolioController.isStockOverViewLoading)
                  ? SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: SizedBox(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 60,
                              width: size.width,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 35.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const SizedBox(width: 15),
                                        Text(
                                          widget.symbol,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18,
                                          ),
                                        ),
                                        const SizedBox(width: 7),
                                        CircleAvatar(
                                          radius: 16,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              100,
                                            ),
                                            child: Image.network(
                                              portfolioController
                                                  .getStockOverviewResponseModel
                                                  .logo!,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    SizedBox(
                                      height: size.width * .07,
                                      width: size.width * .35,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Get.to(
                                            DeepResearchNewsScreen(
                                              symbol: widget.symbol,
                                            ),
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.green,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                            side: const BorderSide(
                                              color: Colors.green,
                                            ),
                                          ),
                                        ),
                                        child: Text(
                                          'Deep Research',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 30),
                                    SizedBox(
                                      height: size.width * .07,
                                      width: size.width * .07,
                                      child:
                                          portfolioController
                                                  .getStockOverviewResponseModel
                                                  .shariaCompliant!
                                              ? Image.asset(
                                                'assets/logos/chad.png',
                                              )
                                              : Image.asset(
                                                'assets/logos/chad red1.png',
                                              ),
                                    ),

                                    TooltipOnTapIcon(
                                      message:
                                          portfolioController
                                              .getStockOverviewResponseModel
                                              .reason ??
                                          '',
                                    ),

                                  ],
                                ),
                              ),
                            ),

                            SizedBox(height: 30),

                            Container(
                              height: size.height * .3,
                              width: size.height * .3,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withValues(alpha: 0.2),
                                    spreadRadius: 2,
                                    blurRadius: 2,
                                    offset: Offset(0, 1),
                                  ),
                                ],
                              ),
                              child: Stack(
                                children: [
                                  Positioned(
                                    top: 10,
                                    left: 70,
                                    child: Text(
                                      'Strong Financial Health',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 10,
                                    left: 70,
                                    child: Text(
                                      'Poor Financial Health',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 50,
                                    left: 10,
                                    child: Transform.flip(
                                      flipY: true,
                                      flipX: true,
                                      child: RotatedBox(
                                        quarterTurns: 1,
                                        child: Text(
                                          'Low Competitive Advantage',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 50,
                                    right: 10,
                                    child: Transform.flip(
                                      flipY: false,
                                      flipX: false,
                                      child: RotatedBox(
                                        quarterTurns: -1,
                                        child: Text(
                                          'High Competitive Advantage',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: (size.height * .3) / 12,
                                    bottom: (size.height * .3) / 2,
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 2,
                                          width: size.width * .24,
                                          color: Colors.black,
                                        ),
                                        Transform.translate(
                                          offset: Offset(-7, 0),
                                          child: Icon(
                                            Icons.arrow_forward_ios,
                                            size: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    left: (size.height * .3) / 12,
                                    bottom: (size.height * .3) / 2,
                                    child: Transform.rotate(
                                      angle: degreesToRadians(180),
                                      child: Row(
                                        children: [
                                          Container(
                                            height: 2,
                                            width: size.width * .24,
                                            color: Colors.black,
                                          ),
                                          Transform.translate(
                                            offset: Offset(-7, 0),
                                            child: Icon(
                                              Icons.arrow_forward_ios,
                                              size: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: (size.height * .3) / 3.2,
                                    top: 67,
                                    child: Transform.rotate(
                                      angle: degreesToRadians(270),
                                      child: Row(
                                        children: [
                                          Container(
                                            height: 2,
                                            width: size.width * .22,
                                            color: Colors.black,
                                          ),
                                          Transform.translate(
                                            offset: Offset(-7, 0),
                                            child: Icon(
                                              Icons.arrow_forward_ios,
                                              size: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: (size.height * .3) / 3.3,
                                    bottom: 80,
                                    child: Transform.rotate(
                                      angle: degreesToRadians(90),
                                      child: Row(
                                        children: [
                                          Container(
                                            height: 2,
                                            width: size.width * .23,
                                            color: Colors.black,
                                          ),
                                          Transform.translate(
                                            offset: Offset(-7, 0),
                                            child: Icon(
                                              Icons.arrow_forward_ios,
                                              size: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 45,
                                    left: 50,
                                    child: Container(
                                      height: (size.height * .18) / 2,
                                      width: ((size.height * .16) / 2) + 10,
                                      color: Colors.transparent,
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          height: (size.height * .17) / 2,
                                          width: (size.height * .16) / 2,
                                          decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black26,
                                                spreadRadius: 2,
                                                blurRadius: 2,
                                              ),
                                            ],
                                            color:
                                                portfolioController
                                                            .getStockOverviewResponseModel
                                                            .quadrant ==
                                                        "Lime Green"
                                                    ? Color(0xff32cd32)
                                                    : Colors.white,
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                          child: Center(
                                            child: SizedBox(
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    height: 40,
                                                    width: 40,
                                                    child: Image.asset(
                                                      'assets/logos/financial_icon.png',
                                                    ),
                                                  ),
                                                  SizedBox(height: 5),
                                                  Text(
                                                    'Lime Green',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 11,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 45,
                                    right: 40,
                                    child: Container(
                                      height: (size.height * .18) / 2,
                                      width: ((size.height * .16) / 2) + 10,
                                      color: Colors.transparent,
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          height: (size.height * .17) / 2,
                                          width: (size.height * .16) / 2,
                                          decoration: BoxDecoration(
                                            color:
                                                portfolioController
                                                            .getStockOverviewResponseModel
                                                            .quadrant ==
                                                        "Olive Green"
                                                    ? Color(0xff04e4a4)
                                                    : Colors.white,
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black26,
                                                spreadRadius: 2,
                                                blurRadius: 2,
                                              ),
                                            ],
                                          ),
                                          child: Center(
                                            child: Container(
                                              child: Column(
                                                children: [
                                                  Container(
                                                    height: 40,
                                                    width: 40,
                                                    child: Image.asset(
                                                      'assets/logos/financial_icon.png',
                                                    ),
                                                  ),
                                                  SizedBox(height: 5),
                                                  Text(
                                                    'Olive Green',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 11,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 55,
                                    left: 50,
                                    child: Container(
                                      height: (size.height * .18) / 2,
                                      width: ((size.height * .16) / 2) + 10,
                                      color: Colors.transparent,
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          height: (size.height * .17) / 2,
                                          width: (size.height * .16) / 2,
                                          decoration: BoxDecoration(
                                            color:
                                                portfolioController
                                                            .getStockOverviewResponseModel
                                                            .quadrant ==
                                                        "Orange"
                                                    ? Colors.orange
                                                    : Colors.white,
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black26,
                                                spreadRadius: 2,
                                                blurRadius: 2,
                                              ),
                                            ],
                                          ),
                                          child: Center(
                                            child: Container(
                                              child: Column(
                                                children: [
                                                  Container(
                                                    height: 40,
                                                    width: 40,
                                                    child: Image.asset(
                                                      'assets/logos/financial_icon.png',
                                                    ),
                                                  ),
                                                  SizedBox(height: 5),
                                                  Text(
                                                    'Orange',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 11,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 55,
                                    right: 40,
                                    child: Container(
                                      height: (size.height * .18) / 2,
                                      width: ((size.height * .16) / 2) + 10,
                                      color: Colors.transparent,
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          height: (size.height * .17) / 2,
                                          width: (size.height * .16) / 2,
                                          decoration: BoxDecoration(
                                            color:
                                                portfolioController
                                                            .getStockOverviewResponseModel
                                                            .quadrant ==
                                                        "Yellow"
                                                    ? Colors.yellow
                                                    : Colors.white,
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black26,
                                                spreadRadius: 2,
                                                blurRadius: 2,
                                              ),
                                            ],
                                          ),
                                          child: Center(
                                            child: Container(
                                              child: Column(
                                                children: [
                                                  Container(
                                                    height: 40,
                                                    width: 40,
                                                    child: Image.asset(
                                                      'assets/logos/financial_icon.png',
                                                    ),
                                                  ),
                                                  SizedBox(height: 5),
                                                  Text(
                                                    'Yellow',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 11,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: 30),

                            Container(
                              height: size.height * .3,
                              width: size.width * .9,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                              ),
                              child: Stack(
                                children: [
                                  Align(
                                    alignment: Alignment.center,
                                    child: Transform.translate(
                                      offset: Offset(0, -30),
                                      child: OliveTreeSvg(
                                        oliveColors: {
                                          "financialHealth":
                                              portfolioController
                                                  .getStockOverviewResponseModel
                                                  .olives!
                                                  .financialHealth ??
                                              "",
                                          "competitiveAdvantage":
                                              portfolioController
                                                  .getStockOverviewResponseModel
                                                  .olives!
                                                  .competitiveAdvantage ??
                                              "",
                                          "valuation":
                                              portfolioController
                                                  .getStockOverviewResponseModel
                                                  .olives!
                                                  .valuation ??
                                              "",
                                        },
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: size.height * .08,
                                    left: size.width * .02,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          'Financial Health',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12,
                                          ),
                                        ),
                                        SizedBox(width: 40),
                                        Text(
                                          'Competitive Advantage',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12,
                                          ),
                                        ),
                                        SizedBox(width: 40),
                                        Text(
                                          'Valuation',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    left: 0,
                                    right: size.width * .42,
                                    bottom: size.height * .1,
                                    child: Image.asset(
                                      'assets/images/left_arrow.png',
                                      height: 100,
                                      width: 50,
                                    ),
                                  ),
                                  Positioned(
                                    left: size.width * .07,
                                    right: 0,
                                    bottom: size.height * .1,
                                    child: Image.asset(
                                      'assets/images/middle_arrow.png',
                                      height: 80,
                                      width: 50,
                                    ),
                                  ),
                                  Positioned(
                                    left: size.width * .51,
                                    right: 0,
                                    bottom: size.height * .1,
                                    child: Image.asset(
                                      'assets/images/right_arrow.png',
                                      height: 100,
                                      width: 50,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Container(
                              height: size.height * .12,
                              width: size.width * .9,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withValues(),
                                    spreadRadius: 2,
                                    blurRadius: 2,
                                    offset: Offset(0, 1),
                                  ),
                                ],
                              ),
                              child: Stack(
                                children: [
                                  Column(
                                    children: [
                                      SizedBox(height: 10),
                                      Container(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 18.0,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                height: 20,
                                                width: size.width * .21,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    width: 1,
                                                    color: Colors.black38,
                                                  ),
                                                ),
                                                child: Align(
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    'Under Value',
                                                    style: TextStyle(
                                                      fontSize: 11,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: 20,
                                                width: size.width * .21,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    width: 1,
                                                    color: Colors.black38,
                                                  ),
                                                ),
                                                child: Align(
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    'Fair Value',
                                                    style: TextStyle(
                                                      fontSize: 11,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: 20,
                                                width: size.width * .21,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    width: 1,
                                                    color: Colors.black38,
                                                  ),
                                                ),
                                                child: Align(
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    'Over Value',
                                                    style: TextStyle(
                                                      fontSize: 11,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      VectorShape(),
                                    ],
                                  ),
                                  Positioned(
                                    top: 80,
                                    left: size.width * .42,
                                    child: Container(
                                      height: 20,
                                      width: size.width * .3,
                                      child: Text(
                                        '\$${portfolioController.getStockOverviewResponseModel.valuationBar!.fairValue}',
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 80,
                                    left: size.width * .64,
                                    child: Container(
                                      height: 20,
                                      width: size.width * .3,
                                      child: Text(
                                        '\$${portfolioController.getStockOverviewResponseModel.valuationBar?.currentPrice}',
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 40,
                                    left: size.width * .64,
                                    child: Container(
                                      height: 50,
                                      width: 10,
                                      child: Icon(
                                        Icons.arrow_downward_rounded,
                                        size: 30,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: 20),

                            Container(
                              height: size.height * .06,
                              width: size.width * .4,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withValues(alpha: 0.2),
                                    spreadRadius: 2,
                                    blurRadius: 2,
                                    offset: Offset(0, 1),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 5.0,
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      '\$${portfolioController.getStockOverviewResponseModel.valuationBar?.percent}%',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        color: Colors.red,
                                      ),
                                    ),
                                    Text(
                                      'Overvalued',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        color: Colors.green,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            SizedBox(height: 60),

                            SizedBox(
                              height: size.height * .1,
                              width: size.width * .9,
                              child: Column(
                                children: [
                                  !portfolioController.isPriceChartLoading
                                      ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: size.width * .4,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  portfolioController
                                                      .getStockOverviewResponseModel
                                                      .company!,
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                Text(
                                                  portfolioController
                                                      .priceChartResponseModel
                                                      .data!
                                                      .company!
                                                      .exchange!,
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w500,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),

                                          Container(
                                            width: size.width * .4,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Image.asset(
                                                  'assets/images/share-06.png',
                                                  height: 24,
                                                  width: 24,
                                                  fit: BoxFit.cover,
                                                ),
                                                const SizedBox(width: 6),
                                                DropdownButtonHideUnderline(
                                                  child: DropdownButton2<
                                                    String
                                                  >(
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 14,
                                                      color: Colors.white,
                                                    ),
                                                    value: selectedValue,
                                                    isExpanded: true,
                                                    hint: Row(
                                                      children: [
                                                        SizedBox(width: 4),
                                                        Expanded(
                                                          child: Text(
                                                            selectedValue ??
                                                                'Price',
                                                            style: TextStyle(
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    items:
                                                        items
                                                            .map(
                                                              (
                                                                String item,
                                                              ) => DropdownMenuItem<
                                                                String
                                                              >(
                                                                value: item,
                                                                child: Text(
                                                                  item,
                                                                  style: const TextStyle(
                                                                    fontSize:
                                                                        18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color:
                                                                        Colors
                                                                            .white,
                                                                  ),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                              ),
                                                            )
                                                            .toList(),
                                                    onChanged: (String? value) {
                                                      setState(() {
                                                        selectedValue = value;
                                                      });
                                                    },
                                                    buttonStyleData: ButtonStyleData(
                                                      height: 50,
                                                      width: 120,
                                                      padding:
                                                          const EdgeInsets.only(
                                                            left: 14,
                                                            right: 14,
                                                          ),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              14,
                                                            ),
                                                        border: Border.all(
                                                          color: Colors.white,
                                                        ),
                                                        color: Color(
                                                          0xff28A745,
                                                        ),
                                                      ),
                                                      elevation: 0,
                                                    ),
                                                    iconStyleData:
                                                        const IconStyleData(
                                                          icon: Icon(
                                                            Icons
                                                                .arrow_forward_ios_outlined,
                                                          ),
                                                          iconSize: 14,
                                                          iconEnabledColor:
                                                              Colors.white,
                                                          iconDisabledColor:
                                                              Colors.white,
                                                        ),
                                                    dropdownStyleData: DropdownStyleData(
                                                      maxHeight: 200,
                                                      width: 200,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              14,
                                                            ),
                                                        color: Color(
                                                          0xff28A745,
                                                        ),
                                                      ),
                                                      offset: const Offset(
                                                        -20,
                                                        0,
                                                      ),
                                                      scrollbarTheme: ScrollbarThemeData(
                                                        radius:
                                                            const Radius.circular(
                                                              40,
                                                            ),
                                                        thickness:
                                                        WidgetStateProperty .all<
                                                              double
                                                            >(6),
                                                        thumbVisibility:
                                                        WidgetStateProperty .all<
                                                              bool
                                                            >(true),
                                                      ),
                                                    ),
                                                    menuItemStyleData:
                                                        const MenuItemStyleData(
                                                          height: 40,
                                                          padding:
                                                              EdgeInsets.only(
                                                                left: 14,
                                                                right: 14,
                                                              ),
                                                        ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      )
                                      : Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                  Divider(thickness: 1.2, color: Colors.black),
                                ],
                              ),
                            ),

                            Column(
                              children: <Widget>[
                                if (selectedValue == 'Price')
                                  SingleStockMarketPriceWidget(
                                    symbol: widget.symbol,
                                  ),
                                if (selectedValue == 'Target')
                                  SingleStockMarketTargetWidget(
                                    symbol: widget.symbol,
                                  ),
                                if (selectedValue == 'Cashflow')
                                  CashFlowChartWidget(symbol: widget.symbol),
                                SizedBox(height: 20),

                                SizedBox(
                                  height: size.height * .15,
                                  width: size.width * .9,
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: size.width * .4,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  portfolioController
                                                      .getStockOverviewResponseModel
                                                      .company!,
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  portfolioController
                                                          .priceChartResponseModel
                                                          .data
                                                          ?.company
                                                          ?.exchange ??
                                                      '',
                                                  style: const TextStyle(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),

                                          SizedBox(
                                            width: size.width * .4,
                                            height: size.height * .10,
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Image.asset(
                                                      'assets/images/share-06.png',
                                                      height: 22,
                                                      width: 22,
                                                      fit: BoxFit.cover,
                                                    ),
                                                    const SizedBox(width: 9),
                                                    Container(
                                                      child: DropdownButtonHideUnderline(
                                                        child: DropdownButton2<
                                                          String
                                                        >(
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 14,
                                                            color: Colors.white,
                                                          ),
                                                          value: selectedValue1,
                                                          isExpanded: true,
                                                          hint: Row(
                                                            children: [
                                                              SizedBox(
                                                                width: 4,
                                                              ),
                                                              Expanded(
                                                                child: Text(
                                                                  selectedValue1 ??
                                                                      'Revenue',
                                                                  style: TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color:
                                                                        Colors
                                                                            .white,
                                                                  ),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          items:
                                                              items1
                                                                  .map(
                                                                    (
                                                                      String
                                                                      item,
                                                                    ) => DropdownMenuItem<
                                                                      String
                                                                    >(
                                                                      value:
                                                                          item,
                                                                      child: Text(
                                                                        item,
                                                                        style: const TextStyle(
                                                                          fontSize:
                                                                              16,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                      ),
                                                                    ),
                                                                  )
                                                                  .toList(),
                                                          onChanged: (
                                                            String? value,
                                                          ) {
                                                            setState(() {
                                                              selectedValue1 =
                                                                  value;
                                                            });
                                                          },
                                                          buttonStyleData: ButtonStyleData(
                                                            height: 40,
                                                            width: 120,
                                                            padding:
                                                                const EdgeInsets.only(
                                                                  left: 14,
                                                                  right: 14,
                                                                ),
                                                            decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                    14,
                                                                  ),
                                                              border: Border.all(
                                                                color:
                                                                    Colors
                                                                        .white,
                                                              ),
                                                              color: Color(
                                                                0xff28A745,
                                                              ),
                                                            ),
                                                            elevation: 0,
                                                          ),
                                                          iconStyleData:
                                                              const IconStyleData(
                                                                icon: Icon(
                                                                  Icons
                                                                      .arrow_forward_ios_outlined,
                                                                ),
                                                                iconSize: 18,
                                                                iconEnabledColor:
                                                                    Colors
                                                                        .white,
                                                                iconDisabledColor:
                                                                    Colors
                                                                        .white,
                                                              ),
                                                          dropdownStyleData: DropdownStyleData(
                                                            maxHeight: 200,
                                                            width: 200,
                                                            decoration:
                                                                BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                        14,
                                                                      ),
                                                                  color: Color(
                                                                    0xff28A745,
                                                                  ),
                                                                ),
                                                            offset:
                                                                const Offset(
                                                                  -20,
                                                                  0,
                                                                ),
                                                            scrollbarTheme: ScrollbarThemeData(
                                                              radius:
                                                                  const Radius.circular(
                                                                    40,
                                                                  ),
                                                              thickness:
                                                              WidgetStateProperty .all<
                                                                    double
                                                                  >(6),
                                                              thumbVisibility:
                                                              WidgetStateProperty .all<
                                                                    bool
                                                                  >(true),
                                                            ),
                                                          ),
                                                          menuItemStyleData:
                                                              const MenuItemStyleData(
                                                                height: 35,
                                                                padding:
                                                                    EdgeInsets.only(
                                                                      left: 14,
                                                                      right: 14,
                                                                    ),
                                                              ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Spacer(),
                                                SizedBox(
                                                  height: size.height * 0.05, // a bit taller for text comfort
                                                  width: double.infinity, // full width
                                                  child: Align(
                                                    alignment: Alignment.centerRight, // move to right end
                                                    child: ElevatedButton(
                                                      onPressed: () {
                                                        Get.to(
                                                          SankyScreen(
                                                            symbol: widget.symbol,
                                                          ),
                                                        );
                                                      },
                                                      style: ElevatedButton.styleFrom(
                                                        backgroundColor: const Color(0xff28A745),
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(8),
                                                        ),
                                                        padding: const EdgeInsets.symmetric(
                                                          horizontal: 16, // enough space for text
                                                          vertical: 8,
                                                        ),
                                                      ),
                                                      child: const Text(
                                                        'Stock Earnings', // full text, no truncation
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                )


                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 20),
                                      Divider(
                                        thickness: 1.2,
                                        color: Colors.black,
                                      ),
                                    ],
                                  ),
                                ),

                                if (selectedValue1 == 'Revenue')
                                  RevenueBarChart(symbol: widget.symbol),
                                if (selectedValue1 == 'EPS')
                                  SingleStockMarketEPSWidget(),
                                if (selectedValue1 == 'Earning')
                                  MarketStocksMiddleWidget(),
                              ],
                            ),

                            SizedBox(height: 20),

                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 18.0,
                              ),
                              child: Container(
                                width: size.width,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(4),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withValues(alpha: 0.2),
                                      spreadRadius: 2,
                                      blurRadius: 2,
                                      offset: Offset(0, 1),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 15),
                                    MarketNews(symbol: widget.symbol),
                                    SizedBox(height: 10),
                                  ],
                                ),
                              ),
                            ),

                            SizedBox(height: 20),

                            SingleStockMarketDailyGainersLosers(),

                            SizedBox(height: 20),

                            SingleStockMarketUpcomingEventsWidget(),

                            SizedBox(height: 60),
                          ],
                        ),
                      ),
                    ),
                  )
                  : Center(child: CircularProgressIndicator());
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Get.to(PortfolioSmartScoreScreen(id: id,));
        },
        backgroundColor: Color(0xff28A745),
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

class MarketNews extends StatelessWidget {
  final String symbol; // Add symbol parameter

  const MarketNews({super.key, required this.symbol}); // Require symbol

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Latest News - $symbol", // Show symbol in title
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10),
          GetBuilder<NewsController>(
            builder: (newsController) {
              if (newsController.isMarketNewsLoading) {
                return SizedBox(
                  height: size.height * 0.5,
                  child: const Center(child: CircularProgressIndicator()),
                );
              }

              final allNews = newsController.getAllNewsResponseModel.data ?? [];

              // Filter news by the current symbol
              final newsList =
                  allNews.where((news) => news.symbol == symbol).toList();

              if (newsList.isEmpty) {
                return const Text("No news available for this stock.");
              }

              return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: newsList.length > 10 ? 10 : newsList.length,
                itemBuilder: (context, index) {
                  final news = newsList[index];

                  return GestureDetector(
                    onTap: () {
                      Get.to(() => NewsDetailsScreen(newsData: news));
                    },
                    child: SingleMarketNewsWidget(newsData: news),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class TooltipOnTapIcon extends StatefulWidget {
  final String message;

  const TooltipOnTapIcon({super.key, required this.message});

  @override
  State<TooltipOnTapIcon> createState() => _TooltipOnTapIconState();
}

class _TooltipOnTapIconState extends State<TooltipOnTapIcon> {
  OverlayEntry? _overlayEntry;

  void _showTooltip(BuildContext context) {
    final renderBox = context.findRenderObject() as RenderBox;
    final targetPosition = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;

    _overlayEntry = OverlayEntry(
      builder:
          (context) => Positioned(
            right: 30,
            top: targetPosition.dy - 40, // show above the icon
            child: Material(
              color: Colors.transparent,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  widget.message,
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ),
          ),
    );

    Overlay.of(context).insert(_overlayEntry!);

    Future.delayed(const Duration(seconds: 3), () {
      _overlayEntry?.remove();
      _overlayEntry = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_overlayEntry == null) {
          _showTooltip(context);
        }
      },
      child: SizedBox(
        height: 20,
        width: 20,
        child: Image.asset('assets/logos/mdi-help.png'),
      ),
    );
  }
}
