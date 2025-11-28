import 'package:flutter/material.dart';


class StockSentimentModel {
  final double strongBuy;
  final double moderateBuy;
  final double hold;
  final double strongSell;
  final double moderateSell;
  final String ratingLabel;

  StockSentimentModel({
    required this.strongBuy,
    required this.moderateBuy,
    required this.hold,
    required this.strongSell,
    required this.moderateSell,
    required this.ratingLabel,
  });

  Color get ratingColor {
    switch (ratingLabel) {
      case 'Strong Buy':
        return Colors.green;
      case 'Moderate Buy':
        return Colors.green;
      case 'Hold':
        return Colors.grey;
      case 'Moderate Sell':
        return Colors.red;
      case 'Strong Sell':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}