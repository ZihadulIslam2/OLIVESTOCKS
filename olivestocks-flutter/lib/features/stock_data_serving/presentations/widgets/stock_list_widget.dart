import 'package:flutter/material.dart';

class StockRow extends StatelessWidget {
  final String logo;
  final String symbol;
  final String name;
  final String dividend;
  final String yield;
  final String target;
  final String payout;

  const StockRow({
    Key? key,
    required this.logo,
    required this.symbol,
    required this.name,
    required this.dividend,
    required this.yield,
    required this.target,
    required this.payout,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        children: [
          // Dividend
          Expanded(
            child: Center(child: Text(dividend, style: const TextStyle(fontSize: 14))),
          ),
          // Yield
          Expanded(
            child: Center(child: Text(yield, style: const TextStyle(fontSize: 14))),
          ),
          // Target
          Expanded(
            child: Center(child: Text(target, style: const TextStyle(fontSize: 14))),
          ),
          // Payout Ratio
          Expanded(
            child: Center(child: Text(payout, style: const TextStyle(fontSize: 14))),
          ),
        ],
      ),
    );
  }
}