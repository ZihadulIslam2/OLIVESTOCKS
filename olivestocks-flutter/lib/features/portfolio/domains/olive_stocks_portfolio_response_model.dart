class OliveStocksPortfolioResponseModel {
  List<OliveStocks>? oliveStocks;

  OliveStocksPortfolioResponseModel({this.oliveStocks});

  OliveStocksPortfolioResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['OliveStocks'] != null) {
      oliveStocks = <OliveStocks>[];
      json['OliveStocks'].forEach((v) {
        oliveStocks!.add(OliveStocks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (oliveStocks != null) {
      data['OliveStocks'] = oliveStocks!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    return 'OliveStocksPortfolioResponseModel{oliveStocks: $oliveStocks}';
  }
}

class OliveStocks {
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

  OliveStocks(
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

  OliveStocks.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['symbol'] = symbol;
    data['companyName'] = companyName;
    data['logo'] = logo;
    data['sector'] = sector;
    data['marketCap'] = marketCap;
    data['oneMonthReturn'] = oneMonthReturn;
    data['stockRating'] = stockRating;
    data['analystTarget'] = analystTarget;
    if (ratingTrend != null) {
      data['ratingTrend'] = ratingTrend!.toJson();
    }
    data['lastRatingDate'] = lastRatingDate;
    data['quadrant'] = quadrant;
    data['valuationColor'] = valuationColor;
    if (olives != null) {
      data['olives'] = olives!.toJson();
    }
    return data;
  }


  @override
  String toString() {
    return 'OliveStocks{symbol: $symbol, companyName: $companyName, logo: $logo, sector: $sector, marketCap: $marketCap, oneMonthReturn: $oneMonthReturn, stockRating: $stockRating, analystTarget: $analystTarget, ratingTrend: $ratingTrend, lastRatingDate: $lastRatingDate, quadrant: $quadrant, valuationColor: $valuationColor, olives: $olives}';
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['buy'] = buy;
    data['hold'] = hold;
    data['sell'] = sell;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['financialHealth'] = financialHealth;
    data['competitiveAdvantage'] = competitiveAdvantage;
    data['valuation'] = valuation;
    return data;
  }
}
