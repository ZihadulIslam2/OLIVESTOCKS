class MarketNewsResponseModel {
  final bool? status;
  final String? message;
  final List<MarketNewsData>? data;

  MarketNewsResponseModel({this.status, this.message, this.data});

  factory MarketNewsResponseModel.fromJson(Map<String, dynamic> json) {
    return MarketNewsResponseModel(
      status: json['status'],
      message: json['message'],
      data: json['data'] != null
          ? List<MarketNewsData>.from(
          json['data'].map((x) => MarketNewsData.fromJson(x)))
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'status': status,
    'message': message,
    'data': data?.map((x) => x.toJson()).toList(),
  };
}

class MarketNewsData {
  final String? category;
  final int? datetime;
  final String? headline;
  final int? id;
  final String? image;
  final String? related;
  final String? source;
  final String? summary;
  final String? url;

  MarketNewsData({
    this.category,
    this.datetime,
    this.headline,
    this.id,
    this.image,
    this.related,
    this.source,
    this.summary,
    this.url,
  });

  factory MarketNewsData.fromJson(Map<String, dynamic> json) {
    return MarketNewsData(
      category: json['category'],
      datetime: json['datetime'],
      headline: json['headline'],
      id: json['id'],
      image: json['image'],
      related: json['related'],
      source: json['source'],
      summary: json['summary'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() => {
    'category': category,
    'datetime': datetime,
    'headline': headline,
    'id': id,
    'image': image,
    'related': related,
    'source': source,
    'summary': summary,
    'url': url,
  };
}
