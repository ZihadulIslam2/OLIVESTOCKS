
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../portfolio/controller/portfolio_controller.dart';
import '../../../portfolio/domains/olive_stocks_portfolio_response_model.dart';
import '../../../stock_data_serving/presentations/widgets/filter_chips_widget.dart';
import '../widgets/analyst_consensus_widget.dart';
import '../widgets/list_widget_analyst.dart';

class OliveStocksPortfolioScreen extends StatefulWidget {
  const OliveStocksPortfolioScreen({super.key});
  @override
  _OliveStocksPortfolioScreenState createState() => _OliveStocksPortfolioScreenState();
}



class _OliveStocksPortfolioScreenState extends State<OliveStocksPortfolioScreen> {

  String formatDateTime(String isoDate) {
    try {
      final dateTime = DateTime.parse(isoDate).toLocal();
      return DateFormat('MMM d, y • h:mm a').format(dateTime);
    } catch (e) {
      return 'Invalid date';
    }
  }

  @override
  void initState() {
    super.initState();
    Get.find<PortfolioController>().getAllOliveStocksPortfolio();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Olive Stocks Portfolio',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            pinned: true,
            snap: true,
            floating: true,
            // expandedHeight: 280,
            backgroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              expandedTitleScale: 1,
              title: FilterChipsWidget(),
              // background:  _buildDescriptionText(),
            ),
          ),
          SliverToBoxAdapter(
            child: _buildBody(context),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(height: 1, color: Color(0xffB0B0B0)),
          const SizedBox(height: 8),
          ListWidgetAnalyst(),
        ],
      ),
    );
  }

  Widget _buildDescriptionText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 12),
        AnalystConsensusWidget(),
      ],
    );
  }
}