import 'package:flutter/material.dart';

import '../widgets/filter_chips_widget.dart';
import '../widgets/insider_list_widget.dart';
import '../widgets/transaction_strategy_cards.dart';

class InsidersHotStocksScreen extends StatefulWidget {
  const InsidersHotStocksScreen({super.key});

  @override
  _InsidersHotStocksScreenState createState() => _InsidersHotStocksScreenState();
}

class _InsidersHotStocksScreenState extends State<InsidersHotStocksScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Insider\'s Hot Stocks',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
      ),
     body:  NestedScrollView(
       headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
         return [
           SliverToBoxAdapter(
             child: _buildDescriptionText(),
           ),
           SliverAppBar(
             automaticallyImplyLeading: false,
             pinned: true,
             snap: true,
             floating: true,
             backgroundColor: Colors.white,
             title: FilterChipsWidget(),
           ),
         ];
     },
     body: _buildBody(context)
     ),

    );
  }

  Widget _buildBody(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Divider(height: 1, color: Color(0xffB0B0B0)),
            const SizedBox(height: 8),
            InsiderListWidget(context: context),
          ],
        ),
      ),
    );
  }

  Widget _buildDescriptionText() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Stocks that exhibit strong buy indicators based on insider trading ",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Color(0xff000000),
            ),
          ),
          SizedBox(height: 13),
          Row(
            children: [
              Text(
                'Filter By Trading Strategies ',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              Icon(Icons.info_outline,size: 16,color: Colors.green,)
            ],
          ),
          SizedBox(height: 12),
          TransactionStrategy(),
        ],
      ),
    );
  }
}