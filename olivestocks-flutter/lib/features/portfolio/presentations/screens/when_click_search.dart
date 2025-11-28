import 'package:flutter/material.dart';

class SearchStocksScreen extends StatefulWidget {
  const SearchStocksScreen({super.key});

  @override
  State<SearchStocksScreen> createState() => _SearchStocksScreenState();
}

class _SearchStocksScreenState extends State<SearchStocksScreen> {
  final List<Map<String, String>> popularStocks = [
    {"symbol": "AAPL", "name": "Apple Inc"},
    {"symbol": "AAPL", "name": "Apple Inc"},
    {"symbol": "AAPL", "name": "Apple Inc"},
  ];

  final List<Map<String, String>> topStocks = List.generate(7, (i) {
    return {"symbol": "NVDA", "name": "Nvidia"};
  });

  final Set<String> selectedKeys = {};
  String _currentLanguage = 'English';

  final List<String> languages = ['English', 'বাংলা', 'العربية'];

  String _getKey(String category, int index) => "$category-$index";

  void toggleSelection(String key) {
    setState(() {
      if (selectedKeys.contains(key)) {
        selectedKeys.remove(key);
      } else {
        selectedKeys.add(key);
      }
    });
  }

  void changeLanguage(String lang) {
    setState(() {
      _currentLanguage = lang;
      // Implement real i18n logic here if needed
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Stocks or ETFs"),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.language),
            tooltip: "Select Language",
            onSelected: changeLanguage,
            itemBuilder: (BuildContext context) {
              return languages.map((String lang) {
                return PopupMenuItem<String>(
                  value: lang,
                  child: Row(
                    children: [
                      Icon(
                        _currentLanguage == lang ? Icons.check_circle : Icons.circle_outlined,
                        color: _currentLanguage == lang ? Colors.green : Colors.grey,
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      Text(lang),
                    ],
                  ),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text("Popular Searches", style: theme.textTheme.titleMedium),
            // const SizedBox(height: 8),
            // // ...popularStocks.asMap().entries.map((entry) {
            // //   final index = entry.key;
            // //   final stock = entry.value;
            // //   final key = _getKey("popular", index);
            //
            //   // return ListTile(
            //   //   contentPadding: EdgeInsets.zero,
            //   //   leading: const CircleAvatar(
            //   //     backgroundImage: AssetImage('assets/logos/aapl.png'),
            //   //   ),
            //   //   title: Text(stock["symbol"]!),
            //   //   subtitle: Text(stock["name"]!),
            //   //   trailing: selectedKeys.contains(key)
            //   //       ? const Icon(Icons.check, color: Colors.green)
            //   //       : null,
            //   //   onTap: () => toggleSelection(key),
            //   // );
            // }),
            const SizedBox(height: 16),
            Text("Explore Analysts Top Stocks", style: theme.textTheme.titleMedium,),
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
                title: const Text("Analyst’s Top Stocks",style: TextStyle(fontWeight: FontWeight.bold),),
                subtitle: const Text(
                  "Lorem Ipsum is simply dummy text of the printing and typesetting",style: TextStyle(fontSize: 10),
                ),
                trailing: Container(
                  height: size.height * .03,
                  width: size.width * .2,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.blue),
                    ),
                    onPressed: () {},
                    child: const Text("Try Now",style: TextStyle(color: Colors.blue,fontSize: 9,fontWeight: FontWeight.bold),),
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
                leading:  CircleAvatar(
                  backgroundColor: Colors.green,
                  child: Image.asset('assets/logos/nvda.png'),
                ),
                title: Text(stock["symbol"]!),
                subtitle: Text(stock["name"]!),
                trailing: selectedKeys.contains(key)
                    ? const Icon(Icons.check, color: Colors.green)
                    : null,
                onTap: () => toggleSelection(key),
              );
            }),
          ],
        ),
      ),
    );
  }
}
