import 'package:get/get_connect/http/src/response/response.dart';

abstract class NewsServiceInterface {

 Future<Response> getNewsList(String symbol);
 Future<Response> getASingleNews(String symbol);
 Future<Response> getMarketNews();
 Future<Response> getPortfolioNews(String portfolioId);
 Future<Response> getDeepResearchNews(String symbol);

}