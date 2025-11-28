class GetPortfolioResponseModel {
  String? id;
  String? name;
  String? user;
  double? cash;
  List<PortfolioStock>? stocks;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  GetPortfolioResponseModel({
    this.id,
    this.name,
    this.user,
    this.cash,
    this.stocks,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory GetPortfolioResponseModel.fromJson(Map<String, dynamic> json) {
    return GetPortfolioResponseModel(
      id: json['_id'],
      name: json['name'],
      user: json['user'],
      cash: (json['cash'] as num?)?.toDouble(),
      stocks: (json['stocks'] as List<dynamic>?)
          ?.map((e) => PortfolioStock.fromJson(e))
          .toList(),
      createdAt: DateTime.tryParse(json['createdAt'] ?? ''),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? ''),
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'user': user,
      'cash': cash,
      'stocks': stocks?.map((e) => e.toJson()).toList(),
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      '__v': v,
    };
  }
}

class PortfolioStock {
  String? symbol;
  int? quantity;
  double? price;
  DateTime? date;
  List<PortfolioTransaction>? transection;
  String? id;

  PortfolioStock({
    this.symbol,
    this.quantity,
    this.price,
    this.date,
    this.transection,
    this.id,
  });

  factory PortfolioStock.fromJson(Map<String, dynamic> json) {
    return PortfolioStock(
      symbol: json['symbol'],
      quantity: json['quantity'],
      price: (json['price'] as num?)?.toDouble(),
      date: DateTime.tryParse(json['date'] ?? ''),
      transection: (json['transection'] as List<dynamic>?)
          ?.map((e) => PortfolioTransaction.fromJson(e))
          .toList(),
      id: json['_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'symbol': symbol,
      'quantity': quantity,
      'price': price,
      'date': date?.toIso8601String(),
      'transection': transection?.map((e) => e.toJson()).toList(),
      '_id': id,
    };
  }
}

class PortfolioTransaction {
  String? event;
  double? price;
  int? quantity;
  String? id;

  PortfolioTransaction({
    this.event,
    this.price,
    this.quantity,
    this.id,
  });

  factory PortfolioTransaction.fromJson(Map<String, dynamic> json) {
    return PortfolioTransaction(
      event: json['event'],
      price: (json['price'] as num?)?.toDouble(),
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
