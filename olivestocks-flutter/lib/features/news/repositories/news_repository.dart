import 'package:get/get_connect/http/src/response/response.dart';
import 'package:olive_stocks_flutter/helpers/remote/data/api_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/contants/urls.dart';
import 'news_repository_interface.dart';

class NewsRepository implements NewsRepositoryInterface {

  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  NewsRepository(this.apiClient, this.sharedPreferences);

  @override
  Future<Response> getASingleNews(String symbol) {
    return apiClient.getData(Urls.getASingleNews + symbol);
  }

  @override
  Future<Response> getNewsList(String symbol) {
    return apiClient.getData(Urls.getAllNewsList+symbol);
  }

  @override
  Future<Response> getMarketNews() async{
    return await apiClient.getData(Urls.getMarketNews);

  }

  @override
  Future<Response> getPortfolioNews(String portfolioId) async{
    return await apiClient.postData(Urls.getPortfolioNews,
        {
          "protfolioId": portfolioId
        }

    );

  }

  @override
  Future<Response> getDeepResearchNews(String symbol) async {
  return await apiClient.getData(Urls.getDeepResearchNews);
  }

}
