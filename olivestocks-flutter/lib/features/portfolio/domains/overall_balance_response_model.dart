class OverallBalanceResponseModel {
  String? totalHoldings;
  double? cash;
  String? totalValueWithCash;
  String? dailyReturn;
  String? dailyReturnPercent;
  String? monthlyReturnPercent;
  List<Holding>? holdings;
  String? unrealizedGains;
  String? overallReturnPercent;

  OverallBalanceResponseModel({
    this.totalHoldings,
    this.cash,
    this.totalValueWithCash,
    this.dailyReturn,
    this.dailyReturnPercent,
    this.monthlyReturnPercent,
    this.holdings,
    this.unrealizedGains,
    this.overallReturnPercent,
  });

  factory OverallBalanceResponseModel.fromJson(Map<String, dynamic> json) {
    double? toDouble(dynamic value) {
      if (value == null) return null;
      if (value is double) return value;
      if (value is int) return value.toDouble();
      if (value is String) return double.tryParse(value);
      return null;
    }

    return OverallBalanceResponseModel(
      totalHoldings: json['totalHoldings']?.toString(),
      cash: toDouble(json['cash']),
      totalValueWithCash: json['totalValueWithCash']?.toString(),
      dailyReturn: json['dailyReturn']?.toString(),
      dailyReturnPercent: json['dailyReturnPercent']?.toString(),
      monthlyReturnPercent: json['monthlyReturnPercent']?.toString(),
      holdings: json['holdings'] != null
          ? List<Holding>.from(json['holdings'].map((x) => Holding.fromJson(x)))
          : null,
      unrealizedGains: json['unrealizedGains']?.toString(),
      overallReturnPercent: json['overallReturnPercent']?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
    'totalHoldings': totalHoldings,
    'cash': cash,
    'totalValueWithCash': totalValueWithCash,
    'dailyReturn': dailyReturn,
    'dailyReturnPercent': dailyReturnPercent,
    'monthlyReturnPercent': monthlyReturnPercent,
    'holdings': holdings?.map((x) => x.toJson()).toList(),
    'unrealizedGains': unrealizedGains,
    'overallReturnPercent': overallReturnPercent,
  };
}

class Holding {
  String? logo;
  String? name;
  String? symbol;
  int? shares;
  double? avgBuyPrice;
  double? costBasis;
  String? holdingPrice;
  String? holdingGain;
  double? price;
  double? preMarketPrice;
  double? preMarketChangePercent;
  double? change;
  double? percent;
  String? value;
  String? unrealized;
  String? pL;
  OliveIndicators? olives;
  int? quadrant;
  String? oneMonthReturn;
  PriceTarget? priceTarget;

  Holding({
    this.logo,
    this.name,
    this.symbol,
    this.shares,
    this.avgBuyPrice,
    this.costBasis,
    this.holdingPrice,
    this.holdingGain,
    this.price,
    this.preMarketPrice,
    this.preMarketChangePercent,
    this.change,
    this.percent,
    this.value,
    this.unrealized,
    this.pL,
    this.olives,
    this.quadrant,
    this.oneMonthReturn,
    this.priceTarget,
  });

  factory Holding.fromJson(Map<String, dynamic> json) {
    double? toDouble(dynamic value) {
      if (value == null) return null;
      if (value is double) return value;
      if (value is int) return value.toDouble();
      if (value is String) return double.tryParse(value);
      return null;
    }

    int? toInt(dynamic value) {
      if (value == null) return null;
      if (value is int) return value;
      if (value is double) return value.toInt();
      if (value is String) return int.tryParse(value);
      return null;
    }

    return Holding(
      logo: json['logo'],
      name: json['name'],
      symbol: json['symbol'],
      shares: toInt(json['shares']),
      avgBuyPrice: toDouble(json['avgBuyPrice']),
      costBasis: toDouble(json['costBasis']),
      holdingPrice: json['holdingPrice']?.toString(),
      holdingGain: json['holdingGain']?.toString(),
      price: toDouble(json['price']),
      preMarketPrice: toDouble(json['preMarketPrice']),
      preMarketChangePercent: toDouble(json['preMarketChangePercent']),
      change: toDouble(json['change']),
      percent: toDouble(json['percent']),
      value: json['value']?.toString(),
      unrealized: json['unrealized']?.toString(),
      pL: json['pL']?.toString(),
      olives: json['olives'] != null ? OliveIndicators.fromJson(json['olives']) : null,
      quadrant: toInt(json['quadrant']),
      oneMonthReturn: json['oneMonthReturn']?.toString(),
      priceTarget: json['priceTarget'] != null ? PriceTarget.fromJson(json['priceTarget']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'logo': logo,
    'name': name,
    'symbol': symbol,
    'shares': shares,
    'avgBuyPrice': avgBuyPrice,
    'costBasis': costBasis,
    'holdingPrice': holdingPrice,
    'holdingGain': holdingGain,
    'price': price,
    'preMarketPrice': preMarketPrice,
    'preMarketChangePercent': preMarketChangePercent,
    'change': change,
    'percent': percent,
    'value': value,
    'unrealized': unrealized,
    'pL': pL,
    'olives': olives?.toJson(),
    'quadrant': quadrant,
    'oneMonthReturn': oneMonthReturn,
    'priceTarget': priceTarget?.toJson(),
  };
}

class OliveIndicators {
  String? financialHealth;
  String? competitiveAdvantage;
  String? valuation;

  OliveIndicators({
    this.financialHealth,
    this.competitiveAdvantage,
    this.valuation,
  });

  factory OliveIndicators.fromJson(Map<String, dynamic> json) {
    return OliveIndicators(
      financialHealth: json['financialHealth'],
      competitiveAdvantage: json['competitiveAdvantage'],
      valuation: json['valuation'],
    );
  }

  Map<String, dynamic> toJson() => {
    'financialHealth': financialHealth,
    'competitiveAdvantage': competitiveAdvantage,
    'valuation': valuation,
  };
}

class PriceTarget {
  double? high;
  double? low;
  double? mean;

  PriceTarget({this.high, this.low, this.mean});

  factory PriceTarget.fromJson(Map<String, dynamic> json) {
    double? toDouble(dynamic value) {
      if (value == null) return null;
      if (value is double) return value;
      if (value is int) return value.toDouble();
      if (value is String) return double.tryParse(value);
      return null;
    }

    return PriceTarget(
      high: toDouble(json['high']),
      low: toDouble(json['low']),
      mean: toDouble(json['mean']),
    );
  }

  Map<String, dynamic> toJson() => {
    'high': high,
    'low': low,
    'mean': mean,
  };
}
