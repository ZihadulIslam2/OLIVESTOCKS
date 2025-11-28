import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:olive_stocks_flutter/features/portfolio/controller/portfolio_controller.dart';
import '../../domains/search_stock_response_model.dart';

class StockDataSearchDelegate extends SearchDelegate<Results> {
  final List<Results> items;

  // Track already added stocks (both to watchlist or portfolio)
  final Set<String> addedSymbols = {};

  StockDataSearchDelegate(this.items);

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData.light().copyWith(
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: const TextStyle(color: Colors.black54),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black, width: 1.5),
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      textTheme: const TextTheme(
        titleLarge: TextStyle(color: Colors.black, fontSize: 18),
      ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          icon: const Icon(Icons.clear, color: Colors.black),
          onPressed: () => query = '',
        ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return const BackButton(color: Colors.black);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (query.isEmpty) {
      return Container(color: Colors.white);
    }

    final controller = Get.find<PortfolioController>();

    Future.microtask(() => controller.searchStockData(query));

    return GetBuilder<PortfolioController>(
      builder: (controller) {
        if (controller.isLoadingSearch) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.black),
          );
        }

        final results = controller.searchStockResponseModel.results;

        if (results == null || results.isEmpty) {
          return Center(
            child: Text(
              "No results found for \"$query\"",
              style: const TextStyle(color: Colors.black),
            ),
          );
        }

        return _buildResultsList(context, results, size);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final controller = Get.find<PortfolioController>();
    Size size = MediaQuery.of(context).size;

    return GetBuilder<PortfolioController>(
      builder: (controller) {
        if (controller.isLoading) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.black),
          );
        }

        final results = controller.searchStockResponseModel.results;

        if (results == null || results.isEmpty) {
          return Center(
            child: Text(
              "No results found for \"$query\"",
              style: const TextStyle(color: Colors.black),
            ),
          );
        }

        return _buildResultsList(context, results, size);
      },
    );
  }

  Widget _buildResultsList(BuildContext context, List<Results> results, Size size) {
    final portfolioController = Get.find<PortfolioController>();
    List<Map<String, dynamic>> stocks = [];

    return Container(
      color: Colors.white,
      child: ListView.builder(
        itemCount: results.length,
        itemBuilder: (context, index) {
          final item = results[index];
          final alreadyAdded = addedSymbols.contains(item.symbol);

          return ListTile(
            leading: Container(
              height: 30,
              width: 30,
              child: item.logo != null
                  ? Image.network(item.logo!, fit: BoxFit.cover)
                  : const Icon(Icons.business),
            ),
            title: Text(item.symbol ?? '', style: const TextStyle(color: Colors.black)),
            subtitle: Text(item.description ?? '', style: const TextStyle(color: Colors.black54)),
            trailing: GestureDetector(
              onTap: () async {
                if (alreadyAdded) {
                  _showStockAddedSnackbar(item.logo, '${item.symbol} already added');
                  return;
                }

                if (portfolioController.watchlistSelected) {
                  await portfolioController.addToWatchlist(item.symbol!);
                  await portfolioController.getWatchList();
                  _showStockAddedSnackbar(item.logo, '${item.symbol} added to watchlist');
                } else {
                  stocks.add({
                    "symbol": item.symbol,
                    "price": item.price,
                    "event": 'buy',
                    "quantity": 1,
                  });
                  String? id = await portfolioController.getPresentPortfolio();
                  await portfolioController.postAddStockPortfolio(stocks, id!);
                  await portfolioController.getAllOverallBalance(id);
                  _showStockAddedSnackbar(item.logo, '${item.symbol} added to portfolio');
                }

                // Mark this stock as added
                addedSymbols.add(item.symbol!);
                // Rebuild to update the icon
                showSuggestions(context);
              },
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: alreadyAdded ? Colors.green.shade100 : Colors.green.shade50,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.green,
                    width: 1.5,
                  ),
                ),
                child: Icon(
                  alreadyAdded ? Icons.check : Icons.add,
                  color: Colors.black,
                  size: 20,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showStockAddedSnackbar(String? logoUrl, String message) {
    Get.snackbar(
      '',
      '',
      titleText: Row(
        children: [
          if (logoUrl != null)
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Image.network(logoUrl, height: 24, width: 24),
            ),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      borderRadius: 12,
      duration: const Duration(seconds: 2),
    );
  }
}
