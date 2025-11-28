class UpdatePortfolioNameResponseModel {
  final String? message;
  final Portfolio? portfolio;

  UpdatePortfolioNameResponseModel({this.message, this.portfolio});

  factory UpdatePortfolioNameResponseModel.fromJson(Map<String, dynamic> json) {
    return UpdatePortfolioNameResponseModel(
      message: json['message'],
      portfolio: json['portfolio'] != null ? Portfolio.fromJson(json['portfolio']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      if (portfolio != null) 'portfolio': portfolio!.toJson(),
    };
  }
}

class Portfolio {
  final String? id;
  final String? name;
  final String? user;
  final int? cash;
  final List<Stock>? stocks;
  final String? createdAt;
  final String? updatedAt;
  final int? v;

  Portfolio({
    this.id,
    this.name,
    this.user,
    this.cash,
    this.stocks,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Portfolio.fromJson(Map<String, dynamic> json) {
    return Portfolio(
      id: json['_id'],
      name: json['name'],
      user: json['user'],
      cash: json['cash'],
      stocks: (json['stocks'] as List<dynamic>?)
          ?.map((e) => Stock.fromJson(e))
          .toList(),
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'user': user,
      'cash': cash,
      if (stocks != null) 'stocks': stocks!.map((e) => e.toJson()).toList(),
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': v,
    };
  }
}

class Stock {
  final String? symbol;
  final int? quantity;
  final double? price;
  final String? date;
  final List<Transaction>? transaction;
  final String? id;

  Stock({
    this.symbol,
    this.quantity,
    this.price,
    this.date,
    this.transaction,
    this.id,
  });

  factory Stock.fromJson(Map<String, dynamic> json) {
    return Stock(
      symbol: json['symbol'],
      quantity: json['quantity'],
      price: (json['price'] is int) ? (json['price'] as int).toDouble() : json['price'],
      date: json['date'],
      transaction: (json['transection'] as List<dynamic>?)
          ?.map((e) => Transaction.fromJson(e))
          .toList(),
      id: json['_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'symbol': symbol,
      'quantity': quantity,
      'price': price,
      'date': date,
      if (transaction != null) 'transection': transaction!.map((e) => e.toJson()).toList(),
      '_id': id,
    };
  }
}

class Transaction {
  final String? event;
  final double? price;
  final int? quantity;
  final String? id;

  Transaction({this.event, this.price, this.quantity, this.id});

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      event: json['event'],
      price: (json['price'] is int) ? (json['price'] as int).toDouble() : json['price'],
      quantity: json['quantity'],
      id: json['_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'event': event,
      'price': price,
      'quantity': quantity,
      '_id': id,
    };
  }
}
