import 'package:flutter/material.dart';
import 'package:olive_stocks_flutter/features/experts/presentations/widgets/top_smart_score_list_widget.dart';
import '../widgets/daily_inside_filter_widget.dart';


class TheOliveStocksPortfolioScreen extends StatefulWidget {
  const TheOliveStocksPortfolioScreen({super.key});

  @override
  State<TheOliveStocksPortfolioScreen> createState() => _TheOliveStocksPortfolioScreenState();
}

class _TheOliveStocksPortfolioScreenState extends State<TheOliveStocksPortfolioScreen>
    with SingleTickerProviderStateMixin {

  final ScrollController _verticalScrollController = ScrollController();


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(),
        body: Flexible(
          child: NestedScrollView(
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
                  TopSmartScoreList(oliveStocks: [],),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,

      title: const Text(
        'The Olive Stocks Portfolio',
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
                "Best Stocks to buy now based on the Olive Stocks",
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff000000),
                ),
              ),
              const Text(
                maxLines: 3,
                "Smart Score system",
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 343,
                height: 56,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      color: Colors.black,
                      height: 56,
                      width: 2,
                    ),
                    Column(
                      crossAxisAlignment:CrossAxisAlignment.start ,
                      children: [
                        Text('Total Return',style: TextStyle(fontSize: 10,fontWeight: FontWeight.w400),),
                        Text('299.50%',style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500,color: Colors.green),),
                      ],
                    ),
                    SizedBox(width: 15,),
                    Container(
                      color: Colors.black,
                      height: 56,
                      width: 2,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Alpha over S&P 500',style: TextStyle(fontSize: 10,fontWeight: FontWeight.w400),),
                        Text('+147.39%',style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500,color: Colors.green),),
                      ],
                    ),
                    SizedBox(width: 15,),
                    Container(
                      color: Colors.black,
                      height: 56,
                      width: 2,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Average Annualized\nReturn',style: TextStyle(fontSize: 10,fontWeight: FontWeight.w400),),
                        Text('+16.31%',style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500,color: Colors.green),),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        )
      ],
    ),
  );
}