import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:olive_stocks_flutter/common/screens/NabScreen.dart';
import 'package:olive_stocks_flutter/features/portfolio/domains/cash_flow_response_model.dart';
import 'package:olive_stocks_flutter/features/portfolio/domains/create_new_portfolio_response_model.dart';
import 'package:olive_stocks_flutter/features/portfolio/domains/earnings_response_model.dart';
import 'package:olive_stocks_flutter/features/portfolio/domains/eps_chart_response_model.dart';
import 'package:olive_stocks_flutter/features/portfolio/domains/get_portfolio_by_id_response_model.dart';
import 'package:olive_stocks_flutter/features/portfolio/domains/get_portfolio_response_model.dart';
import 'package:olive_stocks_flutter/features/portfolio/domains/get_watchlist_response_model.dart'
    hide Data, Olives;
import 'package:olive_stocks_flutter/features/portfolio/domains/olive_stocks_portfolio_response_model.dart'
    hide Olives;
import 'package:olive_stocks_flutter/features/portfolio/domains/overall_balance_response_model.dart';
import 'package:olive_stocks_flutter/features/portfolio/domains/price_chart_response_model.dart' hide Data;
import 'package:olive_stocks_flutter/features/portfolio/domains/revenue_chart_response_model.dart';
import 'package:olive_stocks_flutter/features/portfolio/domains/search_stock_response_model.dart';
import 'package:olive_stocks_flutter/features/portfolio/domains/target_chart_response_model.dart';
import 'package:olive_stocks_flutter/features/portfolio/domains/tranding_stocks_response_model.dart'
    hide Olives;
import 'package:olive_stocks_flutter/features/portfolio/domains/upcoming_event_response_model.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../../../core/contants/urls.dart';
import '../../../helpers/custom_snackbar.dart';
import '../../../helpers/remote/data/api_checker.dart';
import '../../../helpers/remote/data/api_client.dart';
import '../../../payment/const.dart';
import '../../auth/controllers/auth_controller.dart';
import '../domains/analysts_top_stocks_response_model.dart' hide Olives;
import '../domains/asset_allocation_response_model.dart';
import '../domains/daily_analyst_ratings_response_model.dart' hide Olives;
import '../domains/daily_gainer_and_looser_model.dart';
import '../domains/delete_portfolio_response_model.dart';
import '../domains/get_single_user_response_model.dart';
import '../domains/get_stock_overview_response_model.dart';
import '../domains/most_treded_stock_model.dart';
import '../domains/notification_response_model.dart';
import '../domains/patch_update_portfolio_name_response_model.dart';
import '../domains/patch_update_portfolio_response model.dart';
import '../domains/performance_response_model.dart';
import '../domains/post_update_user_profile_response_model.dart';
import '../domains/stock_update_socket_response_model.dart';
import '../services/portfolio_service_interface.dart';

class PortfolioController extends GetxController implements GetxService {
  @override
  void onReady() async {
    initSocket();
    if (Get.find<AuthController>().isLoggedIn()) {
      await getPortfolio();
    }
    super.onReady();
  }

  final PortfolioServiceInterface portfolioServiceInterface;

  PortfolioController(this.portfolioServiceInterface);

  bool isLoading = false;
  bool isGainLoading = false;
  bool isMostLoading = false;
  bool isAnalystLoading = false;
  bool isDailyLoading = false;
  bool isUpcomingLoading = false;
  bool isBalanceLoading = false;
  bool isPerformanceLoading = false;
  bool isPortfolioLoading = false;
  bool isUnderRadarLoading = false;
  bool isPriceChartLoading = false;
  bool isTargetChartLoading = false;
  bool isRevenueChartLoading = false;
  bool isEPSChartLoading = false;
  bool isCashFlowChartLoading = false;
  bool isEarningChartLoading = false;
  bool isCreatingLoading = false;
  bool isWatchListLoading = false;
  bool isTrendingLoading = false;
  bool isAssetAllocationLoading = false;
  bool isoPortfolioNewLoading = false;
  bool isStocksWarningLoading = false;
  bool isSupportLoading = false;
  bool isNotificationLoading = false;
  bool isAddPortfolioLoading = false;
  bool isDeletePortfolioLoading = false;
  bool isDeleteWatchListLoading = false;
  var isUpdateProfileLoading = false.obs;
  bool isPortfolioByLoading = false;

  bool isSingleUserLoading = false;

