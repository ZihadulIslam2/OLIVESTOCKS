import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../core/contants/urls.dart';
import '../../features/auth/controllers/auth_controller.dart';
import '../const.dart';
class StripeService extends GetxController {
  static StripeService get instance => Get.find();

  Map<String, dynamic>? paymentIntentData;

  StripeService() {
    Stripe.publishableKey = Constants.publishableKey;
    debugPrint("Stripe initialized with key: ${Stripe.publishableKey}");
  }

  Future<void> makePayment({
    required String price,
    required String subscriptionId,
    required String duration,
    required String userId,
  }) async {
    try {
      // 1. Create payment intent
      paymentIntentData = await createPaymentIntent(
          price: price,
          currency: "USD",
          userId: userId,
          subscriptionId: subscriptionId,
          duration: duration,
      );

      if (paymentIntentData == null) {
        throw Exception("Failed to create payment intent");
      } else {
        debugPrint("Payment intent created: $paymentIntentData");
      }

      //2. Initialize payment sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          merchantDisplayName: 'Rabby',
          paymentIntentClientSecret: paymentIntentData!['clientSecret'],
          style: ThemeMode.dark,
        ),
      );

      // 3. Display payment sheet
      await displayPaymentSheet(
        price: price,
        subscriptionId: subscriptionId,
        duration: duration,
        userId: userId,
      );

    } catch (e) {
      debugPrint("Payment error 1: $e");
      Get.snackbar("Error", "Payment failed: $e");
    }
  }


  /// Save expire date
  Future<void> saveExpireDate(DateTime expireDate) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('expireDate', expireDate.toIso8601String());
  }

  /// Delete expire date
  Future<void> deleteExpireDate() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('expireDate', '');
  }

  /// Check if expire date is valid
  /// If not present, creates key with empty string and returns false
  Future<bool> isExpireDateValid() async {
    final prefs = await SharedPreferences.getInstance();
    String? expireDateStr = prefs.getString('expireDate');

    //If not present → create empty value and return false
    if (expireDateStr == null) {
      await prefs.setString('expireDate', "");
      return false;
    }

    // If empty → invalid
    if (expireDateStr!.isEmpty) return false;

    try {
      DateTime expireDate = DateTime.parse(expireDateStr).toLocal();
      DateTime now = DateTime.now();

      return expireDate.isAfter(now) || expireDate.isAtSameMomentAs(now);
    } catch (e) {
      // If parsing fails → invalid
      return false;
    }
  }


  Future<Map<String, dynamic>> createPaymentIntent({
    required String price,
    required String currency,
    required String userId,
    required String subscriptionId,
    required String duration
  }) async {
    try {

      Map<String, dynamic> body = {
        'userId':  userId,
        'price': price,
        'currency': currency,
        "subscriptionId": subscriptionId,
        "duration": duration
      };

      var response = await http.post(
        Uri.parse('${Urls.baseUrl}/create-payment'),
        body: body,
        headers: {
          'Authorization': 'Bearer ${Constants.secretKey}',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception("Failed to create payment intent: ${response.body}");
      }
    } catch (e) {
      debugPrint("Error creating payment intent: $e");
      rethrow;
    }
  }
  Future<void> displayPaymentSheet({
    required String price,
    required String subscriptionId,
    required String duration,
    required String userId,
  }) async {
    try {
      await Stripe.instance.presentPaymentSheet();

      final paymentIntentId = paymentIntentData!['clientSecret'].split('_secret')[0];

      await confirmPayment(paymentIntentId: paymentIntentId);

      // ✅ Refresh user profile after payment
      await Get.find<AuthController>().getSingleUser(userId);

      Get.snackbar("Success", "Payment completed successfully");
    } on StripeException catch (e) {
      debugPrint("Stripe error: ${e.error.localizedMessage}");
      Get.snackbar("Error", "Payment failed: ${e.error.localizedMessage}");
    } catch (e) {
      debugPrint("Payment error: $e");
      Get.snackbar("Error", "Payment failed: $e");
    } finally {
      paymentIntentData = null;
    }
  }
  }

  Future<void> confirmPayment({
    required String paymentIntentId,
  }) async {
    try {
      // Here you would call your backend API to confirm the payment
      // This is just a placeholder - replace with your actual API call
      debugPrint("Confirming payment: $paymentIntentId");
      var response = await http.post(
        Uri.parse('${Urls.baseUrl}/confirm-payment'),
        body: {
          'paymentIntentId': paymentIntentId,
        },
      );

      if (response.statusCode != 200) {
        throw Exception("Failed to confirm payment: ${response.body}");
      }

      // Process the response if needed
      final responseData = jsonDecode(response.body);
      debugPrint("Payment confirmed: $responseData");

    } catch (e) {
      debugPrint("Error confirming payment: $e");
      rethrow;
    }
  }

  // Helper method to retrieve payment intent details
  Future<PaymentIntent> retrievePaymentIntent(String paymentIntentId) async {
    try {
      return await Stripe.instance.retrievePaymentIntent(paymentIntentId);
    } catch (e) {
      debugPrint("Error retrieving payment intent: $e");
      rethrow;
    }
  }
