import 'package:flutter/material.dart';

import 'linear_percent_widget.dart';

class RatingLabelIndication {
  final String value;

  RatingLabelIndication(this.value);

  int get ratingIndex {
    return 0;
  }

  double indicatorXPositionX({
    required double gap,
    required double actualCellWidth,
  }) {
    return ((actualCellWidth + gap) * (ratingIndex - 1)) + (actualCellWidth / 2);
  }
}

class FiveRatingLabelIndication extends RatingLabelIndication{
  FiveRatingLabelIndication(super.value);

  @override
  int get ratingIndex {
    print("Rating: ${value}");
    switch(value) {
      case "Strong Buy":
        return 5;
      case "Moderate Buy":
        return 4;
      case "Hold":
        return 3;
      case "Moderate Sell":
        return 2;
      case "Strong Sell":
        return 1;
      default:
        return 0;
    }
  }

  @override
  double indicatorXPositionX({
    required double gap,
    required double actualCellWidth,
  }) {
    return ((actualCellWidth + gap) * (ratingIndex - 1)) + (actualCellWidth / 2);
  }
}



class ThreeRatingLabelIndication extends RatingLabelIndication{
  ThreeRatingLabelIndication(super.value);

  @override
  int get ratingIndex {
    print("Rating: ${value}");
    switch(value) {
      case "Bullish":
        return 3;
      case "Neutral":
        return 2;
      case "Bearish":
        return 1;
      default:
        return 0;
    }
  }

  @override
  double indicatorXPositionX({
    required double gap,
    required double actualCellWidth,
  }) {
    return ((actualCellWidth + gap) * (ratingIndex - 1)) + (actualCellWidth / 2);
  }
}


class LinearPercentSmartStockWidget extends StatelessWidget {

  final RatingLabelIndication ratingLabel;
  final Color ratingColor;
  final double widgetWidth;
  final List<AnalystConsensus> census;

  LinearPercentSmartStockWidget({
    super.key,
    required this.ratingLabel,
    this.ratingColor = Colors.transparent,
    required this.widgetWidth,
    required this.census,
  });

  final double gap = 3;
  final double iconSize = 34;

  @override
  Widget build(BuildContext context) {
    //final total = strongBuy + moderateBuy + hold + moderateSell + strongSell;

    final actualWidgetWidth = widgetWidth - gap * (census.length - 1);
    return Container(
      //color: Colors.blue,
      width: widgetWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              ratingLabel.value,
              style: TextStyle(
                color: ratingColor,
                fontWeight: FontWeight.bold,
                fontSize: 1,
              ),
            ),
          ),
          Stack(
            clipBehavior: Clip.none,
            alignment: AlignmentDirectional.topCenter,
            children: [
              Container(
                height: 12,
                width: widgetWidth,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Row(
                      children: [
                        for (int i = 0; i < census.length; i++)
                          Row(
                            spacing: 0,
                            children: [
                              StockProgressWidget(
                                color: census[i].color,
                                isFast: i == 0,
                                isLast: i == census.length - 1,
                                analystConsensus: census[i],
                                height: 10,
                                gap: gap,
                                width:  (actualWidgetWidth / census.length ) //+  (i == census.length - 1 ? 0 : 5),
                              ),
                              if(i != census.length -1) SizedBox(width: gap,)
                            ],
                          ),
                      ],
                    );
                  },
                ),
              ),
              Positioned(
                top: -3,
                left: ratingLabel
                      .indicatorXPositionX( gap: gap, actualCellWidth: actualWidgetWidth / census.length,) - (16),
                child: Icon(
                  Icons.arrow_drop_up,
                  size: iconSize,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class StockProgressWidget extends StatelessWidget {
  final double height;
  final double width;
  final Color color;
  final AnalystConsensus analystConsensus;
  final bool isLast;
  final bool isFast;
  final double gap;
  const StockProgressWidget({
    super.key,
    required this.analystConsensus, required this.height, required this.gap, required this.isFast, required this.width, required this.color, required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(

        color: color,
        borderRadius: isFast
            ? const BorderRadius.only(
          topLeft: Radius.circular(30),
          bottomLeft: Radius.circular(30),
        )
            : isLast
            ? const BorderRadius.only(
          topRight: Radius.circular(30),
          bottomRight: Radius.circular(30),
        )
            : BorderRadius.zero,
      ),
    );
  }
}