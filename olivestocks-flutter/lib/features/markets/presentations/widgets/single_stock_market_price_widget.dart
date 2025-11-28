import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:olive_stocks_flutter/features/portfolio/controller/portfolio_controller.dart';
import '../../../../common/screens/dummy_chart2.dart';
import '../../../../common/screens/dumy_chart_widget.dart';
import '../../../portfolio/domains/price_chart_response_model.dart';

class SingleStockMarketPriceWidget extends StatefulWidget {
  final String symbol;

  const SingleStockMarketPriceWidget({super.key, required this.symbol});

  @override
  State<SingleStockMarketPriceWidget> createState() => _SingleStockMarketPriceWidgetState();
}

class _SingleStockMarketPriceWidgetState extends State<SingleStockMarketPriceWidget> {

  @override
  void initState() {
    Get.find<PortfolioController>().getPriceChart(widget.symbol);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GetBuilder<PortfolioController>(builder: (portfolioController){
      var data = portfolioController.priceChartResponseModel;
      if (portfolioController.isPriceChartLoading) {
        return Center(child: CircularProgressIndicator());
      }
      if (data == null) {
        return Center(child: Text("No data available."));
      }

      return !portfolioController.isPriceChartLoading ? Padding(
        padding: const EdgeInsets.only(left: 16,right: 16),
        child: Container(
          // color: Colors.red,
            width: size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Container(
                //   height: size.height * .04,
                //   width: size.width * .9,
                //   child: Padding(
                //     padding: const EdgeInsets.symmetric(horizontal: 20.0),
                //     // child: Row(
                //     //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     //   children: [
                //     //     //Text('\$${} USD', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800)),
                //     //     Text('+12.03 (2.24%)', style: TextStyle(color: Colors.green, fontSize: 13, fontWeight: FontWeight.w500)),
                //     //     RotatedBox(
                //     //         quarterTurns: 1,
                //     //         child: Icon(Icons.arrow_back, size: 20, color: Colors.green, weight: 30,)
                //     //     ),
                //     //     Text('+12.03 (2.24%)', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500),),
                //     //     Text('Today', style: TextStyle(color: Colors.green, fontSize: 13, fontWeight: FontWeight.w500),),
                //     //   ],
                //     // ),
                //   ),
                // ),

                // Container(
                //   height: size.height * .04,
                //   width: size.width * .8,
                //   child: Padding(
                //     padding: const EdgeInsets.symmetric(horizontal: 20.0),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       children: [
                //         Text('Closed Apr 2, 7:45 PM EDT. ', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black.withOpacity(.5))),
                //
                //         Text('Disclaimer', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black.withOpacity(.5)),),
                //       ],
                //     ),
                //   ),
                // ),

                StockChartWidget(data: portfolioController.priceChartResponseModel,),

              ],
            )

        ),
      ) : Center(child: CircularProgressIndicator(),);
    });
  }
}




