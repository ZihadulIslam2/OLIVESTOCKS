class DailyGainerAndDailyLooserResponseModel {
  bool? success;
  List<Gainers>? gainers;
  List<Losers>? losers;

  DailyGainerAndDailyLooserResponseModel({this.success, this.gainers, this.losers});

  DailyGainerAndDailyLooserResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['gainers'] != null) {
      gainers = <Gainers>[];
      json['gainers'].forEach((v) {
        gainers!.add(Gainers.fromJson(v));
      });
    }
    if (json['losers'] != null) {
      losers = <Losers>[];
      json['losers'].forEach((v) {
        losers!.add(Losers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (gainers != null) {
      data['gainers'] = gainers!.map((v) => v.toJson()).toList();
    }
    if (losers != null) {
      data['losers'] = losers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Gainers {
  String? symbol;
  String? name;
  double? currentPrice;
  String? changePercent;
  String? change;
  bool? isUp;

  Gainers({
    this.symbol,
    this.name,
    this.currentPrice,
    this.changePercent,
    this.change,
    this.isUp,
  });

  Gainers.fromJson(Map<String, dynamic> json) {
    symbol = json['symbol'];
    name = json['name'];
    currentPrice = json['currentPrice']?.toDouble(); // Ensure double conversion
    changePercent = json['changePercent'];
    change = json['change'];
    isUp = json['isUp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['symbol'] = symbol;
    data['name'] = name;
    data['currentPrice'] = currentPrice;
    data['changePercent'] = changePercent;
    data['change'] = change;
    data['isUp'] = isUp;
    return data;
  }
}

class Losers {
  String? symbol;
  String? name;
  double? currentPrice;
  String? changePercent;
  String? change;
  bool? isUp;

  Losers({
    this.symbol,
    this.name,
    this.currentPrice,
    this.changePercent,
    this.change,
    this.isUp,
  });

  Losers.fromJson(Map<String, dynamic> json) {
    symbol = json['symbol'];
    name = json['name'];
    currentPrice = json['currentPrice']?.toDouble(); // Ensure double conversion
    changePercent = json['changePercent'];
    change = json['change'];
    isUp = json['isUp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['symbol'] = symbol;
    data['name'] = name;
    data['currentPrice'] = currentPrice;
    data['changePercent'] = changePercent;
    data['change'] = change;
    data['isUp'] = isUp;
    return data;
  }
}
