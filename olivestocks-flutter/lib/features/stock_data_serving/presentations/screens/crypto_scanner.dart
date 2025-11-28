import 'package:flutter/material.dart';
import 'package:olive_stocks_flutter/features/stock_data_serving/presentations/screens/price_change_screen.dart';

import 'default_screen.dart';

class ShowingItem {
  final String name;
  final bool value;

  ShowingItem({required this.name, required this.value});
}

class CryptoScreener extends StatefulWidget {
  @override
  State<CryptoScreener> createState() => _CryptoScreenerState();
}

class _CryptoScreenerState extends State<CryptoScreener>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<String> tabs = ["Default", "Price Change"];

  final List<Widget> tabScreens = [
    DefaultCryptoContent(),
    PriceChangeCryptoScreener(),
  ];

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: tabs.length);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDescriptionText(),
            const SizedBox(height: 8),
            _buildTabBar(),
            const Divider(height: 1),
            _buildHeaderRow(),
            const Divider(height: 1),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: tabScreens,
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      elevation: 4.0,
      shadowColor: Colors.black,
      title: const Text(
        'Crypto Screener',
        style: TextStyle(
          fontSize: 19,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(Icons.keyboard_backspace, color: Colors.black),
      ),
    );
  }

  Widget _buildDescriptionText() {
    return Container(
      padding: const EdgeInsets.all(13),
      child: const Text(
        "Displaying 120 Results",
        style: TextStyle(
          fontSize: 14,
          color: Color(0xff595959),
          fontWeight: FontWeight.w400,
          height: 2,
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      height: 60,
      child: TabBar(
        controller: _tabController,
        isScrollable: true,
        indicator: const BoxDecoration(
          color: Colors.transparent, // No default indicator overlay
        ),
        labelPadding: const EdgeInsets.symmetric(horizontal: 8),
        tabs: List.generate(
          tabs.length,
              (index) => GestureDetector(
            onTap: () {
              _tabController.animateTo(index);
              setState(() {
                _tabController.index = index; // Keep in sync if you're using this variable
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: _tabController.index == index
                    ? const Color(0xff28A745) // Selected tab - green
                    : const Color(0xffEAF6EC), // Unselected tab - light green
                border: Border.all(
                  color: Colors.white, // White border like your chips
                  width: 1,
                ),
              ),
              child: Text(
                tabs[index],
                style: TextStyle(
                  fontSize: 12,
                  color: _tabController.index == index
                      ? Colors.white // Selected tab text - white
                      : Colors.black, // Unselected tab text - green
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderRow() {
    return Row(
      children: [
        Container(
          width: 136,
          height: 32,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                offset: const Offset(0, 2),
                blurRadius: 10,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Symbol"),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.keyboard_arrow_up, size: 8),
                  Icon(Icons.keyboard_arrow_down, size: 8),
                ],
              ),
            ],
          ),
        ),
        const Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: 8),
            child: Center(
              child: Text(
                "Price",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 60,
          child: Center(
            child: Text(
              "Volume",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
          ),
        ),
      ],
    );
  }
}
