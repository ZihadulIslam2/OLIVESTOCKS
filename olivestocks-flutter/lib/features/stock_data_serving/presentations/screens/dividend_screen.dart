import 'package:flutter/material.dart';

import '../widgets/dividend_filter_chips_widget.dart';
import 'best_dividend_stock.dart';
import 'dividend_aristocrats.dart';

class DividendScreener extends StatefulWidget {
  @override
  State<DividendScreener> createState() => _DividendScreenerState();
}

class _DividendScreenerState extends State<DividendScreener>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();

  late TabController _tabController;
  final ScrollController _horizontalScrollController = ScrollController();

  int selectedChipIndex = -1;
  String selectedMarket = "US";
  String selectedScore = "Any";
  String selectedImpact = "Any";

  final List<String> tabs = ["Best Dividend Stocks", "Dividend Aristocrats"];

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: tabs.length);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _horizontalScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: _buildAppBar(),
      body: NestedScrollView(
          controller:_horizontalScrollController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return  [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    _buildTabBar(),
                    _buildDescriptionText(),
                    const SizedBox(height: 8),
                  ],
                ),
              ),

              SliverAppBar(
                automaticallyImplyLeading: false,
                pinned: true,
                snap: true,
                floating: true,
                title: DividendFilterChipsWidget(),
              ),
            ];
          },
          body: TabBarView(
            controller: _tabController,
            children: [
              SingleChildScrollView(child: BestDividendStock(horizontalScrollController: _horizontalScrollController,)),
              SingleChildScrollView(child: DividendAristocrats(horizontalScrollController: _horizontalScrollController,)),
            ],
          )
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
        'Best Dividend Stocks',
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
        "Welcome to our Best Dividend Stocks tool, where we feature the top dividend-paying stocks on the market. Whether you are looking for the best dividend stocks to buy now or just want to explore your options, we've got you covered with our comprehensive list of the best dividend stocks. Our list comprises dividend-paying stocks that have a Smart Score of 10.",
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
        dividerColor: Colors.transparent,
        indicator: const BoxDecoration(
          color: Colors.transparent,
        ),
        labelPadding: const EdgeInsets.symmetric(horizontal: 8),
        tabs: List.generate(
          tabs.length,
              (index) => GestureDetector(
            onTap: () {
              _tabController.animateTo(index);
              setState(() {
                _tabController.index = index;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: _tabController.index == index
                    ? const Color(0xff28A745)
                    : const Color(0xffEAF6EC),
                border: Border.all(
                  color: Colors.white,
                  width: 1,
                ),
              ),
              child: Text(
                tabs[index],
                style: TextStyle(
                  fontSize: 12,
                  color: _tabController.index == index
                      ? Colors.white
                      : Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }

}