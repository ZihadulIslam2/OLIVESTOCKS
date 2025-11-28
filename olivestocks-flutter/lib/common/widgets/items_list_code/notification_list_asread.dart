import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../features/portfolio/controller/portfolio_controller.dart';
import '../../../features/portfolio/domains/notification_response_model.dart';
import '../notification_tile.dart';

class NotificationListAsread extends StatelessWidget {
  const NotificationListAsread({super.key});

  List<NotificationResponseModel> getReadNotifications(List<NotificationResponseModel> notificationList) {
    return notificationList.where((n) => n.isRead == true).toList();
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
          itemCount: getReadNotifications(controller.notificationList).length,
          itemBuilder: (context, index) {
            return NotificationTile(
              notification: getReadNotifications(controller.notificationList)[index],
            );
          },
        );
      },
    );
  }
}