  DailyGainerAndDailyLooserResponseModel?
  dailyGainerAndDailyLooserResponseModel =
  DailyGainerAndDailyLooserResponseModel(gainers: [], losers: []);
  MostTradedStocksResponseModel? mostTradedStocksResponseModel =
  MostTradedStocksResponseModel(trendingStocks: [], topStocks: []);
  AnalystsTopStocksResponseModel? analystsTopStocksResponseModel =
  AnalystsTopStocksResponseModel(trendingStocks: [], topStocks: []);
  DailyAnalystRatingsResponseModel dailyAnalystRatingResponseModel =
  DailyAnalystRatingsResponseModel(qualityStocks: []);
  UpComingEventsResponseModel upcomingEventsResponseModel =
  UpComingEventsResponseModel(events: []);
  OverallBalanceResponseModel? overallBalanceResponseModel =
  OverallBalanceResponseModel(
    totalHoldings: '',
    cash: 0,
    totalValueWithCash: '0',
    dailyReturn: '0',
    dailyReturnPercent: '0',
    monthlyReturnPercent: '0',
    holdings: [],
  );
  PerformanceResponseModel performanceResponseModel = PerformanceResponseModel(
    overview: Overview(),
    rankings: Rankings(),
    mostProfitableTrade: MostProfitableTrade(),
    returnsComparison: [],
    recentActivity: RecentActivity(),
    transactionHistory: [],
    performanceChart: PerformanceChart(),
  );
  OliveStocksPortfolioResponseModel? oliveStocksPortfolioResponseModel =
  OliveStocksPortfolioResponseModel(oliveStocks: []);
  TrendingStocksResponseModel? trendingStocksResponseModel =
  TrendingStocksResponseModel(trendingStocks: [], topStocks: []);
  AssetAllocationResponseModel? assetAllocationResponseModel =
  AssetAllocationResponseModel(
    assetAllocation: AssetAllocation(),
    holdingsBySector: [],
    metrics: Metrics(),
  );

  PriceChartResponseModel  priceChartResponseModel = PriceChartResponseModel();
  TargetChartResponseModel? targetChartResponseModel = TargetChartResponseModel(
    targets: Targets(),
  );
  RevenueChartResponseModel revenueChartResponseModel =
  RevenueChartResponseModel(
    actual: 0,
    estimate: 0,
    period: '',
    quarter: 0,
    surprise: 0,
    surprisePercent: 0,
    symbol: '',
    year: 0,
  );
  EPSChartResponseModel epsChartResponseModel = EPSChartResponseModel(
    actual: 0,
    estimate: 0,
    period: '',
    quarter: 0,
    surprise: 0,
    surprisePercent: 0,
    symbol: '',
    year: 0,
  );
  CashFlowChartResponseModel? cashFlowChartResponseModel =
  CashFlowChartResponseModel(symbol: '', cashFlows: []);
  EarningsChartResponseModel earningsChartResponseModel =
  EarningsChartResponseModel(
    actual: 0,
    estimate: 0,
    period: '',
    quarter: 0,
    surprise: 0,
    surprisePercent: 0,
    symbol: '',
    year: 0,
  );

  GetStockOverviewResponseModel getStockOverviewResponseModel =
  GetStockOverviewResponseModel(
    company: '',
    logo: '',
    exchange: '',
    quadrant: '',
    olives: Olives(),
    shariaCompliant: false,
    reason: '',
    valuationBar: ValuationBar(),
  );

  SearchStockResponseModel searchStockResponseModel = SearchStockResponseModel(
    results: [],
  );

  CreateNewPortfolioResponseModel createNewPortfolioResponseModel =
  CreateNewPortfolioResponseModel();

  GetWatchListResponseModel? getWatchListResponseModel =
  GetWatchListResponseModel(data: []);

  NotificationResponseModel notificationResponseModel =
  NotificationResponseModel(
    id: '',
    userId: '',
    message: '',
    type: '',
    related: '',
    isRead: false,
    link: '',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    v: 0,
  );

  UpdateUserResponseModel? updateUserResponseModel = UpdateUserResponseModel();

  GetSingleUserResponseModel? getSingleUserResponseModel = GetSingleUserResponseModel();

  DeletePortfolioResponseModel? deletePortfolioResponseModel = DeletePortfolioResponseModel();

  UpdatePortfolioResponseModel updatePortfolioResponseModel = UpdatePortfolioResponseModel();


  UpdatePortfolioNameResponseModel updatePortfolioNameResponseModel = UpdatePortfolioNameResponseModel();
  GetPortfolioByIdResponseModel getPortfolioByIdResponseModel = GetPortfolioByIdResponseModel();


  // Gainer Loser
  Future<void> getAllGainAndLoose() async {
    isGainLoading = true;

    try {
      Response? response = await portfolioServiceInterface.getAllGainAndLoose();

      if (response.statusCode == 200) {
        dailyGainerAndDailyLooserResponseModel =
            DailyGainerAndDailyLooserResponseModel.fromJson(response.body);
        print('Success: getAllGainAndLoose');
      } else {
        ApiChecker.checkApi(response);
      }
    } catch (e) {
      print('Error in getAllGainAndLoose: $e');
    } finally {
      isGainLoading = false;
      update();
    }
  }

