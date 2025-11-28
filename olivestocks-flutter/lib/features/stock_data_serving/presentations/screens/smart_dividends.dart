import 'package:flutter/material.dart';

import '../widgets/bottom_subscription.dart';
import '../widgets/info_card.dart';


// Import the new widget

class SmartDevidendsScreen extends StatelessWidget {
  final List<Map<String, String>> faqs = [

    {
      "id": "faq1",
      "question": "What is The Smart Investor Portfolio Strategy",
      "answer":
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
    },

    {
      "id": "faq2",
      "question": "What is The Smart Investor Portfolio Strategy",
      "answer":
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
    },

    {
      "id": "faq3",
      "question": "What is The Smart Investor Portfolio Strategy",
      "answer": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
    },

  ];

SmartDevidendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack( // Changed to Stack to position the bottom section
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/images/banner.png',
                          width: double.infinity,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                        Container(
                          height: 1100,
                          width: double.infinity,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    Positioned(
                      top: 60,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 8),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.green,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 2,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Image.asset(
                                'assets/images/headlogo.png',
                                fit: BoxFit.cover,
                                width: 20,
                                height: 20,
                              ),
                            ),
                            Text(
                              'SMART DEVIDENDS',
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 100,
                      left: 20,
                      right: 20,
                      child: Column(
                        children: [
                          Column(),
                          InfoCard(
                            image: 'assets/images/smart_devidends.png',
                            title: "HOW DOES IT WORK?",
                            content:
                                "Olives Stocks Smart Investor Model Portfolio  Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                          ),
                          InfoCard(
                            title: "WHAT'S INCLUDED:",
                            content:
                                "Smart Investor Model Portfolio on the App\n\nLorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                          ),
                          InfoCard(
                            title: "Weekly Analysis Newsletter",
                            content:
                                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                          ),
                          SizedBox(height: 16),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Frequently Asked Questions",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(height: 8),
                          ExpansionPanelList.radio(
                            elevation: 0,
                            expandedHeaderPadding: EdgeInsets.symmetric(vertical: 4),
                            children: faqs.map((faq) {
                              return ExpansionPanelRadio(
                                value: faq['id']!,
                                headerBuilder: (context, isExpanded) => ListTile(
                                  title: Text(faq['question']!),
                                ),
                                body: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 8.0),
                                  child: Text(
                                    faq['answer']!,
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                          SizedBox(height: 24),
                          // Removed BottomSubscribeSection from here
                          SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          Positioned( // Added Positioned widget for BottomSubscribeSection
            left: 20,
            right: 20,
            bottom: 0,
            child: BottomSubscribeSection(),
          ),
        ],
      ),
    );
  }
}


