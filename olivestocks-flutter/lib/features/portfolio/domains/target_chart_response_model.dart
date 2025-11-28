class TargetChartResponseModel {
  final String? currentPrice;
  final String? upside;
  final Chart? chart;
  final Targets? targets;
  final Analysts? analysts;

  TargetChartResponseModel({
    this.currentPrice,
    this.upside,
    this.chart,
    this.targets,
    this.analysts,
  });

  factory TargetChartResponseModel.fromJson(Map<String, dynamic> json) {
    return TargetChartResponseModel(
      currentPrice: json['currentPrice'],
      upside: json['upside'],
      chart: json['chart'] != null ? Chart.fromJson(json['chart']) : null,
      targets: json['targets'] != null ? Targets.fromJson(json['targets']) : null,
      analysts: json['analysts'] != null ? Analysts.fromJson(json['analysts']) : null,
    );
  }
}

class Chart {
  final List<String>? labels;
  final List<double>? pastPrices;
  final Forecast? forecast;

  Chart({
    this.labels,
    this.pastPrices,
    this.forecast,
  });

  factory Chart.fromJson(Map<String, dynamic> json) {
    return Chart(
      labels: (json['labels'] as List<dynamic>?)?.map((e) => e.toString()).toList(),
      pastPrices: (json['pastPrices'] as List<dynamic>?)?.map((e) => (e as num).toDouble()).toList(),
      forecast: json['forecast'] != null ? Forecast.fromJson(json['forecast']) : null,
    );
  }
}

class Forecast {
  final List<String>? average;
  final List<String>? high;
  final List<String>? low;

  Forecast({
    this.average,
    this.high,
    this.low,
  });

  factory Forecast.fromJson(Map<String, dynamic> json) {
    return Forecast(
      average: (json['average'] as List<dynamic>?)?.map((e) => e.toString()).toList(),
      high: (json['high'] as List<dynamic>?)?.map((e) => e.toString()).toList(),
      low: (json['low'] as List<dynamic>?)?.map((e) => e.toString()).toList(),
    );
  }
}

class Targets {
  final String? high;
  final String? average;
  final String? low;

  Targets({
    this.high,
    this.average,
    this.low,
  });

  factory Targets.fromJson(Map<String, dynamic> json) {
    return Targets(
      high: json['high'],
      average: json['average'],
      low: json['low'],
    );
  }
}

class Analysts {
  final int? buy;
  final int? hold;
  final int? sell;
  final int? total;

  Analysts({
    this.buy,
    this.hold,
    this.sell,
    this.total,
  });

  factory Analysts.fromJson(Map<String, dynamic> json) {
    return Analysts(
      buy: json['buy'],
      hold: json['hold'],
      sell: json['sell'],
      total: json['total'],
    );
  }
}
