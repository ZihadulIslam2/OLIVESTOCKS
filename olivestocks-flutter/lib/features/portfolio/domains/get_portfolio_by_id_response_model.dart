class GetPortfolioByIdResponseModel {
  String? sId;
  String? name;
  String? user;
  double? cash; // changed to double for flexibility
  List<Stocks>? stocks;
  String? createdAt;
  String? updatedAt;
  int? iV;

  GetPortfolioByIdResponseModel({
    this.sId,
    this.name,
    this.user,
    this.cash,
    this.stocks,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  GetPortfolioByIdResponseModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    user = json['user'];
    cash = json['cash'] != null ? (json['cash'] as num).toDouble() : null;
    if (json['stocks'] != null) {
      stocks = (json['stocks'] as List)
          .map((v) => Stocks.fromJson(v))
          .toList();
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['user'] = user;
    data['cash'] = cash;
    if (stocks != null) {
      data['stocks'] = stocks!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class Stocks {
  String? symbol;
  int? quantity;
  double? price;
  String? date;
  List<Transection>? transection;
  String? sId;

  Stocks({
    this.symbol,
    this.quantity,
    this.price,
    this.date,
    this.transection,
    this.sId,
  });

  Stocks.fromJson(Map<String, dynamic> json) {
    symbol = json['symbol'];
    quantity = json['quantity'] != null ? (json['quantity'] as num).toInt() : null;
    price = json['price'] != null ? (json['price'] as num).toDouble() : null;
    date = json['date'];
    if (json['transection'] != null) {
      transection = (json['transection'] as List)
          .map((v) => Transection.fromJson(v))
          .toList();
    }
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['symbol'] = symbol;
    data['quantity'] = quantity;
    data['price'] = price;
    data['date'] = date;
    if (transection != null) {
      data['transection'] = transection!.map((v) => v.toJson()).toList();
    }
    data['_id'] = sId;
    return data;
  }
}

class Transection {
  String? event;
  double? price;
  int? quantity;
  String? sId;

  Transection({
    this.event,
    this.price,
    this.quantity,
    this.sId,
  });

  Transection.fromJson(Map<String, dynamic> json) {
    event = json['event'];
    price = json['price'] != null ? (json['price'] as num).toDouble() : null;
    quantity = json['quantity'] != null ? (json['quantity'] as num).toInt() : null;
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['event'] = event;
    data['price'] = price;
    data['quantity'] = quantity;
    data['_id'] = sId;
    return data;
  }
}
