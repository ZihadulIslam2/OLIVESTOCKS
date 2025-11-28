
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:olive_stocks_flutter/features/auth/controllers/auth_controller.dart';
import 'package:olive_stocks_flutter/features/news/controllers/news_controller.dart';
import 'package:olive_stocks_flutter/features/portfolio/presentations/widgets/portfoilio_performance_chart_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../common/screens/side_menu.dart';
import 'package:olive_stocks_flutter/portfolio_allocation/presentation/widgets/custom_circular_percent_widget.dart';
import '../../../../common/widgets/cutom_profile_image.dart';
import '../../../../common/widgets/notification_icon_with_badge.dart';
import '../../../../helpers/custom_snackbar.dart';
import '../../../../portfolio_allocation/presentation/screens/protfolio_health_index.dart';
import '../../../markets/presentations/widgets/single_market_news_widget.dart';
import '../../../markets/presentations/widgets/single_stock_market_daily_gainers_losers.dart';
import '../../../markets/presentations/widgets/single_stock_market_upcoming_events_widget.dart';
import '../../../news/presentations/screens/news_details_screen.dart';
import '../../controller/portfolio_controller.dart';
import '../../domains/get_portfolio_response_model.dart';
import '../widgets/asset_allocation_widget.dart';
import '../widgets/bottom_sheet_widget.dart';
import '../widgets/filter_currency_widgets.dart';
import '../widgets/portfolio_header_widget.dart';
import '../widgets/portfolio_stock_widget.dart';
import '../widgets/search_bar.dart';
import '../widgets/stock_list_widget.dart';
import 'add_stocks_or_etfs.dart';

class PortfolioScreen extends StatefulWidget {
  final VoidCallback onItemTapped;

  const PortfolioScreen({super.key, required this.onItemTapped});

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool isWatchedSelect = true;
  bool _loading = true;

  void dummy()async{
    isWatchedSelect = await Get.find<PortfolioController>().isWatchListSelected();
  }



