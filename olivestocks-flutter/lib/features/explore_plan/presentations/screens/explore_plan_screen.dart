import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:olive_stocks_flutter/common/screens/home_screen.dart';
import 'package:olive_stocks_flutter/features/explore_plan/presentations/widgets/feature_premium_widget.dart';
import 'package:olive_stocks_flutter/payment/services/stripe_service.dart';

import '../../../auth/controllers/auth_controller.dart';
import '../../../subcriptions/presentations/screens/Payment_page.dart';
import '../../../subcriptions/presentations/widgets/feature_item.dart';
import '../../controllers/subcrption_controller.dart';
import '../../domain/get_all_subcription_response_model.dart';
import '../widgets/feature_free_widget.dart';

class ExplorePlanScreen extends StatefulWidget {
  const ExplorePlanScreen({super.key, this.data});

  final List<SubscriptionPlan>? data;



  @override
  State<ExplorePlanScreen> createState() => _ExplorePlanScreenState();
}

class _ExplorePlanScreenState extends State<ExplorePlanScreen> {
  bool isSwitched = false;
  final stripeService = Get.put(StripeService());


  @override
  void initState() {
    Get.find<SubscriptionController>().getAllSubscription();
    Get.put(StripeService());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Explore Plan',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
      body: GetBuilder<SubscriptionController>(
        builder: (subscriptionController) {
          return subscriptionController.isSubscriptionLoading
              ? Center(child: CircularProgressIndicator())
              : Center(
                child: Container(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: SingleChildScrollView(
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Invest Smarter. Choose Your Edge.',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Choose the plan that matches your ambition.',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(height: 12),
                            Text(
                              'Every plan includes expert-grade tools,',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              'intelligent insights, and powerful portfolio-',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              'building features.',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Monthly Billing'),
                                SizedBox(width: 6),
                                Switch(
                                  value: isSwitched,
                                  onChanged: (value) {
                                    setState(() {
                                      isSwitched = value;
                                    });
                                  },
                                ),
                                SizedBox(width: 4),
                                Text('Annual Billing'),
                                SizedBox(width: 6),
                                Text(
                                  '(Save 20%)',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 4),

                            Column(
                              children: List.generate(subscriptionController.getAllSubscriptionPlanResponseModel.data!.length, (index)
                              {
                                if(subscriptionController.getAllSubscriptionPlanResponseModel.data![index].title == 'Free'){
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 25.0),
                                    child: FreeExplorePlan( isSwitched: isSwitched, data: subscriptionController.getAllSubscriptionPlanResponseModel.data![index],),
                                  );
                                }
                                if(subscriptionController.getAllSubscriptionPlanResponseModel.data![index].title == 'Premium'){
                                  print(subscriptionController.getAllSubscriptionPlanResponseModel.data![index].title);
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 25.0),
                                    child: PremiumExplorePlan(isSwitched: isSwitched, data: subscriptionController.getAllSubscriptionPlanResponseModel.data![index],),
                                  );
                                }
                                if(subscriptionController.getAllSubscriptionPlanResponseModel.data![index].title == 'Ultimate'){
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 25.0),
                                    child: UltimateExplorePlan(isSwitched: isSwitched, data: subscriptionController.getAllSubscriptionPlanResponseModel.data![index],),
                                  );
                                }
                                else{
                                  return Container(
                                    child: Center(
                                      child: Text("There is no plan"),
                                    ),
                                  );                               }
                              },
                            )
                            ),

                            // FreeExplorePlan(
                            //   data: widget.data?[0]! ,
                            // ),

                            // SizedBox(height: 44),
                            // PremiumExplorePlan(),
                            //
                            // SizedBox(height: 44),
                            // UltimateExplorePlan(),
                            // SizedBox(height: 40),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
        },
      ),
    );
  }
}

class FreeExplorePlan extends StatelessWidget {
  const FreeExplorePlan({super.key, required this.data, required this.isSwitched});

