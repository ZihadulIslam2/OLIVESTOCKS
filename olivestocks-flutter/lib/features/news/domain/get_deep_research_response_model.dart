class DeepResearchNewsResponseModel {
  bool? status;
  String? message;
  List<NewsData>? data;

  DeepResearchNewsResponseModel({this.status, this.message, this.data});

  DeepResearchNewsResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = List<NewsData>.from(json['data'].map((v) => NewsData.fromJson(v)));
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data?.map((v) => v.toJson()).toList(),
    };
  }
}

class NewsData {
  String? sId;
  String? newsTitle;
  String? newsDescription;
  String? newsImage;
  int? views;
  String? symbol;
  String? source;
  bool? isPaid;
  String? createdAt;
  String? updatedAt;
  int? iV;

  NewsData({
    this.sId,
    this.newsTitle,
    this.newsDescription,
    this.newsImage,
    this.views,
    this.symbol,
    this.source,
    this.isPaid,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  factory NewsData.fromJson(Map<String, dynamic> json) {
    return NewsData(
      sId: json['_id'],
      newsTitle: json['newsTitle'],
      newsDescription: json['newsDescription'],
      newsImage: json['newsImage'],
      views: json['views'],
      symbol: json['symbol'],
      source: json['source'],
      isPaid: json['isPaid'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      iV: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': sId,
      'newsTitle': newsTitle,
      'newsDescription': newsDescription,
      'newsImage': newsImage,
      'views': views,
      'symbol': symbol,
      'source': source,
      'isPaid': isPaid,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': iV,
    };
  }
}
