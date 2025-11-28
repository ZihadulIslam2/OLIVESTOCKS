import 'dart:convert';

import 'package:get/get_connect/http/src/response/response.dart';
import 'package:olive_stocks_flutter/features/portfolio/domains/get_single_user_response_model.dart';
import 'package:olive_stocks_flutter/features/portfolio/repositories/portfolio_repository_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/contants/urls.dart';
import '../../../helpers/remote/data/api_client.dart';

class PortfolioRepository implements PortfolioRepositoryInterface {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  PortfolioRepository(this.apiClient, this.sharedPreferences);

  @override
  Future<Response> getPortfolio() async{
    return await apiClient.getData(Urls.getPortfolio);
  }

  @override
  Future<Response> getAllGainAndLoose() async {
   return await apiClient.getData(Urls.getAllGainerAndLooserUrl);
  }

  @override
  Future<Response> mostTradedStocks() async{
   return await apiClient.getData(Urls.getAllMostTradedStocks);
  }

  @override
  Future<Response> getAllAnalystTopStocks()async {
   return await apiClient.getData(Urls.getAllAnalystsTopStocks);
  }

  @override
  Future<Response> getAllDailyAnalystRatings()async {
    return await apiClient.getData(Urls.getAllDailyAnalystRatings);
  }

  @override
  Future<Response> getAllUpComingEvents(String portfolioId) async{
    return await apiClient.getData(Urls.getAllUpComingEvents+portfolioId);
  }

  @override
  Future<Response> getAllOverallBalance(String portfolioId) async{
   return await apiClient.postData(Urls.getAllOverallBalance,
       {
       "id": portfolioId
       }
   );
  }

  @override
  Future<Response> getAllPerformance(String id) async{
    return await apiClient.getData(Urls.getAllPerformances + id);
  }

  @override
  Future<Response> getAllOliveStocksPortfolio() async {
    return await apiClient.getData(Urls.getAllOliveStocksPortfolio);
  }

  @override
  Future<Response> getAllOliveStocksUnderRadar() async {
    return await apiClient.getData(Urls.getAllOliveStocksUnderRadar);

  }

  @override
  Future<Response> getStockOverview(String symbol) async{
    return await apiClient.getData(Urls.getStockOverview+symbol);
  }

  @override
  Future<Response> getPriceChart(String symbol) async{
   return await apiClient.getData(Urls.getPriceChart + symbol );
  }

  @override
  Future<Response> getTargetChart(String symbol) async {
    return await apiClient.getData(Urls.getTargetChart+symbol);
  }

  @override
  Future<Response> getRevenueChart(String symbol) async {
    return await apiClient.getData(Urls.getEPSChart+symbol);
  }

  @override
  Future<Response> getEPSChart(String symbol) async{
    return await apiClient.getData(Urls.getEPSChart+symbol);

  }

  @override
  Future<Response> getCashFlowChart(String symbol) async{
    return await apiClient.getData(Urls.getCashFlowChart+symbol);

  }

  @override
  Future<Response> getEarningsChart(String symbol)async {
    return await apiClient.getData(Urls.getEarningsChart+symbol);
  }


  @override
  Future<Response> searchStockData(String symbol) async {
    return await apiClient.getData(Urls.searchStockData + symbol);
  }

  @override
  Future<Response> getCreateNewPortfolio(String name) async{
    return await apiClient.postData(Urls.createNewPortfolio,
        {
          "name": name
        }
    );
  }

  @override
  Future<Response> getWatchList() async {
   return await apiClient.getData(Urls.getWatchlist);
  }

  @override
  Future<Response> getAllTrendingStocks()async {
    return await apiClient.getData(Urls.getAllTrendingStocks);

  }

  @override
  Future<Response> postAssetAllocation(String id)async {
    print('Allocation Portfolio================================$id');
   return await apiClient.postData(Urls.postAssetAllocation+id,
       {
         "portfolioId" : id
       }
   );
  }

