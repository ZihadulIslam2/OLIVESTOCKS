import 'package:flutter/material.dart';
import 'package:olive_stocks_flutter/features/stock_data_serving/presentations/screens/stock_splits_screen.dart';

import 'IPOs_screen.dart';
import 'buybacks_screen.dart';
import 'dividends_screen.dart';
import 'earning_screen.dart';
import 'economic_tab.dart';
import 'holidays_screen.dart';

class CalendersScreen extends StatefulWidget {
  const CalendersScreen({super.key});

  @override
  State<CalendersScreen> createState() => _CalendersScreenState();
}

class _CalendersScreenState extends State<CalendersScreen> with TickerProviderStateMixin{

  late TabController tabController;
  // Keep track of selected chips
  int selectedChipIndex = 0;
  String selectedMarket = "US";
  String selectedBenchmark = "Any";
  String selectedImpact = "Any";

  List<String> tabs = [
    "Economic",
    "Earnings",
    "Dividend",
    "IPOs",
    "Holidays",
    "Stock Splits",
    "BuyBacks",

 ];

  List<Widget> tabScreen =
  [
    EconomicTab(),
    ErningScreen(),
    DividendScreen(),
    IPOsScreen(),
    HolidaysScreen(),
    StockSplitsScreen(),
    BuyBacksScreen(),
  ];

  @override
  void initState() {
     tabController =TabController(vsync: this, length: tabs.length);
    super.initState();
  }
  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 4.0,
        shadowColor: Colors.black,
        title: const Text(
          'Calenders',
          style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.keyboard_backspace, color: Colors.black),
        ),
      ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(13),
                child: Text(
                  "Easy-to-use calendars to keep you on top of upcoming economic events, earnings reports, dividend dates, and IPOs",
                  style: TextStyle(
                    fontSize: 15,
                    color: Color(0xff595959),
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w400,
                    //height: 2,
                  ),
                ),
              ),
        Container(
          height: 60,
          child: TabBar(
            controller: tabController,
            isScrollable: true,
            indicator: const BoxDecoration(
              color: Colors.transparent, // No default indicator overlay
            ),
            labelPadding: const EdgeInsets.symmetric(horizontal: 8),
            tabs: List.generate(
              tabs.length,
                  (index) => GestureDetector(
                onTap: () {
                  tabController.animateTo(index);
                  setState(() {
                    selectedChipIndex = index; // Keep in sync if you're using this variable
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: tabController.index == index
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
                      color: tabController.index == index
                          ? Colors.white // Selected tab text - white
                          : Colors.black, // Unselected tab text - green
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        ),
               Container(
                 height: size.height,
                 child: TabBarView(
                   controller: tabController,
                  children: tabScreen,
                             ),
               ),
            ],
          ),
        )
    );
  }

}

