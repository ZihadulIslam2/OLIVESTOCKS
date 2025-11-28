import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../experts/presentations/widgets/top_lock_widget.dart';
import '../widgets/dividendLinearProgressWidget.dart';


class DividendAristocrats extends StatelessWidget {
  final ScrollController horizontalScrollController;

  DividendAristocrats({super.key, required this.horizontalScrollController});

  static const List<Map<String, dynamic>> stockData = [
    {
      "symbol": "BTC",
      "name": "Bitcoin",
      "logo": "assets/logos/btc.png",
      "dividend": "3.5%",
      "yield": "2.02%",
      "btarget": DividendLinearPercentIndicator(
        percent: 0.70,
      ),
      "atarget": "\$16.55\n  ▲27.27% (Upside)",
      "smart score": "assets/logos/10.svg",
      "market cap": "\$151.5B",
      "yearly gain": "-4.7%",
    },
    {
      "symbol": "TONCOIN",
      "name": "Toncoin",
      "logo": "assets/logos/toncoin.png",
      "dividend": "3.5%",
      "yield": "2.02%",
      "btarget": DividendLinearPercentIndicator(
        percent: 0.70,
      ),
      "atarget": "\$16.55\n  ▲27.27% (Upside)",
      "smart score": "assets/logos/10.svg",
      "market cap": "\$151.5B",
      "yearly gain": "-4.7%",
    },
    {
      "symbol": "TONCOIN",
      "name": "Toncoin",
      "logo": "assets/logos/toncoin2.png",
      "dividend": "3.5%",
      "yield": "2.02%",
      "btarget": DividendLinearPercentIndicator(
        percent: 0.70,
      ),
      "atarget": "\$16.55\n  ▲27.27% (Upside)",
      "smart score": "assets/logos/10.svg",
      "market cap": "\$151.5B",
      "yearly gain": "-4.7%",
    },
    {
      "symbol": "BTC",
      "name": "Bitcoin",
      "logo": "assets/logos/btc.png",
      "dividend": "3.5%",
      "yield": "2.02%",
      "btarget": DividendLinearPercentIndicator(
        percent: 0.70,
      ),
      "atarget": "\$16.55\n  ▲27.27% (Upside)",
      "smart score": "assets/logos/10.svg",
      "market cap": "\$151.5B",
      "yearly gain": "-4.7%",
    },
    {
      "symbol": "TONCOIN",
      "name": "Toncoin",
      "logo": "assets/logos/toncoin.png",
      "dividend": "3.5%",
      "yield": "2.02%",
      "btarget": DividendLinearPercentIndicator(
        percent: 0.70,
      ),
      "atarget": "\$16.55\n  ▲27.27% (Upside)",
      "smart score": "assets/logos/10.svg",
      "market cap": "\$151.5B",
      "yearly gain": "-4.7%",
    },
    {
      "symbol": "TONCOIN",
      "name": "Toncoin",
      "logo": "assets/logos/toncoin2.png",
      "dividend": "3.5%",
      "yield": "2.02%",
      "btarget": DividendLinearPercentIndicator(
        percent: 0.70,
      ),
      "atarget": "\$16.55\n  ▲27.27% (Upside)",
      "smart score": "assets/logos/10.svg",
      "market cap": "\$151.5B",
      "yearly gain": "-4.7%",
    },
    {
      "symbol": "BTC",
      "name": "Bitcoin",
      "logo": "assets/logos/btc.png",
      "dividend": "3.5%",
      "yield": "2.02%",
      "btarget": DividendLinearPercentIndicator(
        percent: 0.70,
      ),
      "atarget": "\$16.55\n  ▲27.27% (Upside)",
      "smart score": "assets/logos/10.svg",
      "market cap": "\$151.5B",
      "yearly gain": "-4.7%",
    },
    {
      "symbol": "TONCOIN",
      "name": "Toncoin",
      "logo": "assets/logos/toncoin.png",
      "dividend": "3.5%",
      "yield": "2.02%",
      "btarget": DividendLinearPercentIndicator(
        percent: 0.70,
      ),
      "atarget": "\$16.55\n  ▲27.27% (Upside)",
      "smart score": "assets/logos/10.svg",
      "market cap": "\$151.5B",
      "yearly gain": "-4.7%",
    },
    {
      "symbol": "TONCOIN",
      "name": "Toncoin",
      "logo": "assets/logos/toncoin2.png",
      "dividend": "3.5%",
      "yield": "2.02%",
      "btarget": DividendLinearPercentIndicator(
        percent: 0.70,
      ),
      "atarget": "\$16.55\n  ▲27.27% (Upside)",
      "smart score": "assets/logos/10.svg",
      "market cap": "\$151.5B",
      "yearly gain": "-4.7%",
    },
    {
      "symbol": "BTC",
      "name": "Bitcoin",
      "logo": "assets/logos/btc.png",
      "dividend": "3.5%",
      "yield": "2.02%",
      "btarget": DividendLinearPercentIndicator(
        percent: 0.70,
      ),
      "atarget": "\$16.55\n  ▲27.27% (Upside)",
      "smart score": "assets/logos/10.svg",
      "market cap": "\$151.5B",
      "yearly gain": "-4.7%",
    },
    {
      "symbol": "TONCOIN",
      "name": "Toncoin",
      "logo": "assets/logos/toncoin.png",
      "dividend": "3.5%",
      "yield": "2.02%",
      "btarget": DividendLinearPercentIndicator(
        percent: 0.70,
      ),
      "atarget": "\$16.55\n  ▲27.27% (Upside)",
      "smart score": "assets/logos/10.svg",
      "market cap": "\$151.5B",
      "yearly gain": "-4.7%",
    },
    {
      "symbol": "TONCOIN",
      "name": "Toncoin",
      "logo": "assets/logos/toncoin2.png",
      "dividend": "3.5%",
      "yield": "2.02%",
      "btarget": DividendLinearPercentIndicator(
        percent: 0.70,
      ),
      "atarget": "\$16.55\n  ▲27.27% (Upside)",
      "smart score": "assets/logos/10.svg",
      "market cap": "\$151.5B",
      "yearly gain": "-4.7%",
    },

  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: 800,
      // height: stockData.length * 63,
      child: Column(children: [_buildScrollableTable(context)]),
    );
  }

  Widget _buildScrollableTable(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 136,
          child: IntrinsicHeight(
            child: Column(
              children: [
                Container(
                  width: 136,
                  height: 31,
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
                  child: Center(
                    child: const Text(
                      "Symbol",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),

                Container(color: Color(0xffB0B0B0), height: 2,width: 700,),
                Expanded(
                  child: Container(
                      width: 136,
                      child: Column(
                        children: List.generate(
                            stockData.length,
                                (index){
                              return Container(
                                height: 60,
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
                                ),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      stockData[index]["logo"],
                                      width: 24,
                                      height: 24,
                                      errorBuilder: (context, error, stackTrace) =>
                                      const Icon(Icons.error, size: 20),
                                    ),
                                    const SizedBox(width: 8),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          stockData[index]["symbol"],
                                          style: const TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          stockData[index]["name"],
                                          style: const TextStyle(color: Colors.grey, fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            }
                        ),
                      )
                  ),
                ),
              ],
            ),
          ),
        ),
        // Scrollable Content Columns
        Expanded(
          child: SizedBox(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(color: Color(0xffB0B0B0), height: 2,width: 850,),
                    Container(
                      height: 30, // Total width of scrollable content
                      child: Row(
                        children: [
                          // Dividend Amount
                          Container(
                            width: 100,
                            child: const Center(
                              child: Text(
                                "Dividend Amount",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 11,
                                ),
                              ),
                            ),
                          ),
                          // Dividend Yield
                          Container(
                            width: 100,
                            child: const Center(
                              child: Text(
                                "Dividend Yield",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 11,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 130,
                            child: const Center(
                              child: Text(
                                "Analyst Price Target",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 11,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 180,
                            child: const Center(
                              child: Text(
                                "Analyst Price Target",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 11,
                                ),
                              ),
                            ),
                          ),
                          // Add more headers as needed

                          Container(

                            width: 100,
                            child: const Center(
                              child: Text(
                                "Smart Score",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 11,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 100,
                            child: const Center(
                              child: Text(
                                "Market Cap",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 11,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 100,
                            child: const Center(
                              child: Text(
                                "Yearly Gain",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 11,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    Container(color: Color(0xffB0B0B0), height: 2, width: 855),
                    Container(
                      child: Column(
                        children: List.generate(stockData.length, (index) {
                          return Column(
                            children: [
                              Container(
                                height: 60,
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Colors.grey.shade200,
                                    ),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    // Dividend Amount
                                    Container(
                                      width: 100,
                                      child: Center(
                                        child: Text(
                                          stockData[index]["dividend"],
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                      ),
                                    ),
                                    // Dividend Yield
                                    Container(
                                      width: 115,
                                      child: Center(
                                        child: Text(
                                          stockData[index]["yield"],
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 100,
                                      child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Center(child: TopLockWidget(lockPosition: -45, boxAlignment: Alignment.centerRight)),
                                      ),
                                    ),
                                    Container(
                                      width: 200,
                                      child: Center(
                                        child:
                                        stockData[index]["btarget"]
                                        is Widget
                                            ? stockData[index]["btarget"] // Render widget directly
                                            : Text(
                                          stockData[index]["btarget"]
                                              .toString(),
                                          // Fallback for strings
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 100,
                                      child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Center(child: TopLockWidget(lockPosition: 0, boxAlignment: Alignment.center)),
                                      ),
                                    ),
                                    Container(
                                      width: 100,
                                      child: Center(
                                        child: Text(
                                          stockData[index]["market cap"],
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 100,
                                      child: Center(
                                        child: Text(
                                          stockData[index]["yearly gain"],
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