  // Most Traded
  Future<void> getAllMostTradedStocks() async {
    isMostLoading = true;
    try {
      Response? response = await portfolioServiceInterface.mostTradedStocks();

      if (response.statusCode == 200) {
        mostTradedStocksResponseModel = MostTradedStocksResponseModel.fromJson(
          response.body,
        );
        print('Success: getAllMostTradedStocks');
      } else {
        ApiChecker.checkApi(response);
      }
    } catch (e) {
      print('Error in getAllMostTradedStocks: $e');
    } finally {
      isMostLoading = false;
      update();
    }
  }

  //AnalystsTopStocks
  Future<void> getAllAnalystsTopStocks() async {
    isAnalystLoading = true;
    try {
      Response? response =
      await portfolioServiceInterface.getAllAnalystTopStocks();

      if (response.statusCode == 200) {
        analystsTopStocksResponseModel =
            AnalystsTopStocksResponseModel.fromJson(response.body);
        print('Success: getAllAnalystsTopStocks');
      } else {
        ApiChecker.checkApi(response);
      }
    } catch (e) {
      print('Error in getAllAnalystsTopStocks: $e');
    } finally {
      isAnalystLoading = false;
      update();
    }
  }

  //DailyAnalystRatings
  Future<void> getAllDailyAnalystRatings() async {
    isDailyLoading = true;

    try {
      Response? response =
      await portfolioServiceInterface.getAllDailyAnalystRatings();

      if (response.statusCode == 200) {
        dailyAnalystRatingResponseModel =
            DailyAnalystRatingsResponseModel.fromJson(response.body);
        print('Success: getAllAnalystsTopStocks');
      } else {
        ApiChecker.checkApi(response);
      }
    } catch (e) {
      print('Error in getAllAnalystsTopStocks: $e');
    } finally {
      isDailyLoading = false;
      update();
    }
  }

  //UpcomingEarnings
  Future<void> getAllUpcomingEvents(String portfolioId) async {
    isUpcomingLoading = true;

    try {
      Response? response = await portfolioServiceInterface.getAllUpComingEvents(
        portfolioId,
      );
      if (response.statusCode == 200) {
        upcomingEventsResponseModel = UpComingEventsResponseModel.fromJson(
          response.body,
        );
        print('Success: getAllUpcomingEarnings');
      } else {
        ApiChecker.checkApi(response);
      }
    } catch (e) {
      print('Error in getAllUpcomingEarnings: $e');
    } finally {
      isDailyLoading = false;
      update();
    }
  }

  //OverallBalance
  void updateCashValue(double newValue) {
    overallBalanceResponseModel?.cash = newValue; // Update the cash value
    update(); // Notify listeners
  }

  Future<void> getAllOverallBalance(String portfolioId) async {
    isBalanceLoading = true;
    update(); // Notify UI to show loading state

    try {
      Response? response = await portfolioServiceInterface.getAllOverallBalance(
        portfolioId,
      );

      if (response.statusCode == 200) {
        overallBalanceResponseModel = OverallBalanceResponseModel.fromJson(
          response.body,
        );
        print("Portfolio data updated successfully");
      } else {
        ApiChecker.checkApi(response);
        throw Exception("Failed to load portfolio: ${response.statusCode}");
      }
    } catch (e) {
      print('Error in getAllOverallBalance: $e');
      rethrow; // Re-throw to handle in the calling function
    } finally {
      isBalanceLoading = false;
      update(); // Always update when done
    }
  }

  Future<void> getPortfolioById(String symbol) async {
   isPortfolioByLoading= true;
    try {
      Response? response = await portfolioServiceInterface.getPortfolioById(
        symbol,
      );

      print(
        'Success: Portfolo by id. ----------------- ggggggggg lllllllll-----------------------///////////////////==============',
      );

      if (response.statusCode == 200) {
        getPortfolioByIdResponseModel = GetPortfolioByIdResponseModel.fromJson(
          response.body,
        );
        print("Raw API Response: ${response.body}");
        print(
          'Success: getPortfolioById. ----------------- ggggggggg-----------------------///////////////////==============',
        );
       isPortfolioByLoading = false;
      } else {
        ApiChecker.checkApi(response);
      }

      print(response.body.toString());
    } catch (e) {
      print('Error in getPortfolioById: $e');
    }
   isPortfolioByLoading = false;
    update();
  }

