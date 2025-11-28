import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:olive_stocks_flutter/common/widgets/items_list_code/notification_list_previous.dart';
import 'package:olive_stocks_flutter/features/portfolio/controller/portfolio_controller.dart';

import '../../features/manage_notification/presentation/manage_notification_screen.dart';
import '../widgets/items_list_code/notification_list_asread.dart';
import '../widgets/notification_list.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool isSwitched = false;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    Get.find<PortfolioController>().getNotification();
    super.initState();
  }

  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),

        // leading: const BackButton(),
      ),
      body: GetBuilder<PortfolioController>(builder: (portfolioController){
        return portfolioController.isPortfolioLoading ? Center(child: CircularProgressIndicator(),) : Column(
          children: [
            Container(
              width: size.width * .9,
              height: size.height * .15,
              decoration: BoxDecoration(
                color: Color(0xffEAF6EC),
                borderRadius: BorderRadius.circular(4),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.notifications_outlined,
                    color: Colors.black,
                    size: 28,
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Smart Notifications',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 12,),
                      Text(
                        textAlign: TextAlign.start,
                        'Get alerts on price movements, upcoming earnings, \nand more for the stocks and experts you follow.',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextButton(
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                            ),
                            onPressed: () {
                              Get.to(() => ManageNotificationScreen());
                            },
                            child: Text(
                              'Manage Notifications',
                              style: TextStyle(color: Colors.green),
                            ),
                          ),
                          SizedBox(width: 8,),
                          Icon(Icons.arrow_forward, color: Colors.green,size: 18,),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(width: 20,),
                  // Switch
                  Switch(value: isSwitched, onChanged: (value){
                    setState(() {
                      isSwitched = value;
                    });
                  },
                    activeColor: Colors.green,),

                ],
              ),
            ),

            Container(

              child: TabBar(
                controller: _tabController,
                isScrollable: false,
                indicatorColor: Colors.green,
                labelColor: Colors.green,
                unselectedLabelColor: Colors.black,
                unselectedLabelStyle: TextStyle(fontSize: 12),
                labelStyle: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,),
                tabs: [
                  Tab(text: 'Today',),
                  Tab(text: 'Previous',),
                  Tab(text: 'Mark as read'),
                ],
              ),
            ),

            // Tab Views
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  SafeArea(child: NotificationListToday()),
                  SafeArea(child: NotificationListPrevious()),
                  SafeArea(child: NotificationListAsread()),
                ],
              ),
            ),



          ],
        );
      }),
    );
  }
}
