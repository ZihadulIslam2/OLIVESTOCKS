import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'filter_screen.dart';

class ETFScreen extends StatefulWidget {
  const ETFScreen({super.key});

  @override
  _ETFScreenState createState() => _ETFScreenState();
}

class _ETFScreenState extends State<ETFScreen> {
  int selectedChipIndex = -1;
  String selectedMarket = "US";
  String selectedBenchmark = "Any";
  String selectedImpact = "Any";

  final List<Map<String, dynamic>> cryptoData = [
    {
      "symbol": "VOO",
      "logo": "assets/logos/voo.png",
      "ETF name": "Vanguard S&P 500ETF",
      "AUM": "+\$598.65B",
    },
    {
      "symbol": "SPY",
      "logo": "assets/logos/spy.png",
      "ETF name": "SPDR S&P 500ETF",
      "AUM": "+\$598.65B",
    },
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAppBar(),
            _buildDescriptionText(),
            const SizedBox(height: 8),
            Divider(height: 2,color: Color(0xff595959),),
            const SizedBox(height: 8),
            buildDropDownMenu(context),
            SizedBox(height: 8),
            Divider(height: 2,color: Color(0xff595959),),
            const SizedBox(height: 16),
            Divider(height: 2,color: Color(0xff595959),),
            _buildHeaderRow(),
            Divider(height: 2,color: Color(0xff595959),),
            Expanded(child: _buildCryptoListView()),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      elevation: 4.0,
      shadowColor: Colors.black,
      title: Row(
        children: [
          Text(
            'ETF Screener',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Spacer(),
          IconButton(
            onPressed: () {
              Get.to(FilterScreen());
            },
            icon: Container(
                height: 24,
                width: 24,
                child: Image.asset('assets/logos/filtericon.png')),
          ),
        ],
      ),
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(Icons.keyboard_backspace, color: Colors.black),
      ),
    );
  }

  Widget _buildDescriptionText() {
    return Container(
      padding: const EdgeInsets.all(13),
      child: const Text(
        "Displaying 4450 filtered Results",
        style: TextStyle(
          fontSize: 14,
          color: Color(0xff595959),
          fontWeight: FontWeight.w500,
          height: 2,
        ),
      ),
    );
  }

  // Widget _buildFilterRow(BuildContext context) {
  //   return SingleChildScrollView(
  //     scrollDirection: Axis.horizontal,
  //     child: ConstrainedBox(
  //       constraints: BoxConstraints(
  //         minWidth: MediaQuery.of(context).size.width,
  //       ),
  //       child: Padding(
  //         padding: const EdgeInsets.symmetric(horizontal: 16),
  //         child: Row(
  //           children: [
  //             _buildFilterChip(
  //               label: "Market",
  //               value: selectedMarket,
  //               icon: Image.asset(
  //                 'assets/images/usa_flag.png',
  //                 width: 12,
  //                 height: 9,
  //               ),
  //               onTap: () => _showMarketMenu(context),
  //               isGreen: true,
  //             ),
  //             const SizedBox(width: 8),
  //             _buildFilterChip(
  //               label: "SmartScore:",
  //               value: selectedBenchmark,
  //               onTap: () => _showSmartScoreMenu(context),
  //               isGreen: true,
  //             ),
  //             const SizedBox(width: 8),
  //             _buildFilterChip(
  //               label: "AUM:",
  //               value: selectedImpact,
  //               onTap: () => _showAUMMenu(context),
  //               isGreen: false,
  //             ),
  //             const SizedBox(width: 8),
  //             _buildFilterChip(
  //               label: "Price:",
  //               value: selectedImpact,
  //               onTap: () => _showPriceMenu(context),
  //               isGreen: false,
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

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
                        fontSize: 11,
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
                        fontSize: 11,
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
                  border: Border.all(color: Color(0xff595959), width: 2),
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
                      "Smart Score:",
                      style: TextStyle(
                        color: Color(0xff595959),
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      selectedMarket,
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 11,
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: 8),
                    Text(
                      "AUM:",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 11,
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      selectedImpact,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 11,
                      ),
                    ),
                    SizedBox(width: 8),
                    Center(
                      child: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black,
                        size: 20,
                      ),
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: 8),
                    Text(
                      "Price:",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 11,
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      selectedImpact,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 11,
                      ),
                    ),
                    SizedBox(width: 8),
                    Center(
                      child: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black,
                        size: 20,
                      ),
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
  // Widget _buildFilterChip({
  //   required String label,
  //   required String value,
  //   Widget? icon,
  //   String? badge,
  //   required Function() onTap,
  //   required bool isGreen,
  // }) {
  //   return GestureDetector(
  //     onTap: onTap,
  //     child: Container(
  //       height: 32,
  //       decoration: BoxDecoration(
  //         border: Border.all(
  //           color: isGreen ? Colors.green : Colors.grey,
  //           width: 2,
  //         ),
  //         borderRadius: BorderRadius.circular(30),
  //       ),
  //       padding: const EdgeInsets.symmetric(horizontal: 8),
  //       child: Row(
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           Text(
  //             label,
  //             style: TextStyle(
  //               color: isGreen ? Colors.green : Colors.black,
  //               fontSize: 11,
  //             ),
  //           ),
  //           if (icon != null) ...[const SizedBox(width: 4), icon],
  //           if (badge != null) ...[
  //             const SizedBox(width: 4),
  //             Container(
  //               width: 15,
  //               height: 15,
  //               decoration: BoxDecoration(
  //                 color: Colors.green,
  //                 shape: BoxShape.circle,
  //               ),
  //               child: Center(
  //                 child: Text(
  //                   badge,
  //                   style: const TextStyle(color: Colors.white, fontSize: 8),
  //                 ),
  //               ),
  //             ),
  //           ],
  //           const SizedBox(width: 4),
  //           Text(
  //             value,
  //             style: TextStyle(
  //               color: isGreen ? Colors.green : Colors.black,
  //               fontSize: 11,
  //             ),
  //           ),
  //           const SizedBox(width: 4),
  //           Icon(
  //             Icons.arrow_drop_down,
  //             color: isGreen ? Colors.green : Colors.black,
  //             size: 20,
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget _buildHeaderRow() {
    return Row(
      children: [
        Container(
          width: 136,
          height: 32,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                offset: const Offset(0, 2),
                blurRadius: 10,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Symbol",
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xff595959),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        const Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: 8),
            child: Center(
              child: Text(
                "ETF Name",
                style: TextStyle(fontSize: 12,color: Color(0xff595959),fontWeight: FontWeight.w400),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 60,
          child: Center(
            child: Text(
              "AUM",
              style: TextStyle(fontSize: 12,color: Color(0xff595959),fontWeight: FontWeight.w400),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCryptoListView() {
    return ListView.separated(
      padding: EdgeInsets.zero,
      itemCount: cryptoData.length * 10,
      separatorBuilder: (_, __) => const Divider(height: 1, thickness: 0.5),
      itemBuilder: (context, index) {
        return _buildCryptoRow(cryptoData[index % cryptoData.length]);
      },
    );
  }

  Widget _buildCryptoRow(Map<String, dynamic> data) {
    Size size = MediaQuery.of(context).size;

    return SizedBox(
      height: 40,
      child: Row(
        children: [
          // Symbol and name column
          Container(
            width: 136,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  offset: const Offset(0, 2),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Row(
              children: [
                Image.asset(
                  data["logo"],
                  width: 24,
                  height: 24,
                  errorBuilder:
                      (context, error, stackTrace) =>
                          const Icon(Icons.error, size: 20),
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data["symbol"],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Price and change column
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    data["ETF name"],
                    style: TextStyle(fontSize: 12,color: Color(0xff595959),fontWeight: FontWeight.w400),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 4),
              ],
            ),
          ),
          // Volume column
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: size.width * 0.15,
              child: Center(
                child: Text(
                  "\$598.65B",
                  style: TextStyle(fontSize: 12,color: Color(0xff595959),fontWeight: FontWeight.w400),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showMarketMenu(BuildContext context) async {
    final result = await showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(100, 100, 100, 100),
      items: const [
        PopupMenuItem(value: "US", child: Text("US")),
        PopupMenuItem(value: "UK", child: Text("UK")),
        PopupMenuItem(value: "EU", child: Text("EU")),
        PopupMenuItem(value: "Asia", child: Text("Asia")),
      ],
    );

    if (result != null) {
      setState(() => selectedMarket = result);
    }
  }

  Future<void> _showSmartScoreMenu(BuildContext context) async {
    final result = await showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(100, 100, 100, 100),
      items: const [
        PopupMenuItem(value: "US", child: Text("US")),
        PopupMenuItem(value: "UK", child: Text("UK")),
        PopupMenuItem(value: "EU", child: Text("EU")),
        PopupMenuItem(value: "Asia", child: Text("Asia")),
      ],
    );

    if (result != null) {
      setState(() => selectedMarket = result);
    }
  }

  Future<void> _showAUMMenu(BuildContext context) async {
    final result = await showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(100, 100, 100, 100),
      items: const [
        PopupMenuItem(value: "High", child: Text("High")),
        PopupMenuItem(value: "Medium", child: Text("Medium")),
        PopupMenuItem(value: "Low", child: Text("Low")),
        PopupMenuItem(value: "Any", child: Text("Any")),
      ],
    );

    if (result != null) {
      setState(() => selectedImpact = result);
    }
  }

  Future<void> _showPriceMenu(BuildContext context) async {
    final result = await showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(100, 100, 100, 100),
      items: const [
        PopupMenuItem(value: "High", child: Text("High")),
        PopupMenuItem(value: "Medium", child: Text("Medium")),
        PopupMenuItem(value: "Low", child: Text("Low")),
        PopupMenuItem(value: "Any", child: Text("Any")),
      ],
    );

    if (result != null) {
      setState(() => selectedImpact = result);
    }
  }
}
