class PerformanceResponseModel {
  Overview? overview;
  Rankings? rankings;
  MostProfitableTrade? mostProfitableTrade;
  List<ReturnsComparison>? returnsComparison;
  RecentActivity? recentActivity;
  List<TransactionHistory>? transactionHistory;
  PerformanceChart? performanceChart;

  PerformanceResponseModel({
    this.overview,
    this.rankings,
    this.mostProfitableTrade,
    this.returnsComparison,
    this.recentActivity,
    this.transactionHistory,
    this.performanceChart,
  });

  factory PerformanceResponseModel.fromJson(Map<String, dynamic> json) {
    return PerformanceResponseModel(
      overview: json['overview'] != null ? Overview.fromJson(json['overview']) : null,
      rankings: json['rankings'] != null ? Rankings.fromJson(json['rankings']) : null,
      mostProfitableTrade: json['mostProfitableTrade'] != null
          ? MostProfitableTrade.fromJson(json['mostProfitableTrade'])
          : null,
      returnsComparison: json['returnsComparison'] != null
          ? List<ReturnsComparison>.from(
          json['returnsComparison'].map((x) => ReturnsComparison.fromJson(x)))
          : null,
      recentActivity: json['recentActivity'] != null
          ? RecentActivity.fromJson(json['recentActivity'])
          : null,
      transactionHistory: json['transactionHistory'] != null
          ? List<TransactionHistory>.from(
          json['transactionHistory'].map((x) => TransactionHistory.fromJson(x)))
          : null,
      performanceChart: json['performanceChart'] != null
          ? PerformanceChart.fromJson(json['performanceChart'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'overview': overview?.toJson(),
    'rankings': rankings?.toJson(),
    'mostProfitableTrade': mostProfitableTrade?.toJson(),
    'returnsComparison': returnsComparison?.map((x) => x.toJson()).toList(),
    'recentActivity': recentActivity?.toJson(),
    'transactionHistory': transactionHistory?.map((x) => x.toJson()).toList(),
    'performanceChart': performanceChart?.toJson(),
  };
}

class Overview {
  String? totalReturn;
  String? totalReturnColor;
  String? oneMonthReturn;
  String? activeSince;
  String? riskProfile;
  String? yTDReturn;

  Overview({
    this.totalReturn,
    this.totalReturnColor,
    this.oneMonthReturn,
    this.activeSince,
    this.riskProfile,
    this.yTDReturn,
  });

  factory Overview.fromJson(Map<String, dynamic> json) => Overview(
    totalReturn: json['totalReturn']?.toString(),
    totalReturnColor: json['totalReturnColor']?.toString(),
    oneMonthReturn: json['oneMonthReturn']?.toString(),
    activeSince: json['activeSince']?.toString(),
    riskProfile: json['riskProfile']?.toString(),
    yTDReturn: json['YTDReturn']?.toString(),
  );

  Map<String, dynamic> toJson() => {
    'totalReturn': totalReturn,
    'totalReturnColor': totalReturnColor,
    'oneMonthReturn': oneMonthReturn,
    'activeSince': activeSince,
    'riskProfile': riskProfile,
    'YTDReturn': yTDReturn,
  };
}

class Rankings {
  String? successRate;
  String? averageReturn;

  Rankings({
    this.successRate,
    this.averageReturn,
  });

  factory Rankings.fromJson(Map<String, dynamic> json) => Rankings(
    successRate: json['successRate']?.toString(),
    averageReturn: json['averageReturn']?.toString(),
  );

  Map<String, dynamic> toJson() => {
    'successRate': successRate,
    'averageReturn': averageReturn,
  };
}

class MostProfitableTrade {
  String? symbol;
  String? openDate;
  String? gain;

  MostProfitableTrade({
    this.symbol,
    this.openDate,
    this.gain,
  });

  factory MostProfitableTrade.fromJson(Map<String, dynamic> json) => MostProfitableTrade(
    symbol: json['symbol']?.toString(),
    openDate: json['openDate']?.toString(),
    gain: json['gain']?.toString(),
  );

  Map<String, dynamic> toJson() => {
    'symbol': symbol,
    'openDate': openDate,
    'gain': gain,
  };
}

class ReturnsComparison {
  String? month;
  double? portfolio;
  double? mudarabahAverage;
  double? sp500;

  ReturnsComparison({
    this.month,
    this.portfolio,
    this.mudarabahAverage,
    this.sp500,
  });

  factory ReturnsComparison.fromJson(Map<String, dynamic> json) {
    double? toDouble(dynamic value) {
      if (value == null) return null;
      if (value is double) return value;
      if (value is int) return value.toDouble();
      if (value is String) return double.tryParse(value);
      return null;
    }

    return ReturnsComparison(
      month: json['month']?.toString(),
      portfolio: toDouble(json['portfolio']),
      mudarabahAverage: toDouble(json['mudarabahAverage']),
      sp500: toDouble(json['sp500']),
    );
  }

  Map<String, dynamic> toJson() => {
    'month': month,
    'portfolio': portfolio,
    'mudarabahAverage': mudarabahAverage,
    'sp500': sp500,
  };
}

class RecentActivity {
  String? oneMonth;
  String? sixMonth;
  String? twelveMonth;
  String? ytd;
  String? total;

  RecentActivity({
    this.oneMonth,
    this.sixMonth,
    this.twelveMonth,
    this.ytd,
    this.total,
  });

  factory RecentActivity.fromJson(Map<String, dynamic> json) => RecentActivity(
    oneMonth: json['oneMonth']?.toString(),
    sixMonth: json['sixMonth']?.toString(),
    twelveMonth: json['twelveMonth']?.toString(),
    ytd: json['ytd']?.toString(),
    total: json['total']?.toString(),
  );

  Map<String, dynamic> toJson() => {
    'oneMonth': oneMonth,
    'sixMonth': sixMonth,
    'twelveMonth': twelveMonth,
    'ytd': ytd,
    'total': total,
  };
}

class TransactionHistory {
  String? symbol;
  String? companyName;
  String? logo;
  String? sector;
  double? currentPrice;
  int? quantity;
  String? holdingValue;
  String? portfolioPercentage;
  int? transactions;
  String? lastTransaction;
  String? date;

  TransactionHistory({
    this.symbol,
    this.companyName,
    this.logo,
    this.sector,
    this.currentPrice,
    this.quantity,
    this.holdingValue,
    this.portfolioPercentage,
    this.transactions,
    this.lastTransaction,
    this.date,
  });

  factory TransactionHistory.fromJson(Map<String, dynamic> json) {
    double? toDouble(dynamic value) {
      if (value == null) return null;
      if (value is double) return value;
      if (value is int) return value.toDouble();
      if (value is String) return double.tryParse(value);
      return null;
    }

    return TransactionHistory(
      symbol: json['symbol']?.toString(),
      companyName: json['companyName']?.toString(),
      logo: json['logo']?.toString(),
      sector: json['sector']?.toString(),
      currentPrice: toDouble(json['currentPrice']),
      quantity: json['quantity'] as int?,
      holdingValue: json['holdingValue']?.toString(),
      portfolioPercentage: json['portfolioPercentage']?.toString(),
      transactions: json['transactions'] as int?,
      lastTransaction: json['lastTransaction']?.toString(),
      date: json['date']?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
    'symbol': symbol,
    'companyName': companyName,
    'logo': logo,
    'sector': sector,
    'currentPrice': currentPrice,
    'quantity': quantity,
    'holdingValue': holdingValue,
    'portfolioPercentage': portfolioPercentage,
    'transactions': transactions,
    'lastTransaction': lastTransaction,
    'date': date,
  };
}

class PerformanceChart {
  List<String>? labels;
  List<Datasets>? datasets;

  PerformanceChart({
    this.labels,
    this.datasets,
  });

  factory PerformanceChart.fromJson(Map<String, dynamic> json) => PerformanceChart(
    labels: json['labels'] != null
        ? List<String>.from(json['labels'].map((x) => x.toString()))
        : null,
    datasets: json['datasets'] != null
        ? List<Datasets>.from(
        json['datasets'].map((x) => Datasets.fromJson(x)))
        : null,
  );

  Map<String, dynamic> toJson() => {
    'labels': labels,
    'datasets': datasets?.map((x) => x.toJson()).toList(),
  };
}

class Datasets {
  String? label;
  List<double>? data;
  String? borderColor;
  String? backgroundColor;
  double? tension;

  Datasets({
    this.label,
    this.data,
    this.borderColor,
    this.backgroundColor,
    this.tension,
  });

  factory Datasets.fromJson(Map<String, dynamic> json) {
    double? toDouble(dynamic value) {
      if (value == null) return null;
      if (value is double) return value;
      if (value is int) return value.toDouble();
      if (value is String) return double.tryParse(value);
      return null;
    }

    return Datasets(
      label: json['label']?.toString(),
      data: json['data'] != null
          ? List<double>.from(json['data'].map((x) => toDouble(x) ?? 0.0))
          : null,
      borderColor: json['borderColor']?.toString(),
      backgroundColor: json['backgroundColor']?.toString(),
      tension: toDouble(json['tension']),
    );
  }

  Map<String, dynamic> toJson() => {
    'label': label,
    'data': data,
    'borderColor': borderColor,
    'backgroundColor': backgroundColor,
    'tension': tension,
  };
}