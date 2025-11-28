import 'package:flutter/material.dart';
import '../../../../common/widgets/custom_appbar.dart';
import '../../../../common/widgets/tow_tabs_bar_custom.dart';
import '../../../portfolio/presentations/widgets/portfolio_header_widget.dart';
import '../../../stock_data_serving/presentations/widgets/stocks/models/stock_model.dart';
import '../../../stock_data_serving/presentations/widgets/stocks/tabs/etfs_tab.dart';
import '../../../stock_data_serving/presentations/widgets/stocks/tabs/stock_tab.dart';
import '../../../stock_data_serving/presentations/widgets/stocks/widgets/market_header_card.dart';

class MarketScreen extends StatefulWidget {
  const MarketScreen({super.key});

  @override
  State<MarketScreen> createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen> with SingleTickerProviderStateMixin {

  int selectedTabIndex = 0;

  late TabController tabController;
  //
  // final List<Stock> topDailyStocks = [
  //   Stock(company: 'AAPL', value1: '\$145.00', value2: '+3.25%', isPositive: true),
  //   Stock(company: 'GOOG', value1: '\$2734.50', value2: '+1.78%', isPositive: true),
  //   Stock(company: 'MSFT', value1: '\$299.10', value2: '+2.45%', isPositive: true),
  // ];

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
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
      body: Column(
        children: [
          const SizedBox(height: 20),
          const CustomAppBar(appBarTitle: "Markets", isDefaultIcon: true),
          const PortfolioHeaderCards(),

          Expanded(
            child: ListView(
              padding: const EdgeInsets.only(top: 8),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TwoTabsBarCustom(
                    firstTabText: "Stocks",
                    secondTabText: "ETFs",
                    selectedIndex: selectedTabIndex,
                    onTabChanged: (index) {
                      setState(() {
                        selectedTabIndex = index;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 12),
                if (selectedTabIndex == 0)
                  Container(
                    // color: Colors.red,
                    child: StocksTab(),
                  )
                else
                  Container(
                    child: EtfsTab(tabController: tabController),
                  ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
