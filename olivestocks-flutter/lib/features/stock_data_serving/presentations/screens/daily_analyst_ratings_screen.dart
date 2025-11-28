import 'package:flutter/material.dart';
import 'package:olive_stocks_flutter/features/stock_data_serving/presentations/screens/sell_ratting_screen.dart';
import '../widgets/filter_chips_widget.dart';
import 'buy_rating_screen.dart';
import 'hold_rating_screen.dart';

class DailyAnalystRatings extends StatefulWidget {
  const DailyAnalystRatings({super.key});

  @override
  State<DailyAnalystRatings> createState() =>
      _DailyAnalystRatingsState();
}

class _DailyAnalystRatingsState extends State<DailyAnalystRatings>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ScrollController _verticalScrollController = ScrollController();

  final List<String> tabs = ["Buy Ratings", "Hold Ratings", "Sell Ratings"];

  @override
  void initState() {

    _tabController = TabController(vsync: this, length: tabs.length);
    super.initState();

  }

  @override
  void dispose() {
    _tabController.dispose();
    _verticalScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Scaffold(

      appBar: _buildAppBar(),

      body: NestedScrollView(
        controller: _verticalScrollController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
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
              title: FilterChipsWidget(),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            BuyRatingScreen(
              verticalScrollController: _verticalScrollController,
            ),
            HoldRatingsScreen(
              verticalScrollController: _verticalScrollController,
            ),
            SellRatingScreen(
              verticalScrollController: _verticalScrollController,
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
        'Daily Analyst Ratings',
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

  Widget _buildTabBar() {
    return Container(
      height: 60,
      child: TabBar(
        controller: _tabController,
        isScrollable: true,
        dividerColor: Colors.transparent,
        indicator: const BoxDecoration(color: Colors.transparent),
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
                color:
                    _tabController.index == index
                        ? const Color(0xff28A745)
                        : const Color(0xffEAF6EC),
                border: Border.all(color: Colors.white, width: 1),
              ),
              child: Text(
                tabs[index],
                style: TextStyle(
                  fontSize: 12,
                  color:
                      _tabController.index == index
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

Widget _buildDescriptionText() {
  return Padding(
    padding: const EdgeInsets.only(left: 16, right: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Tracking insider transactions can be a valuable strategy. Insiders often have better practical insights into a company's outlook than the average investor. By following which stocks Insiders are buying or selling, you can see how those most in the know are trading.  ",
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Color(0xff000000),
          ),
        ),
      ],
    ),
  );
}
