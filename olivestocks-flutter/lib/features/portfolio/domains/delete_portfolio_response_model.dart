class DeletePortfolioResponseModel {
  String? message;
  Portfolio? portfolio;

  DeletePortfolioResponseModel({this.message, this.portfolio});

  DeletePortfolioResponseModel.fromJson(Map<String, dynamic> json) {
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
  List<dynamic>? stocks; // ✅ FIXED: changed from List<Null> to List<dynamic>
  String? createdAt;
  String? updatedAt;
  int? iV;

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

  Portfolio.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    user = json['user'];
    cash = json['cash'];
    stocks = json['stocks']; // ✅ directly assign
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
    data['stocks'] = stocks; // ✅ directly return
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
