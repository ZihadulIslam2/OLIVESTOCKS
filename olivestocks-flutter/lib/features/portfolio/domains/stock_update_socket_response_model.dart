class StockUpdateModel {
  final String symbol;
  final double currentPrice;
  final double change;
  final double percent;
  final String name;

  StockUpdateModel({
    required this.symbol,
    required this.currentPrice,
    required this.change,
    required this.percent,
    required this.name,
  });

  factory StockUpdateModel.fromJson(Map<String, dynamic> json) {
    return StockUpdateModel(
      symbol: json['symbol'] ?? '',
      name: json['name'] ?? '',
      currentPrice: (json['currentPrice'] ?? 0).toDouble(),
      change: (json['change'] ?? 0).toDouble(),
      percent: (json['percent'] ?? 0).toDouble(),
    );
  }
}