  final SubscriptionPlan data;
  final bool isSwitched;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<AuthController>(builder: (authController) {
      return GetBuilder<SubscriptionController>(
        builder: (subscriptionController) {
          final data =
              subscriptionController
                  .getAllSubscriptionPlanResponseModel
                  .data?[0] ??
                  SubscriptionPlan();

          return subscriptionController.isSubscriptionLoading
              ? Center(child: CircularProgressIndicator())
              : Column(
            children: [
              Center(
                child: Container(
                  // height: 731,
                  width: size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        data.title!,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 8),
                      Center(
                        child: Text(
                          textAlign: TextAlign.center,
                          data.description!,
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF4E4E4E),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(height: 12),
                      Container(
                        width: 165,
                        decoration: BoxDecoration(
                          color: Color(0xFFEFF6FF),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            'Perfect for New Investors',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff2563EB),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 12),
                      Column(
                        children: [

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                isSwitched ? '\$${data.yearlyPrice}' : '\$${data.monthlyPrice}',
                                style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                isSwitched ? '/yearly' : '/month',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff4E4E4E),
                                ),
                              ),
                            ],
                          ),

                          Text(
                            'billed annually',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff4E4E4E),
                            ),
                          ),
                          SizedBox(height: 6),
                          Container(
                            height: 47,
                            width: size.width,
                            decoration: BoxDecoration(
                              color: Color(0xffF9FAFB),
                              border: Border(
                                top: BorderSide(
                                  color: Color(0xffE4E6EA),
                                  width: 1,
                                ),
                                bottom: BorderSide(
                                  color: Color(0xffE4E6EA),
                                  width: 1,
                                ),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'No credit card required',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff000000),
                                ),
                              ),
                            ),
                          ),

                          FeatureBaseWidget(data: data),

                          SizedBox(height: 9),

                          Container(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                splashFactory: NoSplash.splashFactory,
                                backgroundColor: Color(0xffF9FAFB),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0),
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 32,
                                  vertical: 12,
                                ),
                              ),
                              onPressed: (){},
                              // onPressed: () async {
                              //   final price = isSwitched ? data.yearlyPrice! : data.monthlyPrice!;
                              //   final duration = isSwitched ? 'yearly' : 'monthly';
                              //   final subscriptionId = data.id;
                              //   final userId = authController.getSingleUserResponseModel?.data?.sId;
                              //
                              //   if (userId == null || subscriptionId == null) {
                              //     print("⚠️ Error: userId or subscriptionId is null");
                              //     return;
                              //   }
                              //
                              //   try {
                              //     await StripeService.instance.makePayment(
                              //       price: price.toString(),
                              //       subscriptionId: subscriptionId,
                              //       duration: duration,
                              //       userId: userId,
                              //     );
                              //   } catch (e) {
                              //     Get.snackbar("Error", "Payment failed: $e");
                              //   }
                              // },
                              child: Text(
                                'Start Free Today →',
                                style: TextStyle(
                                  color: Color(0xff000000),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 6),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      );
    });
  }
}

class PremiumExplorePlan extends StatelessWidget {
  final SubscriptionPlan data;

  bool isSwitched = false;

