import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/dimensions.dart';

void customPrint(String message) {
  if (kDebugMode) {
    print(message);
  }
}

void showCustomSnackBar(String message,
    {bool isError = true, int seconds = 2, String? subMessage}) {
  Get.closeCurrentSnackbar();
  Get.showSnackbar(GetSnackBar(
    dismissDirection: DismissDirection.horizontal,
    margin: const EdgeInsets.all(Dimensions.paddingSizeSmall).copyWith(
      right: Dimensions.paddingSizeSmall,
    ),
    duration: Duration(seconds: seconds),
    backgroundColor: Get.isDarkMode
        ? Colors.white
        : Theme.of(Get.context!).textTheme.titleMedium!.color!,
    borderRadius: Dimensions.paddingSizeSmall,
    messageText: Row(children: [
      const SizedBox(
        width: Dimensions.paddingSize,
      ),
      Expanded(
          child: SizedBox(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(message,
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white)),
                    subMessage != null
                        ? Text(subMessage,
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white))
                        : const SizedBox(),
                  ]))),
    ]),
  ));
}
