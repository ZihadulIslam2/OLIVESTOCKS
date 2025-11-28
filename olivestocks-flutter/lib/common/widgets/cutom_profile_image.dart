import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:olive_stocks_flutter/features/auth/controllers/auth_controller.dart';

class ProfileAvatarWithBadge extends StatelessWidget {
  final bool isLoading;
  const ProfileAvatarWithBadge({super.key, this.isLoading = false});

  static const double radius = 60.0;
  static const Color green = Colors.green;
  static const Color white = Colors.white;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (controller) {
      ImageProvider imageProvider;

      if (controller.pickedProfileFile != null) {
        imageProvider = FileImage(File(controller.pickedProfileFile!.path));
      } else if (controller.getSingleUserResponseModel?.data?.profilePhoto !=
          null &&
          controller.getSingleUserResponseModel!.data!.profilePhoto!.isNotEmpty) {
        imageProvider =
            NetworkImage(controller.getSingleUserResponseModel!.data!.profilePhoto!);
      } else {
        imageProvider = const AssetImage('assets/images/default_profile.png');
      }

      return Stack(
        alignment: Alignment.center,
        children: [
          CircleAvatar(
            radius: radius,
            backgroundImage: imageProvider,
          ),
          if (isLoading)
            SizedBox(
              width: radius * 2,
              height: radius * 2,
              child: CircularProgressIndicator(
                strokeWidth: 4,
                color: Colors.green,
              ),
            ),
        ],
      );
    });
  }
}
