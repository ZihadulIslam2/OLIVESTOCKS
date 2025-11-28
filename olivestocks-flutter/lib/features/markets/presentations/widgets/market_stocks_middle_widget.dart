import 'package:flutter/material.dart';

class MarketStocksMiddleWidget extends StatefulWidget {
  const MarketStocksMiddleWidget({super.key});

  @override
  State<MarketStocksMiddleWidget> createState() =>
      _MarketStocksMiddleWidgetState();
}

class _MarketStocksMiddleWidgetState extends State<MarketStocksMiddleWidget>
    with SingleTickerProviderStateMixin {
  @override
  late TabController _tabController;

  // Only the dynamic data: estimate, actual, percent
  final List<List<String>> dynamicData = [
    ["\$5.058 (est)", "\$5.718", "0.99%"],
    ["\$4.97 (est)", "\$5.08", "2.21%"],
  ];

  // Static first column labels
  final List<String> labels = ["REV", "EPS"];

  initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  int selectedChipIndex = 0;
  List<String> tabs = ["Result", "Guidance Pro "];

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            width: double.infinity,

            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  constraints: BoxConstraints(minHeight: 70),
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: const BoxDecoration(
                    color: Color(0XFFBCE4C5),
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Q1 2025 Earnings',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Mar 12, 2025, 4:00 PM (PT)',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff737373),
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.calendar_month_outlined,
                          size: 24,
                          color: Color(0xff28A745),
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  height: 40,
                  width: double.infinity,
                  child: Center(
                    child: TabBar(
                      controller: _tabController,
                      isScrollable: false,
                      indicator: UnderlineTabIndicator(
                        borderSide: BorderSide(color: Colors.black, width: 2.0),
                      ),
                      labelPadding: const EdgeInsets.symmetric(horizontal: 8),
                      tabs:
                          tabs.asMap().entries.map((entry) {
                            final index = entry.key;
                            final title = entry.value;

                            if (title.contains("Pro")) {
                              return Tab(
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Guidance ',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color:
                                              _tabController.index == index
                                                  ? Colors.black
                                                  : Colors.grey,
                                        ),
                                      ),
                                      TextSpan(
                                        text: 'Pro',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.green, // Always green
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            } else {
                              return Tab(
                                child: Text(
                                  title,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color:
                                        _tabController.index == index
                                            ? Colors.black
                                            : Colors.grey,
                                  ),
                                ),
                              );
                            }
                          }).toList(),
                    ),
                  ),
                ),

                Container(
                  width: double.infinity,
                  height: 140,
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      EarningsTableWidget(),
                      Container(
                        color: Colors.green,
                        child: Text('Guidance Pro'),
                      ),
                    ],
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.play_arrow_outlined),
                    ),
                    Container(
                      width: size.width * .6,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Color(0xffCCCCCC),
                        borderRadius: BorderRadius.all(Radius.circular(32)),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/new_image/strarIcon.png',
                              height: 30,
                            ),
                            Text(
                              'AI Summary',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.green,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Image.asset(
                              'assets/new_image/prologo.png',
                              height: 30,
                            ),
                          ],
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Center(
                        child: Icon(Icons.arrow_drop_down_sharp, size: 30),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            width: double.infinity,

            decoration: BoxDecoration(
              color: Color(0xffF5F2FA),
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  constraints: BoxConstraints(minHeight: 70),
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: const BoxDecoration(
                    color: Color(0xffE2D9F1),
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Q2 2025',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Generated by AI, may be inaccurate',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff737373),
                            ),
                          ),
                        ],
                      ),
                      Image.asset('assets/new_image/strarIcon.png', height: 30),
                    ],
                  ),
                ),

                Container(
                  //  height: 40,
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 36),
                      Text(
                        "Summary of Adobe's Q1 FY '23 Earnings Conference Call",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "Positives:",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            textAlign: TextAlign.start,
                            '\u2022 ',
                            style: TextStyle(fontSize: 30),
                          ), // Bullet point
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Strong Financial Performance:  ",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        'Lorem ipsum is a dummy or placeholder text commonly used in graphic design, publishing, and web development. Lorem ipsum is a dummy or placeholder text commonly used in graphic design, publishing, and web development.',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            textAlign: TextAlign.start,
                            '\u2022 ',
                            style: TextStyle(fontSize: 30),
                          ), // Bullet point
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Growth in Digital Media:  ",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        'Lorem ipsum is a dummy or placeholder text commonly used in graphic design, publishing, and web development. Lorem ipsum is a dummy or placeholder text commonly used in graphic design, publishing, and web development.',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.play_arrow_outlined),
                    ),
                    Container(
                      width: size.width * .6,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Color(0xffCCCCCC),
                        borderRadius: BorderRadius.all(Radius.circular(32)),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Image.asset(
                            //   'assets/new_image/strarIcon.png',
                            //   height: 30,
                            // ),
                            Text(
                              'AI Summary',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Image.asset(
                              'assets/new_image/prologo.png',
                              height: 30,
                            ),
                          ],
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Center(
                        child: Icon(Icons.arrow_drop_down_sharp, size: 30),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            width: double.infinity,

            decoration: BoxDecoration(
              color: Color(0xffEAF3F9),
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  constraints: BoxConstraints(minHeight: 70),
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: const BoxDecoration(
                    color: Color(0xffC9D9E4),
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Q2 2025 Earnings in 87 Days',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          Row(
                            children: [
                              Text(
                                'Jan 12, 2025, 4:00 PM (PT)',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff737373),
                                ),
                              ),

                              Image.asset(
                                'assets/new_image/estimate_container.png',

                                height: 30,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Image.asset('assets/new_image/moon.png', height: 30),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  constraints: BoxConstraints(minHeight: 60),
                  width: double.infinity,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: const BoxDecoration(
                            color: Color(0xffC9D9E4),
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                          ),
                          child: Column(
                            children: [
                              Text(
                                'Revenue',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff656565),
                                ),
                              ),
                              Text(
                                "\$" + "5.88",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: const BoxDecoration(
                            color: Color(0xffC9D9E4),
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                          ),
                          child: Column(
                            children: [
                              Text(
                                'Revenue',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff656565),
                                ),
                              ),
                              Text(
                                "\$" + "5.88",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [Text('Upgrade to View Corporate Guidance')],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            width: double.infinity,

            decoration: BoxDecoration(
              color: Color(0xffE6E6E6),
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  constraints: BoxConstraints(minHeight: 70),
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: const BoxDecoration(
                    color: Color(0xffBFBFBF),
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Previous Earnings',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          // Row(
                          //   children: [
                          //     Text(
                          //       'Jan 12, 2025, 4:00 PM (PT)',
                          //       style: TextStyle(
                          //         fontSize: 12,
                          //         fontWeight: FontWeight.w500,
                          //         color: Color(0xff737373),
                          //       ),
                          //     ),

                          //     Image.asset(
                          //       'assets/new_image/estimate_container.png',

                          //       height: 30,
                          //     ),
                          //   ],
                          // ),
                        ],
                      ),

                      Image.asset(
                        'assets/new_image/Icon_clock .png',
                        height: 30,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                EarningsDropdownList(),

                // Container(
                //   constraints: BoxConstraints(minHeight: 60),
                //   width: double.infinity,
                //   child: Row(
                //     children: [
                //       Expanded(
                //         child: Container(
                //           padding: const EdgeInsets.symmetric(
                //             horizontal: 16,
                //             vertical: 8,
                //           ),
                //           decoration: const BoxDecoration(
                //             color: Color(0xffC9D9E4),
                //             borderRadius: BorderRadius.all(Radius.circular(16)),
                //           ),
                //           child: Column(
                //             children: [
                //               Text(
                //                 'Revenue',
                //                 style: TextStyle(
                //                   fontSize: 14,
                //                   fontWeight: FontWeight.w400,
                //                   color: Color(0xff656565),
                //                 ),
                //               ),
                //               Text(
                //                 "\$" + "5.88",
                //                 style: TextStyle(
                //                   fontSize: 18,
                //                   fontWeight: FontWeight.w600,
                //                   color: Colors.black,
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ),
                //       ),
                //       const SizedBox(width: 16),
                //       Expanded(
                //         child: Container(
                //           padding: const EdgeInsets.symmetric(
                //             horizontal: 16,
                //             vertical: 8,
                //           ),
                //           decoration: const BoxDecoration(
                //             color: Color(0xffC9D9E4),
                //             borderRadius: BorderRadius.all(Radius.circular(16)),
                //           ),
                //           child: Column(
                //             children: [
                //               Text(
                //                 'Revenue',
                //                 style: TextStyle(
                //                   fontSize: 14,
                //                   fontWeight: FontWeight.w400,
                //                   color: Color(0xff656565),
                //                 ),
                //               ),
                //               Text(
                //                 "\$" + "5.88",
                //                 style: TextStyle(
                //                   fontSize: 18,
                //                   fontWeight: FontWeight.w600,
                //                   color: Colors.black,
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                const SizedBox(height: 20),

                // Row(
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                //   children: [Text('Upgrade to View Corporate Guidance')],
                // ),
                // const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class EarningsTableWidget extends StatelessWidget {
  // Only the dynamic data: estimate, actual, percent
  final List<List<String>> dynamicData = [
    ["\$5.058 (est)", "\$5.718", "0.99%"],
    ["\$4.97 (est)", "\$5.08", "2.21%"],
  ];

  // Static first column labels
  final List<String> labels = ["REV", "EPS"];

  EarningsTableWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      color: const Color(0xffeaf6ec), // light green background
      child: Table(
        columnWidths: const {
          0: FlexColumnWidth(1.2), // Static label column
          1: FlexColumnWidth(2),
          2: FlexColumnWidth(2),
          3: FlexColumnWidth(1.5),
        },
        border: TableBorder(
          verticalInside: BorderSide(color: Colors.grey.shade400, width: 0.4),
          horizontalInside: BorderSide(color: Colors.grey, width: 0.2),
        ),
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: List.generate(labels.length, (index) {
          return TableRow(
            children: [
              _buildCell(labels[index], isBold: true),

              _buildCell(dynamicData[index][0]),
              _buildCell(dynamicData[index][1]),
              _buildCell(dynamicData[index][2], color: Colors.green),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildCell(String text, {bool isBold = false, Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: isBold ? FontWeight.w600 : FontWeight.normal,
          fontSize: 14,
          color: color ?? Colors.black87,
        ),
      ),
    );
  }
}

class PreviousEarningsDropdown extends StatefulWidget {
  const PreviousEarningsDropdown({super.key});

  @override
  State<PreviousEarningsDropdown> createState() =>
      _PreviousEarningsDropdownState();
}

class _PreviousEarningsDropdownState extends State<PreviousEarningsDropdown> {
  List<bool> _isExpanded = List.generate(
    6,
    (_) => false,
  ); // Expand state for each item

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          // Header with title and refresh icon
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    "Previous Earnings",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Icon(Icons.refresh),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // List of dropdown items
          Expanded(
            child: ListView.builder(
              itemCount: _isExpanded.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: ExpansionTile(
                    tilePadding: const EdgeInsets.symmetric(horizontal: 16),
                    title: const Text(
                      "Q3 2024",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: const Text(
                      "Dec 13, 2024, 4:00 PM (PT)",
                      style: TextStyle(fontSize: 13),
                    ),
                    trailing: Icon(
                      _isExpanded[index]
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                    ),
                    onExpansionChanged: (expanded) {
                      setState(() {
                        _isExpanded[index] = expanded;
                      });
                    },
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        width: double.infinity,
                        color: Colors.grey.shade200,
                        child: const Text(
                          "Earnings Details Here...",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          // "View More Earnings" button
          const SizedBox(height: 8),
          TextButton(
            onPressed: () {
              // Load more logic
            },
            child: const Text("View More Earnings"),
          ),
        ],
      ),
    );
  }
}

class EarningItem {
  final String quarter;
  final String dateTime;
  final String details;

  EarningItem({
    required this.quarter,
    required this.dateTime,
    required this.details,
  });
}

class EarningsDropdownList extends StatefulWidget {
  const EarningsDropdownList({super.key});

  @override
  State<EarningsDropdownList> createState() => _EarningsDropdownListState();
}

class _EarningsDropdownListState extends State<EarningsDropdownList> {
  final List<EarningItem> earnings = [
    EarningItem(
      quarter: "Q3 2024",
      dateTime: "Dec 13, 2024, 4:00 PM (PT)",
      details: "Revenue up by 12%, net profit margin stable.",
    ),
    EarningItem(
      quarter: "Q2 2024",
      dateTime: "Sep 10, 2024, 4:00 PM (PT)",
      details: "Slight dip in operating income, strong guidance.",
    ),
    EarningItem(
      quarter: "Q1 2024",
      dateTime: "Jun 5, 2024, 4:00 PM (PT)",
      details: "Record revenue in Q1 driven by new product launch.",
    ),
  ];

  late List<bool> _isExpanded;

  @override
  void initState() {
    super.initState();
    _isExpanded = List.filled(earnings.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // // Header
        // Container(
        //   padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        //   decoration: BoxDecoration(
        //     color: Colors.grey.shade300,
        //     borderRadius: BorderRadius.circular(8),
        //   ),
        //   child: Row(
        //     children: const [
        //       Expanded(
        //         child: Text(
        //           "Previous Earnings",
        //           style: TextStyle(fontWeight: FontWeight.bold),
        //         ),
        //       ),
        //       Icon(Icons.refresh),
        //     ],
        //   ),
        // ),
        const SizedBox(height: 8),

        // List
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: earnings.length,
          itemBuilder: (context, index) {
            final item = earnings[index];
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 4),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: ExpansionTile(
                tilePadding: const EdgeInsets.symmetric(horizontal: 16),
                title: Text(
                  item.quarter,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                subtitle: Text(
                  item.dateTime,
                  style: const TextStyle(fontSize: 13),
                ),
                trailing: Icon(
                  _isExpanded[index]
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                ),
                onExpansionChanged: (expanded) {
                  setState(() {
                    _isExpanded[index] = expanded;
                  });
                },
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    width: double.infinity,
                    color: Colors.grey.shade200,
                    child: Text(
                      item.details,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
            );
          },
        ),

        const SizedBox(height: 8),
        TextButton(
          onPressed: () {
            // Load more logic
          },
          child: const Text("View More Earnings"),
        ),
      ],
    );
  }
}
