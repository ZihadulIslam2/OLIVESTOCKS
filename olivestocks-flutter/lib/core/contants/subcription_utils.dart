import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../features/explore_plan/presentations/screens/explore_plan_screen.dart';
import '../../features/stock_data_serving/presentations/widgets/lock_widget.dart';


void showUpgradeDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text("Upgrade Required"),
      content: const Text("This feature is available for subscribed users only."),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () {
            Get.to(() => const ExplorePlanScreen());
          },
          style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
          child: const Text("Upgrade Plan", style: TextStyle(color: Colors.white)),
        )
      ],
    ),
  );
}

/// ✅ Reusable function
Widget buildSubscriptionContent({
  required String? subscriptionStatus,
  required BuildContext context,
  required Widget child,
}) {
  if (subscriptionStatus == "Premium" || subscriptionStatus == "Ultimate") {
    return child; // show actual content
  } else {
    return GestureDetector(
      onTap: () => showUpgradeDialog(context),
      child: const LockWidget(),
    );
  }
}
