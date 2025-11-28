import 'package:flutter/material.dart';

import '../widgets/payment_button.dart';
import '../widgets/payment_form.dart';
import '../widgets/payment_header.dart';
import '../widgets/payment_method_icon.dart';
import '../widgets/plan_summary_section.dart';



class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        title: const Text('Plan Upgrade', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            PaymentHeader(),
            SizedBox(height: 24),
            PlanSummarySection(),
            SizedBox(height: 16),
            PaymentMethodIcons(),
            SizedBox(height: 20),
            PaymentForm(),
            SizedBox(height: 20),
            PaymentButton(),
          ],
        ),
      ),
    );
  }
}