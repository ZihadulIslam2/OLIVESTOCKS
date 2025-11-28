class EarningsChartResponseModel {
  double? actual;
  double? estimate;
  String? period;
  int? quarter;
  double? surprise;
  double? surprisePercent;
  String? symbol;
  int? year;

  EarningsChartResponseModel({
    this.actual,
    this.estimate,
    this.period,
    this.quarter,
    this.surprise,
    this.surprisePercent,
    this.symbol,
    this.year,
  });

  EarningsChartResponseModel.fromJson(Map<String, dynamic> json) {
    actual = (json['actual'] as num?)?.toDouble();
    estimate = (json['estimate'] as num?)?.toDouble();
    period = json['period'] as String?;
    quarter = json['quarter'] as int?;
    surprise = (json['surprise'] as num?)?.toDouble();
    surprisePercent = (json['surprisePercent'] as num?)?.toDouble();
    symbol = json['symbol'] as String?;
    year = json['year'] as int?;
  }

  Map<String, dynamic> toJson() {
    return {
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
}
