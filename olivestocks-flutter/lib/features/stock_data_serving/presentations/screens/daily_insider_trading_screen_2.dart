import 'package:flutter/material.dart';

import '../../../experts/presentations/widgets/daily_inside_filter_widget.dart';
import '../widgets/daily_insider_list_widget.dart';




class DailyInsiderTradingScreen2 extends StatefulWidget {
  const DailyInsiderTradingScreen2({super.key});

  @override
  State<DailyInsiderTradingScreen2> createState() => _DailyInsiderTradingScreen2State();
}

class _DailyInsiderTradingScreen2State extends State<DailyInsiderTradingScreen2>
    with SingleTickerProviderStateMixin {

  final ScrollController _verticalScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(),

        body: Container(
          height: size.height,
          width: size.width,
          child: Center(
            child: Text('Coming Soon', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black, fontSize: 30),),
          ),
        ),

        // body: NestedScrollView(
        //     //controller: _verticalScrollController,
        //     headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        //       return  [
        //         SliverToBoxAdapter(
        //           child: Column(
        //             children: [
        //               _buildDescriptionText(),
        //               const SizedBox(height: 8),
        //             ],
        //           ),
        //         ),
        //
        //         SliverAppBar(
        //           automaticallyImplyLeading: false,
        //           pinned: true,
        //           snap: true,
        //           floating: true,
        //           title:DailyInsiderFilterChipsWidget(),
        //         ),
        //       ];
        //     },
        //     body: SingleChildScrollView(
        //       child: Column(
        //         children: [
        //           DailyInsiderListWidget(context: context),
        //         ],
        //       ),
        //     ),
        // ),


      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,

      title: const Text(
        'Daily Insider Trading',
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
        const Text(
          "Tracking insider transactions can be a valuable strategy. Insiders often have better practical insights into a company's outlook than the average investor. By following which stocks Insiders are buying or selling, you can see how those most in the know are trading.  ",
          style: TextStyle(
            fontSize: 13.8,
            fontWeight: FontWeight.w400,
            color: Color(0xff000000),
          ),
        ),
      ],
    ),
  );
}