  @override
  void initState() {
    super.initState();
    final controller = Get.find<PortfolioController>();
    Get.find<NewsController>().getAllNewsWithMarket('');
    controller.searchStockData('AAPL');

    dummy();


    if (controller.portfolios.isNotEmpty) {
      if(!isWatchedSelect){

        //final portfolioId = controller.getPresentPortfolio().toString();
        final portfolioId = '688b33c871107483b54f02a9';
        controller.getAllStocksWarning(portfolioId);
        controller.getAllOverallBalance(portfolioId);
        controller.getAllUpcomingEvents(portfolioId);
        controller.getAllPerformance(portfolioId);
        controller.postAssetAllocation(portfolioId);

      }
    }
  }





  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;


    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      drawer: SideMenu(),

      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 2.0,
        shadowColor: Colors.black,
        title: Row(
          children: [
            GestureDetector(
              onTap: () => showBottomSheetCustom(context),
              child: Row(
                children: [
                GetBuilder<AuthController>(builder:(authController){
                  return   GetBuilder<PortfolioController>(
                    builder: (controller){
                      return Row(
                        children: [
                          CircleAvatar(
                            radius: 19,
                            backgroundColor: Colors.grey.shade200,
                            child: ClipOval(
                              child: (authController.getSingleUserResponseModel?.data?.profilePhoto?.isNotEmpty ?? false)
                                  ? CachedNetworkImage(
                                imageUrl: authController.getSingleUserResponseModel!.data!.profilePhoto!,
                                fit: BoxFit.cover,
                                width: 38,
                                height: 38,
                                placeholder: (context, url) => const CircularProgressIndicator(strokeWidth: 2),
                                errorWidget: (context, url, error) => const Icon(Icons.person, size: 24),
                              )
                                  : const Icon(Icons.person, size: 24),
                            ),
                          ),


                          SizedBox(width: 5),
                          Text(controller.name,style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black,fontStyle: FontStyle.italic),),
                          Icon(
                            Icons.arrow_drop_down_sharp,
                            size: 35,
                            color: Color(0xff737373),
                          ),
                        ],
                      );
                    },
                  );
                }),
                ],
              ),
            ),

            Spacer(),

            GestureDetector(
              onTap: () {
                final items = Get.find<PortfolioController>().searchStockResponseModel.results ?? [];
                showSearch(
                  context: context,
                  delegate: MyDataSearchDelegate(items: items),
                );
              },
              child: Container(
                height: 18,
                width: 18,
                child: Image.asset('assets/logos/search.png'),
              ),
            ),

            SizedBox(width: 13),

            GestureDetector(
              onTap: () => showBottomSheetCustom(context),
              child: Container(
                height: 18,
                width: 18,
                child: Image.asset('assets/logos/bag.png'),
              ),
            ),

            SizedBox(width: 13),

            const NotificationIconWithBadge(),

          ],
        ),
      ),

      body: GetBuilder<AuthController>(
        builder: (authController) {
          return GetBuilder<PortfolioController>(
            builder: (portfolioController) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    PortfolioHeaderCards(),
                    SizedBox(height: 10),

                    portfolioController.watchlistSelected ?  Container(child: StockListScreen()) : Container(
                      child: PortfolioStockWidget(),
                    ),
                    SizedBox(height: 10),
                    _buildOverallBalance(authController, portfolioController, size),
                    SizedBox(height: 10),
                    _buildLatestNews(size),
                    SizedBox(height: 20),
                    _buildPerformanceWidget(authController),
                    SizedBox(height: 20),
                    SingleStockMarketDailyGainersLosers(),
                    SizedBox(height: 20),
                    _buildPerformanceChart(authController, portfolioController),
                    SizedBox(height: 20),
                    SingleStockMarketUpcomingEventsWidget(),
                    SizedBox(height: 20),
                    _buildAssetAllocation(authController),
                    SizedBox(height: 20),
                    _buildStockWarnings(),
                    SizedBox(height: 20),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(AddStocksScreen()),
        //onPressed: () => Get.to(StockListWidget()),
        backgroundColor: Colors.green,
        shape: CircleBorder(),
        elevation: 4.0,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildOverallBalance(
      AuthController auth, PortfolioController portfolio, Size size) {
    final TextEditingController cashController = TextEditingController();

    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final prefs = snapshot.data!;
        final isGoogleLoggedIn = prefs.getBool('isGoogleLoggedIn') ?? false;
        final isUserLoggedIn = auth.isLoggedIn();
        final isLoggedIn = isUserLoggedIn || isGoogleLoggedIn;

        // 🔒 Block only if user is not logged in at all
        if (!isLoggedIn) {
          return Container(
            height: size.height * .2,
            width: size.width * .9,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(color: Colors.black26, spreadRadius: 2, blurRadius: 2),
              ],
            ),
            child: Center(
              child: Container(
                height: size.height * .2,
                width: size.width * .7,
                child: const Center(
                  child: Text(
                    'Please Log In and create a portfolio to see the Overall Balance',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          );
        }

        // 🔄 Show loading while fetching balance
        if (portfolio.isBalanceLoading ||
            portfolio.overallBalanceResponseModel == null) {
          return const Center(child: CircularProgressIndicator());
        }

        // ✅ Show balance widget if user is logged in (Google OR Email/Password)
        return Column(
          children: [
            OverallBalanceWidget(
              dailyReturn:
              portfolio.overallBalanceResponseModel?.dailyReturn ?? '0',
              totalValueWithCash:
              portfolio.overallBalanceResponseModel?.totalValueWithCash ?? '0',
              totalHoldings:
              portfolio.overallBalanceResponseModel?.totalHoldings ?? '0',
              cash: portfolio.overallBalanceResponseModel?.cash ?? 0.0,
              dailyReturnPercent:
              portfolio.overallBalanceResponseModel?.dailyReturnPercent ?? '0',
              monthlyReturnPercent:
              portfolio.overallBalanceResponseModel?.monthlyReturnPercent ?? '0',
              overallReturnPercent:
              portfolio.overallBalanceResponseModel?.overallReturnPercent ?? '0',
            ),
            const SizedBox(height: 16),

            // ✅ Cash Input + Add Button
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.green),
                boxShadow: [
                  BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 6),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Add Portfolio Cash (\$):",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: cashController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            hintText: 'Enter cash amount',
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 10),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () async {
                          final input = cashController.text.trim();
                          if (input.isEmpty || int.tryParse(input) == null) {
                            showCustomSnackBar('Please enter a valid amount');
                            return;
                          }

                          final int cashAmount = int.parse(input);
                          final selectedPortfolio =
                          portfolio.portfolios.firstWhereOrNull(
                                (p) => p.id == portfolio.selectedPortfolioId,
                          );

                          if (selectedPortfolio != null) {
                            // ✅ Update portfolio cash
                            await portfolio.patchUpdatePortfolio(
                              selectedPortfolio.id ?? '',
                              getPortfolioNameById(
                                  selectedPortfolio.id!, portfolio.portfolios)
                                  .toString(),
                              cashAmount.toDouble(),
                            );

                            // ✅ Refresh overall balance
                            await portfolio.getAllOverallBalance(
                                selectedPortfolio.id ?? '');

                            cashController.clear();
                            showCustomSnackBar('Cash updated successfully');
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                        child: const Text(
                          "Add",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }



  Widget _buildLatestNews(Size size) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: size.height * 0.85),
        child: Container(
          width: size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 1,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Latest News',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 15),
                  GetBuilder<NewsController>(
                    builder: (newsController) {
                      if (newsController.isAllNewsLoading) {
                        return Container(
                          height: size.height * 0.5,
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }

                      final newsList = newsController.getAllNewsResponseModel.data ?? [];
                      if (newsList.isEmpty) {
                        return Text('No news available');
                      }

                      return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: newsList.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Get.to(NewsDetailsScreen(newsData: newsList[index]));
                            },
                            child: SingleMarketNewsWidget(newsData: newsList[index]),
                          );
                        },
                      );
                    },
                  ),
                  SizedBox(height: 10),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Show More News',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPerformanceWidget(AuthController auth) {
    return auth.isAnyLoggedIn() ? PerformanceWidget() : SizedBox();
  }

  Widget _buildPerformanceChart(AuthController auth, PortfolioController portfolio) {
    if (!auth.isAnyLoggedIn()) return SizedBox();
    if (portfolio.performanceResponseModel.performanceChart == null) {
      return Center(child: CircularProgressIndicator());
    }
    return PortfolioPerformanceChart(
      performanceChart: portfolio.performanceResponseModel.performanceChart!,
    );
  }

  Widget _buildAssetAllocation(AuthController auth) {
    return auth.isAnyLoggedIn() ? AssetAllocationWidget() : SizedBox();
  }


  Widget _buildStockWarnings() {
    return GetBuilder<PortfolioController>(
      builder: (controller) {
        if (controller.isStocksWarningLoading) {
          return Center(child: CircularProgressIndicator());
        }
        return SingleStockPortfolioStockWarningsWidget();
      },
    );
  }
}


String? getPortfolioNameById(String id, List<GetPortfolioResponseModel> portfolioList) {
  final matchedPortfolio = portfolioList.firstWhere(
        (portfolio) => portfolio.id == id,
    orElse: () => GetPortfolioResponseModel(), // fallback if not found
  );

  return matchedPortfolio.name;
}

class PerformanceWidget extends StatelessWidget {
  PerformanceWidget({super.key});

  String trimPercentage(String? input) {
    if (input == null) return '0';
    return input.replaceAll('%', '').trim();
  }

  // Helper method to parse and format average return
  Map<String, dynamic> formatAverageReturn(String? averageReturn) {
    if (averageReturn == null) return {'text': '0%', 'color': Colors.black};

    // Remove % sign and parse the value
    String cleanValue = averageReturn.replaceAll('%', '').trim();
    double? value = double.tryParse(cleanValue);

    if (value == null) return {'text': '0%', 'color': Colors.black};

    if (value > 0) {
      return {
        'text': '+${value.toStringAsFixed(2)}%',
        'color': Colors.green
      };
    } else if (value < 0) {
      return {
        'text': '${value.toStringAsFixed(2)}%',
        'color': Colors.red
      };
    } else {
      return {
        'text': '0.00%',
        'color': Colors.black
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<AuthController>(builder: (authController) {
      return GetBuilder<PortfolioController>(
        builder: (portfolioController) {
          if (portfolioController.isPerformanceLoading) {
            return Center(child: CircularProgressIndicator());
          }

          // Safely get portfolio name
          String name = '';
          for (final portfolio in portfolioController.portfolios) {
            if (portfolio.id == portfolioController.selectedPortfolioId) {
              name = portfolio.name ?? '';
              break;
            }
          }

          // Safely get performance data
          final performance = portfolioController.performanceResponseModel;
          final rankings = performance.rankings;
          final successRate = rankings?.successRate ?? '0%';
          final averageReturn = rankings?.averageReturn ?? '0%';

          // Format average return with color and sign
          final averageReturnFormatted = formatAverageReturn(averageReturn);

          // Parse success rate for progress display
          double successRateValue = double.parse(trimPercentage(successRate)) / 100;

          return Container(
            height: size.height * .38,
            width: size.width * .9,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Performance',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          Icon(Icons.info_outline, color: Colors.red, size: 18),
                        ],
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () => Get.to(ProtfolioHealthIndex()),
                            child: Text(
                              'See More',
                              style: TextStyle(fontSize: 12, color: Colors.green),
                            ),
                          ),
                          Icon(Icons.chevron_right_outlined, color: Colors.green),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(authController.getSingleUserResponseModel?.data?.profilePhoto ?? ''),
                      ),
                      SizedBox(width: 7),
                      Container(
                        width: size.width * .6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                            ),
                            Text(
                              'Rate of successful transactions and their average returns',
                              maxLines: 5,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff4E4E4E),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 185,
                        width: 154,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.green),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Text('Success Rate', style: TextStyle(fontSize: 12)),
                              SizedBox(height: 10),
                              CustomCircularPercentWidget(
                                percent: performance.rankings?.successRate?.length ?? 0,
                                size: 60,
                              ),
                              // CircularPercentWidget(
                              //   percent: (performance.rankings!.successRate?.isNotEmpty ?? false)
                              //       ? successRateValue
                              //       : 0, // Show progress only when we have a value
                              //   selectedSortTab: 10,
                              //   centerText: "${(double.tryParse(trimPercentage(successRate).toString()) ?? 0).toStringAsFixed(0)}%",
                              // ),

                              SizedBox(height: 20),
                              Text(
                                '0 out of 3 profitable transactions',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Container(
                        height: 185,
                        width: 154,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.green),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Text('Average Return', style: TextStyle(fontSize: 12)),
                              SizedBox(height: 31),
                              Text(
                                averageReturnFormatted['text'],
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: averageReturnFormatted['color'],
                                ),
                              ),
                              SizedBox(height: 31),
                              Text(
                                '0 out of 3 profitable transactions',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }
}



class OverallBalanceWidget extends StatelessWidget {
  const OverallBalanceWidget({
    super.key,
    this.dailyReturn,
    this.totalHoldings,
    this.cash,
    this.totalValueWithCash,
    this.dailyReturnPercent,
    this.monthlyReturnPercent,
    this.unrealizedGains,
    this.overallReturnPercent,
  });

  final String? totalHoldings;
  final double? cash;
  final String? totalValueWithCash;
  final String? dailyReturn;
  final String? dailyReturnPercent;
  final String? monthlyReturnPercent;
  final String? unrealizedGains;
  final String? overallReturnPercent;

  void _showEditDialog(BuildContext context, PortfolioController portfolio) {
    final TextEditingController _cashController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Update Cash"),
        content: TextField(
          controller: _cashController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'Enter new cash amount',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () async {
              final input = _cashController.text.trim();
              if (input.isEmpty || int.tryParse(input) == null) {
                showCustomSnackBar('Please enter a valid amount');
                return;
              }

              final int cashAmount = int.parse(input);
              final selectedPortfolio = portfolio.portfolios.firstWhereOrNull(
                    (p) => p.id == portfolio.selectedPortfolioId,
              );

              if (selectedPortfolio != null) {
                selectedPortfolio.cash = cashAmount.toDouble();

                await portfolio.patchUpdatePortfolio(selectedPortfolio.id ?? '',  getPortfolioNameById(selectedPortfolio.id!, portfolio.portfolios).toString(), cashAmount.toDouble());
                await portfolio.getAllOverallBalance(selectedPortfolio.id ?? '');

                Navigator.pop(context);
                showCustomSnackBar('Cash updated successfully');
              } else {
                showCustomSnackBar('Portfolio not found');
              }
            },
            child: Text("Save"),
          ),
        ],
      ),
    );
  }


  Color _getColor(double value) {
    if (value > 0) return Colors.green;
    if (value < 0) return Colors.red;
    return Colors.grey;
  }

  String _getArrow(double value) {
    if (value > 0) return '▲';
    if (value < 0) return '▼';
    return '';
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<PortfolioController>(
      builder: (portfolioController) {
        return Container(
          padding: EdgeInsets.only(left: 16, right: 16),
          height: size.height * .222,
          width: size.width * .9,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 1,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Overall Balance",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    CurrencyFilterChip(),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Container(
                height: size.height * .063,
                width: size.width * .7,
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xff28A745), width: 1.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${totalValueWithCash.toString()}',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 24,
                        ),
                      ),
                      Container(
                        height: size.height * .05,
                        width: 2,
                        color: Colors.green,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Daily Return',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                '${_getArrow(double.tryParse(dailyReturn ?? "0") ?? 0)}\$${dailyReturn ?? "0"}',
                                style: TextStyle(
                                  color: _getColor(double.tryParse(dailyReturn ?? "0") ?? 0),
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 4),
                              Text(
                                '(${_getArrow(double.tryParse(dailyReturnPercent ?? "0") ?? 0)}${dailyReturnPercent ?? "0"}%)',
                                style: TextStyle(
                                  color: _getColor(double.tryParse(dailyReturnPercent ?? "0") ?? 0),
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Monthly Return',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '\$${monthlyReturnPercent.toString()}',
                          style: TextStyle(color: Colors.green),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'Overall Return',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '${overallReturnPercent.toString()}%',
                          style: TextStyle(color: Colors.green),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Text('Cash Value: \$${cash.toString()}', style: TextStyle(fontSize: 12)),
                  TextButton(
                    onPressed: () => _showEditDialog(context, portfolioController),
                    style: TextButton.styleFrom(padding: EdgeInsets.zero),
                    child: Text('', style: TextStyle(color: Colors.green)),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}



class SingleStockPortfolioStockWarningsWidget extends StatefulWidget {
  const SingleStockPortfolioStockWarningsWidget({super.key,});

  @override
  State<SingleStockPortfolioStockWarningsWidget> createState() => _SingleStockPortfolioStockWarningsWidgetState();
}


class _SingleStockPortfolioStockWarningsWidgetState extends State<SingleStockPortfolioStockWarningsWidget> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<PortfolioController>(builder: (portfolioController){
      return !portfolioController.isStocksWarningLoading ?  Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.0),
        child: Container(
          width: size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 1,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: Column(
            children: [
              SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Stock Warnings',
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                    Text(
                      'Show More',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 4),

              Visibility(
                visible: portfolioController.assetAllocationResponseModel?.metrics?.warnings?.isNotEmpty == true,
                child: Column(
                  children: List.generate(portfolioController.assetAllocationResponseModel!.metrics!.warnings?.length ?? 0, (index) {
                    final warnings = portfolioController.assetAllocationResponseModel!.metrics!.warnings![index];
                    return Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.warning, color: Colors.red, size: 25),

                            Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        width: size.width * .76,
                                        child: Text(
                                          warnings.symbol!,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                      Container(

                                        width: size.width * .76,
                                        child: Text(
                                          warnings.name!,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 10,
                                              color: Color(0xff737373)
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                          ],
                        ),
                      ),
                    );
                  }),
                ),
              )


            ],
          ),
        ),
      ) :const Center(child: CircularProgressIndicator(),) ;
    });
  }
}
