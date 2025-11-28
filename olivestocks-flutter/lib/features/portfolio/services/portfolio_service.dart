import 'package:get/get_connect/http/src/response/response.dart';
import 'package:olive_stocks_flutter/features/portfolio/services/portfolio_service_interface.dart';

import '../repositories/portfolio_repository_interface.dart';

class PortfolioService implements PortfolioServiceInterface{
  final PortfolioRepositoryInterface portfolioRepositoryInterface;

  PortfolioService(this.portfolioRepositoryInterface);

  @override
  Future<Response> getPortfolio() async{
    return portfolioRepositoryInterface.getPortfolio();
  }

  @override
  Future<Response> getAllGainAndLoose() async{
    return await portfolioRepositoryInterface.getAllGainAndLoose();
  }

  @override
  Future<Response> mostTradedStocks() async{
    return await portfolioRepositoryInterface.mostTradedStocks();
  }

  @override
  Future<Response> getAllAnalystTopStocks() async{
    return await portfolioRepositoryInterface.getAllAnalystTopStocks();
  }

  @override
  Future<Response> getAllDailyAnalystRatings() async{
    return await portfolioRepositoryInterface.getAllDailyAnalystRatings();
  }

  @override
  Future<Response> getAllUpComingEvents(String portfolioId) async {
    return await portfolioRepositoryInterface.getAllUpComingEvents(portfolioId);
  }

  @override
  Future<Response> getAllOverallBalance(String portfolioId) async{
    return await portfolioRepositoryInterface.getAllOverallBalance(portfolioId);
  }

  @override
  Future<Response> getAllPerformance(String id) async{
    return await portfolioRepositoryInterface.getAllPerformance(id);
  }

  @override
  Future<Response> getAllOliveStocksPortfolio() async {
    return await portfolioRepositoryInterface.getAllOliveStocksPortfolio();
  }

  @override
  Future<Response> getAllOliveStocksUnderRadar() async {
    return await portfolioRepositoryInterface.getAllOliveStocksUnderRadar();
  }

  @override
  Future<Response> getStockOverview(String symbol) async{
    return await portfolioRepositoryInterface.getStockOverview(symbol);
  }

  @override
  Future<Response> getPriceChart(String symbol ) async{
    return await portfolioRepositoryInterface.getPriceChart(symbol);
  }

  @override
  Future<Response> getTargetChart(String symbol) async{
    return await portfolioRepositoryInterface.getTargetChart(symbol);

  }

  @override
  Future<Response> getRevenueChart(String symbol)async {
   return await portfolioRepositoryInterface.getRevenueChart(symbol);
  }

  @override
  Future<Response> getEPSChart(String symbol)async {
    return await portfolioRepositoryInterface.getEPSChart(symbol);
  }

  @override
  Future<Response> getCashFlowChart(String symbol) async{
    return await portfolioRepositoryInterface.getCashFlowChart(symbol);
  }

  @override
  Future<Response> getEarningsChart(String symbol) async{
    return await portfolioRepositoryInterface.getEarningsChart(symbol);
  }

  @override
  Future<Response> searchStockData(String symbol) async{
    return await portfolioRepositoryInterface.searchStockData(symbol);
  }

  @override
  Future<Response> getCreateNewPortfolio(String name) async{
    return await portfolioRepositoryInterface.getCreateNewPortfolio(name);
  }

  @override
  Future<Response> getWatchList() async {
   return await portfolioRepositoryInterface.getWatchList();
  }

  @override
  Future<Response> getAllTrendingStocks() async {
    return await portfolioRepositoryInterface.getAllTrendingStocks();

  }

  @override
  Future<Response> postAssetAllocation(String id) async{
    return await portfolioRepositoryInterface.postAssetAllocation(id);

  }

  @override
  Future<Response> getAllOliveStocksPortfolioNew() async {
    return await portfolioRepositoryInterface.getAllOliveStocksPortfolioNew();
  }

  @override
  Future<Response> getAllStocksWarning(String id) async{
   return await portfolioRepositoryInterface.getAllStocksWarning(id);
  }

  @override
  Future<Response> postSupport(String firstName, String lastName, String email, String message, String subject, String phoneNumber) async{
    return await portfolioRepositoryInterface.postSupport(firstName, lastName, email, message, subject, phoneNumber);
  }

  @override
  Future<String?> getPresentPortfolioNew() async{
    return await portfolioRepositoryInterface.getPresentPortfolioNew();
  }

  @override
  Future<void> setPresentPortfolio(String id) async{
    return await portfolioRepositoryInterface.setPresentPortfolio(id);
  }

  @override
  Future<Response> postAddToWatchList(symbol) async {
    return await portfolioRepositoryInterface.postAddToWatchList(symbol);

  }

  @override
  Future<Response> getNotification() async {
    return await portfolioRepositoryInterface.getNotification();

  }



  @override
  Future<Response> postDeleteStockPortfolio(String symbol, String portfolioId) async {
    return await portfolioRepositoryInterface.postDeleteStockPortfolio(symbol, portfolioId);
  }


  @override
  Future<bool> isWatchListSelected() async{
    return await portfolioRepositoryInterface.isWatchListSelected();
  }



  @override
  Future<void> setWatchList() async{
    return await portfolioRepositoryInterface.setWatchList();
  }

  @override
  Future<Response> loadSinglePortfolioStocks(String portfolioId) async{

    return await portfolioRepositoryInterface.loadSinglePortfolioStocks(portfolioId);

  }

  @override
  Future<Response> postAddStockPortfolio(List<Map<String, dynamic>> stocks, String id) async{
    return await portfolioRepositoryInterface.postAddStockPortfolio(stocks, id);
  }


  @override
  Future<Response> getSingleUser(String id) async{
    return await portfolioRepositoryInterface.getSingleUser(id);

  }

  @override
  Future<Response> deletePortfolio(String id) async {
    return await portfolioRepositoryInterface.deletePortfolio(id);

  }

  @override
  Future<Response> postUpdatePortfolio(String id) async{
    return await portfolioRepositoryInterface.postUpdatePortfolio(id);

  }

  @override
  Future<Response> postUpdateProfile({required String name, required String email, required String phoneNumber, required String profilePicture, required String userId}) async {
   return await portfolioRepositoryInterface.postUpdateProfile(name, email, phoneNumber, profilePicture, userId);
  }

  @override
  Future<Response> patchUpdatePortfolio(String id, String portfolioName, double cash)async{
   return await portfolioRepositoryInterface.patchUpdatePortfolio(id, portfolioName, cash);
  }

  @override
  Future<Response> patchRenamePortfolio(String id, String portfolioName) async {
    return await portfolioRepositoryInterface.patchRenamePortfolio(id, portfolioName);

  }

  @override
  Future<Response> getPortfolioById(String symbol) async{
    return await portfolioRepositoryInterface.getPortfolioById(symbol);

  }

  @override
  Future<Response> postDeleteStockWatchList(String symbol) async {
   return await portfolioRepositoryInterface.postDeleteStockWatchList(symbol);
  }





}