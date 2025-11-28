import 'package:flutter/material.dart';

class HolidaysScreen extends StatefulWidget {
  const HolidaysScreen({super.key});

  @override
  State<HolidaysScreen> createState() => _HolidaysScreenState();
}

class _HolidaysScreenState extends State<HolidaysScreen> {
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
                  padding:  EdgeInsets.only(bottom: 8.0),
                  child: Column(
                    children: [
                      Container(
                        height: size.height * .080,
                        width: size.width * .9,
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
// Event Details
                              Container(
                                width: ((size.width * .9)/2),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "New Year’s Day",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Row(
                                      children: [
                                        Text(
                                          "Closed",
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Color(0xff595959),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 58),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.only(left: 18),
                                  child: Align(
                                    alignment: Alignment.topCenter,
                                    child: Row(
                                      children: [

                                        Text(
                                          "Apr 07, 2025",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xff595959),
                                          ),
                                        ),
                                        SizedBox(width: 4),
                                        ClipOval(
                                          child: Image.asset(
                                            'assets/images/usa_flag.png',
// Path to the local flag image
                                            width: 14,
                                            height: 14,
                                            fit: BoxFit.cover, // Ensures the image covers the circular area
                                          ),
                                        )

                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Divider(),
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
                            "Calender Year:",
                            style: TextStyle(
                              color: Color(0xff595959),
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


