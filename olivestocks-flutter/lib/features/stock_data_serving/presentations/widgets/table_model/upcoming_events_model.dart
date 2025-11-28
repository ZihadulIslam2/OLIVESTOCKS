class UpFinancialInstrument {
  final String ticker;
  final String description;
  final double currentValue;
  final double percentageChange;
  final double valueChange;

  UpFinancialInstrument({
    required this.ticker,
    required this.description,
    required this.currentValue,
    required this.percentageChange,
    required this.valueChange,
  });
}
