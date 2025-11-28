class EPSChartResponseModel {
  double? actual;
  double? estimate;
  String? period;
  int? quarter;
  double? surprise;
  double? surprisePercent;
  String? symbol;
  int? year;

  EPSChartResponseModel({
    this.actual,
    this.estimate,
    this.period,
    this.quarter,
    this.surprise,
    this.surprisePercent,
    this.symbol,
    this.year,
  });

  EPSChartResponseModel.fromJson(Map<String, dynamic> json) {
    actual = json['actual'] != null ? double.tryParse(json['actual'].toString()) : null;
    estimate = json['estimate'] != null ? double.tryParse(json['estimate'].toString()) : null;
    period = json['period'] as String?;
    quarter = json['quarter'] as int?;
    surprise = json['surprise'] != null ? double.tryParse(json['surprise'].toString()) : null;
    surprisePercent = json['surprisePercent'] != null ? double.tryParse(json['surprisePercent'].toString()) : null;
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
