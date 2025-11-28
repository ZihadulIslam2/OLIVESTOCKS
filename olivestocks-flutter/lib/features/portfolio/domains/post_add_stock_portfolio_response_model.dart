class PostAddStockPortfolioResponseModel {
  final String? message;
  final Portfolio? portfolio;

  PostAddStockPortfolioResponseModel({this.message, this.portfolio});

  factory PostAddStockPortfolioResponseModel.fromJson(Map<String, dynamic> json) {
    return PostAddStockPortfolioResponseModel(
      message: json['message'],
      portfolio: json['portfolio'] != null ? Portfolio.fromJson(json['portfolio']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'portfolio': portfolio?.toJson(),
    };
  }
}

class Portfolio {
  final String? sId;
  final String? name;
  final String? user;
  final int? cash;
  final List<Stocks>? stocks;
  final String? createdAt;
  final String? updatedAt;
  final int? iV;

  Portfolio({
    this.sId,
    this.name,
    this.user,
    this.cash,
    this.stocks,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  factory Portfolio.fromJson(Map<String, dynamic> json) {
    return Portfolio(
      sId: json['_id'],
      name: json['name'],
      user: json['user'],
      cash: json['cash'],
      stocks: json['stocks'] != null
          ? List<Stocks>.from(json['stocks'].map((x) => Stocks.fromJson(x)))
          : null,
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      iV: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': sId,
      'name': name,
      'user': user,
      'cash': cash,
      'stocks': stocks?.map((x) => x.toJson()).toList(),
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': iV,
    };
  }
}

class Stocks {
  final String? symbol;
  final int? quantity;
  final int? price;
  final String? date;
  final List<Transection>? transection;
  final String? sId;

  Stocks({
    this.symbol,
    this.quantity,
    this.price,
    this.date,
    this.transection,
    this.sId,
  });

  factory Stocks.fromJson(Map<String, dynamic> json) {
    return Stocks(
      symbol: json['symbol'],
      quantity: json['quantity'],
      price: json['price'],
      date: json['date'],
      transection: json['transection'] != null
          ? List<Transection>.from(json['transection'].map((x) => Transection.fromJson(x)))
          : null,
      sId: json['_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'symbol': symbol,
      'quantity': quantity,
      'price': price,
      'date': date,
      'transection': transection?.map((x) => x.toJson()).toList(),
      '_id': sId,
    };
  }
}

class Transection {
  final String? event;
  final int? price;
  final int? quantity;
  final String? sId;

  Transection({this.event, this.price, this.quantity, this.sId});

  factory Transection.fromJson(Map<String, dynamic> json) {
    return Transection(
      event: json['event'],
      price: json['price'],
      quantity: json['quantity'],
      sId: json['_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'event': event,
      'price': price,
      'quantity': quantity,
      '_id': sId,
    };
  }
}
