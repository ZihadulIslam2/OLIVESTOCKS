class RevenueChartResponseModel {
  final double actual;
  final double estimate;
  final String period;
  final int quarter;
  final double surprise;
  final double surprisePercent;
  final String symbol;
  final int year;

  RevenueChartResponseModel({
    required this.actual,
    required this.estimate,
    required this.period,
    required this.quarter,
    required this.surprise,
    required this.surprisePercent,
    required this.symbol,
    required this.year,
  });

  factory RevenueChartResponseModel.fromJson(Map<String, dynamic> json) {
    return RevenueChartResponseModel(
      actual: _toDouble(json['actual']),
      estimate: _toDouble(json['estimate']),
      period: json['period']?.toString() ?? '',
      quarter: json['quarter'] as int? ?? 0,
      surprise: _toDouble(json['surprise']),
      surprisePercent: _toDouble(json['surprisePercent']),
      symbol: json['symbol']?.toString() ?? '',
      year: json['year'] as int? ?? 0,
    );
  }

  static double _toDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }

  Map<String, dynamic> toJson() => {
    'actual': actual,
    'estimate': estimate,
    'period': period,
    'quarter': quarter,
    'surprise': surprise,
    'surprisePercent': surprisePercent,
    'symbol': symbol,
    'year': year,
  };
}