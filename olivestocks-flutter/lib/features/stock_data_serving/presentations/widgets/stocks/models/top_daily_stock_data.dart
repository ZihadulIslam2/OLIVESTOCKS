class EtfData {
  final String symbol;
  final String name;
  final double price;
  final double percentChange;
  final double valueChange;

  EtfData({
    required this.symbol,
    required this.name,
    required this.price,
    required this.percentChange,
    required this.valueChange,
  });
}
