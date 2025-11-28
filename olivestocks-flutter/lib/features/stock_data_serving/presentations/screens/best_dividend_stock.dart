import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../experts/presentations/widgets/top_lock_widget.dart';
import '../widgets/dividendLinearProgressWidget.dart';

class BestDividendStock extends StatelessWidget {
  final ScrollController horizontalScrollController;

  BestDividendStock({super.key, required this.horizontalScrollController});

  final List<Map<String, dynamic>> stockData = [

    {
      "symbol": "MSFT",
      "name": "Microsoft",
      "logo": "assets/logos/microsoft.png",
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
      "symbol": "MSFT",
      "name": "Microsoft",
      "logo": "assets/logos/microsoft.png",
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
      "symbol": "MSFT",
      "name": "Microsoft",
      "logo": "assets/logos/microsoft.png",
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
      "symbol": "MSFT",
      "name": "Microsoft",
      "logo": "assets/logos/microsoft.png",
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
      "symbol": "MSFT",
      "name": "Microsoft",
      "logo": "assets/logos/microsoft.png",
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
      "symbol": "MSFT",
      "name": "Microsoft",
      "logo": "assets/logos/microsoft.png",
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
      "symbol": "MSFT",
      "name": "Microsoft",
      "logo": "assets/logos/microsoft.png",
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
      "symbol": "MSFT",
      "name": "Microsoft",
      "logo": "assets/logos/microsoft.png",
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
      "symbol": "MSFT",
      "name": "Microsoft",
      "logo": "assets/logos/microsoft.png",
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
      "symbol": "MSFT",
      "name": "Microsoft",
      "logo": "assets/logos/microsoft.png",
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
      "symbol": "MSFT",
      "name": "Microsoft",
      "logo": "assets/logos/microsoft.png",
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
      "symbol": "MSFT",
      "name": "Microsoft",
      "logo": "assets/logos/microsoft.png",
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
      "symbol": "MSFT",
      "name": "Microsoft",
      "logo": "assets/logos/microsoft.png",
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
      "symbol": "MSFT",
      "name": "Microsoft",
      "logo": "assets/logos/microsoft.png",
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
      "symbol": "MSFT",
      "name": "Microsoft",
      "logo": "assets/logos/microsoft.png",
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
      child: Column(children: [buildScrollableTable(context)]),
    );
  }

  Widget buildScrollableTable(BuildContext context) {
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
                        fontSize: 11,
                      ),
                    ),
                  ),
                ),

                Container(color: Color(0xffB0B0B0), height: 2, width: 1000),

                Expanded(
                  child: Container(
                    width: 300,
                    child: Column(
                      children: List.generate(stockData.length, (index) {
                        return Container(
                          height: 60,
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              bottom: BorderSide(color: Colors.grey.shade200),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TopLockWidget(
                              lockPosition: 50,
                              boxAlignment: Alignment.centerLeft,
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),

        Expanded(
          child: SizedBox(
            // width: 800, // Should match header width
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                // width: 1000,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                                      width: 100,
                                      child: Center(
                                        child: Text(
                                          stockData[index]["yield"],
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 150,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Text( '\$16.55',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                                            Text(
                                              "▲27.27% (Upside)",
                                              style: TextStyle(fontSize: 14, color: Colors.green),
                                            ),
                                          ],
                                        ),
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
                                      child: Center(
                                        child: SvgPicture.asset(
                                          stockData[index]["smart score"],
                                          width: 27,
                                          height: 27,
                                          errorBuilder: (context, error, stackTrace) =>
                                          const Icon(Icons.error, size: 20),
                                        ),
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
