import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:olive_stocks_flutter/features/stock_data_serving/presentations/widgets/pro_ratings_widget.dart';
import 'package:olive_stocks_flutter/features/stock_data_serving/presentations/widgets/pro_widget.dart';

import '../../../auth/presentations/screens/login_screen.dart';

class DailyInsiderListWidget extends StatelessWidget {
  const DailyInsiderListWidget({super.key, required this.context});

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          const Divider(height: 1, thickness: 1),
          _buildHeaderRow(),
          const Divider(height: 1, thickness: 1),
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: _buildListContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderRow() {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: size.width * .20,
            child: const Text(
              "Insider",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
          ),
          const Spacer(),
          Container(
            width: size.width * .56,
            child: Row(
              children: [
                const Text(
                  "Company",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
                const Spacer(),
                Row(
                  children: [
                    const Text(
                      /**/
                      "Transaction",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(width: 8,),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: (){
                            Get.to(LoginScreen());
                          },
                          child: Container(
                            height: 16,
                            child: Center(child: Icon(Icons.keyboard_arrow_up, size: 17)),
                          ),
                        ),
                        GestureDetector(
                          onTap: (){},
                          child: Container(
                            height: 16,
                            child: Center(child: Icon(Icons.keyboard_arrow_down, size: 17)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListContent() {
    Size size = MediaQuery.of(context).size;

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 20,
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Stock Item
            InkWell(
              onTap: () {
                //Get.to(AdsScreen());
              },
              child: Center(
                child: Container(
                  padding: const EdgeInsets.only(left: 18, top: 8, bottom: 8),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Stock Info Section
                      Container(
                        height: size.height * .080,
                        width: size.width * .22,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ProRatingsWidget(),
                            //StarRatingWidget(),
                            Text(
                              'Non-Executive\nDirector',
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Price and Ratings Section
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Price Change Section
                          Container(
                            width: size.width * .40,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [ProWidget()],
                            ),
                          ),
                          // Analyst Ratings Section
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text('BUY',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: Colors.green),),
                              const Text(
                                "CS4,875.00",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.green,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    '04/06/25',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Divider(height: 1, thickness: 1),
            const SizedBox(height: 4),
          ],
        );
      },
    );
  }
}
