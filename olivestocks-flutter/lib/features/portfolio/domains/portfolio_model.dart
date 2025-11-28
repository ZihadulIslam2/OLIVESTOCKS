class MarketItem {
  final String title;
  final String price;
  final String change;
  final bool isPositive;

  MarketItem({
    required this.title,
    required this.price,
    required this.change,
    required this.isPositive,
  });

  // Factory constructor to create from JSON/map
  factory MarketItem.fromJson(Map<String, dynamic> json) {
    return MarketItem(
      title: json['title'],
      price: json['price'],
      change: json['change'],
      isPositive: json['isPositive'],
    );
  }

  // Convert to JSON/map
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'price': price,
      'change': change,
      'isPositive': isPositive,
    };
  }
}
