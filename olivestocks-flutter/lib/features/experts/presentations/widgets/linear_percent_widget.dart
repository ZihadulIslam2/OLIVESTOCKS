import 'package:flutter/material.dart';

class AnalystConsensus{
  final Color color;
  final String label;
  final double value;
  AnalystConsensus({required this.color, required this.label, required this.value});
}
class LinearPercentWidget2 extends StatelessWidget {
  final double strongBuy;
  final double moderateBuy;
  final double hold;
  final double moderateSell;
  final double strongSell;
   String ratingLabel;
   Color ratingColor;
   final double widgetWidth;

  LinearPercentWidget2({
    super.key,
    required this.strongBuy,
    required this.moderateBuy,
    required this.hold,
    this.ratingLabel = "",
    this.ratingColor = Colors.transparent,
    required this.widgetWidth,
    required this.moderateSell,
    required this.strongSell,
  });

  @override
  Widget build(BuildContext context) {
    final total = strongBuy + moderateBuy + hold + moderateSell + strongSell;



   Size size = MediaQuery.of(context).size;

    final totalWidth = widgetWidth;
    List<AnalystConsensus> census = [
      AnalystConsensus(color: Color(0xFFFF5733), label: "Moderate Sell", value: moderateSell),
      AnalystConsensus(color: Colors.red, label: "Strong Sell", value: strongSell),
      AnalystConsensus(color: Colors.grey, label: "Hold", value: hold),
      AnalystConsensus(color: Color(0xFF1E7D34), label: "Strong Buy", value: strongBuy),
      AnalystConsensus(color: Colors.green, label: "Moderate Buy", value: moderateBuy),
    ];
    // Calculate indicator position (center of the buy segments)
    //final indicatorPosition = (buySegments * segmentWidth) - (segmentWidth / 2);

    return LayoutBuilder(
      builder: (context, constraints) {
        final perValueWidth = constraints.maxWidth / total;
        return Container(
          width: widgetWidth,
          //color: Colors.black,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Rating label
              Center(
                child: Text(
                  ratingLabel,
                  style: TextStyle(
                    color: ratingColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(height: 6),

              // Progress bar with segments
              Stack(
                clipBehavior: Clip.none,
                alignment: AlignmentDirectional.topCenter,
                children: [
                  Row(
                    children: [
                      for (int i = 0; i < census.length; i++)
                        Container(
                          width: perValueWidth * census[i].value,
                          height: 10,
                          decoration: BoxDecoration(
                            color: census[i].color,
                            borderRadius: i == 0
                                ? const BorderRadius.only(
                              topLeft: Radius.circular(30),
                              bottomLeft: Radius.circular(30),
                            )
                                : i == census.length - 1
                                ? const BorderRadius.only(
                              topRight: Radius.circular(30),
                              bottomRight: Radius.circular(30),
                            )
                                : BorderRadius.zero,
                          ),
                        ),
                    ],
                  ),

                  // Triangle Indicator
                ],
              ),
            ],
          ),
        );
      }
    );
  }
}