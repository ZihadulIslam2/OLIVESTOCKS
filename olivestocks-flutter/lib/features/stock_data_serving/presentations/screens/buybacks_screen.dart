import 'package:flutter/material.dart';

class BuyBacksScreen extends StatefulWidget {
  const BuyBacksScreen({super.key});

  @override
  State<BuyBacksScreen> createState() => _BuyBacksScreenState();
}

class _BuyBacksScreenState extends State<BuyBacksScreen> {
  // Keep track of selected chips
  int selectedChipIndex = -1;
  String selectedMarket = "US";
  String selectedBenchmark = "Any";
  String selectedImpact = "Any";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 16,right: 16,bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Divider(),
            SizedBox(height: 8),
            // Dropdown Chips Row
            buildDropDownMenu(context),
            SizedBox(height: 8),
            Divider(),
            SizedBox(height: 8),
            // List of Events
            Expanded(
              child: buildListView(size),
            ),
          ],
        ),
      ),
    );
  }

  ListView buildListView(Size size) {
    return ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Column(
                    children: [
                      Container(
                        height: size.height * 0.12,
                        width: size.width * .9,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Event Details
                            SizedBox(
                              height: size.height * .2,
                              width: ((size.width * .9) / 2) + 30,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Acuity Brand Inc (AYI)",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: const [
                                      Text(
                                        "Buyback Amount:",
                                        style: TextStyle(fontSize: 12, color: Color(0xff595959)),
                                      ),
                                      Text(
                                        '\$16.07M',
                                        style: TextStyle(fontSize: 12, color: Colors.black),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text('Market Cap:',style: TextStyle(fontSize: 12, color: Color(0xff595959))),
                                      Text(
                                        '\$7.22B',
                                        style: TextStyle(fontSize: 12, color: Colors.black),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'EPS:',
                                        style: TextStyle(color: Color(0xff595959), fontSize: 12),
                                      ),
                                      Text(
                                        '\$3.73',
                                        style: TextStyle(color: Colors.black, fontSize: 12),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    'Period Ending: Feb 28,2025',
                                    style: TextStyle(color: Color(0xff595959), fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.only(left: 18),
                                child: Align(
                                  alignment: Alignment.topCenter,
                                  child: Row(
                                    children: [
                                      const Text(
                                        "Report on: ",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xff595959),
                                        ),
                                      ),
                                      Text('Apr 07,2025',style: TextStyle(fontSize: 12,)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(),
                    ],
                  ),
                );
              },
            );
  }

  SingleChildScrollView buildDropDownMenu(BuildContext context) {
    return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () async {
                    String? result = await showMenu<String>(
                      context: context,
                      position: RelativeRect.fromLTRB(100, 100, 100, 100),
                      items: [
                        PopupMenuItem(value: "High", child: Text("High")),
                        PopupMenuItem(
                          value: "Medium",
                          child: Text("Medium"),
                        ),
                        PopupMenuItem(value: "Low", child: Text("Low")),
                        PopupMenuItem(value: "Any", child: Text("Any")),
                      ],
                    );

                    if (result != null) {
                      setState(() {
                        selectedImpact = result;
                      });
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Container(
                      height: 32,
                      //margin: EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 2),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: 8,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(width: 8),
                          Text(
                            "Market Cap:",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                            ),
                          ),
                          SizedBox(width: 8),
                          Text(
                            selectedImpact,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
