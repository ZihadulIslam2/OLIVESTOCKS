import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../features/portfolio/controller/portfolio_controller.dart';
import '../../features/portfolio/domains/notification_response_model.dart';
import 'notification_tile.dart';

class NotificationListToday extends StatelessWidget {
  const NotificationListToday({super.key});

  List<NotificationResponseModel> getTodaysNews(List<NotificationResponseModel> notificationList) {
    final now = DateTime.now();
    return notificationList.where((n) {
      final created = n.createdAt;
      return created != null &&
          n.isRead != true &&
          created.year == now.year &&
          created.month == now.month &&
          created.day == now.day;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PortfolioController>(
      builder: (controller) {


        if (controller.isNotificationLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.notificationList.isEmpty) {
          return const Center(child: Text("No notifications available"));
        }

        return ListView.builder(
          itemCount: getTodaysNews(controller.notificationList).length,
          itemBuilder: (context, index) {
            return NotificationTile(
              notification: getTodaysNews(controller.notificationList)[index],
            );
          },
        );
      },
    );
  }
}


