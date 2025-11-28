import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class TransactionStrategy extends StatefulWidget {
  TransactionStrategy({super.key});

  @override
  State<TransactionStrategy> createState() => _TransactionStrategyState();

  static _buildStrategyItem(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: size.height * .208,
            width: size.width * .95,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 20,
                      width: 20,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/logos/coins-swap.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Transaction Strategy',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF000000),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                const Text(
                  'Trend of Buy or Sell Transactions by All Insiders',
                  style: TextStyle(
                    color: Color(0xFF595959),
                    fontSize: 10.5,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Container(
                  height: size.height * .05,
                  width: size.width * .6,
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFB0B0B0)),
                    color: const Color(0xFFD9D9D9),
                  ),
                  child: const Center(
                    child: Text(
                      'Performance Result',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                        color: Color(0xFF000000),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: size.height * .07,
                  width: size.width * .6,
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFB0B0B0)),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 4),
                      const Text(
                        "Annualized Return",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 10,
                          color: Color(0xFF595959),
                        ),
                      ),
                      const Spacer(),
                      const Text(
                        '+5.23%',
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Based on',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 10,
                              color: Color(0xFF595959),
                            ),
                          ),
                          SizedBox(width: 2),
                          Text(
                            '855',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                              color: Color(0xFF000000),
                            ),
                          ),
                          SizedBox(width: 2),
                          Text(
                            'positions',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 10,
                              color: Color(0xFF595959),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: size.height * .01),
                const Text(
                  '0 Stocks With Positive Signal',
                  style: TextStyle(
                    color: Color(0xFF595959),
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TransactionStrategyState extends State<TransactionStrategy> {
  late List<Widget> transactionStrategyItems ;

    int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    transactionStrategyItems = [
      TransactionStrategy._buildStrategyItem(context),
      TransactionStrategy._buildStrategyItem(context),
      TransactionStrategy._buildStrategyItem(context), // Second item for carousel
      TransactionStrategy._buildStrategyItem(context), // Second item for carousel
    ];
    return AnimatedAlign(
      duration: const Duration(seconds: 1),
      alignment: Alignment.center,
      child: Container(
        height: size.height * .27,
        width: size.width * .9,
        decoration: BoxDecoration(
          color: const Color(0xFFE6E6E6),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 17.5),
          child: Column(
            children: [
              CarouselSlider.builder(
                options: CarouselOptions(
                  autoPlay: false,
                  aspectRatio: 2.0,
                  enlargeCenterPage: true,
                  viewportFraction: 0.9,
                  onPageChanged: (index, reason) {
                    setState(() {
                      activeIndex = index;
                    });
                  },
                ),
                itemCount: transactionStrategyItems.length,
                itemBuilder: (context, index, realIndex) {
                  return transactionStrategyItems[index];
                },
              ),
        Divider(
          color: Color(0xFFBFBFBF),
          thickness: 2,
          indent: 16,
          endIndent: 16,),
          buildIndicator(transactionStrategyItems.length),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildIndicator(int itemCount) => AnimatedSmoothIndicator(
    activeIndex: activeIndex,
    count: itemCount,
    effect: const WormEffect(
      dotWidth: 6,
      dotHeight: 6,
      dotColor: Colors.grey,
      activeDotColor: Colors.black,
    ),
  );
}