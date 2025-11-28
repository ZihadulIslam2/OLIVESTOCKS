import 'package:olive_stocks_flutter/features/experts/domain/sentiment_model_stock_scanner.dart';

import 'blogger_consensus_model.dart';

class StockScreenerModel {
  final String symbol;
  final String name;
  final String logo;
  final String price;
  final String priceChange;
  final String smartScore;
  final String sector;
  final String analystConsensus;
  final String analystPriceTarget;
  final String analystPriceTargetChange;
  final String marketCap;
  final String topAnalystConsensus;
  final String topAnalystPriceTarget;
  final String insiderSignal;
  final String hedgeFundSignal;
  final String dividendYield;
  final BloggerConsensusModel bloggerConsensus;
  final StockSentimentModel newsSentiment;

  StockScreenerModel({
    required this.symbol,
    required this.name,
    required this.logo,
    required this.price,
    required this.priceChange,
    required this.smartScore,
    required this.sector,
    required this.analystConsensus,
    required this.analystPriceTarget,
    required this.analystPriceTargetChange,
    required this.marketCap,
    required this.topAnalystConsensus,
    required this.topAnalystPriceTarget,
    required this.insiderSignal,
    required this.hedgeFundSignal,
    required this.dividendYield,
    required this.bloggerConsensus,
    required this.newsSentiment,
  });
}