  PremiumExplorePlan({super.key, required this.data, required this.isSwitched});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<AuthController>(builder: (authController){
      return GetBuilder<SubscriptionController>(
        builder: (subscriptionController) {
          return subscriptionController.isSubscriptionLoading
              ? Center(child: CircularProgressIndicator())
              : Container(
            //height: 8000,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Center(
                  child: Container(
                    //height: 735,
                    width: size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: Color(0xffAEB6F3), width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: size.height * .04),
                        Text(
                          data.title!,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          data.description!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF4E4E4E),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 12),
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  isSwitched ? '\$${data.yearlyPrice}' : '\$${data.monthlyPrice}',
                                  style: TextStyle(
                                    fontSize: 26,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                                Text(
                                  isSwitched ? '/yearly' : '/month',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff4E4E4E),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Visibility(
                              visible: isSwitched,
                              child: Container(
                                height: 39,
                                width: 136,
                                decoration: BoxDecoration(
                                  color: Color(0xFFC8F8D9),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Center(
                                  child: Text(
                                    'Save 20%',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff22C55E),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'billed annually',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff4E4E4E),
                              ),
                            ),
                            Container(
                              height: 47,
                              width: size.width,
                              decoration: BoxDecoration(
                                color: Color(0xffF9FAFB),
                                border: Border(
                                  top: BorderSide(
                                    color: Color(0xffE4E6EA),
                                    width: 1,
                                  ),
                                  bottom: BorderSide(
                                    color: Color(0xffE4E6EA),
                                    width: 1,
                                  ),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'Unlock premium features',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff000000),
                                  ),
                                ),
                              ),
                            ),
                            FeatureBaseWidget(data: data),
                            Container(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  splashFactory: NoSplash.splashFactory,
                                  backgroundColor: Color(0xffF6264F0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 32,
                                    vertical: 12,
                                  ),
                                ),
                                onPressed: () async {
                                  final price = isSwitched ? data.yearlyPrice! : data.monthlyPrice!;
                                  final duration = isSwitched ? 'yearly' : 'monthly';
                                  final subscriptionId = data.id;
                                  final userId = authController.getSingleUserResponseModel?.data?.sId;

                                  if (userId == null || subscriptionId == null) {
                                    print("⚠️ Error: userId or subscriptionId is null");
                                    return;
                                  }

                                  try {
                                    await StripeService.instance.makePayment(
                                      price: price.toString(),
                                      subscriptionId: subscriptionId,
                                      duration: duration,
                                      userId: userId,
                                    );
                                  } catch (e) {
                                    Get.snackbar("Error", "Payment failed: $e");
                                  }
                                },
                                child: Text(
                                  'Unlock Pro Insights →',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 6),
                            Container(
                              //height: 47,
                              width: size.width,
                              decoration: BoxDecoration(
                                color: Color(0xffF9FAFB),
                                // border: Border(
                                //   top: BorderSide(
                                //     color: Color(0xffE4E6EA),
                                //     width: 1,
                                //   ),
                                //   bottom: BorderSide(
                                //     color: Color(0xffE4E6EA),
                                //     width: 1,
                                //   ),
                                // ),
                              ),
                              child: Center(
                                child: Column(
                                  children: [
                                    Divider(),
                                    Text(
                                      'Billed annually, auto-renews until canceled',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff000000),
                                      ),
                                    ),
                                    Divider(),
                                    Text(
                                      'Trusted by Professionals',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff15803D),
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 5),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: -15,
                  left: 30,
                  right: 0,
                  child: Container(
                    child: Row(
                      children: [
                        Container(
                          width: size.width * .35,
                          height: 26,
                          decoration: BoxDecoration(
                            color: Color(0xff2563EB),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Center(
                            child: Text(
                              "MOST POPULAR",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 11),
                        Image.asset(
                          'assets/logos/Polygon 16.png',
                          height: 24,
                          width: 24,
                        ),
                        SizedBox(width: 11),
                        Container(
                          width: 136,
                          height: 26,
                          decoration: BoxDecoration(
                            color: Color(0xff2563EB),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Center(
                            child: Text(
                              "⭐RECOMMENDED",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    });
  }
}

class UltimateExplorePlan extends StatelessWidget {

  final SubscriptionPlan data;

  bool isSwitched = false;

  UltimateExplorePlan({super.key, required this.data, required this.isSwitched});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<AuthController>(builder: (authController){
      return GetBuilder <SubscriptionController>(builder: (subscriptionController){
        return Container(
          //height: 8000,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Center(
                child: Container(
                  //height: 735,
                  width: size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    // border: Border.all(
                    //   color: Color(0xffAEB6F3),
                    //   width: 2,
                    // ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: size.height * .04),
                      Text(
                        data.title!,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        data.description!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF4E4E4E),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 12),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                isSwitched ? '\$${data.yearlyPrice}' : '\$${data.monthlyPrice}',
                                style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                              Text(
                                isSwitched ? '/yearly' : '/month',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff4E4E4E),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Visibility(
                            visible: isSwitched,
                            child: Container(
                              height: 39,
                              width: 136,
                              decoration: BoxDecoration(
                                color: Color(0xFFC8F8D9),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                child: Text(
                                  'Save 20%',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff22C55E),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'billed annually',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff4E4E4E),
                            ),
                          ),
                          SizedBox(height: 8),
                          Container(
                            height: 47,
                            width: size.width,
                            decoration: BoxDecoration(
                              color: Color(0xffF9FAFB),
                              border: Border(
                                top: BorderSide(color: Color(0xffE4E6EA), width: 1),
                                bottom: BorderSide(
                                  color: Color(0xffE4E6EA),
                                  width: 1,
                                ),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'Unlock premium features',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff000000),
                                ),
                              ),
                            ),
                          ),

                          FeatureBaseWidget(data: data),


                          SizedBox(height: 9),
                          Container(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                splashFactory: NoSplash.splashFactory,
                                backgroundColor: Color(0xff16A34A),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 32,
                                  vertical: 12,
                                ),
                              ),
                              onPressed: () async {
                                final price = isSwitched ? data.yearlyPrice! : data.monthlyPrice!;
                                final duration = isSwitched ? 'yearly' : 'monthly';
                                final subscriptionId = data.id;
                                final userId = authController.getSingleUserResponseModel?.data?.sId;

                                if (userId == null || subscriptionId == null) {
                                  print("⚠️ Error: userId or subscriptionId is null");
                                  return;
                                }

                                try {
                                  await StripeService.instance.makePayment(
                                    price: price.toString(),
                                    subscriptionId: subscriptionId,
                                    duration: duration,
                                    userId: userId,
                                  );
                                } catch (e) {
                                  Get.snackbar("Error", "Payment failed: $e");
                                }
                              },
                              child: Text(
                                'Claim Your Elite Access →',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 6),
                          Container(
                            //height: 47,
                            width: size.width,
                            decoration: BoxDecoration(color: Color(0xffF9FAFB)),
                            child: Center(
                              child: Column(
                                children: [
                                  Divider(),
                                  Text(
                                    'Billed annually, auto-renews until canceled',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff000000),
                                    ),
                                  ),
                                  Divider(),
                                  Text(
                                    'Elite Investor Choice',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff15803D),
                                    ),
                                  ),
                                  Divider(),
                                  Text(
                                    'Used by professional hedge fund managers',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff4E4E4E),
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 16),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              Positioned(
                top: -14,
                right: 50,
                left: 200,
                child: Container(
                  child: Container(
                    width: size.width * .35,
                    height: 26,
                    decoration: BoxDecoration(
                      color: Color(0xff06996B),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: Text(
                        "️🛡️All Access",
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      });
    } );
  }
}
