import 'package:olive_stocks_flutter/features/experts/domain/sentiment_model.dart';

class StockModel{
  final String symbol;
  final String oliveStocksScore;
  final String ourChoiceSince;
  final String price;
  final String marketCap;
  final String peRatio;
  final String sector;
  final String dividendYield;
  final String yearlyGain;
  final SentimentModel newsSentiment;
  final SentimentModel investor;
  final SentimentModel blogger;

  StockModel({
    required this.symbol,
    required this.oliveStocksScore,
    required this.ourChoiceSince,
    required this.price,
    required this.marketCap,
    required this.peRatio,
    required this.sector,
    required this.dividendYield,
    required this.yearlyGain,
    required this.newsSentiment,
    required this.investor,
    required this.blogger,
  });
}