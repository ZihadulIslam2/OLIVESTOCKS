import 'package:flutter/material.dart';
import '../../../experts/presentations/widgets/stock_screener_list_widget.dart';
import '../../../experts/presentations/widgets/top_smart_score_list_widget.dart';
import '../widgets/daily_inside_filter_widget.dart';




class StockScreenerScreen extends StatefulWidget {
  const StockScreenerScreen({super.key});

  @override
  State<StockScreenerScreen> createState() => _StockScreenerScreenState();
}

class _StockScreenerScreenState extends State<StockScreenerScreen>
    with SingleTickerProviderStateMixin {

  final ScrollController _verticalScrollController = ScrollController();


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(),
        body: NestedScrollView(
          //controller: _verticalScrollController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return  [
              SliverToBoxAdapter(
                child: Column(
                  children: [
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
                title:DailyInsiderFilterChipsWidget(),
              ),
            ];
          },
          body: SingleChildScrollView(
            child: Column(
              children: [
                buildStockScannerList(context,),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      title: Row(
        children: [
          const Text(
            'Stock Screener',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Spacer(),
          Container(
              height: 20,
              width: 20,
              child: GestureDetector(
                onTap: (){},
                child: Image.asset('assets/logos/filtericon.png',
                fit: BoxFit.cover,),
              )),
        ],
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
        Container(
          width: 343,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Displaying 70 filtered Results",
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff000000),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}