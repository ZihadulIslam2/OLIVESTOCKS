import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:olive_stocks_flutter/features/stock_data_serving/presentations/screens/calenders_screen.dart';

import '../../../../../portfolio/domains/upcoming_event_response_model.dart';

class UpcomingEventScreen extends StatefulWidget {
   const UpcomingEventScreen({super.key, required this.events});

  final List<Events>? events;


  @override
  State<UpcomingEventScreen> createState() => _UpcomingEventScreenState();
}

class _UpcomingEventScreenState extends State<UpcomingEventScreen>
    with TickerProviderStateMixin {
  late TabController tabController;
  int selectedChipIndex = 0;


  List<String> tabs = ["Economic", "Earnings", "Dividend"];

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
        height: size.height * .66,
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
                'Upcoming Events',
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
                children: [EconomicTab(events: widget.events), EarningsTab(events: widget.events), DividendTab(events: widget.events,),],
              ),
            ),
            Center(
              child: TextButton(
                onPressed: () {
                  Get.to(() => const CalendersScreen());
                },
                child: Text(
                  'See More',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Economic Tab
class EconomicTab extends StatelessWidget {
  const EconomicTab({super.key,required this.events});
  final List<Events>? events;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
      height: size.height * .05,
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
                  "Event",
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
                    "Estimate",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Color(0xff595959),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    width: size.width * .10,
                    child: Row(
                      children: [
                        const Text(
                          "Date",
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
      itemCount: events!.length,
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 8, right: 16),
                child: Container(
                  height: size.height * .05,
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
                            // const CircleAvatar(
                            //   radius: 10,
                            //   backgroundImage: AssetImage(
                            //     'assets/flags/us.png',
                            //   ),
                            // ),
                            SizedBox(width: 10),
                            Container(
                              height: size.height * .060,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    events![index].symbol!,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Price and Ratings Section
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Price Change Section
                          Container(
                            width: size.width * .40,
                            child: Text(events![index].type!),
                          ),
                          // Analyst Ratings Section
                          Text(
                           events![index].date!,
                           style: TextStyle(
                             fontSize: 14,
                             color: Colors.black,
                             fontWeight: FontWeight.w500,
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

// Earnings Tab
class EarningsTab extends StatelessWidget {
  const EarningsTab({super.key, required this.events});

  final List<Events>? events;

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
      height: size.height * .05,
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
                  "Company",
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
                    "EPS Forecast",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Color(0xff595959),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    width: size.width * .10,
                    child: Row(
                      children: [
                        const Text(
                          "Date",
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
      itemCount: events!.length,
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 8, right: 16),
                child: Container(
                  height: size.height * .05,
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
                            // const CircleAvatar(
                            //   radius: 10,
                            //   backgroundImage: AssetImage(
                            //     'assets/flags/us.png',
                            //   ),
                            // ),
                            SizedBox(width: 10),
                            Container(
                              height: size.height * .060,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    events![index].symbol!,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Price and Ratings Section
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Price Change Section
                          Container(
                            width: size.width * .40,
                            child: Text(events![index].type!),
                          ),
                          // Analyst Ratings Section
                          Text(
                            events![index].date!,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
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

// Dividend Tab
class DividendTab extends StatelessWidget {
  const DividendTab({super.key,required this.events});
  final List<Events>? events;

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
                padding: const EdgeInsets.only(left: 10),
                child: const Text(
                  "Company",
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
              width: size.width * .68,
              child: Row(
                children: [
                  const Text(
                    "Dividend Amount",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Color(0xff595959),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    width: size.width * .260,
                    child: Row(
                      children: [
                        const Text(
                          "Payment Date",
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
      itemCount: events!.length,
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 8, right: 16),
                child: Container(
                  height: size.height * .05,
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
                            // const CircleAvatar(
                            //   radius: 10,
                            //   backgroundImage: AssetImage(
                            //     'assets/flags/us.png',
                            //   ),
                            // ),
                            SizedBox(width: 10),
                            Container(
                              height: size.height * .060,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    events![index].symbol!,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Price and Ratings Section
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Price Change Section
                          Container(
                            width: size.width * .40,
                            child: Text(events![index].type!),
                          ),
                          // Analyst Ratings Section
                          Text(
                            events![index].date!,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
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
