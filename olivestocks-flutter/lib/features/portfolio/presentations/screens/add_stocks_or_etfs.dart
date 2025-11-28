import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:olive_stocks_flutter/features/portfolio/presentations/screens/when_click_search.dart';

import '../../controller/portfolio_controller.dart';
import '../widgets/add_watch_liststock_search.dart';

class AddStocksScreen extends StatefulWidget {
  const AddStocksScreen({super.key});

  @override
  State<AddStocksScreen> createState() => _AddStocksScreenState();
}

class _AddStocksScreenState extends State<AddStocksScreen> {
  final List<Map<String, String>> popularStocks = [
    {"symbol": "AAPL", "name": "Apple Inc"},
    {"symbol": "MSFT", "name": "Microsoft"},
    {"symbol": "SPY", "name": "SPDR S&P 500 ETF Trust"},
  ];

  final List<Map<String, String>> topStocks = List.generate(7, (i) {
    return {"symbol": "NVDA", "name": "Nvidia"};
  });

  final Set<String> selectedKeys = {};
  String _currentLanguage = 'Global';

  final List<Map<String, String>> languages = [
    // {"name": "Global", "flag": "assets/flags/global.png"},
    {"name": "USA", "flag": "assets/flags/usa.png"},
    {"name": "Canada", "flag": "assets/flags/canada.png"},
    {"name": "UK", "flag": "assets/flags/uk.png"},
    {"name": "Australia", "flag": "assets/flags/australia.png"},
    {"name": "Germany", "flag": "assets/flags/germany.png"},
    {"name": "India", "flag": "assets/flags/india.png"},
    {"name": "Japan", "flag": "assets/flags/japan.png"},
    {"name": "Singapore", "flag": "assets/flags/singapore.png"},
  ];

  String _getKey(String category, int index) => "$category-$index";

  void toggleSelection(String key, String name) {
    if (selectedKeys.contains(key)) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Remove $name?"),
            content: Text(
              "Are you sure you want to remove $name?",
              style: const TextStyle(fontSize: 12),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Cancel", style: TextStyle(color: Colors.red)),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    selectedKeys.remove(key);
                  });
                  Navigator.of(context).pop();
                },
                child: const Text("OK", style: TextStyle(color: Colors.green)),
              ),
            ],
          );
        },
      );
    } else {
      setState(() {
        selectedKeys.add(key);
      });
    }
  }

  void changeLanguage(String lang) {
    setState(() {
      _currentLanguage = lang;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Stocks with Search"),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                  context: context,
                  delegate: StockDataSearchDelegate(Get.find<PortfolioController>().searchStockResponseModel.results!));

            },
          ),
          PopupMenuButton<String>(
            tooltip: "Select Language",
            onSelected: changeLanguage,
            itemBuilder: (BuildContext context) {
              return languages.map((lang) {
                return PopupMenuItem<String>(
                  value: lang["name"]!,
                  child: Row(
                    children: [
                      Image.asset(
                        lang["flag"]!,
                        width: 24,
                        height: 24,
                      ),
                      const SizedBox(width: 8),
                      Text(lang["name"]!),
                      const Spacer(),
                      if (_currentLanguage == lang["name"])
                        const Icon(Icons.check, color: Colors.blue, size: 18),
                    ],
                  ),
                );
              }).toList();
            },
            child: Row(
              children: [
                const Icon(Icons.language),
                const Icon(Icons.arrow_drop_down),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Popular Searches", style: theme.textTheme.titleMedium),
            const SizedBox(height: 8),
            ...popularStocks.asMap().entries.map((entry) {
              final index = entry.key;
              final stock = entry.value;
              final key = _getKey("popular", index);

              return ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const CircleAvatar(
                  backgroundImage: AssetImage('assets/logos/aapl.png'),
                ),
                title: Text(stock["symbol"]!),
                subtitle: Text(stock["name"]!),
                trailing: selectedKeys.contains(key)
                    ? const Icon(Icons.check, color: Colors.green)
                    : null,
                onTap: () => toggleSelection(key, stock["name"]!),
              );
            }),
            const SizedBox(height: 16),
            Text(
              "Explore Analysts Top Stocks",
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(2),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.green,
                  child: Image.asset('assets/logos/olive_tree.png'),
                ),
                title: const Text(
                  "Analyst’s Top Stocks",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: const Text(
                  "Lorem Ipsum is simply dummy text of the printing and typesetting",
                  style: TextStyle(fontSize: 10),
                ),
                trailing: Container(
                  height: size.height * .03,
                  width: size.width * .2,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.blue),
                    ),
                    onPressed: () {},
                    child: const Text(
                      "Try Now",
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 9,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ...topStocks.asMap().entries.map((entry) {
              final index = entry.key;
              final stock = entry.value;
              final key = _getKey("top", index);

              return ListTile(
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(
                  backgroundColor: Colors.green,
                  child: Image.asset('assets/logos/nvda.png'),
                ),
                title: Text(stock["symbol"]!),
                subtitle: Text(stock["name"]!),
                trailing: selectedKeys.contains(key)
                    ? const Icon(Icons.check, color: Colors.green)
                    : null,
                onTap: () => toggleSelection(key, stock["name"]!),
              );
            }),
          ],
        ),
      ),
    );
  }
}
