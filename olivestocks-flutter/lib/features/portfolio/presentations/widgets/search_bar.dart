import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:olive_stocks_flutter/features/markets/presentations/screens/single_stock_market.dart';
import 'package:olive_stocks_flutter/features/portfolio/controller/portfolio_controller.dart';

import '../../domains/search_stock_response_model.dart';

class MyDataSearchDelegate extends SearchDelegate<Results> {
  final List<Results> items;

  MyDataSearchDelegate({required this.items});

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

        return Container(
          color: Colors.white,
          child: ListView.builder(
            itemCount: results.length,
            itemBuilder: (context, index) {
              final item = results[index];
              return GestureDetector(
                onTap: () {
                  Get.to(
                    SingleStockMarket(symbol: item.symbol!),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 5),
                  child: Container(
                    child: Row(
                      children: [
                        Container(
                          height: 30,
                          width: 30,
                          child: Center(
                            child: Image.network(item.logo!),
                          ),
                        ),
                        SizedBox(width: size.width * .05,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item.symbol ?? '', style: const TextStyle(color: Colors.black)),
                            Text(item.description ?? '', style: const TextStyle(color: Colors.black54)),
                          ],
                        )
                      ],
                    ),
                  ),
                ),

              );
            },
          ),
        );
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

        return Container(
          color: Colors.white,
          child: ListView.builder(
            itemCount: results.length,
            itemBuilder: (context, index) {
              final item = results[index];
              return GestureDetector(
                onTap: () {
                  Get.to(
                    SingleStockMarket(symbol: item.symbol!),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 5),
                  child: Container(
                    child: Row(
                      children: [
                        Container(
                          height: 30,
                          width: 30,
                          child: Center(
                            child: Image.network(item.logo!),
                          ),
                        ),
                        SizedBox(width: size.width * .05,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item.symbol ?? '', style: const TextStyle(color: Colors.black)),
                            Text(item.description ?? '', style: const TextStyle(color: Colors.black54)),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
