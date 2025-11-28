import 'package:flutter/material.dart';
import 'linear_percent_widget.dart';

class AnalystConsensusWidget extends StatefulWidget {
  const AnalystConsensusWidget({super.key});

  @override
  State<AnalystConsensusWidget> createState() => _AnalystConsensusWidgetState();

  static Widget _buildRatingChart() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildRatingItem(const Color(0xFF1E7D34), "Strong Buy"),
        _buildRatingItem(const Color(0xFF28A745), "Moderate Buy"),
        _buildRatingItem(const Color(0xFFB0B0B0), "Hold"),
        _buildRatingItem(const Color(0xFFFF5733), "Moderate Sell"),
        _buildRatingItem(const Color(0xFFBF4126), "Strong Sell"),
      ],
    );
  }

  static Widget _buildRatingItem(Color color, String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(height: 8, width: 8, decoration: BoxDecoration(color: color)),
        const SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(
            fontSize: 9,
            color: Colors.black,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.5,
            height: 1.2,
          ),
        ),
      ],
    );
  }
}

class _AnalystConsensusWidgetState extends State<AnalystConsensusWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Container(
        height: size.height * .23,
        width: size.width * .97,
        decoration: BoxDecoration(
          color: const Color(0xFFE6E6E6),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                'Top 3 Sectors by Analyst Consensus',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF000000),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: AnalystConsensusWidget._buildRatingChart(),
            ),
            Expanded(
              child: Container(
                child: Column(
                  children: [
                    _buildSectorRow(size, 'Technology', 80, 15, 5),
                    _buildSectorRow(size, 'Materials', 70, 20, 10),
                    _buildSectorRow(size, 'HealthCare', 60, 25, 15),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        'Stocks are selected according to Olive Stocks proprietary formula, which factors in the ratings made by top-performing analysts',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff000000),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectorRow(
    Size size,
    String sectorName,
    int buy,
    int hold,
    int sell,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: size.width * 0.25,
          child: Text(
            sectorName,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ),
        Transform.translate(
          offset: Offset(0, -10),
          child: SizedBox(
            width: size.width * 0.6,
            child: LinearPercentWidget2(
              widgetWidth: size.width * 0.6,
              strongBuy: buy.toDouble(),
              moderateBuy: hold.toDouble(),
              moderateSell: sell.toDouble(),
              strongSell: hold.toDouble(),
              hold: sell.toDouble(),
            ),
          ),
        ),
      ],
    );
  }
}
