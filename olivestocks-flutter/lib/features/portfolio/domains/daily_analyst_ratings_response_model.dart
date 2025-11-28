class DailyAnalystRatingsResponseModel {
  List<QualityStocks>? qualityStocks;

  DailyAnalystRatingsResponseModel({this.qualityStocks});

  DailyAnalystRatingsResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['qualityStocks'] != null) {
      qualityStocks = <QualityStocks>[];
      json['qualityStocks'].forEach((v) {
        qualityStocks!.add(QualityStocks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.qualityStocks != null) {
      data['qualityStocks'] =
          this.qualityStocks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class QualityStocks {
  String? symbol;
  String? companyName;
  String? logo;
  String? sector;
  String? marketCap;
  String? oneMonthReturn;
  String? stockRating;
  String? analystTarget;
  RatingTrend? ratingTrend;
  String? lastRatingDate;
  String? quadrant;
  String? valuationColor;
  Olives? olives;

  QualityStocks(
      {this.symbol,
        this.companyName,
        this.logo,
        this.sector,
        this.marketCap,
        this.oneMonthReturn,
        this.stockRating,
        this.analystTarget,
        this.ratingTrend,
        this.lastRatingDate,
        this.quadrant,
        this.valuationColor,
        this.olives});

  QualityStocks.fromJson(Map<String, dynamic> json) {
    symbol = json['symbol'];
    companyName = json['companyName'];
    logo = json['logo'];
    sector = json['sector'];
    marketCap = json['marketCap'];
    oneMonthReturn = json['oneMonthReturn'];
    stockRating = json['stockRating'];
    analystTarget = json['analystTarget'];
    ratingTrend = json['ratingTrend'] != null
        ? RatingTrend.fromJson(json['ratingTrend'])
        : null;
    lastRatingDate = json['lastRatingDate'];
    quadrant = json['quadrant'];
    valuationColor = json['valuationColor'];
    olives =
    json['olives'] != null ? Olives.fromJson(json['olives']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['symbol'] = this.symbol;
    data['companyName'] = this.companyName;
    data['logo'] = this.logo;
    data['sector'] = this.sector;
    data['marketCap'] = this.marketCap;
    data['oneMonthReturn'] = this.oneMonthReturn;
    data['stockRating'] = this.stockRating;
    data['analystTarget'] = this.analystTarget;
    if (this.ratingTrend != null) {
      data['ratingTrend'] = this.ratingTrend!.toJson();
    }
    data['lastRatingDate'] = this.lastRatingDate;
    data['quadrant'] = this.quadrant;
    data['valuationColor'] = this.valuationColor;
    if (this.olives != null) {
      data['olives'] = this.olives!.toJson();
    }
    return data;
  }
}

class RatingTrend {
  int? buy;
  int? hold;
  int? sell;

  RatingTrend({this.buy, this.hold, this.sell});

  RatingTrend.fromJson(Map<String, dynamic> json) {
    buy = json['buy'];
    hold = json['hold'];
    sell = json['sell'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['buy'] = this.buy;
    data['hold'] = this.hold;
    data['sell'] = this.sell;
    return data;
  }
}

class Olives {
  String? financialHealth;
  String? competitiveAdvantage;
  String? valuation;

  Olives({this.financialHealth, this.competitiveAdvantage, this.valuation});

  Olives.fromJson(Map<String, dynamic> json) {
    financialHealth = json['financialHealth'];
    competitiveAdvantage = json['competitiveAdvantage'];
    valuation = json['valuation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['financialHealth'] = this.financialHealth;
    data['competitiveAdvantage'] = this.competitiveAdvantage;
    data['valuation'] = this.valuation;
    return data;
  }
}
