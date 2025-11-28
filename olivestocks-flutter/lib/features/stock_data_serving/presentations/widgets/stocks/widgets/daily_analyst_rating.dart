import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../portfolio/domains/daily_analyst_ratings_response_model.dart';
import '../../../screens/daily_analyst_ratings_screen.dart';
import '../../rating_star_widget.dart';

class DailyAnalystRatingScreen extends StatefulWidget {
   DailyAnalystRatingScreen({super.key, required this.qualityStocks});

  List<QualityStocks>? qualityStocks;

  @override
  State<DailyAnalystRatingScreen> createState() => _DailyAnalystRatingScreenState();
}

class _DailyAnalystRatingScreenState extends State<DailyAnalystRatingScreen>
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
                children: [BuyTab(qualityStocks: widget.qualityStocks), HoldTab(qualityStocks: widget.qualityStocks,), SellTab(qualityStocks: widget.qualityStocks),],
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

  final List<QualityStocks>? qualityStocks;

  const BuyTab({super.key, this.qualityStocks});

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
      itemCount: qualityStocks!.length,
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                height: size.height * .07,
                width: size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Stock Info Section
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          // height: size.height * .05,
                           width: size.width * .28,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                qualityStocks![index].symbol.toString(),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                qualityStocks![index].companyName.toString(),
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              qualityStocks![index].stockRating!= null ?
                               StarRatingWidget(rating: 4,):
                               Text('N/A'),
                            ],
                          ),
                        ),
                      ],
                    ),
                    // Price and Ratings Section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                           width: size.width * .3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.network(
                                qualityStocks![index].logo ?? '', // Assuming it's a URL
                                height: 35, // Set height or width as needed
                                width: 35,
                                fit: BoxFit.contain,
                                errorBuilder: (context, error, stackTrace) => Icon(Icons.error, size: 30), // Error placeholder
                              ),
                              Text(
                                qualityStocks![index].sector.toString(),
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
                          // width: size.width * .15,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                               Text(
                                qualityStocks![index].analystTarget.toString(),
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.green,
                                  fontWeight: FontWeight.w500,
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
            const Divider(height: 1, thickness: 1),
          ],
        );
      },
    );
  }
}

class HoldTab extends StatelessWidget {

  final List<QualityStocks>? qualityStocks;

  const HoldTab({super.key, this.qualityStocks});

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
      itemCount: qualityStocks!.length,
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                height: size.height * .07,
                width: size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Stock Info Section
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          // height: size.height * .05,
                          width: size.width * .28,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                qualityStocks![index].symbol.toString(),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                qualityStocks![index].companyName.toString(),
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              qualityStocks![index].stockRating!= null ?
                              StarRatingWidget(rating: 4,):
                              Text('N/A'),
                            ],
                          ),
                        ),
                      ],
                    ),
                    // Price and Ratings Section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: size.width * .3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.network(
                                qualityStocks![index].logo ?? '', // Assuming it's a URL
                                height: 35, // Set height or width as needed
                                width: 35,
                                fit: BoxFit.contain,
                                errorBuilder: (context, error, stackTrace) => Icon(Icons.error, size: 30), // Error placeholder
                              ),
                              Text(
                                qualityStocks![index].sector.toString(),
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
                          // width: size.width * .15,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                qualityStocks![index].analystTarget.toString(),
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.green,
                                  fontWeight: FontWeight.w500,
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
            const Divider(height: 1, thickness: 1),
          ],
        );
      },
    );
  }
}


class SellTab extends StatelessWidget {
  final List<QualityStocks>? qualityStocks;

  const SellTab({super.key, this.qualityStocks});


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
      itemCount: qualityStocks!.length,
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                height: size.height * .07,
                width: size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Stock Info Section
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          // height: size.height * .05,
                          width: size.width * .28,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                qualityStocks![index].symbol.toString(),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                qualityStocks![index].companyName.toString(),
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              qualityStocks![index].stockRating!= null ?
                              StarRatingWidget(rating: 4,):
                              Text('N/A'),
                            ],
                          ),
                        ),
                      ],
                    ),
                    // Price and Ratings Section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: size.width * .3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.network(
                                qualityStocks![index].logo ?? '', // Assuming it's a URL
                                height: 35, // Set height or width as needed
                                width: 35,
                                fit: BoxFit.contain,
                                errorBuilder: (context, error, stackTrace) => Icon(Icons.error, size: 30), // Error placeholder
                              ),
                              Text(
                                qualityStocks![index].sector.toString(),
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
                          // width: size.width * .15,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                qualityStocks![index].analystTarget.toString(),
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.green,
                                  fontWeight: FontWeight.w500,
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
            const Divider(height: 1, thickness: 1),
          ],
        );
      },
    );
  }
}

