class PortfolioPerformanceChartResponseModel {
  Overview? overview;
  Rankings? rankings;
  MostProfitableTrade? mostProfitableTrade;
  List<ReturnsComparison>? returnsComparison;
  RecentActivity? recentActivity;
  List<TransactionHistory>? transactionHistory;
  PerformanceChart? performanceChart;

  PortfolioPerformanceChartResponseModel({
    this.overview,
    this.rankings,
    this.mostProfitableTrade,
    this.returnsComparison,
    this.recentActivity,
    this.transactionHistory,
    this.performanceChart,
  });

  PortfolioPerformanceChartResponseModel.fromJson(Map<String, dynamic> json) {
    overview =
    json['overview'] != null ? Overview.fromJson(json['overview']) : null;
    rankings =
    json['rankings'] != null ? Rankings.fromJson(json['rankings']) : null;
    mostProfitableTrade = json['mostProfitableTrade'] != null
        ? MostProfitableTrade.fromJson(json['mostProfitableTrade'])
        : null;
    if (json['returnsComparison'] != null) {
      returnsComparison = <ReturnsComparison>[];
      json['returnsComparison'].forEach((v) {
        returnsComparison!.add(ReturnsComparison.fromJson(v));
      });
    }
    recentActivity = json['recentActivity'] != null
        ? RecentActivity.fromJson(json['recentActivity'])
        : null;
    if (json['transactionHistory'] != null) {
      transactionHistory = <TransactionHistory>[];
      json['transactionHistory'].forEach((v) {
        transactionHistory!.add(TransactionHistory.fromJson(v));
      });
    }
    performanceChart = json['performanceChart'] != null
        ? PerformanceChart.fromJson(json['performanceChart'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (overview != null) data['overview'] = overview!.toJson();
    if (rankings != null) data['rankings'] = rankings!.toJson();
    if (mostProfitableTrade != null) {
      data['mostProfitableTrade'] = mostProfitableTrade!.toJson();
    }
    if (returnsComparison != null) {
      data['returnsComparison'] =
          returnsComparison!.map((v) => v.toJson()).toList();
    }
    if (recentActivity != null) {
      data['recentActivity'] = recentActivity!.toJson();
    }
    if (transactionHistory != null) {
      data['transactionHistory'] =
          transactionHistory!.map((v) => v.toJson()).toList();
    }
    if (performanceChart != null) {
      data['performanceChart'] = performanceChart!.toJson();
    }
    return data;
  }
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

  Overview.fromJson(Map<String, dynamic> json) {
    totalReturn = json['totalReturn'];
    totalReturnColor = json['totalReturnColor'];
    oneMonthReturn = json['oneMonthReturn'];
    activeSince = json['activeSince'];
    riskProfile = json['riskProfile'];
    yTDReturn = json['YTDReturn'];
  }

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

  Rankings({this.successRate, this.averageReturn});

  Rankings.fromJson(Map<String, dynamic> json) {
    successRate = json['successRate'];
    averageReturn = json['averageReturn'];
  }

  Map<String, dynamic> toJson() => {
    'successRate': successRate,
    'averageReturn': averageReturn,
  };
}

class MostProfitableTrade {
  String? symbol;
  String? openDate;
  String? gain;

  MostProfitableTrade({this.symbol, this.openDate, this.gain});

  MostProfitableTrade.fromJson(Map<String, dynamic> json) {
    symbol = json['symbol'];
    openDate = json['openDate'];
    gain = json['gain'];
  }

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

  ReturnsComparison.fromJson(Map<String, dynamic> json) {
    month = json['month'];
    portfolio = (json['portfolio'] as num?)?.toDouble();
    mudarabahAverage = (json['mudarabahAverage'] as num?)?.toDouble();
    sp500 = (json['sp500'] as num?)?.toDouble();
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

  RecentActivity.fromJson(Map<String, dynamic> json) {
    oneMonth = json['oneMonth'];
    sixMonth = json['sixMonth'];
    twelveMonth = json['twelveMonth'];
    ytd = json['ytd'];
    total = json['total'];
  }

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
  String? monthlyGains;

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
    this.monthlyGains,
  });

  TransactionHistory.fromJson(Map<String, dynamic> json) {
    symbol = json['symbol'];
    companyName = json['companyName'];
    logo = json['logo'];
    sector = json['sector'];
    currentPrice = (json['currentPrice'] as num?)?.toDouble();
    quantity = json['quantity'];
    holdingValue = json['holdingValue'];
    portfolioPercentage = json['portfolioPercentage'];
    transactions = json['transactions'];
    lastTransaction = json['lastTransaction'];
    date = json['date'];
    monthlyGains = json['monthlyGains'];
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
    'monthlyGains': monthlyGains,
  };
}

class PerformanceChart {
  List<String>? labels;
  List<Datasets>? datasets;

  PerformanceChart({this.labels, this.datasets});

  PerformanceChart.fromJson(Map<String, dynamic> json) {
    labels = (json['labels'] as List?)?.map((e) => e.toString()).toList();
    if (json['datasets'] != null) {
      datasets = <Datasets>[];
      json['datasets'].forEach((v) {
        datasets!.add(Datasets.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() => {
    'labels': labels,
    'datasets': datasets?.map((v) => v.toJson()).toList(),
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

  Datasets.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    data = (json['data'] as List?)?.map((e) => (e as num).toDouble()).toList();
    borderColor = json['borderColor'];
    backgroundColor = json['backgroundColor'];
    tension = (json['tension'] as num?)?.toDouble();
  }

  Map<String, dynamic> toJson() => {
    'label': label,
    'data': data,
    'borderColor': borderColor,
    'backgroundColor': backgroundColor,
    'tension': tension,
  };
}
