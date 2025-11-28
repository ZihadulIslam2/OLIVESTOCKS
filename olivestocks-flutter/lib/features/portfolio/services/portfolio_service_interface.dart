import 'package:get/get_connect/http/src/response/response.dart';
import 'package:http/http.dart' as http;

abstract class PortfolioServiceInterface {

  Future<Response> getPortfolio();
  Future<Response> getAllGainAndLoose();
  Future<Response> mostTradedStocks();
  Future<Response> getAllAnalystTopStocks();
  Future<Response> getAllDailyAnalystRatings();
  Future<Response> getAllUpComingEvents(String portfolioId);
  Future<Response> getAllOverallBalance(String portfolioId);
  Future<Response> getAllPerformance(String id);
  Future<Response> getAllOliveStocksUnderRadar();
  Future<Response> getAllTrendingStocks();
  Future<Response> postAssetAllocation(String id);
  Future<Response> getAllStocksWarning(String id);
  Future<Response> getPortfolioById(String symbol);


  Future<Response> getPriceChart(String symbol);
  Future<Response> getTargetChart(String symbol);
  Future<Response> getRevenueChart(String symbol);
  Future<Response> getEPSChart(String symbol);
  Future<Response> getCashFlowChart(String symbol);
  Future<Response> getEarningsChart(String symbol);
  Future<Response> searchStockData(String symbol);



  Future<Response> getAllOliveStocksPortfolio();
  Future<Response> getAllOliveStocksPortfolioNew();

  Future<Response> postSupport(String firstName, String lastName, String email, String message, String subject, String phoneNumber);

  Future<void> setPresentPortfolio(String id);

  Future<String?> getPresentPortfolioNew();

  Future<Response> getStockOverview(String symbol);


  Future<Response> getCreateNewPortfolio(String name);

  Future<Response> getWatchList();

  Future<Response> postAddToWatchList( String symbol);


  Future<Response> getNotification( );

  Future<Response> postAddStockPortfolio(List<Map< String, dynamic>> stocks, String id);


  Future<Response> postDeleteStockPortfolio(String symbol, String portfolioId);
  Future<Response> postDeleteStockWatchList(String symbol);

  // to Set the watchlist
  Future<void> setWatchList();

  // to get the watchlist
  Future<bool> isWatchListSelected();

  Future<Response> loadSinglePortfolioStocks(String portfolioId);




  Future<Response> getSingleUser(String id);
  Future<Response> deletePortfolio(String id);

  Future<Response> postUpdatePortfolio(String id);

  Future<Response> patchUpdatePortfolio(String id, String portfolioName, double cash);

  Future<Response> patchRenamePortfolio(String id, String portfolioName);




}