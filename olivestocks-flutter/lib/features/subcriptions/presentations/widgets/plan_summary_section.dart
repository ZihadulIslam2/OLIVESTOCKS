import 'package:flutter/material.dart';

class PlanSummarySection extends StatelessWidget {
  const PlanSummarySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Summary', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        const Text('Recurring Payment Terms:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        const Text('● \$359.00, charged every year'),
        const Text('● Charges include applicable VAT/GST and/or Sale Taxes'),
        const Divider(height: 32),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text('Total:', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
            Text('\$359.00', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
          ],
        ),
        const Divider(height: 32),
        const Text('Safe & secure payment', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        const Text(
          'By clicking the Pay button, you are agreeing to our Terms of Service and Privacy Statement. You are also authorizing us to charge your credit/debit card...',
          style: TextStyle(fontSize: 13),
        ),
      ],
    );
  }
}