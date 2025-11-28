// breaking_news_card.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../domain/get_all_news_response_model.dart';
import '../screens/news_details_screen.dart';

class BreakingNewsCard extends StatelessWidget { // Changed class name

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * .59,
      child: ListView(
        children: List.generate(100, (index){
          return GestureDetector(
            onTap: (){
              //Get.to(NewsDetailsScreen(newsData: newsData,));
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Container(
                height: size.height * .13,
                child: Card(
                  elevation: 0.5,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Apple fixes Passwords bug that exposed users to phishing attacks, Verge says......",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.access_time, size: 16, color: Colors.green),
                          SizedBox(width: 5),
                          Text("3m ago", style: TextStyle(fontSize: 12)),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.red.shade100,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              "AMZN ▼0.12%",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}