import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import '../../../../common/widgets/default_circular_percent_widget.dart';

class ProtfolioHealthIndex extends StatefulWidget {
  const ProtfolioHealthIndex({super.key});

  @override
  State<ProtfolioHealthIndex> createState() => _ProtfolioHealthIndexState();
}

class _ProtfolioHealthIndexState extends State<ProtfolioHealthIndex> {
  int selectedValue = 0;
  int selectedValueTocompareToMarkets = 0;
  String transactionType = 'buy';

  final List<Map<String, dynamic>> items = [
    {'label': 'Showing Report by me', 'value': 0},
    {'label': 'Item 2', 'value': 1},
    {'label': 'Item 3', 'value': 2},
  ];
  final List<Map<String, dynamic>> itemsTocompareToMarkets = [
    {'label': 'S&P 500', 'value': 0},
    {'label': 'Average Portfolio', 'value': 1},
    {'label': 'Best Performing', 'value': 2},
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.black),
        ),
        title: const Text('Protfolio Health Index'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Align(
              //   alignment: Alignment.topLeft,
              //   child: Container(
              //     // width: double.infinity,
              //     decoration: BoxDecoration(
              //       border: Border.all(
              //         color: Colors.blue,
              //         width: 1.5,
              //       ), // <-- Border color here
              //       borderRadius: BorderRadius.circular(8),
              //     ),
              //     child: DropdownMenu<int>(
              //       width: 200,
              //       initialSelection: 1,
              //       onSelected: (int? value) {
              //         if (value != null) {
              //           dropdownValue = value;
              //           setState(() {});
              //         }
              //       },
              //       dropdownMenuEntries: [
              //         DropdownMenuEntry(label: 'Showing Report by me', value: 0),
              //         DropdownMenuEntry(label: 'Item 2', value: 1),
              //         DropdownMenuEntry(label: 'Item 3', value: 2),
              //       ],
              //     ),
              //   ),
              // ),
              Container(
                height: 38,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.green, width: 1.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2<int>(
                    isExpanded: false,
                    value: selectedValueTocompareToMarkets,
                    items:
                        items
                            .map(
                              (item) => DropdownMenuItem<int>(
                                value: item['value'],
                                child: Text(
                                  item['label'],
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                    onChanged: (int? value) {
                      if (value != null) {
                        setState(() {
                          selectedValueTocompareToMarkets = value;
                        });
                      }
                    },
                    buttonStyleData: const ButtonStyleData(
                      height: 36,
                      padding: EdgeInsets.symmetric(horizontal: 8),
                    ),
                    iconStyleData: const IconStyleData(
                      icon: Icon(Icons.keyboard_arrow_down_rounded),
                      iconSize: 18,
                      iconEnabledColor: Colors.green,
                    ),
                    dropdownStyleData: DropdownStyleData(
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                      ),
                      offset: const Offset(0, 4),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 32),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage(
                          'assets/new_image/profile.jpg',
                        ),
                        radius: 30,
                      ),
                      const SizedBox(width: 10),
                      Container(
                        width: size.width - 110,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              maxLines: 2,
                              'User Name - New Portfolio',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              maxLines: 5,
                              'Performance metrics and average returns of the transactions you specified ',
                              style: TextStyle(
                                fontSize: 12,
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
              const SizedBox(height: 32),
              Text(
                'Stock Picking Performance',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              Container(
                width: size.width,

                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        'Success Rate',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 16),
                      CircularPercentWidget(percent: 33,  selectedSortTab: 10,),
                      const SizedBox(height: 16),
                      Text(
                        '1 out of 3 profitable transactions',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 36),
                      Container(
                        width: size.width,
                        height: 4,
                        color: Color(0xff28A745),
                      ),
                      const SizedBox(height: 36),
                      Text(
                        'Average Return',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        height: 33,
                        width: 88,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.arrow_drop_down,
                                size: 30,
                                color: Colors.green,
                              ),
                              Text(
                                '3.02%',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Average Return per transaction',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Text(
                'Performance is evaluated based on the end-of-day stock prices relative to the portfolio.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              Container(
                width: size.width,
                height: 350,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Card(
                    margin: EdgeInsets.all(12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Measured Performance (6M)',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            'Compared to Markets',
                            style: TextStyle(fontSize: 14),
                          ),
                          SizedBox(height: 8),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              height: 38,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                border: Border.all(
                                  color: Colors.green,
                                  width: 1.2,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton2<int>(
                                  isExpanded: false,
                                  value: selectedValue,
                                  items:
                                      itemsTocompareToMarkets
                                          .map(
                                            (
                                              itemsTocompareToMarkets,
                                            ) => DropdownMenuItem<int>(
                                              value:
                                                  itemsTocompareToMarkets['value'],
                                              child: Text(
                                                itemsTocompareToMarkets['label'],
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          )
                                          .toList(),
                                  onChanged: (int? value) {
                                    if (value != null) {
                                      setState(() {
                                        selectedValue = value;
                                      });
                                    }
                                  },
                                  buttonStyleData: const ButtonStyleData(
                                    height: 36,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8,
                                    ),
                                  ),
                                  iconStyleData: const IconStyleData(
                                    icon: Icon(
                                      Icons.keyboard_arrow_down_rounded,
                                    ),
                                    iconSize: 18,
                                    iconEnabledColor: Colors.white,
                                  ),
                                  dropdownStyleData: DropdownStyleData(
                                    width: 200,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.green,
                                    ),
                                    offset: const Offset(0, 4),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 12),
                          SizedBox(
                            height: 180,
                            child: BarChart(
                              BarChartData(
                                alignment: BarChartAlignment.spaceAround,
                                maxY: 7,
                                minY: -5,
                                groupsSpace: 16,
                                barTouchData: BarTouchData(enabled: false),
                                titlesData: FlTitlesData(
                                  leftTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: true,
                                      reservedSize: 30,
                                      getTitlesWidget: (value, meta) {
                                        return Text(
                                          '${value.toInt()}%',
                                          style: TextStyle(fontSize: 10),
                                        );
                                      },
                                      interval: 3,
                                    ),
                                  ),
                                  bottomTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: true,
                                      getTitlesWidget: (value, meta) {
                                        return Text(
                                          'Jan 25',
                                          style: TextStyle(fontSize: 10),
                                        );
                                      },
                                    ),
                                  ),
                                  rightTitles: AxisTitles(
                                    sideTitles: SideTitles(showTitles: false),
                                  ),
                                  topTitles: AxisTitles(
                                    sideTitles: SideTitles(showTitles: false),
                                  ),
                                ),
                                gridData: FlGridData(
                                  show: true,
                                  drawHorizontalLine: true,
                                  drawVerticalLine: false,
                                ),
                                borderData: FlBorderData(
                                  show: true,
                                  border: Border.all(
                                    color: Colors.grey.shade300,
                                  ),
                                ),
                                barGroups: [
                                  makeGroupData(0, 5, -2),
                                  makeGroupData(1, 6, -4),
                                  makeGroupData(2, -3, 3),
                                  makeGroupData(3, -4, 2),
                                  makeGroupData(4, 2, 3),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                width: size.width,
                padding: const EdgeInsets.all(16),
                height: 170,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Portfolio Risk (Beta)',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Container(
                      height: 33,
                      width: 88,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Icon(
                            //   Icons.arrow_drop_down,
                            //   size: 30,
                            //   color: Colors.green,
                            // ),
                            Text(
                              '1.1',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // const SizedBox(height: 36),
                    Container(
                      width: size.width,
                      height: 3,
                      color: Color(0xff28A745),
                    ),
                    // const SizedBox(height: 36),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Risk Profile:',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(width: 16),
                        _RiskShowLevel(isfill: false, levelName: 'Low'),
                        const SizedBox(width: 8),
                        _RiskShowLevel(isfill: true, levelName: 'Medium'),
                        const SizedBox(width: 8),
                        _RiskShowLevel(isfill: false, levelName: 'High'),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Container(
                width: size.width,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Portfolio p/E Ratio',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Container(
                      height: 33,
                      width: 88,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Icon(
                            //   Icons.arrow_drop_down,
                            //   size: 30,
                            //   color: Colors.green,
                            // ),
                            Text(
                              '31.82',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Container(
                width: size.width,
                height: 140,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Portfolio Dividends',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Container(
                      height: 60,
                      width: 130,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Icon(
                            //   Icons.arrow_drop_down,
                            //   size: 30,
                            //   color: Colors.green,
                            // ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Devidend Yield',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  '31.82',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Container(
                width: size.width,
                height: 170,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Best Trade',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      height: 80,
                      width: 210,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Stock:',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'Apple',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '(AAPL)',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Date Opened:',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'Apr 15, 2025',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Stock:',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '+0.69%',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Container(
                width: size.width,
                height: 170,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Who can see my portfolio?',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      height: 80,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Icon(
                            //   Icons.arrow_drop_down,
                            //   size: 30,
                            //   color: Colors.green,
                            // ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  height: 30,
                                  child: Row(
                                    children: [
                                      Radio(
                                        value: 'buy',
                                        fillColor:
                                            MaterialStateProperty.resolveWith<
                                              Color
                                            >((Set<MaterialState> states) {
                                              if (states.contains(
                                                MaterialState.selected,
                                              )) {
                                                return Colors
                                                    .green; // when selected
                                              }
                                              return Colors
                                                  .green; // when not selected
                                            }),
                                        groupValue: transactionType,
                                        onChanged: (value) {
                                          setState(() {
                                            transactionType = value!;
                                          });
                                        },
                                      ),
                                      Image.asset('assets/new_image/globe.png'),
                                      const SizedBox(width: 4),
                                      Text(
                                        'Everyone',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.green,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                SizedBox(
                                  height: 30,
                                  child: Row(
                                    children: [
                                      Radio(
                                        fillColor:
                                            MaterialStateProperty.resolveWith<
                                              Color
                                            >((Set<MaterialState> states) {
                                              if (states.contains(
                                                MaterialState.selected,
                                              )) {
                                                return Colors
                                                    .red; // when selected
                                              }
                                              return Colors
                                                  .red; // when not selected
                                            }),
                                        value: 'sell',
                                        groupValue: transactionType,
                                        onChanged: (value) {
                                          setState(() {
                                            transactionType = value!;
                                          });
                                        },
                                      ),
                                      Image.asset('assets/new_image/lock.png'),
                                      const SizedBox(width: 10),
                                      Text(
                                        'Only Me',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.red,
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RiskShowLevel extends StatelessWidget {
  final bool isfill;
  final String levelName;

  const _RiskShowLevel({
    super.key,
    required this.isfill,
    required this.levelName,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 8,
          width: 8,
          decoration: BoxDecoration(
            color: isfill ? Colors.green : Colors.white,
            shape: BoxShape.circle,
            border: Border.all(
              color: isfill ? Colors.white : Colors.grey.shade300,
              width: 1,
            ),
          ),
        ),
        const SizedBox(width: 4),
        Text(
          levelName,
          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
        ),
      ],
    );
  }
}

BarChartGroupData makeGroupData(int x, double y1, double y2) {
  return BarChartGroupData(
    x: x,
    barRods: [
      BarChartRodData(
        toY: y1,
        color: Colors.green,
        width: 8,
        borderRadius: BorderRadius.zero,
      ),
      BarChartRodData(
        toY: y2,
        color: Colors.blue,
        width: 8,
        borderRadius: BorderRadius.zero,
      ),
    ],
  );
}
