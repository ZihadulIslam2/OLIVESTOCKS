class DeletePortfolioFromPortfolioResponseModel {
  String? message;
  Portfolio? portfolio;

  DeletePortfolioFromPortfolioResponseModel({this.message, this.portfolio});

  DeletePortfolioFromPortfolioResponseModel.fromJson(
      Map<String, dynamic> json) {
    message = json['message'];
    portfolio = json['portfolio'] != null
        ? Portfolio.fromJson(json['portfolio'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['message'] = message;
    if (portfolio != null) {
      data['portfolio'] = portfolio!.toJson();
    }
    return data;
  }
}

class Portfolio {
  String? sId;
  String? name;
  String? user;
  int? cash;
  List<Stocks>? stocks;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Portfolio(
      {this.sId,
        this.name,
        this.user,
        this.cash,
        this.stocks,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Portfolio.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    user = json['user'];
    cash = json['cash'] is int ? json['cash'] : int.tryParse(json['cash']?.toString() ?? "0");
    if (json['stocks'] != null) {
      stocks = <Stocks>[];
      json['stocks'].forEach((v) {
        stocks!.add(Stocks.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
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

  Stocks(
      {this.symbol,
        this.quantity,
        this.price,
        this.date,
        this.transection,
        this.sId});

  Stocks.fromJson(Map<String, dynamic> json) {
    symbol = json['symbol'];
    quantity = json['quantity'] is int
        ? json['quantity']
        : int.tryParse(json['quantity']?.toString() ?? "0");
    price = json['price'] != null ? (json['price'] as num).toDouble() : null;
    date = json['date'];
    if (json['transection'] != null) {
      transection = <Transection>[];
      json['transection'].forEach((v) {
        transection!.add(Transection.fromJson(v));
      });
    }
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
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

  Transection({this.event, this.price, this.quantity, this.sId});

  Transection.fromJson(Map<String, dynamic> json) {
    event = json['event'];
    price = json['price'] != null ? (json['price'] as num).toDouble() : null;
    quantity = json['quantity'] is int
        ? json['quantity']
        : int.tryParse(json['quantity']?.toString() ?? "0");
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['event'] = event;
    data['price'] = price;
    data['quantity'] = quantity;
    data['_id'] = sId;
    return data;
  }
}
