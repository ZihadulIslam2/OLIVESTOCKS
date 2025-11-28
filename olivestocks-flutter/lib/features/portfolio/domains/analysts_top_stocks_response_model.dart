class AnalystsTopStocksResponseModel {
  bool? success;
  String? message;
  List<TrendingStocks>? trendingStocks;
  List<TopStocks>? topStocks;

  AnalystsTopStocksResponseModel({
    this.success,
    this.message,
    this.trendingStocks,
    this.topStocks,
  });

  AnalystsTopStocksResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['trendingStocks'] != null) {
      trendingStocks = <TrendingStocks>[];
      json['trendingStocks'].forEach((v) {
        trendingStocks!.add(TrendingStocks.fromJson(v));
      });
    }
    if (json['topStocks'] != null) {
      topStocks = <TopStocks>[];
      json['topStocks'].forEach((v) {
        topStocks!.add(TopStocks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['success'] = success;
    data['message'] = message;
    if (trendingStocks != null) {
      data['trendingStocks'] = trendingStocks!.map((v) => v.toJson()).toList();
    }
    if (topStocks != null) {
      data['topStocks'] = topStocks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TrendingStocks {
  String? symbol;
  double? currentPrice;
  double? priceChange;
  double? percentChange;
  int? buy;
  int? hold;
  int? sell;
  double? targetMean;
  String? upsidePercent;
  String? quadrant;
  String? valuationColor;
  Olives? olives;

  TrendingStocks({
    this.symbol,
    this.currentPrice,
    this.priceChange,
    this.percentChange,
    this.buy,
    this.hold,
    this.sell,
    this.targetMean,
    this.upsidePercent,
    this.quadrant,
    this.valuationColor,
    this.olives,
  });

  TrendingStocks.fromJson(Map<String, dynamic> json) {
    symbol = json['symbol'];
    currentPrice = (json['currentPrice'] as num?)?.toDouble();
    priceChange = (json['priceChange'] as num?)?.toDouble();
    percentChange = (json['percentChange'] as num?)?.toDouble();
    buy = json['buy'];
    hold = json['hold'];
    sell = json['sell'];
    targetMean = (json['targetMean'] as num?)?.toDouble();
    upsidePercent = json['upsidePercent']?.toString();
    quadrant = json['quadrant'];
    valuationColor = json['valuationColor'];
    olives = json['olives'] != null ? Olives.fromJson(json['olives']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['symbol'] = symbol;
    data['currentPrice'] = currentPrice;
    data['priceChange'] = priceChange;
    data['percentChange'] = percentChange;
    data['buy'] = buy;
    data['hold'] = hold;
    data['sell'] = sell;
    data['targetMean'] = targetMean;
    data['upsidePercent'] = upsidePercent;
    data['quadrant'] = quadrant;
    data['valuationColor'] = valuationColor;
    if (olives != null) {
      data['olives'] = olives!.toJson();
    }
    return data;
  }
}

class Olives {
  String? financialHealth;
  String? competitiveAdvantage;
  String? valuation;

  Olives({
    this.financialHealth,
    this.competitiveAdvantage,
    this.valuation,
  });

  Olives.fromJson(Map<String, dynamic> json) {
    financialHealth = json['financialHealth'];
    competitiveAdvantage = json['competitiveAdvantage'];
    valuation = json['valuation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['financialHealth'] = financialHealth;
    data['competitiveAdvantage'] = competitiveAdvantage;
    data['valuation'] = valuation;
    return data;
  }
}

// Dummy TopStocks class (customize based on your real API fields)
class TopStocks {
  String? symbol;
  double? currentPrice;
  double? priceChange;
  double? percentChange;
  int? buy;
  int? hold;
  int? sell;
  double? targetMean;
  String? upsidePercent;
  String? quadrant;
  String? valuationColor;
  Olives? olives;

  TopStocks({
    this.symbol,
    this.currentPrice,
    this.priceChange,
    this.percentChange,
    this.buy,
    this.hold,
    this.sell,
    this.targetMean,
    this.upsidePercent,
    this.quadrant,
    this.valuationColor,
    this.olives,
  });

  TopStocks.fromJson(Map<String, dynamic> json) {
    symbol = json['symbol'];
    currentPrice = (json['currentPrice'] as num?)?.toDouble();
    priceChange = (json['priceChange'] as num?)?.toDouble();
    percentChange = (json['percentChange'] as num?)?.toDouble();
    buy = json['buy'];
    hold = json['hold'];
    sell = json['sell'];
    targetMean = (json['targetMean'] as num?)?.toDouble();
    upsidePercent = json['upsidePercent']?.toString();
    quadrant = json['quadrant'];
    valuationColor = json['valuationColor'];
    olives = json['olives'] != null ? Olives.fromJson(json['olives']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['symbol'] = symbol;
    data['currentPrice'] = currentPrice;
    data['priceChange'] = priceChange;
    data['percentChange'] = percentChange;
    data['buy'] = buy;
    data['hold'] = hold;
    data['sell'] = sell;
    data['targetMean'] = targetMean;
    data['upsidePercent'] = upsidePercent;
    data['quadrant'] = quadrant;
    data['valuationColor'] = valuationColor;
    if (olives != null) {
      data['olives'] = olives!.toJson();
    }
    return data;
  }
}
