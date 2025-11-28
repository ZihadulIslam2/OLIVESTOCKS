import 'package:flutter/material.dart';

class PaymentMethodIcons extends StatelessWidget {
  const PaymentMethodIcons({super.key});

  @override
  Widget build(BuildContext context) {
     Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            Image(image: AssetImage('assets/images/cards/visaCard.png'), height: 50 ,width: 100,),
            Image(image: AssetImage('assets/images/cards/paypalCard.png'), height: 50, width: 100,),
            Image(image: AssetImage('assets/images/cards/Xcard.png'), height: 50, width: 100,),
          ],
        ),
        const SizedBox(height: 24),
        const Text(
          'Total: \$359.00',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 24),
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: size.width * 0.22),
          child: DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
            value: 'United States',
            items: const [
              DropdownMenuItem(value: 'United States', child: Row(
                children: [
                  Image(image: AssetImage('assets/images/flags/usa.png'), height: 60, width: 40,),
                  SizedBox(width: 8),
                  Text('United States'),
                ],
              )),
              DropdownMenuItem(value: 'Canada', child: Row(
                children: [
                  Image(image: AssetImage('assets/images/flags/canada.png'), height: 60, width: 40,),
                  SizedBox(width: 8),
                  Text('Canada'),
                ],
              )),
              DropdownMenuItem(value: 'Germany', child: Row(
                children: [
                  Image(image: AssetImage('assets/images/flags/germany.png'), height: 60, width: 40,),
                    SizedBox(width: 8),
                  Text('Germany'),
                ],
              )),
            ],
            onChanged: (value) {},
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          decoration: const InputDecoration(
            labelText: 'Email',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          alignment: WrapAlignment.center,
          children: const [
            PaymentIcon('assets/images/paymentMethod/frame1.png'),
            PaymentIcon('assets/images/paymentMethod/frame2.png'),
            PaymentIcon('assets/images/paymentMethod/frame3.png'),
            PaymentIcon('assets/images/paymentMethod/frame4.png'),
            PaymentIcon('assets/images/paymentMethod/frame5.png'),
          ],
        ),
      ],
    );
  }
}

class PaymentIcon extends StatelessWidget {
  final String assetPath;
  const PaymentIcon(this.assetPath, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 80,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Image.asset(assetPath, fit: BoxFit.contain),
    );
  }
}