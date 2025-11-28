import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../common/screens/ads_screen.dart';
import '../../../experts/presentations/widgets/lock_widget.dart';
import 'linear_percent_widget.dart';

class InsiderListWidget extends StatelessWidget {
  const InsiderListWidget({
    super.key,
    required this.context,
  });

  final BuildContext context;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          _buildHeaderRow(),
          const Divider(height: 1, thickness: 1,),
           _buildListContent(),
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
            width: size.width * .23,
            child: const Text(
              "Insider",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
          ),
          const Spacer(),
          Container(
            width: size.width * .68,
            child: Row(
              children: [
                const Text(
                  "Company",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
                const Spacer(),
                const Text(
                  "Insider Signal",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
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
                Get.to(AdsScreen());
              },
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: const BoxDecoration(color: Colors.transparent),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Stock Info Section
                          Container(
                            height: size.height * .066,
                            width: size.width * .23,
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "04/07/2025",
                                      style: TextStyle(fontSize: 11, color: Colors.green),
                                    ),
                                    const SizedBox(height: 4),
                                    lockWidget(),
                                  ],
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
                                width: size.width * .30,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [lockWidget()],
                                ),
                              ),
                              // Analyst Ratings Section
                              Container(
                                width: size.width * 0.4,
                                child: LinearPercentWidget(
                                  buyPercent: 85,
                                  holdPercent: 10,
                                  sellPercent: 5,
                                  ratingLabel: "Very Positive",
                                  ratingColor: Colors.green,
                                ),
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
            // Rating Reasoning
            Container(
              height: 16,
              width: 162,
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Rating Reasoning:",
                        style: TextStyle(fontSize: 11, color: Colors.green),
                      ),
                      SvgPicture.asset("assets/logos/ultimate.svg"),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            const Divider(height: 1, thickness: 1),
          ],
        );
      },
    );
  }
}