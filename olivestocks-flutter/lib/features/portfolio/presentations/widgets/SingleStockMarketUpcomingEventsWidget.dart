import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../portfolio/controller/portfolio_controller.dart';
import '../../../portfolio/domains/daily_gainer_and_looser_model.dart';

class SingleStockMarketDailyGainersLosers extends StatefulWidget {
  const SingleStockMarketDailyGainersLosers({super.key});

  @override
  State<SingleStockMarketDailyGainersLosers> createState() => _SingleStockMarketDailyGainersLosersState();
}

class _SingleStockMarketDailyGainersLosersState extends State<SingleStockMarketDailyGainersLosers> {
  @override
  void initState() {
    Get.find<PortfolioController>().getAllGainAndLoose(); // Call the function here <==>
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GetBuilder<PortfolioController>(builder: (portfolioController){
      return portfolioController.isGainLoading ? const Center(child: CircularProgressIndicator(),) : Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0,),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 2,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: size.width * .40,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
                  child: Container(
                    width: size.width * .45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.green),
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 20,),
                        Text(
                          'Daily Gainers',
                          style: TextStyle(fontWeight : FontWeight.w600,
                            fontSize: 17,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Column(
                          children: List.generate(portfolioController.dailyGainerAndDailyLooserResponseModel!.gainers!.length, (index){

                            return GainersWidgetItem(gainers: portfolioController.dailyGainerAndDailyLooserResponseModel!.gainers![index],);
                          }),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              Spacer(),

              Container(
                width: size.width * .45,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 8),
                  child: Container(

                    width: size.width * .45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.green),
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 20,),
                        Text(
                          'Daily Losers',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Column(
                          children: List.generate(portfolioController.dailyGainerAndDailyLooserResponseModel!.losers!.length, (index) {
                            return LooserWidgetItem(losers: portfolioController.dailyGainerAndDailyLooserResponseModel!.losers![index],);
                          }
                          ),),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class LooserWidgetItem extends StatelessWidget {

  final Losers losers;

  const LooserWidgetItem({super.key, required this.losers});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(
                losers.symbol!,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
              Text(
                losers.name! ?? 'Name',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                ),
              ),
            ],
          ),

          Column(
            children: [
              Container(
                child: Row(
                  children: [
                    Icon(
                      Icons.arrow_drop_down,
                      size: 30,
                      color: Colors.red,
                    ),
                    Text(
                      '${losers.change!}%',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                '\$${losers.changePercent!}',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

}

class GainersWidgetItem extends StatelessWidget {
  final Gainers gainers;

  const GainersWidgetItem({super.key, required this.gainers});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(
                gainers.symbol!,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
              Text(
                gainers.name! ?? 'Name',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                ),
              ),
            ],
          ),

          Column(
            children: [
              Container(
                child: Row(
                  children: [
                    Icon(
                      Icons.arrow_drop_up,
                      size: 30,
                      color: Colors.green,
                    ),
                    Text(
                      '${gainers.change!}%',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                '+\$${gainers.changePercent!}',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}