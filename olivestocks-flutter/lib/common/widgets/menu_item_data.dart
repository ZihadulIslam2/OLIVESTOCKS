



import 'package:flutter/material.dart';

class MenuItemData {
  final String title;
  final String iconImage;
  final Widget route;
  final bool isUpComing;

  const MenuItemData({
    required this.title,
    required this.iconImage,
    required this.route,
     this.isUpComing = false,
  });
}
