class GetWatchListResponseModel {
  bool? success;
  List<Data>? data;

  GetWatchListResponseModel({this.success, this.data});

  GetWatchListResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'] as bool?;
    if (json['data'] != null) {
      data = (json['data'] as List<dynamic>)
          .map((item) => Data.fromJson(item as Map<String, dynamic>))
          .toList();
    }
  }

  Map<String, dynamic> toJson() => {
    'success': success,
    'data': data?.map((item) => item.toJson()).toList(),
  };
}

class Data {
  String? symbol;
  String? name;
  String? logo;
  String? sector;
  double? marketCap;
  double? change;
  double? currentPrice;
  String? analystTarget;
  Olives? olives;
  RatingTrend? ratingTrend;

  Data({
    this.symbol,
    this.name,
    this.logo,
    this.sector,
    this.marketCap,
    this.change,
    this.currentPrice,
    this.analystTarget,
    this.olives,
    this.ratingTrend,
  });

  Data.fromJson(Map<String, dynamic> json) {
    symbol = json['symbol'] as String?;
    name = json['name'] as String?;
    logo = json['logo'] as String?;
    sector = json['sector'] as String?;
    marketCap = (json['marketCap'] as num?)?.toDouble();
    change = (json['change'] as num?)?.toDouble();
    currentPrice = (json['currentPrice'] as num?)?.toDouble();
    analystTarget = json['analystTarget'] as String?;
    olives = json['olives'] != null
        ? Olives.fromJson(json['olives'] as Map<String, dynamic>)
        : null;
    ratingTrend = json['ratingTrend'] != null
        ? RatingTrend.fromJson(json['ratingTrend'] as Map<String, dynamic>)
        : null;
  }

  Map<String, dynamic> toJson() => {
    'symbol': symbol,
    'name': name,
    'logo': logo,
    'sector': sector,
    'marketCap': marketCap,
    'change': change,
    'currentPrice': currentPrice,
    'analystTarget': analystTarget,
    'olives': olives?.toJson(),
    'ratingTrend': ratingTrend?.toJson(),
  };
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
    financialHealth = json['financialHealth'] as String?;
    competitiveAdvantage = json['competitiveAdvantage'] as String?;
    valuation = json['valuation'] as String?;
  }

  Map<String, dynamic> toJson() => {
    'financialHealth': financialHealth,
    'competitiveAdvantage': competitiveAdvantage,
    'valuation': valuation,
  };
}

class RatingTrend {
  int? buy;
  int? hold;
  int? sell;

  RatingTrend({
    this.buy,
    this.hold,
    this.sell,
  });

  RatingTrend.fromJson(Map<String, dynamic> json) {
    buy = json['buy'] as int?;
    hold = json['hold'] as int?;
    sell = json['sell'] as int?;
  }

  Map<String, dynamic> toJson() => {
    'buy': buy,
    'hold': hold,
    'sell': sell,
  };
}
