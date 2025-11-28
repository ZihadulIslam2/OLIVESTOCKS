import 'package:flutter/material.dart';


class BloggerConsensusModel {
  final double strongBuy;
  final double moderateBuy;
  final double hold;
  final String ratingLabel;

  BloggerConsensusModel({
    required this.strongBuy,
    required this.moderateBuy,
    required this.hold,
    required this.ratingLabel,
  });

  Color get ratingColor {
    switch (ratingLabel) {
      case 'Strong Buy':
        return Colors.red;
      case 'Moderate Buy':
        return Colors.yellow;
      case 'Hold':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}