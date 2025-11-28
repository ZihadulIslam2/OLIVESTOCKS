import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:olive_stocks_flutter/features/stock_data_serving/presentations/widgets/table_model/analyst_linear_percent_widget.dart';

import '../../../../../experts/presentations/screens/olive_stock_screen.dart';

class EtfAnalystsTop extends StatefulWidget {
  const EtfAnalystsTop({Key? key}) : super(key: key);

  @override
  State<EtfAnalystsTop> createState() =>
      _EtfAnalystsTopState();
}

class _EtfAnalystsTopState extends State<EtfAnalystsTop>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: Container(
        height: size.height * .433,
        width: size.width * .95,
        decoration: BoxDecoration(
          color: Color(0xffFFFFFF),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Analysts Top Stocks',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'By the best performing Analysts',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              child: Column(
                children: [
                  _buildHeaderRow(context),
                  const Divider(height: 1, thickness: 1),
                  _buildListContent(context),
                ],
              ),
            ),
            Container(
              height: size.height * .05,
              padding: EdgeInsets.only(left: 10, right: 10,),
              color: Color(0xffBFBFBF),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text('See what the Best Analysts are recommending\nand why',style: TextStyle(
                      fontSize: 12,
                      color: Color(0xff595959),
                      fontWeight: FontWeight.w400,
                    ),),
                  ),
                  Spacer(),
                  Container(
                    height: 20,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: (){
                          Get.to(OliveStocksPortfolioScreen());
                        }, child: Text('Go Pro',style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),)),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderRow(context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * .06,
      child: Container(
        color: Color(0xffEAF6EC),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(left: 6),
              child: const Text(
                "Company",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Color(0xff595959),
                ),
              ),
            ),
            const Spacer(),
            Container(
              width: size.width * .54,
              child: Row(
                children: [
                  const Text(
                    "Analyst\nConsensus",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Color(0xff595959),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    width: size.width * .15,
                    child: Row(
                      children: [
                        const Text(
                          "Price\nTarget",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Color(0xff595959),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListContent(context) {
    Size size = MediaQuery.of(context).size;
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  height: size.height * .05,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: size.height * .080,
                        width: size.width * .22,
                        child: Container(
                          height: size.height * .060,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'MSFT',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                'Microsoft',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Price and Ratings Section
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: size.width * .23,
                            child: Center(
                              child: Container(
                                child: AnalystLinearPercentWidget(
                                  strongBuy: 10,
                                  moderateBuy: 10,
                                  hold: 10,
                                  widgetWidth: size.width,
                                  moderateSell: 10,
                                  strongSell: 10,
                                  ratingLabel: "Strong Buy",
                                  ratingColor: Colors.green,
                                ),
                              ),
                            ),
                          ),
                          // Analyst Ratings Section
                          Container(
                            width: size.width * .30,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const Text(
                                  "\$420.00",
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.green,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  '30.94% (Upside)',
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Divider(height: 1, thickness: 1),
          ],
        );
      },
    );
  }
}
