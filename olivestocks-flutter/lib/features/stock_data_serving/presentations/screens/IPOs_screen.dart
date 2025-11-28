import 'package:flutter/material.dart';

class IPOsScreen extends StatefulWidget {
  const IPOsScreen({super.key});

  @override
  State<IPOsScreen> createState() => _IPOsScreenState();
}

class _IPOsScreenState extends State<IPOsScreen> {
  // Keep track of selected chips
  int selectedChipIndex = -1;
  String selectedMarket = "US";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return
      SafeArea(
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
                                    "Lianhe Sowell international Group Ltd (LHSW)",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: const [
                                      Text(
                                        "Price:",
                                        style: TextStyle(fontSize: 12, color: Colors.grey),
                                      ),
                                      Text(
                                        '\$4',
                                        style: TextStyle(fontSize: 12, color: Colors.black),
                                      ),
                                      Text('|'),
                                      Text(
                                        'Shares',
                                        style: TextStyle(fontSize: 12, color: Colors.grey),
                                      ),
                                      Text(
                                        '2M',
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
                                      Icon(Icons.message_rounded,color: Colors.green,size: 16,),
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
                        PopupMenuItem(value: "Priced", child: Text("Priced")),
                        PopupMenuItem(value: "Priced", child: Text("Priced")),
                        PopupMenuItem(value: "Priced", child: Text("Priced")),
                        PopupMenuItem(value: "Priced", child: Text("Priced")),
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
                        //horizontal: 3,
                        vertical: 8,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(width: 8),
                          Text(
                            "Status:",
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 10,
                            ),
                          ),
                      Text(
                        selectedMarket,
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 11,
                        ),
                      ),
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
              ],
            ),
          );
  }
}

