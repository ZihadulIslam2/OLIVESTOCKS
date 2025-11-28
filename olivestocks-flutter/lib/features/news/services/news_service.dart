import 'package:get/get_connect/http/src/response/response.dart';
import 'package:olive_stocks_flutter/features/news/repositories/news_repository_interface.dart';

import 'news_service_interface.dart';

class NewsService implements NewsServiceInterface {
  final NewsRepositoryInterface newsRepositoryInterface;

  NewsService(this.newsRepositoryInterface);
  @override
  Future<Response> getASingleNews(String symbol) {
    return newsRepositoryInterface.getASingleNews(symbol);
  }

  @override
  Future<Response> getNewsList(String symbol) {
    return newsRepositoryInterface.getNewsList(symbol);
  }

  @override
  Future<Response> getMarketNews() async {
    return await newsRepositoryInterface.getMarketNews();

  }

  @override
  Future<Response> getPortfolioNews(String portfolioId) async {
    return await newsRepositoryInterface.getPortfolioNews(portfolioId);

  }

  @override
  Future<Response> getDeepResearchNews(String symbol) async {
  return  await newsRepositoryInterface.getDeepResearchNews(symbol);

  }
}