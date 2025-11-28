class MostTradedStocksResponseModel {
  bool? success;
  String? message;
  List<TrendingStocks>? trendingStocks;
  List<TrendingStocks>? topStocks;

  MostTradedStocksResponseModel({
    this.success,
    this.message,
    this.trendingStocks,
    this.topStocks,
  });

  MostTradedStocksResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];

    if (json['trendingStocks'] != null) {
      trendingStocks = [];
      json['trendingStocks'].forEach((v) {
        trendingStocks!.add(TrendingStocks.fromJson(v));
      });
    }

    if (json['topStocks'] != null) {
      topStocks = [];
      json['topStocks'].forEach((v) {
        topStocks!.add(TrendingStocks.fromJson(v));
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
  double? upsidePercent;

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
  });

  TrendingStocks.fromJson(Map<String, dynamic> json) {
    symbol = json['symbol'];
    currentPrice = _parseToDouble(json['currentPrice']) ?? 0.0;
    priceChange = _parseToDouble(json['priceChange']);
    percentChange = _parseToDouble(json['percentChange'] ) ?? 0.0;
    buy = json['buy'];
    hold = json['hold'];
    sell = json['sell'];
    targetMean = _parseToDouble(json['targetMean']);
    upsidePercent = _parseToDouble(json['upsidePercent']);
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
    return data;
  }

  /// Helper function to parse a dynamic value to double safely
  double? _parseToDouble(dynamic value) {
    if (value == null) {
      return null;
    }
    if (value is double) {
      return value;
    }
    if (value is String) {
      return double.tryParse(value);
    }
    return null; // For unexpected data types
  }
}

