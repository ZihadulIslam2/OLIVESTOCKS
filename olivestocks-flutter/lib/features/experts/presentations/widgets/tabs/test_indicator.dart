import 'package:flutter/material.dart';

import '../../../../../common/data/all_data.dart';
import '../linear_percent_smart_stock_widget.dart';
import '../linear_percent_widget.dart';

class TestIndicator extends StatelessWidget {
  const TestIndicator({super.key});
  static var stockData = AllData.stockDatas;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          width: 300,
          height: 30,
          child: LinearPercentSmartStockWidget(
            widgetWidth: 300,
            //ratingLabel: "Strong Buy",
            //ratingLabel: "Strong Sell",
           // ratingLabel: "Moderate Buy",
            ratingLabel: FiveRatingLabelIndication("Moderate Buy"),
            //ratingLabel: "Hold",
            census: [
              AnalystConsensus(color: Color(0xFFFF5733), label: "Moderate Sell", value: stockData[0]
                  .newsSentiment
                  .moderateSell,),
              AnalystConsensus(color: Colors.red, label: "Strong Sell", value: stockData[0]
                  .newsSentiment.strongSell),
              AnalystConsensus(color: Colors.grey, label: "Hold", value: stockData[0]
                  .newsSentiment.hold),
              AnalystConsensus(color: Color(0xFF1E7D34), label: "Strong Buy", value: stockData[0]
                  .newsSentiment.strongBuy),
              AnalystConsensus(color: Colors.green, label: "Moderate Buy", value: stockData[0
              ]
                  .newsSentiment.moderateBuy),
            ]
            ,
          ),
        );
      },
    );
  }
}
