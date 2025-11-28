import 'package:flutter/material.dart';

class PortfolioPerformanceWidget extends StatelessWidget {
  final int toleranceLevel;

  const PortfolioPerformanceWidget({super.key, required this.toleranceLevel});

  String getLabel(int level) {
    if (level <= 4) return "Conservative";
    if (level <= 7) return "Neutral";
    return "Aggressive";
  }

  Color getBarColor(int index) {
    return Color.lerp(Colors.pink[100], Colors.brown[900], index / 10)!;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                const Text(
                  'Portfolio tolerance',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 6),
                const Icon(Icons.info_outline, size: 18, color: Colors.red),
                const Spacer(),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'See More',
                    style: TextStyle(color: Colors.green),
                  ),
                )
              ],
            ),
            const SizedBox(height: 16),
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.transparent,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.red),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  '$toleranceLevel',
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold, color: Colors.red),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              getLabel(toleranceLevel),
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Row(
                  children: List.generate(10, (index) {
                    final value = index + 1;
                    return Expanded(
                      child: Container(
                        height: 10,
                        decoration: BoxDecoration(
                          color: getBarColor(value),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    );
                  }),
                ),
                Positioned(
                  left: ((toleranceLevel - 1) * (MediaQuery.of(context).size.width - 64) / 10),
                  child: const Icon(Icons.arrow_drop_up, size: 30, color: Colors.black),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(10, (index) {
                final value = index + 1;
                return Text(
                  '$value',
                  style: TextStyle(
                    fontWeight: value == toleranceLevel ? FontWeight.bold : FontWeight.normal,
                    color: value == toleranceLevel ? Colors.red : Colors.black,
                  ),
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
