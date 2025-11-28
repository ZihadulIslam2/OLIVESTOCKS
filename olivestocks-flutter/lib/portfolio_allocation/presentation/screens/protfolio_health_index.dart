import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:olive_stocks_flutter/portfolio_allocation/presentation/widgets/custom_circular_percent_widget.dart';

import '../../../features/auth/controllers/auth_controller.dart';
import '../../../features/portfolio/controller/portfolio_controller.dart';


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

  String formatDateTime(String isoDate) {
    try {
      final dateTime = DateTime.parse(isoDate).toLocal();
      return DateFormat('MMM d, y • h:mm a').format(dateTime);
    } catch (e) {
      return 'Invalid date';
    }
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);

    return GetBuilder<AuthController>(builder: (authController){
      return GetBuilder<PortfolioController>(builder: (portfolioController) {

        final metrics = portfolioController.assetAllocationResponseModel?.metrics;
        final performance = portfolioController.performanceResponseModel;
        final avgReturn = double.tryParse(
          performance.rankings!.averageReturn?.toString() ?? '0',
        ) ?? 0;

        String name = '';
        for (final portfolio in portfolioController.portfolios) {
          if (portfolio.id == portfolioController.selectedPortfolioId) {
            name = portfolio.name ?? '';
            break;
          }
        }

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back, color: Colors.black),
            ),
            title: const Text('Portfolio Health Index'),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(authController.getSingleUserResponseModel!.data!.profilePhoto ?? ''),
                            radius: 35,
                          ),
                          const SizedBox(width: 10),
                          Container(
                           width: size.width * .65,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  name,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,

                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Performance metrics and average returns of the transactions you specified ',
                                  style: TextStyle(
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
                          CustomCircularPercentWidget(
                            percent: performance.rankings?.successRate?.length ?? 0,
                            size: 100,
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
                            width: size.width * .3,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Center(
                                child:
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      avgReturn >= 0 ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                                      size: 30,
                                      color: avgReturn >= 0 ? Colors.green : Colors.red,
                                    ),
                                    Text(
                                      '\$${avgReturn.toStringAsFixed(2)}%',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: avgReturn >= 0 ? Colors.green : Colors.red,
                                      ),
                                    ),
                                  ],
                                )
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
                                  metrics!.beta!.toString(),
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
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     Text(
                        //       'Risk Profile:',
                        //       style: TextStyle(
                        //         fontWeight: FontWeight.w400,
                        //         fontSize: 12,
                        //       ),
                        //     ),
                        //     const SizedBox(width: 16),
                        //     _RiskShowLevel(isfill: false, levelName: 'Low'),
                        //     const SizedBox(width: 8),
                        //     _RiskShowLevel(isfill: true, levelName: 'Medium'),
                        //     const SizedBox(width: 8),
                        //     _RiskShowLevel(isfill: false, levelName: 'High'),
                        //   ],
                        // ),
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
                                  metrics.peRatio.toString(),
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

                                      metrics.dividendYield!,
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
                          height: size.height * .09,
                          width: size.width * .7,
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
                                    performance.mostProfitableTrade!.symbol ?? '',
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
                                    formatDateTime(performance.mostProfitableTrade!.openDate ?? ''),
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
                                    'Stock:',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    double.parse(performance.mostProfitableTrade!.gain ?? '0')
                                        .toStringAsFixed(2),
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.green,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Container(
                  //   width: size.width,
                  //   height: 170,
                  //   decoration: BoxDecoration(
                  //     color: Colors.grey.shade100,
                  //     borderRadius: BorderRadius.circular(16),
                  //   ),
                  //   child: Column(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       Text(
                  //         'Who can see my portfolio?',
                  //         style: TextStyle(
                  //           fontSize: 18,
                  //           fontWeight: FontWeight.w500,
                  //           color: Colors.black,
                  //         ),
                  //       ),
                  //       const SizedBox(height: 16),
                  //       Container(
                  //         height: 80,
                  //         width: double.infinity,
                  //         decoration: BoxDecoration(
                  //           color: Colors.white,
                  //           borderRadius: BorderRadius.circular(4),
                  //         ),
                  //         child: Center(
                  //           child: Row(
                  //             mainAxisAlignment: MainAxisAlignment.center,
                  //             crossAxisAlignment: CrossAxisAlignment.center,
                  //             children: [
                  //               // Icon(
                  //               //   Icons.arrow_drop_down,
                  //               //   size: 30,
                  //               //   color: Colors.green,
                  //               // ),
                  //               Column(
                  //                 mainAxisSize: MainAxisSize.min,
                  //                 children: [
                  //                   SizedBox(
                  //                     height: 30,
                  //                     child: Row(
                  //                       children: [
                  //                         Radio(
                  //                           value: 'buy',
                  //                           fillColor:
                  //                           MaterialStateProperty.resolveWith<
                  //                               Color
                  //                           >((Set<MaterialState> states) {
                  //                             if (states.contains(
                  //                               MaterialState.selected,
                  //                             )) {
                  //                               return Colors
                  //                                   .green; // when selected
                  //                             }
                  //                             return Colors
                  //                                 .green; // when not selected
                  //                           }),
                  //                           groupValue: transactionType,
                  //                           onChanged: (value) {
                  //                             setState(() {
                  //                               transactionType = value!;
                  //                             });
                  //                           },
                  //                         ),
                  //                         Image.asset('assets/new_image/globe.png'),
                  //                         const SizedBox(width: 4),
                  //                         Text(
                  //                           'Everyone',
                  //                           style: TextStyle(
                  //                             fontSize: 14,
                  //                             fontWeight: FontWeight.w500,
                  //                             color: Colors.green,
                  //                           ),
                  //                         ),
                  //                       ],
                  //                     ),
                  //                   ),
                  //
                  //                   SizedBox(
                  //                     height: 30,
                  //                     child: Row(
                  //                       children: [
                  //                         Radio(
                  //                           fillColor:
                  //                           MaterialStateProperty.resolveWith<
                  //                               Color
                  //                           >((Set<MaterialState> states) {
                  //                             if (states.contains(
                  //                               MaterialState.selected,
                  //                             )) {
                  //                               return Colors
                  //                                   .red; // when selected
                  //                             }
                  //                             return Colors
                  //                                 .red; // when not selected
                  //                           }),
                  //                           value: 'sell',
                  //                           groupValue: transactionType,
                  //                           onChanged: (value) {
                  //                             setState(() {
                  //                               transactionType = value!;
                  //                             });
                  //                           },
                  //                         ),
                  //                         Image.asset('assets/new_image/lock.png'),
                  //                         const SizedBox(width: 10),
                  //                         Text(
                  //                           'Only Me',
                  //                           style: TextStyle(
                  //                             fontSize: 14,
                  //                             fontWeight: FontWeight.w500,
                  //                             color: Colors.red,
                  //                           ),
                  //                         ),
                  //                       ],
                  //                     ),
                  //                   ),
                  //                 ],
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        );
      });
    });
    }
}

