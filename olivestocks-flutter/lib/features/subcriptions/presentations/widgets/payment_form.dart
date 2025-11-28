import 'package:flutter/material.dart';

class PaymentForm extends StatelessWidget {
  const PaymentForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 12),
        buildTextField('Name'),
        const SizedBox(height: 12),
        buildTextField('Card Number'),
        const SizedBox(height: 12),
        buildTextField('DD/MM/YYYY'),
        const SizedBox(height: 12),
        buildTextField('CVC'),
        const SizedBox(height: 12),
        buildTextField('Phone Number'),
      ],
    );
  }

  Widget buildTextField(String label) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }
}