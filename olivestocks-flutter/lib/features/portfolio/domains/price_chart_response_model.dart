class PriceChartResponseModel {
  bool? success;
  Data? data;

  PriceChartResponseModel({this.success, this.data});

  PriceChartResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  Company? company;
  PriceInfo? priceInfo;
  List<Chart>? chart;
  List<Earnings>? earnings;
  List<String>? actions;

  Data({this.company, this.priceInfo, this.chart, this.earnings, this.actions});

  Data.fromJson(Map<String, dynamic> json) {
    company = json['company'] != null ? Company.fromJson(json['company']) : null;
    priceInfo = json['priceInfo'] != null ? PriceInfo.fromJson(json['priceInfo']) : null;

    if (json['chart'] != null) {
      chart = <Chart>[];
      json['chart'].forEach((v) {
        chart!.add(Chart.fromJson(v));
      });
    }

    if (json['earnings'] != null) {
      earnings = <Earnings>[];
      json['earnings'].forEach((v) {
        earnings!.add(Earnings.fromJson(v));
      });
    }

    actions = json['actions'] != null ? List<String>.from(json['actions']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (company != null) {
      data['company'] = company!.toJson();
    }
    if (priceInfo != null) {
      data['priceInfo'] = priceInfo!.toJson();
    }
    if (chart != null) {
      data['chart'] = chart!.map((v) => v.toJson()).toList();
    }
    if (earnings != null) {
      data['earnings'] = earnings!.map((v) => v.toJson()).toList();
    }
    data['actions'] = actions;
    return data;
  }
}

class Company {
  String? name;
  String? symbol;
  String? exchange;
  String? logo;

  Company({this.name, this.symbol, this.exchange, this.logo});

  Company.fromJson(Map<String, dynamic> json) {
    name = json['name']?.toString();
    symbol = json['symbol']?.toString();
    exchange = json['exchange']?.toString() ?? '';
    logo = json['logo']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['name'] = name;
    data['symbol'] = symbol;
    data['exchange'] = exchange;
    data['logo'] = logo;
    return data;
  }
}


class PriceInfo {
  double? currentPrice;
  double? change;
  double? percentChange;

  PriceInfo({this.currentPrice, this.change, this.percentChange});

  PriceInfo.fromJson(Map<String, dynamic> json) {
    currentPrice = _toDouble(json['currentPrice']);
    change = _toDouble(json['change']);
    percentChange = _toDouble(json['percentChange']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['currentPrice'] = currentPrice;
    data['change'] = change;
    data['percentChange'] = percentChange;
    return data;
  }
}

class Chart {
  int? time;
  double? open;
  double? close;
  double? high;
  double? low;
  int? volume;

  Chart({this.time, this.open, this.close, this.high, this.low, this.volume});

  Chart.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    open = _toDouble(json['open']);
    close = _toDouble(json['close']);
    high = _toDouble(json['high']);
    low = _toDouble(json['low']);
    volume = json['volume'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['time'] = time;
    data['open'] = open;
    data['close'] = close;
    data['high'] = high;
    data['low'] = low;
    data['volume'] = volume;
    return data;
  }
}

class Earnings {
  double? actual;
  double? estimate;
  String? period;
  double? surprise;

  Earnings({this.actual, this.estimate, this.period, this.surprise});

  Earnings.fromJson(Map<String, dynamic> json) {
    actual = _toDouble(json['actual']);
    estimate = _toDouble(json['estimate']);
    period = json['period'];
    surprise = _toDouble(json['surprise']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['actual'] = actual;
    data['estimate'] = estimate;
    data['period'] = period;
    data['surprise'] = surprise;
    return data;
  }
}

/// Helper to convert int or double to double
double? _toDouble(dynamic value) {
  if (value == null) return null;
  if (value is double) return value;
  if (value is int) return value.toDouble();
  return double.tryParse(value.toString());
}
