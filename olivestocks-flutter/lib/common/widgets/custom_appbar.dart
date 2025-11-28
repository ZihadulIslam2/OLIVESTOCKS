import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../features/portfolio/controller/portfolio_controller.dart';
import '../../features/portfolio/presentations/widgets/bottom_sheet_widget.dart';
import '../../features/portfolio/presentations/widgets/search_bar.dart';
import '../screens/notification_screen.dart';
import 'notification_icon_with_badge.dart';

class CustomAppBar extends StatelessWidget {
  final String appBarTitle;
  final bool isDefaultIcon;
  final List<IconData>? customIcons;

  const CustomAppBar({
    Key? key,
    required this.appBarTitle,
    this.isDefaultIcon = true,
    this.customIcons,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final icons =
        isDefaultIcon
            ? [
              GestureDetector(
                onTap: () {
                  showSearch(
                      context: context,
                      delegate: MyDataSearchDelegate(items: Get.find<PortfolioController>().searchStockResponseModel.results!));

                },
                child: Image.asset(
                  'assets/logos/search.png',
                  height: 20,
                  width: 20,
                ),
              ),
              SizedBox(width: 15),
              GestureDetector(
                onTap: () {
                  showBottomSheetCustom(context);
                },
                child: Image.asset(
                  'assets/logos/bag.png',
                  height: 20,
                  width: 20,
                ),
              ),
              SizedBox(width: 15),

          const NotificationIconWithBadge(),

            ]

            : [
              Icon(customIcons?[0]),
              const SizedBox(width: 15),
              Icon(customIcons?[1]),
              const SizedBox(width: 15),
              Icon(customIcons?[2]),
            ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
      child: Column(
        children: [

          const SizedBox(height: 30),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                appBarTitle,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(children: icons),
            ],
          ),

        ],
      ),
    );
  }
}
