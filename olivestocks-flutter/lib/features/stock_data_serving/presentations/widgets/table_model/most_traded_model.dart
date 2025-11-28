class MsFinancialInstrument {
  final String ticker;
  final String description;
  final double currentValue;
  final double percentageChange;
  final double valueChange;

  MsFinancialInstrument({
    required this.ticker,
    required this.description,
    required this.currentValue,
    required this.percentageChange,
    required this.valueChange,
  });
}
