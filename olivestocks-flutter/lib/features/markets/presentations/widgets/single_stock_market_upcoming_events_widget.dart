import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../portfolio_allocation/presentation/screens/upcomming_events.dart';
import '../../../portfolio/controller/portfolio_controller.dart';
import '../../../portfolio/domains/upcoming_event_response_model.dart';

class SingleStockMarketUpcomingEventsWidget extends StatefulWidget {
  const SingleStockMarketUpcomingEventsWidget({super.key, });

  @override
  State<SingleStockMarketUpcomingEventsWidget> createState() => _SingleStockMarketUpcomingEventsWidgetState();
}

class _SingleStockMarketUpcomingEventsWidgetState extends State<SingleStockMarketUpcomingEventsWidget> {

  @override
  void initState() {
    if(Get.find<PortfolioController>().portfolios.isNotEmpty){
      Get.find<PortfolioController>().getAllUpcomingEvents(Get.find<PortfolioController>().portfolios.first.id!);// Call the function here <==>
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GetBuilder<PortfolioController>(builder: (portfolioController){

      if (!(portfolioController.isUpcomingLoading  && portfolioController.upcomingEventsResponseModel != null)) {
        return  Container(
          height: size.height * .2,
          width: size.width * .9,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: Offset(0, 1),
                ),
              ]
          ),
          child: Center(
            child: Container(
                height: size.height * .2,
                width: size.width * .7,
                child: Center(child: Text('It is Under construction'))),
          ),
        ) ;
      }

      return !portfolioController.isUpcomingLoading ? Container(
        height: size.height * .2,
        width: size.width * .9,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 1,
                offset: Offset(0, 1),
              ),
            ]
        ),
        child: Center(
          child: Container(
              height: size.height * .2,
              width: size.width * .7,
              child: Center(child: Text('Please Log In and create a portfolio to see the Overall Balance'))),
        ),
      ) : Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.0,),
      child:Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Column(
            children: [
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(right: 12,left: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Upcoming Events', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),),
                    GestureDetector(
                        onTap: (){
                          Get.to(UpcomingEventsScreen());
                              },
                        child: Row(
                          children: [
                            Text('Show More', style: TextStyle(color: Colors.green ,fontWeight: FontWeight.w500, fontSize: 12),),
                            SizedBox(width: 5,),
                            Icon(Icons.arrow_forward_ios, color: Colors.green,size: 15,)
                          ],
                        )),
                  ],
                ),
              ),

              SizedBox(height: 10),
              Container(
                height: size.height * .03,
                width: size.width,
                color: Colors.green.withOpacity(.2),
                child: Padding(
                  padding: const EdgeInsets.only(left: 12,right: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Company Name', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),),
                      Text('Event & Date', style: TextStyle(color: Colors.black ,fontWeight: FontWeight.w500, fontSize: 14),),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 7),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: List.generate(
                    portfolioController.upcomingEventsResponseModel.events!.length, // Get the first 5 items
                        (index) {
                      return UpcomingEventsWidgetItem(
                        events: portfolioController.upcomingEventsResponseModel.events![index],
                      );
                    },
                  ),
                ),
              ),
            ]
        ),
      ),
      );
    });
  }
}

class UpcomingEventsWidgetItem extends StatelessWidget {
  const UpcomingEventsWidgetItem({
    super.key, required this.events,
  });
  final Events events;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10,horizontal: 10,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                events.symbol!,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),

              Column(
                children: [
                  Container(
                    width: size.width * .30,
                    //height: size.height * .06,
                    child: Column(
                      children: [
                        Text(
                          events.type!,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          events.date!,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
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
      ],
    );
  }
}

