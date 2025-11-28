class CashFlowChartResponseModel {
  String? symbol;
  List<CashFlows>? cashFlows;

  CashFlowChartResponseModel({this.symbol, this.cashFlows});

  CashFlowChartResponseModel.fromJson(Map<String, dynamic> json) {
    symbol = json['symbol'] as String?;
    if (json['cashFlows'] != null) {
      cashFlows = (json['cashFlows'] as List)
          .map((v) => CashFlows.fromJson(v as Map<String, dynamic>))
          .toList();
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'symbol': symbol,
      'cashFlows': cashFlows?.map((v) => v.toJson()).toList(),
    };
  }
}

class CashFlows {
  int? year;
  double? operatingCashFlow;
  double? investingCashFlow;
  double? financingCashFlow;

  CashFlows({
    this.year,
    this.operatingCashFlow,
    this.investingCashFlow,
    this.financingCashFlow,
  });

  CashFlows.fromJson(Map<String, dynamic> json) {
    year = json['year'] as int?;
    operatingCashFlow = (json['operatingCashFlow'] as num?)?.toDouble();
    investingCashFlow = (json['investingCashFlow'] as num?)?.toDouble();
    financingCashFlow = (json['financingCashFlow'] as num?)?.toDouble();
  }

  Map<String, dynamic> toJson() {
    return {
      'year': year,
      'operatingCashFlow': operatingCashFlow,
      'investingCashFlow': investingCashFlow,
      'financingCashFlow': financingCashFlow,
    };
  }
}
