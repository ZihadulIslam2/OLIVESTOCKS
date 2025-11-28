import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../features/portfolio/controller/portfolio_controller.dart';
import '../../features/portfolio/domains/notification_response_model.dart';
import '../screens/notification_screen.dart';

class NotificationIconWithBadge extends StatelessWidget {
  const NotificationIconWithBadge({super.key});

  List<NotificationResponseModel> getTodaysUnreadNotifications(
      List<NotificationResponseModel> notifications) {
    final now = DateTime.now();
    return notifications.where((n) {
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
        final unreadToday =
        getTodaysUnreadNotifications(controller.notificationList);

        return GestureDetector(
          onTap: () => Get.to(() => const NotificationScreen()),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 20,
                width: 20,
                child: Image.asset('assets/logos/notification.png'),
              ),
              if (unreadToday.isNotEmpty)
                Positioned(
                  right: -2,
                  top: -4,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 12,
                      minHeight: 12,
                    ),
                    child: Text(
                      '${unreadToday.length}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
