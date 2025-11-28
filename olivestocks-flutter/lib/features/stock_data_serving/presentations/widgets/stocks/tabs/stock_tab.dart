import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../portfolio/controller/portfolio_controller.dart';
import '../../table/most_traded.dart';
import '../../table/top_daily_stock_gainer_losers.dart';
import '../../table_model/most_traded_model.dart';
import '../../table_model/stock_etf_model.dart';
import '../models/stock_model.dart';
import '../widgets/daily_analyst_rating.dart';
import '../widgets/top_daily_stocks.dart';
import '../widgets/upcoming_events.dart';

class StocksTab extends StatefulWidget {

  @override
  State<StocksTab> createState() => _StocksTabState();
}

class _StocksTabState extends State<StocksTab> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      PortfolioController controller = Get.find<PortfolioController>();
      controller.getAllGainAndLoose();
      controller.getAllMostTradedStocks();
      controller.getAllAnalystsTopStocks();
      controller.getAllDailyAnalystRatings();
      //controller.getAllUpcomingEvents();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;


    return SingleChildScrollView(
      child: GetBuilder<PortfolioController>(
        builder: (portfolioController) {
          if (portfolioController.dailyGainerAndDailyLooserResponseModel == null) {
            print('task is empty');
            return Container(
              height: size.height * 0.8,
              width: size.width,
              child: const Center(child: Text('No Task Found')),
            );
          }
          if (portfolioController.analystsTopStocksResponseModel == null) {
            print('TAsk is null');
            return Container(
              height: size.height * 0.8,
              width: size.width,
              child: const Center(child: Text('No Task Found')),
            );
          }

          if (portfolioController.mostTradedStocksResponseModel == null) {
            print('TAsk is null');
            return Container(
              height: size.height * 0.8,
              width: size.width,
              child: const Center(child: Text('No Task Found')),
            );
          }
          if (portfolioController.upcomingEventsResponseModel == null) {
            print('TAsk is null');
            return Container(
              height: size.height * 0.8,
              width: size.width,
              child: const Center(child: Text('No Task Found')),
            );
          }
          if (portfolioController.dailyAnalystRatingResponseModel == null) {
            print('TAsk is null');
            return Container(
              height: size.height * 0.8,
              width: size.width,
              child: const Center(child: Text('No Task Found')),
            );
          }

          return Column(

            children: [
              // Top Gainers and Losers Table
              portfolioController.dailyGainerAndDailyLooserResponseModel != null
                  ? Container(
                    child: TopGainersLosers(
                      stocks:
                          portfolioController
                              .dailyGainerAndDailyLooserResponseModel!
                              .gainers,
                      losers:
                          portfolioController
                              .dailyGainerAndDailyLooserResponseModel!
                              .losers,
                    ),
                  )
                  : const SizedBox(),

              // const SizedBox(height: 10),

              // Most Traded Stocks Table
              portfolioController.mostTradedStocksResponseModel != null
                  ? MostTradedTable(
                    trendingStocks:
                        portfolioController
                            .mostTradedStocksResponseModel!
                            .trendingStocks,
                    topStocks:
                        portfolioController
                            .mostTradedStocksResponseModel!
                            .topStocks,
                  )
                  : const SizedBox(),

////// It will be visible only when user is logged in and have portfolio///////////////
              const SizedBox(height: 16),
              portfolioController.upcomingEventsResponseModel != null ? UpcomingEventScreen(
                events: portfolioController.upcomingEventsResponseModel.events,
              ) : const SizedBox(),


              const SizedBox(height: 16),
              portfolioController.analystsTopStocksResponseModel != null
                  ? AnalystsTopStocksScreen(
                    trendingStocks:
                portfolioController
                    .analystsTopStocksResponseModel!
                    .trendingStocks,
                    topStocks:
                        portfolioController
                            .analystsTopStocksResponseModel!
                            .topStocks,

                  )
                  : const SizedBox(),
              const SizedBox(height: 16),
              portfolioController.dailyAnalystRatingResponseModel != null ? DailyAnalystRatingScreen(
                qualityStocks:
                portfolioController
                    .dailyAnalystRatingResponseModel
                    .qualityStocks,
              ): const SizedBox(),
              const SizedBox(height: 16),
            ],

          );
        },
      ),
    );
  }
}
