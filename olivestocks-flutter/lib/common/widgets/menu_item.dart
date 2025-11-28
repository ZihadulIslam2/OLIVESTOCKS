import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:olive_stocks_flutter/helpers/custom_snackbar.dart';

import '../../features/experts/presentations/screens/my_export_screen.dart';
import '../../features/stock_data_serving/presentations/screens/daily_insider_trading_screen_2.dart';
import 'menu_item_data.dart';

class MenuItem extends StatelessWidget {
  final MenuItemData data;

  const MenuItem({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Container(
        height: size.height * .045,
        width: size.width * .9,
        child: ElevatedButton(
          onPressed: () {
              Get.back();
              Get.to(data.route);
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            backgroundColor: Colors.white,
            foregroundColor: Colors.black87,
            elevation: 0,
            alignment: Alignment.centerLeft,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
              side: const BorderSide(color: Color(0xFFE0E0E0)),
            ),
          ),
          child: Row(
            children: [
              Container(
                height: 12,
                width: 12,
                child: Image.asset(data.iconImage.toString(),color: Color(0xFF000000),fit: BoxFit.cover,),
              ),
              const SizedBox(width: 12),
              Text(
                data.title,
                style: const TextStyle(fontSize: 12),
              ),
              SizedBox(width: 12,),
              data.isUpComing ? Container(
                height: 14,
                width: 62,
                decoration:BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(10),) ,
                child: Center(child: Center(child: Text('UpComing',style: TextStyle(color: Colors.white,fontSize: 8),))),
              ) : SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}