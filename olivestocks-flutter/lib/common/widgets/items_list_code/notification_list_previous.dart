import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../features/portfolio/controller/portfolio_controller.dart';
import '../../../features/portfolio/domains/notification_response_model.dart';
import '../notification_tile.dart';

class NotificationListPrevious extends StatelessWidget {
  const NotificationListPrevious({super.key});

  /// Get unread notifications before today
  List<NotificationResponseModel> getPreviousNews(List<NotificationResponseModel> notificationList) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    return notificationList.where((n) {
      final created = n.createdAt;
      return created != null &&
          n.isRead != true &&
          created.isBefore(today);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PortfolioController>(
      builder: (controller) {
        if (controller.isNotificationLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        final previousNews = getPreviousNews(controller.notificationList);

        if (previousNews.isEmpty) {
          return const Center(child: Text("No previous notifications"));
        }

        return ListView.builder(
          itemCount: previousNews.length,
          itemBuilder: (context, index) {
            return NotificationTile(
              notification: previousNews[index],
            );
          },
        );
      },
    );
  }
}
