import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdsScreen extends StatefulWidget {
  const AdsScreen({super.key});

  @override
  State<AdsScreen> createState() => _AdsScreenState();
}

class _AdsScreenState extends State<AdsScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFFDFF2E3),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: EdgeInsets.only(right: 16),
                  child: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(Icons.close, color: Color(0xFF28A745), size: 24),
                  ),
                ),
              ],
            ),
            SizedBox(height: 101.69),
            Image.asset('assets/images/olv_logo.png'),
            SizedBox(height: 16),
            Container(
              height: 48,
              width: double.infinity,
              color: Color(0xFF28A745),
              child: Center(
                child: Text(
                  'END OF FQUARTER SALE',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.02),
            Image.asset('assets/images/offer_logo.png'),
            SizedBox(height: size.height * 0.02),
            Text(
              'In Times of Change, Trust the Data',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            SizedBox(height: size.height * 0.02),
            Text(
              'Navigate the Market with Confidence',
              style: TextStyle(fontSize: 12, color: Colors.black),
            ),
            SizedBox(height: size.height * 0.02),
            Text(
              'Offert Ends',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Colors.black,
              ),
            ),
            SizedBox(height: size.height * 0.02),
            Container(
              decoration: BoxDecoration(
                color: Color(0xFF28A745),
                borderRadius: BorderRadius.circular(8),
              ),
              height: size.height * 0.05,
              width: size.width * 0.5,
              child: Center(
                child: Text(
                  'Claim Offer',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
