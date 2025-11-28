class UpdatePortfolioResponseModel {
  String? message;
  Portfolio? portfolio;

  UpdatePortfolioResponseModel({this.message, this.portfolio});

  UpdatePortfolioResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    portfolio = json['portfolio'] != null
        ? new Portfolio.fromJson(json['portfolio'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.portfolio != null) {
      data['portfolio'] = this.portfolio!.toJson();
    }
    return data;
  }
}

class Portfolio {
  String? sId;
  String? name;
  String? user;
  double? cash;
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
    cash = json['cash'];
    if (json['stocks'] != null) {
      stocks = <Stocks>[];
      json['stocks'].forEach((v) {
        stocks!.add(new Stocks.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['user'] = this.user;
    data['cash'] = this.cash;
    if (this.stocks != null) {
      data['stocks'] = this.stocks!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
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
    quantity = json['quantity'];
    price = json['price'];
    date = json['date'];
    if (json['transection'] != null) {
      transection = <Transection>[];
      json['transection'].forEach((v) {
        transection!.add(new Transection.fromJson(v));
      });
    }
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['symbol'] = this.symbol;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['date'] = this.date;
    if (this.transection != null) {
      data['transection'] = this.transection!.map((v) => v.toJson()).toList();
    }
    data['_id'] = this.sId;
    return data;
  }
}

class Transection {
  String? event;
  double? price;
  int? quantity;
  String? sId;
  String? date;

  Transection({this.event, this.price, this.quantity, this.sId, this.date});

  Transection.fromJson(Map<String, dynamic> json) {
    event = json['event'];
    price = json['price'];
    quantity = json['quantity'];
    sId = json['_id'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['event'] = this.event;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['_id'] = this.sId;
    data['date'] = this.date;
    return data;
  }
}
