class SearchStockResponseModel {
  bool? success;
  List<Results>? results;

  SearchStockResponseModel({this.success, this.results});

  SearchStockResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'] ?? false;
    if (json['results'] != null) {
      results = (json['results'] as List<dynamic>)
          .map((e) => Results.fromJson(e))
          .toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  String? logo;
  String? symbol;
  String? description;
  String? exchange;
  String? flag;
  double? price;
  double? change;
  double? percentChange;
  GetStockdetailsData? getStockdetailsData;

  Results({
    this.logo,
    this.symbol,
    this.description,
    this.exchange,
    this.flag,
    this.price,
    this.change,
    this.percentChange,
    this.getStockdetailsData,
  });

  Results.fromJson(Map<String, dynamic> json) {
    logo = json['logo'] ?? '';
    symbol = json['symbol'] ?? '';
    description = json['description'] ?? '';
    exchange = json['exchange'] ?? '';
    flag = json['flag'] ?? '';
    price = (json['price'] ?? 0).toDouble();
    change = (json['change'] ?? 0).toDouble();
    percentChange = (json['percentChange'] ?? 0).toDouble();
    getStockdetailsData = json['getStockdetailsData'] != null
        ? GetStockdetailsData.fromJson(json['getStockdetailsData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['logo'] = logo;
    data['symbol'] = symbol;
    data['description'] = description;
    data['exchange'] = exchange;
    data['flag'] = flag;
    data['price'] = price;
    data['change'] = change;
    data['percentChange'] = percentChange;
    if (getStockdetailsData != null) {
      data['getStockdetailsData'] = getStockdetailsData!.toJson();
    }
    return data;
  }
}

class GetStockdetailsData {
  String? symbol;
  double? currentPrice;
  double? priceChange;
  double? percentChange;
  int? buy;
  int? hold;
  int? sell;
  double? targetMean;
  String? upsidePercent;

  GetStockdetailsData({
    this.symbol,
    this.currentPrice,
    this.priceChange,
    this.percentChange,
    this.buy,
    this.hold,
    this.sell,
    this.targetMean,
    this.upsidePercent,
  });

  GetStockdetailsData.fromJson(Map<String, dynamic> json) {
    symbol = json['symbol'] ?? '';
    currentPrice = (json['currentPrice'] ?? 0).toDouble();
    priceChange = (json['priceChange'] ?? 0).toDouble();
    percentChange = (json['percentChange'] ?? 0).toDouble();
    buy = json['buy'] ?? 0;
    hold = json['hold'] ?? 0;
    sell = json['sell'] ?? 0;
    targetMean = (json['targetMean'] ?? 0).toDouble();
    upsidePercent = json['upsidePercent'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['symbol'] = symbol;
    data['currentPrice'] = currentPrice;
    data['priceChange'] = priceChange;
    data['percentChange'] = percentChange;
    data['buy'] = buy;
    data['hold'] = hold;
    data['sell'] = sell;
    data['targetMean'] = targetMean;
    data['upsidePercent'] = upsidePercent;
    return data;
  }
}