  //Performance
  Future<void> getAllPerformance(String id) async {
    if (isPerformanceLoading) {
      isPerformanceLoading = true;
      update();
    }
    try {
      Response? response = await portfolioServiceInterface.getAllPerformance(
        id,
      );
      if (response.statusCode == 200) {
        performanceResponseModel = PerformanceResponseModel.fromJson(
          response.body,
        );
        isPerformanceLoading = false;
        print('Success: getAllPerformance');
      } else {
        ApiChecker.checkApi(response);
      }
    } catch (e) {
      print('Error in getAllPerformance: $e');
    } finally {
      isPerformanceLoading = false;
      update();
    }
  }

  //Olive Stocks Portfolio
  Future<void> getAllOliveStocksPortfolio() async {
    if (isPortfolioLoading) {
      isPortfolioLoading = true;
      update();
    }
    try {
      Response? response =
      await portfolioServiceInterface.getAllOliveStocksPortfolio();
      //print(response.body);
      if (response.statusCode == 200) {
        oliveStocksPortfolioResponseModel =
            OliveStocksPortfolioResponseModel.fromJson(response.body);
        print("update ui...");
      } else {
        ApiChecker.checkApi(response);
      }
    } catch (e) {
      print('Error in getAllOliveStocksPortfolio: $e');
    }
    isPortfolioLoading = false;
    update();
  }

  // olive stocks under radar
  Future<void> getAllOliveStocksUnderRadar() async {
    if (isUnderRadarLoading) {
      isUnderRadarLoading = true;
      update();
    }
    try {
      Response? response =
      await portfolioServiceInterface.getAllOliveStocksUnderRadar();
      //print(response.body);
      if (response.statusCode == 200) {
        oliveStocksPortfolioResponseModel =
            OliveStocksPortfolioResponseModel.fromJson(response.body);
        print("update ui...");
      } else {
        ApiChecker.checkApi(response);
      }
    } catch (e) {
      print('Error in getAllOliveStocksPortfolio: $e');
    }
    isUnderRadarLoading = false;
    update();
  }

  bool isStockOverViewLoading = false;

  //StockOverview
  Future<void> getStockOverView(String symbol) async {
    isStockOverViewLoading = true;

    try {
      Response? response = await portfolioServiceInterface.getStockOverview(
        symbol,
      );
      if (response.statusCode == 200) {
        print('Success: getAllUpcomingEarnings');
        getStockOverviewResponseModel = GetStockOverviewResponseModel.fromJson(
          response.body,
        );
      } else {
        ApiChecker.checkApi(response);
      }
    } catch (e) {
      print('Error in getAllUpcomingEarnings: $e');
    } finally {
      isStockOverViewLoading = false;
      update();
    }
  }

  //Price chart
  String selectedTimeRange = 'Day';

  Future<void> getPriceChart(String symbol) async {
    isPriceChartLoading = true;

    try {
      Response? response = await portfolioServiceInterface.getPriceChart(
        symbol,
      );
      if (response.statusCode == 200) {
        print(
          'Success: getPriceChart ====================================---------------------==============',
        );
        priceChartResponseModel = PriceChartResponseModel.fromJson(
          response.body,
        );
      } else {
        ApiChecker.checkApi(response);
      }
    } catch (e) {
      print('Error in getPriceChart: $e');
    } finally {
      isPriceChartLoading = false;
      update();
    }
  }

  //target chart
  Future<void> getTargetChart(String symbol) async {
    isTargetChartLoading = true;

    try {
      Response? response = await portfolioServiceInterface.getTargetChart(
        symbol,
      );
      if (response.statusCode == 200) {
        print('Success: getTargetChart');
        targetChartResponseModel = TargetChartResponseModel.fromJson(
          response.body,
        );
      } else {
        ApiChecker.checkApi(response);
      }
    } catch (e) {
      print('Error in getTargetChart: $e');
    } finally {
      isTargetChartLoading = false;
      update();
    }
  }

  //Cash Flow
  Future<void> getCashFlowChart(String symbol) async {
    isCashFlowChartLoading = true;

    try {
      Response? response = await portfolioServiceInterface.getCashFlowChart(
        symbol,
      );
      if (response.statusCode == 200) {
        print('Success: getCashFlowChart');
        cashFlowChartResponseModel = CashFlowChartResponseModel.fromJson(
          response.body,
        );
      } else {
        ApiChecker.checkApi(response);
      }
    } catch (e) {
      print('Error in getCashflowChart: $e');
    } finally {
      isCashFlowChartLoading = false;
      update();
    }
  }

  //REVENUE CHART
  List<RevenueChartResponseModel> revenueChartData = [];

