import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:get/get.dart';
import 'package:olive_stocks_flutter/features/stock_data_serving/presentations/screens/calenders_screen.dart';
import 'package:olive_stocks_flutter/features/stock_data_serving/presentations/widgets/pro_ratings_widget.dart';

import '../../../screens/daily_analyst_ratings_screen.dart';
import '../../rating_star_widget.dart';

class EtfDailyRatings extends StatefulWidget {
  const EtfDailyRatings({Key? key}) : super(key: key);

  @override
  State<EtfDailyRatings> createState() => _EtfDailyRatingsState();
}

class _EtfDailyRatingsState extends State<EtfDailyRatings>
    with TickerProviderStateMixin {
  late TabController tabController;
  int selectedChipIndex = 0;

  List<String> tabs = ["Buy rating", "Hold rating", "Sell rating"];

  @override
  void initState() {
    tabController = TabController(vsync: this, length: tabs.length);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: Container(
        height: size.height * .483,
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
              child: Text(
                'Daily Analyst Ratings',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              height: 35,
              child: TabBar(
                controller: tabController,
                isScrollable: true,
                indicator: const BoxDecoration(
                  color: Colors.transparent, // No default indicator overlay
                ),
                labelPadding: const EdgeInsets.symmetric(horizontal: 8),
                tabs: List.generate(
                  tabs.length,
                      (index) => GestureDetector(
                    onTap: () {
                      tabController.animateTo(index);
                      setState(() {
                        selectedChipIndex = index; // Keep in sync if you're using this variable
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: tabController.index == index
                            ? const Color(0xff28A745) // Selected tab - green
                            : const Color(0xffEAF6EC), // Unselected tab - light green
                        border: Border.all(
                          color: Colors.white, // White border like your chips
                          width: 1,
                        ),
                      ),
                      child: Text(
                        tabs[index],
                        style: TextStyle(
                          fontSize: 12,
                          color: tabController.index == index
                              ? Colors.white // Selected tab text - white
                              : Colors.black, // Unselected tab text - green
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: [HoldTab(), HoldTab(), SellTab(),],
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
                          Get.to(DailyAnalystRatings());
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
}

// Economic Tab
class BuyTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          _buildHeaderRow(context),
          const Divider(height: 1, thickness: 1),
          _buildListContent(context),

        ],
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
              //width: size.width * .,
              child: Padding(
                padding: const EdgeInsets.only(left: 40),
                child: const Text(
                  "Analyst",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Color(0xff595959),
                  ),
                ),
              ),
            ),
            const Spacer(),
            Container(
              width: size.width * .54,
              child: Row(
                children: [
                  const Text(
                    "Company",
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
      itemCount: 4,
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 8, right: 16),
                child: Container(
                  height: size.height * .07,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Stock Info Section
                      Container(
                        height: size.height * .080,
                        width: size.width * .22,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width: 10),
                            Container(
                              height: size.height * .060,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Devin Ryan',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    'JMP Securities',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  StarRatingWidget(rating: 4,),
                                ],
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
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('HOOD'),
                                Text(
                                  'Robinhood Markets',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Analyst Ratings Section
                          Container(
                            width: size.width * .20,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const Text(
                                  "\$511.44",
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.green,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  '30.94%(Upside)',
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 11,
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
class HoldTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          _buildHeaderRow(context),
          const Divider(height: 1, thickness: 1),
          _buildListContent(context),

        ],
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
              //width: size.width * .,
              child: Padding(
                padding: const EdgeInsets.only(left: 40),
                child: const Text(
                  "Analyst",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Color(0xff595959),
                  ),
                ),
              ),
            ),
            const Spacer(),
            Container(
              width: size.width * .54,
              child: Row(
                children: [
                  const Text(
                    "Company",
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
      itemCount: 4,
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 8, right: 16),
                child: Container(
                  height: size.height * .07,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Stock Info Section
                      Container(
                        height: size.height * .080,
                        width: size.width * .22,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width: 10),
                            Container(
                              height: size.height * .060,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Devin Ryan',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    'JMP Securities',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  StarRatingWidget(rating: 4,),
                                ],
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
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('HOOD'),
                                Text(
                                  'Robinhood Markets',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Analyst Ratings Section
                          Container(
                            width: size.width * .20,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const Text(
                                  "\$511.44",
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.green,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  '30.94%(Upside)',
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 11,
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
class SellTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          _buildHeaderRow(context),
          const Divider(height: 1, thickness: 1),
          _buildListContent(context),

        ],
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
              //width: size.width * .,
              child: Padding(
                padding: const EdgeInsets.only(left: 40),
                child: const Text(
                  "Analyst",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Color(0xff595959),
                  ),
                ),
              ),
            ),
            const Spacer(),
            Container(
              width: size.width * .54,
              child: Row(
                children: [
                  const Text(
                    "Company",
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
      itemCount: 4,
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 8, right: 16),
                child: Container(
                  height: size.height * .07,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Stock Info Section
                      Container(
                        height: size.height * .080,
                        width: size.width * .22,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width: 10),
                            Container(
                              height: size.height * .060,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Devin Ryan',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    'JMP Securities',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  StarRatingWidget(rating: 3,),
                                ],
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
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('HOOD'),
                                Text(
                                  'Robinhood Markets',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Analyst Ratings Section
                          Container(
                            width: size.width * .20,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const Text(
                                  "\$511.44",
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.green,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  '30.94%(Upside)',
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 11,
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