  @override
  Future<Response> getAllOliveStocksPortfolioNew() async {
    return await apiClient.getData(Urls.getAllOliveStocksPortfolioNew);

  }

  @override
  Future<Response> getAllStocksWarning(String id) async {
    return await apiClient.getData(Urls.getAllStocksWarning + id);
  }

  @override
  Future<Response> postSupport(String firstName, String lastName, String email, String message, String subject, String phoneNumber) async {
  return await apiClient.postData(Urls.postSupport,
        {
          "firstName": firstName, "lastName": lastName, "email": email, "message": message, "subject": subject, "phoneNumber": phoneNumber
        }
    );
  }

  @override
  Future<String?> getPresentPortfolioNew() async{
    return sharedPreferences.getString('presentPortfolio');
  }

  @override
  Future<void> setPresentPortfolio(String id) {
     sharedPreferences.setBool('isWatchedListSelected', false);
    return sharedPreferences.setString('presentPortfolio', id);
  }

  @override
  Future<Response> postAddToWatchList(String symbol) async {
    return await apiClient.postData(Urls.postAddToWatchList,
        {
          "symbol": symbol
        }
    );
  }

  @override
  Future<Response> getNotification() async{
    return await apiClient.getData(Urls.getNotification);
  }

  @override
  Future<Response> postAddStockPortfolio(List<Map< String, dynamic>> stocks, String id) async{
    return await apiClient.postData(Urls.postAddStockPortfolio,
        {
          "portfolioId": id,

          "symbols": stocks
        }
    );
  }

  @override
  Future<Response> postDeleteStockPortfolio(String symbol, String portfolioId) async {
   return await apiClient.postData(Urls.postDeleteStockPortfolio,
       {
         "symbol": symbol, "portfolioId": portfolioId
       }
   );
  }

  @override
  Future<bool> isWatchListSelected() async {
    return sharedPreferences.getBool('isWatchedListSelected') ?? false;
  }


  @override
  Future<void> setWatchList() async{
     sharedPreferences.setBool('isWatchedListSelected', true);
  }

  @override
  Future<Response> loadSinglePortfolioStocks(String portfolioId) async{
    return await apiClient.getData(Urls.loadSinglePortfolioStocks+portfolioId);
  }

  @override
  Future<Response> postUpdateProfile(String name, String email, String phoneNumber, String profilePicture, String userId) async {
    return await apiClient.postData(Urls.postUpdateUser,
        {
          "name": name, "email": email, "phoneNumber": phoneNumber, "profilePicture": profilePicture, "userId": userId
        }
    );

  }

  @override
  Future<Response> getSingleUser(String id) async {
   return await apiClient.getData(Urls.getSingleUser+id);
  }

  @override
  Future<Response> deletePortfolio(String id) async {
    return await apiClient.deleteData(Urls.deletePortfolio+id);
  }

  @override
  Future<Response> postUpdatePortfolio(String id) async {
   return await apiClient.postData(Urls.postUpdateUser+id,
       {
         "id": id
       }
   );
  }

  @override
  Future<Response> patchUpdatePortfolio(String id, String portfolioName, double cash) async{
    return await apiClient.patchData(Urls.patchUpdatePortfolio+id,
        {
          "name": portfolioName,
          "cash": cash
        }
    );
  }

  @override
  Future<Response> patchRenamePortfolio(String id, String portfolioName) async {
    return await apiClient.patchData(Urls.patchRenamePortfolio+id,
        {
          "name": portfolioName
        }
    );

  }

  @override
  Future<Response> getPortfolioById(String symbol) async{
    return await apiClient.getData(Urls.getPortfolioById+symbol);

  }

  @override
  Future<Response> postDeleteStockWatchList(String symbol) async {
    return await apiClient.postData(Urls. postDeleteStockWatchlist,
        {
          "symbol": symbol
        }
    );

  }









}