  Future<void> parseRevenueChartData(String symbol) async {
    try {
      Response response = await portfolioServiceInterface.getRevenueChart(
        symbol,
      );

      if (response.statusCode == 200) {
        // Check if the body is already a List
        if (response.body is List) {
          print(' Trying to fill data');
          revenueChartData =
              (response.body as List)
                  .map((e) => RevenueChartResponseModel.fromJson(e))
                  .toList();

          print(' Trying to fill data');
        }
        // If it's a String that needs parsing
        else if (response.body is String) {
          final jsonData = json.decode(response.body);
          revenueChartData =
              (jsonData as List)
                  .map((e) => RevenueChartResponseModel.fromJson(e))
                  .toList();
        }

        // Sort by date (newest first)
        revenueChartData.sort(
              (a, b) =>
              DateTime.parse(b.period).compareTo(DateTime.parse(a.period)),
        );

        update(); // Notify listeners if using GetX
        print('Loaded ${revenueChartData.length} revenue data points');
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error parsing revenue data: $e');
      throw Exception('Failed to parse data: $e');
    }
  }

  //Eps chart
  List<EPSChartResponseModel> epsChartList = [];
  String errorMessage = '';

  //FPS chart
  Future<void> getEPSChart(String symbol) async {
    try {
      isEPSChartLoading = true;
      errorMessage = '';
      update(); // Show loading spinner

      final response = await portfolioServiceInterface.getEPSChart(symbol);

      if (response.statusCode == 200 && response.body != null) {
        final responseData =
        response.body is List ? response.body : [response.body];

        final parsedData =
        responseData
            .map<EPSChartResponseModel>(
              (item) => EPSChartResponseModel.fromJson(item),
        )
            .toList();

        if (parsedData.isEmpty) {
          errorMessage = 'No EPS data found for this symbol';
        }

        epsChartList = parsedData;
      } else {
        // errorMessage = 'Failed to load data: ${response.statusCode}';
        epsChartList.clear();
      }
    } catch (e) {
      // errorMessage = 'Error: ${e.toString()}';
      epsChartList.clear();
    } finally {
      isEPSChartLoading = false;
      update(); // Refresh UI
    }
  }

  //Earnings chart
  Future<void> getEarningsChart(String symbol) async {
    isEarningChartLoading = true;

    try {
      Response? response = await portfolioServiceInterface.getEarningsChart(
        symbol,
      );
      if (response.statusCode == 200) {
        print('Success: getEarningsChart');
        earningsChartResponseModel = EarningsChartResponseModel.fromJson(
          response.body,
        );
      } else {
        ApiChecker.checkApi(response);
      }
    } catch (e) {
      print('Error in getEPSChart: $e');
    } finally {
      isEarningChartLoading = false;
      update();
    }
  }

  bool isLoadingSearch = false;

  Future<void> searchStockData(String symbol) async {
    isLoadingSearch = true;
    update();

    Response? response = await portfolioServiceInterface.searchStockData(
      symbol,
    );

    if (response.statusCode == 200) {
      print(response.body.toString());

      searchStockResponseModel = SearchStockResponseModel.fromJson(
        response.body,
      );

      // searchResults = [...getAllContentWithOutFilterResponseModel.data!.data!];
    } else {
      ApiChecker.checkApi(response);
    }

    isLoadingSearch = false;
    update();
  }

  //Create New Portfolio
  Future<void> createNewPortfolio(String name) async {
    isCreatingLoading = true;

    try {
      Response? response = await portfolioServiceInterface
          .getCreateNewPortfolio(name);
      if (response.statusCode == 201) {
        print('Success: getCreatePortfolio');
        createNewPortfolioResponseModel =
            CreateNewPortfolioResponseModel.fromJson(response.body);
        Get.to(NavScreen());
      } else {
        ApiChecker.checkApi(response);
      }
    } catch (e) {
      print('Error in getCreateNewPortfolio: $e');
    } finally {
      isCreatingLoading = false;
      update();
    }
  }

  late List<GetPortfolioResponseModel> portfolios = [];

  bool isLoadingPortfolio = false;

  //Get Portfolio

  Future<void> getPortfolio() async {
    isLoadingPortfolio = true; // Corrected variable name

    try {
      Response? response = await portfolioServiceInterface.getPortfolio();
      if (response.statusCode == 200) {
        print('Success: getCreatePortfolio');
        // Parse response body as a list of portfolios
        portfolios =
            (response.body as List)
                .map((item) => GetPortfolioResponseModel.fromJson(item))
                .toList();
      } else {
        ApiChecker.checkApi(response);
      }
    } catch (e) {
      print('Error in getCreateNewPortfolio: $e');
    } finally {
      isLoadingPortfolio = false;
      update();
    }
  }

  //Watchlist
  Future<void> getWatchList() async {
    isWatchListLoading = true;
    try {
      Response? response = await portfolioServiceInterface.getWatchList();
      if (response.statusCode == 200) {
        print('Success: getWatchList');
        getWatchListResponseModel = GetWatchListResponseModel.fromJson(
          response.body,
        );
      } else {
        ApiChecker.checkApi(response);
      }
    } catch (e) {
      print('Error in getWatchList: $e');
    } finally {
      isWatchListLoading = false;
      update();
    }
  }

  GetPortfolioResponseModel getPortfolioResponseModel =
  GetPortfolioResponseModel();

  ////// laast worked jul 17 ///////

  bool isLoadingSinglePortfolio = false;

  bool watchlistSelected = false;

  Future<void> loadSinglePortfolioStocks(String portfolioId) async {
    try {
      isLoadingSinglePortfolio = true;

      Response? response = await portfolioServiceInterface
          .loadSinglePortfolioStocks(portfolioId);
      if (response.statusCode == 200) {
        print('Success: getWatchList');
        getPortfolioResponseModel = GetPortfolioResponseModel.fromJson(
          response.body,
        );

        isLoadingSinglePortfolio = false;

        watchlistSelected = false;
      } else {
        ApiChecker.checkApi(response);
      }

      // print("${portfolioId} outside condition");
      // for(int i = 0; i < portfolios.length; i++){
      //   print("${portfolios[i].id} outside condition");
      //   if(portfolios[i].id == portfolioId){
      //     print(portfolios[i].id);
      //     getPortfolioResponseModel = portfolios[i];
      //   }
      // }
    } catch (e) {
      print(e.toString());
    }
    update();
  }

  //Trending Stocks
  Future<void> getTrendingStocks() async {
    isTargetChartLoading = true;

    try {
      Response? response =
      await portfolioServiceInterface.getAllTrendingStocks();
      if (response.statusCode == 200) {
        print('Success: getTrendingStocks');
        trendingStocksResponseModel = TrendingStocksResponseModel.fromJson(
          response.body,
        );
      } else {
        ApiChecker.checkApi(response);
      }
    } catch (e) {
      print('Error in getTrendingStocks: $e');
    } finally {
      isTrendingLoading = false;
      update();
    }
  }

  //Asset Allocation
  Future<void> postAssetAllocation(String portfolioId) async {
    isAssetAllocationLoading = true;

    try {
      Response? response = await portfolioServiceInterface.postAssetAllocation(
        portfolioId,
      );
      if (response.statusCode == 200) {
        print('Success: postAssetAllocation');
        assetAllocationResponseModel = AssetAllocationResponseModel.fromJson(
          response.body,
        );
      } else {
        ApiChecker.checkApi(response);
      }
    } catch (e) {
      print('Error in postAssetAllocation: $e');
    } finally {
      isAssetAllocationLoading = false;
      update();
    }
  }

  //Olive Stocks Portfolio New
  Future<void> getAllOliveStocksPortfolioNew() async {
    if (isoPortfolioNewLoading) {
      isoPortfolioNewLoading = true;
      update();
    }
    try {
      Response? response =
      await portfolioServiceInterface.getAllOliveStocksPortfolioNew();
      //print(response.body);
      if (response.statusCode == 200) {
        oliveStocksPortfolioResponseModel =
            OliveStocksPortfolioResponseModel.fromJson(response.body);
        print("update ui...New");
      } else {
        ApiChecker.checkApi(response);
      }
    } catch (e) {
      print('Error in getAllOliveStocksPortfolioNew: $e');
    }
    isoPortfolioNewLoading = false;
    update();
  }

  // Stocks Warnings
  Future<void> getAllStocksWarning(String id) async {
    isStocksWarningLoading = true;

    try {
      Response? response = await portfolioServiceInterface.getAllStocksWarning(
        id,
      );
      if (response.statusCode == 200) {
        print('Success: getAllStocksWarning');
        assetAllocationResponseModel = AssetAllocationResponseModel.fromJson(
          response.body,
        );
      } else {
        ApiChecker.checkApi(response);
      }
    } catch (e) {
      print('Error in getStocksWarning $e');
    } finally {
      isStocksWarningLoading = false;
      update();
    }
  }

  //Support
  Future<void> postSupport(String firstName,
      String lastName,
      String email,
      String message,
      String subject,
      String phoneNumber,) async {
    isSupportLoading = true;

    try {
      Response? response = await portfolioServiceInterface.postSupport(
        firstName,
        lastName,
        email,
        message,
        subject,
        phoneNumber,
      );
      if (response.statusCode == 200) {
        print('Success: postSupport');
        showCustomSnackBar('Successfully Sent Support');
      } else {
        ApiChecker.checkApi(response);
      }
    } catch (e) {
      print('Error in postSupport $e');
    } finally {
      isSupportLoading = false;
      update();
    }
  }

  String? selectedPortfolioId = '';

  //get Portfolio
  Future<String?> getPresentPortfolio() async {
    selectedPortfolioId =
    await portfolioServiceInterface.getPresentPortfolioNew();
    update();
    return selectedPortfolioId;
  }

  //Set Portfolio

  Future<void> setPresentPortfolio(String portfolioId) async {
    await portfolioServiceInterface.setPresentPortfolio(portfolioId);
    getPresentPortfolio();
    getWatchList();
    getAllStocksWarning(selectedPortfolioId!);
    getAllOverallBalance(selectedPortfolioId!);
    getAllUpcomingEvents(selectedPortfolioId!);
    getAllPerformance(selectedPortfolioId!);
    postAssetAllocation(selectedPortfolioId!);
  }

  void refreshPortfolios() async {
    isLoadingPortfolio = true;
    update();
    print('refreshPortfolios');

    await getPortfolio();

    isLoadingPortfolio = false;
    update();
  }

  /////////// Socket Connect///////////////////////////
  IO.Socket socket = IO.io(
    "https://backend-rafi-hzi9.onrender.com",
    <String, dynamic>{
      'autoConnect': false,
      'transports': ['websocket'],
    },
  );

  void initSocket() {
    socket = IO.io("https://backend-rafi-hzi9.onrender.com", <String, dynamic>{
      'autoConnect': false,
      'transports': ['websocket'],
    });

    socket.connect();

    socket.onConnect((_) {
      // print("✅ Socket connection established");
      listenToStockUpdates();
    });

    socket.onDisconnect((_) {
      // print("❌ Socket disconnected");
    });

    socket.onConnectError((err) {
      // print("⚠️ Socket connect error: $err");
    });

    socket.onError((err) {
      // print("❗ Socket general error: $err");
    });
  }

  void listenToStockUpdates() {
    socket.on('stockUpdate', (data) {
      // print("📦 Stock update received: $data");

      try {
        final updatedStock = StockUpdateModel.fromJson(data);

        final index = stockList.indexWhere(
              (s) => s.symbol == updatedStock.symbol,
        );
        if (index >= 0) {
          stockList[index] = updatedStock; // update existing
          // print("🔁 Updated ${updatedStock.symbol}");
          // print("Stock list now has updated: ${stockList.length} items");
        } else {
          stockList.add(updatedStock); // add new
          // print("➕ Added ${updatedStock.symbol}");
          // print("Stock list now has added: ${stockList.length} items");
        }
        update();
      } catch (e) {
        // print("❌ Failed to parse stock update: $e");
      }
    });
    update();
  }

  /////////// Socket Connect End///////////////////////////

  // add to watchlist
  List<StockUpdateModel> stockList = [];

  Future<void> addToWatchlist(String symbol) async {
    try {
      final response = await portfolioServiceInterface.postAddToWatchList(
        symbol,
      );

      if (response.statusCode == 201) {
        showCustomSnackBar('Added to the watchList');
        await getWatchList();
        update();
      }
    } catch (e) {
      print('Error adding to watchlist: $e');
    }
  }

  //Get Notification
  List<NotificationResponseModel> notificationList = [];

  Future<void> getNotification() async {
    isNotificationLoading = true;
    try {
      Response? response = await portfolioServiceInterface.getNotification();
      if (response.statusCode == 200 && response.body is List) {
        print('Success: getNotification');
        notificationList =
            (response.body as List)
                .map((e) => NotificationResponseModel.fromJson(e))
                .toList();
      } else {
        ApiChecker.checkApi(response);
      }
    } catch (e) {
      print('Error in getNotification : $e');
    } finally {
      isNotificationLoading = false;
      update();
    }
  }

  //Post dd Stock to Portfolio
  Future<void> postAddStockPortfolio(List<Map<String, dynamic>> stocks,
      String id,) async {
    isAddPortfolioLoading = true;

    try {
      Response? response = await portfolioServiceInterface
          .postAddStockPortfolio(stocks, id);
      if (response.statusCode == 200) {
        print('Success: postAddStockPortfolio');
        showCustomSnackBar('Successfully Add to Portfolio');
        loadSinglePortfolioStocks(id);
      } else {
        ApiChecker.checkApi(response);
      }
    } catch (e) {
      print('Error in AddStockPortfolio : $e');
    } finally {
      isAddPortfolioLoading = false;
      update();
    }
  }

  Future<void> postDeleteStockPortfolio(String symbol, String portfolioId) async {
    isDeletePortfolioLoading = true;
    update(); // Notify listeners immediately

    try {
      Response? response = await portfolioServiceInterface.postDeleteStockPortfolio(symbol, portfolioId);
      if (response.statusCode == 200) {
        print('Successfully deleted $symbol from portfolio');
        // Force a refresh of the portfolio data
        await getAllOverallBalance(portfolioId);
      } else {
        ApiChecker.checkApi(response);
        throw Exception("Failed to delete: ${response.statusCode}");
      }
    } catch (e) {
      print('Error deleting stock: $e');
      rethrow; // Propagate error to caller
    } finally {
      isDeletePortfolioLoading = false;
      update();
    }
  }


  Future<void> postDeleteStockWatchList(String symbol) async {
    isDeleteWatchListLoading= true;
    update(); // Notify listeners immediately

    try {
      Response? response = await portfolioServiceInterface.postDeleteStockWatchList(symbol);
      if (response.statusCode == 200) {
        print('Successfully deleted $symbol from portfolio');
        // Force a refresh of the portfolio data
      } else {
        ApiChecker.checkApi(response);
        throw Exception("Failed to delete: ${response.statusCode}");
      }
    } catch (e) {
      print('Error deleting stock: $e');
      rethrow; // Propagate error to caller
    } finally {
      isDeleteWatchListLoading = false;
      update();
    }
  }

  Future<bool> isWatchListSelected() async {
    try {
      if (await portfolioServiceInterface.isWatchListSelected() == true) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error in isWatchListSelected: $e');
    }
    update();
    return false;
  }

  Future<void> setWatchListSelected() async {
    try {
      portfolioServiceInterface.setWatchList();

      watchlistSelected = true;
      name = 'Watchlist';
      update();
    } catch (e) {
      print(e.toString());
    }

    update();
  }

  String name = '';

  Future<void> chooseNameFromPortfolios(String id) async {
    for (int i = 0; i < portfolios.length; i++) {
      if (portfolios[i].id == id) {
        name = portfolios[i].name!;
      }
    }
    update();
  }


  //Single User
  Future<void> getSingleUser(String id) async {
    isSingleUserLoading = true;
    update();

    try {
      Response? response = await portfolioServiceInterface.getSingleUser(id);
      if (response.statusCode == 200) {
        print('Success: getSingleUser');
        getSingleUserResponseModel = GetSingleUserResponseModel.fromJson(
          response.body,
        );
      } else {
        ApiChecker.checkApi(response);
      }
    } catch (e) {
      print('Error in getSingleUser : $e');
    } finally {
      isSingleUserLoading = false;
      update();
    }
  }

  //Delete Portfolio
  Future<void> deletePortfolio(String id) async {
    isDeletePortfolioLoading = true;
    try {
      Response? response = await portfolioServiceInterface.deletePortfolio(id);
      if (response.statusCode == 201) {
        print('Success: deletePortfolio');
        showCustomSnackBar('Successfully Deleted Portfolio');
        deletePortfolioResponseModel = DeletePortfolioResponseModel.fromJson(
          response.body,
        );
      } else {
        ApiChecker.checkApi(response);
      }
    } catch (e) {
      print('Error in deletePortfolio: $e');
    } finally {
      isDeletePortfolioLoading = false;
      update();
    }
  }


  //update portfolio
  bool isUpdatePortfolioLoading = false;

  Future<void> patchUpdatePortfolio(String id, String portfolioName,
      double cash) async {
    isUpdatePortfolioLoading = true;
    try {
      Response? response = await portfolioServiceInterface.patchUpdatePortfolio(
          id, portfolioName, cash);
      if (response.statusCode == 201 || response.statusCode == 200) {
        updatePortfolioResponseModel =
            UpdatePortfolioResponseModel.fromJson(response.body);
        showCustomSnackBar('Successfully updated portfolio');
      } else {
        ApiChecker.checkApi(response);
      }
    } catch (e) {
      print('Error in patchUpdatePortfolio: $e');
    } finally {
      isUpdatePortfolioLoading = false;
      update();
    }
  }

  //Rename Portfolio
  bool isRenamePortfolioLoading = false;


  Future<void> patchRenamePortfolio(String id, String portfolioName) async {
    isRenamePortfolioLoading = true;
    update();

    try {
      final response = await portfolioServiceInterface.patchRenamePortfolio(id, portfolioName);

      if (response.statusCode == 200 || response.statusCode == 201) {
        updatePortfolioNameResponseModel =
            UpdatePortfolioNameResponseModel.fromJson(response.body);
        showCustomSnackBar('Portfolio renamed successfully');
        update();
      } else {
        ApiChecker.checkApi(response);
      }
    } catch (e) {
      print('Error in patchRenamePortfolio: $e');
    } finally {
      isRenamePortfolioLoading = false;
      update();
    }
  }



}

