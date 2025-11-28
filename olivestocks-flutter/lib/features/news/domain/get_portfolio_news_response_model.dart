class GetPortfolioNewsResponseModel {
  final String? category;
  final int? datetime;
  final String? headline;
  final int? id;
  final String? image;
  final String? related;
  final String? source;
  final String? summary;
  final String? url;
  final String? symbol;

  GetPortfolioNewsResponseModel({
    this.category,
    this.datetime,
    this.headline,
    this.id,
    this.image,
    this.related,
    this.source,
    this.summary,
    this.url,
    this.symbol,
  });

  factory GetPortfolioNewsResponseModel.fromJson(Map<String, dynamic> json) {
    return GetPortfolioNewsResponseModel(
      category: json['category'],
      datetime: json['datetime'],
      headline: json['headline'],
      id: json['id'],
      image: json['image'],
      related: json['related'],
      source: json['source'],
      summary: json['summary'],
      url: json['url'],
      symbol: json['symbol'],
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'datetime': datetime,
      'headline': headline,
      'id': id,
      'image': image,
      'related': related,
      'source': source,
      'summary': summary,
      'url': url,
      'symbol': symbol,
    };
  }
}
