import 'package:flutter/material.dart';

class StockSplitsScreen extends StatefulWidget {
  const StockSplitsScreen({super.key});

  @override
  State<StockSplitsScreen> createState() => _StockSplitsScreenState();
}

class _StockSplitsScreenState extends State<StockSplitsScreen> {
  // Keep track of selected chips
  int selectedChipIndex = -1;
  String selectedMarket = "US";
  String selectedPeriod = "Any";
  String selectedType = "Any";

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
            //List of Events
            Expanded(
              child: buildListView(size),
            ),
          ],
        ),
      ),
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
                        PopupMenuItem(value: "US", child: Text("US")),
                        PopupMenuItem(value: "UK", child: Text("UK")),
                        PopupMenuItem(value: "EU", child: Text("EU")),
                        PopupMenuItem(value: "Asia", child: Text("Asia")),
                      ],
                    );

                    if (result != null) {
                      setState(() {
                        selectedMarket = result;
                      });
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Container(
                      height: 32,
                      //margin: EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.green, width: 2),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 3,
                        vertical: 8,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(width: 8),
                          Text(
                            "Market",
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 10,
                            ),
                          ),
                          SizedBox(width: 8),
                          Image.asset(
                            'assets/images/usa_flag.png',
                            // Path to the local flag image
                            width: 18,
                            height: 18,
                          ),
                          SizedBox(width: 4),
                          Text(
                            selectedMarket,
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 10,
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(
                            Icons.arrow_drop_down,
                            color: Colors.green,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    String? result = await showMenu<String>(
                      context: context,
                      position: RelativeRect.fromLTRB(100, 100, 100, 100),
                      items: [
                        PopupMenuItem(value: "Upcoming", child: Text("Upcoming")),
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
                        selectedPeriod = result;
                      });
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Container(
                      height: 32,
                      //margin: EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.green, width: 2),
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
                            "Period:",
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 10,
                            ),
                          ),
                          SizedBox(width: 8),
                          Text(
                            selectedPeriod,
                            style: TextStyle(
                              color: Colors.green,
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
                        selectedType = result;
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
                            "Type:",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                            ),
                          ),
                          SizedBox(width: 8),
                          Text(
                            selectedType,
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

  ListView buildListView(Size size) {
    return ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Column(
                    children: [
                      Container(
                        height: size.height * .080,
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
                                    "Newegg Commerce, Inc,(NEGG)",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: const [
                                      Text(
                                        "Type:",
                                        style: TextStyle(fontSize: 12, color: Colors.grey),
                                      ),
                                      Text(
                                        'Reverse',
                                        style: TextStyle(fontSize: 12, color: Color(0xffC863D1)),
                                      ),
                                      Text('|'),
                                      Text(
                                        'Split Ratio:',
                                        style: TextStyle(fontSize: 12, color: Colors.grey),
                                      ),
                                      Text(
                                        '1 for 20.00',
                                        style: TextStyle(color: Colors.black, fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.only(left: 18),
                                child: Align(
                                  alignment: Alignment.topCenter,
                                  child: Row(
                                    children: [
                                      const Text(
                                        "Apr 07, 2025",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xff595959),
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      ClipOval(
                                        child: Image.asset(
                                          'assets/images/usa_flag.png',
                                          width: 14,
                                          height: 14,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
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
}
