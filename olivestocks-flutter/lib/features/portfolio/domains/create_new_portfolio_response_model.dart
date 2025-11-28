class CreateNewPortfolioResponseModel {
  String? message;
  Portfolio? portfolio;

  CreateNewPortfolioResponseModel({this.message, this.portfolio});

  CreateNewPortfolioResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'] as String?;
    portfolio = json['portfolio'] != null
        ? Portfolio.fromJson(json['portfolio'] as Map<String, dynamic>)
        : null;
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'portfolio': portfolio?.toJson(),
    };
  }
}

class Portfolio {
  String? name;
  String? user;
  int? cash;
  String? id; // Changed to more readable 'id'
  List<Stock>? stocks; // Changed from Null to Stock model
  String? createdAt;
  String? updatedAt;
  int? version; // Renamed for clarity

  Portfolio({
    this.name,
    this.user,
    this.cash,
    this.id,
    this.stocks,
    this.createdAt,
    this.updatedAt,
    this.version,
  });

  Portfolio.fromJson(Map<String, dynamic> json) {
    name = json['name'] as String?;
    user = json['user'] as String?;
    cash = json['cash'] as int?;
    id = json['_id'] as String?;
    if (json['stocks'] != null) {
      stocks = (json['stocks'] as List)
          .map((v) => Stock.fromJson(v as Map<String, dynamic>))
          .toList();
    }
    createdAt = json['createdAt'] as String?;
    updatedAt = json['updatedAt'] as String?;
    version = json['__v'] as int?;
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'user': user,
      'cash': cash,
      '_id': id,
      'stocks': stocks?.map((v) => v.toJson()).toList(),
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': version,
    };
  }
}

class Stock {
  String? symbol;
  int? quantity;

  Stock({this.symbol, this.quantity});

  Stock.fromJson(Map<String, dynamic> json) {
    symbol = json['symbol'] as String?;
    quantity = json['quantity'] as int?;
  }

  Map<String, dynamic> toJson() {
    return {
      'symbol': symbol,
      'quantity': quantity,
    };
  }
}
