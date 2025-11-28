import 'dart:convert';

import 'package:get/get.dart';
import 'package:olive_stocks_flutter/features/news/domain/get_a_single_news_response_model.dart' hide Data;
import 'package:olive_stocks_flutter/features/news/domain/get_all_news_response_model.dart';
import 'package:olive_stocks_flutter/features/news/services/news_service.dart';
import 'package:olive_stocks_flutter/features/news/services/news_service_interface.dart';

import '../domain/get_deep_research_response_model.dart' hide NewsData;
import '../domain/get_market_news_response_model.dart';
import '../domain/get_portfolio_news_response_model.dart';

class NewsController extends GetxController implements GetxService {

  final NewsServiceInterface newsServiceInterface;

  NewsController(this.newsServiceInterface);

  late GetAllNewsResponseModel getAllNewsResponseModel;

  GetASingleNewsResponseModel getASingleNewsResponseModel = GetASingleNewsResponseModel(data: null);
  late MarketNewsResponseModel marketNewsResponseModel;
   GetPortfolioNewsResponseModel getPortfolioNewsResponseModel = GetPortfolioNewsResponseModel();
  DeepResearchNewsResponseModel deepResearchNewsResponseModel = DeepResearchNewsResponseModel(data: []);

  bool isLoading = false;
  bool isLoadingNew = false;
  bool isMarketNewsLoading = false;
  bool isPortfolioNewsLoading = false;
  bool isDeepResearchNewsLoading = false;
  bool isSingleNewsLoading = false;




  List<Data> newsList = [];
  //All News
  Future<void> getAllNews(String symbol) async {
    try {
      isLoadingNew = true;

      var response = await newsServiceInterface.getNewsList(symbol);

      if (response.statusCode == 200) {
        getAllNewsResponseModel = GetAllNewsResponseModel.fromJson(response.body);
        newsList = getAllNewsResponseModel.data ?? []; // 👈 Add this
      } else {
        getAllNewsResponseModel = GetAllNewsResponseModel(
          status: false,
          message: response.body['message'],
          data: [],
        );
        newsList = []; // 👈 Handle empty fallback
      }
    } catch (e) {
      print(e);
    }
    isLoadingNew = false;
    update();
  }


  //Single News
  Future<void> getSingleNews(String symbol) async {
    try {
      isSingleNewsLoading = true;
      update(); // Notify listeners about loading state

      print("Getting Single News");
      var response = await newsServiceInterface.getASingleNews(symbol);

      if (response.statusCode == 200) {
        print('DeepResearch News is fetched successfully.');
        print("HTTP Status: ${response.statusCode}");
        print("Raw Response: ${response.body}");

        getASingleNewsResponseModel = GetASingleNewsResponseModel.fromJson(response.body);

        print('Call from single News after model calls.');
      } else {
        print('Failed to load news: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching news: $e');
    } finally {
      isSingleNewsLoading = false;
      update(); // Notify listeners that loading is complete
    }
  }

  //Market News
  Future<void> getMarketNews() async {
    try {
      isMarketNewsLoading = true;
      print("Getting Market News");

      var response = await newsServiceInterface.getMarketNews();

      if (response.statusCode == 200) {

        print('Market News is fetched successfully.');

        print("HTTP Status: ${response.statusCode}");

        print("Raw Response: ${response.body}");

        marketNewsResponseModel = MarketNewsResponseModel.fromJson(response.body);

        print('Call from Market News after model calls.');

      } else {

      }
    } catch (e) {
      if (e is Exception) {
        // print('⚠️ Exception in : $e dddddddddddd');
      } else {
        print(e);
      }
    }
    isMarketNewsLoading = false;
    update();
  }

  bool isAllNewsLoading = false;

  Future<void> getAllNewsWithMarket(String symbol) async {
    isAllNewsLoading = true;
    await getAllNews(symbol).then((value) {
      getMarketNews().then((onValue) {
        if (marketNewsResponseModel.data!.isNotEmpty) {
          for (int i = 0; i < marketNewsResponseModel.data!.length; i++) {
            getAllNewsResponseModel.data!.add(
                Data(
                  id: marketNewsResponseModel.data![0].id.toString(),
                  newsTitle: marketNewsResponseModel.data![0].headline,
                  newsDescription: marketNewsResponseModel.data![0].summary,
                  newsImage: marketNewsResponseModel.data![0].image,
                  views: 0,
                  source: marketNewsResponseModel.data![0].source,
                  createdAt: '',
                  updatedAt: ' marketNewsResponseModel.data![0].updatedAt',
                  v: 0,
                )
            );
          }
        }
        print('${getAllNewsResponseModel.data!.length} ffdefdsafdfffffffffffffffffffff');
        print('${marketNewsResponseModel.data!.length} fuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu');

        isAllNewsLoading = false;
      });
    });

    update();
  }

  //getPortfolioNews
  // portfolio_controller.dart

  List<Data> portfolioNewsList = [];

  Future<void> postPortfolioNewsWithConversion(String portfolioId) async {
    try {
      isPortfolioNewsLoading = true;
      update();

      var response = await newsServiceInterface.getPortfolioNews(portfolioId);

      if (response.statusCode == 200) {
        List<dynamic> rawData = response.body;

        portfolioNewsList = rawData.map((item) {
          final parsed = GetPortfolioNewsResponseModel.fromJson(item);
          return Data(
            id: parsed.id.toString(),
            newsTitle: parsed.headline ?? '',
            newsDescription: parsed.summary ?? '',
            newsImage: parsed.image ?? '',
            views: 0,
            source: parsed.source ?? '',
            createdAt: parsed.datetime.toString(),
            updatedAt: '',
            v: 0,
          );
        }).toList();

        print('ddksfajlklklajl ajkl -----=============434=43=43=3=4=34 3=');
      } else {
        portfolioNewsList = [];
      }
    } catch (e) {
      portfolioNewsList = [];
    }

    isPortfolioNewsLoading = false;
    update();
  }




  //DeepResearch
  Future<void> getDeepResearch(String symbol) async {
    try {
      isDeepResearchNewsLoading = true;
      update(); // Notify listeners about loading state

      print("Getting DeepResearch News");
      var response = await newsServiceInterface.getDeepResearchNews(symbol);

      if (response.statusCode == 200) {
        print('DeepResearch News is fetched successfully.');
        print("HTTP Status: ${response.statusCode}");
        print("Raw Response: ${response.body}");

        deepResearchNewsResponseModel = DeepResearchNewsResponseModel.fromJson(response.body);

        print('Call from Deep Research News after model calls.');
      } else {
        print('Failed to load news: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching news: $e');
    } finally {
      isDeepResearchNewsLoading = false;
      update(); // Notify listeners that loading is complete
    }
  }

  /// ADD THIS FUNCTION FOR BOOKMARK TOGGLE
  ///
   bool isPinned = false;

  void toggleBookmark(String newsId) {
    if (getAllNewsResponseModel.data == null) return;

    final index = getAllNewsResponseModel.data!.indexWhere((n) => n.id == newsId);
    if (index == -1) return;

    final currentPinState = getAllNewsResponseModel.data![index].isPinned ?? false;
    getAllNewsResponseModel.data![index].isPinned = !currentPinState;

    // Sort list: pinned first
    getAllNewsResponseModel.data!.sort((a, b) {
      final aPinned = a.isPinned ?? false;
      final bPinned = b.isPinned ?? false;

      if (aPinned && !bPinned) return -1;
      if (!aPinned && bPinned) return 1;
      return 0;
    });

    update();
  }
}
