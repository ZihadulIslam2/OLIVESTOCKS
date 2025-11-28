class AssetAllocationResponseModel {
  AssetAllocation? assetAllocation;
  List<HoldingsBySector>? holdingsBySector;
  Metrics? metrics;

  AssetAllocationResponseModel(
      {this.assetAllocation, this.holdingsBySector, this.metrics});

  AssetAllocationResponseModel.fromJson(Map<String, dynamic> json) {
    assetAllocation = json['assetAllocation'] != null
        ? AssetAllocation.fromJson(json['assetAllocation'])
        : null;
    if (json['holdingsBySector'] != null) {
      holdingsBySector = <HoldingsBySector>[];
      json['holdingsBySector'].forEach((v) {
        holdingsBySector!.add(HoldingsBySector.fromJson(v));
      });
    }
    metrics =
    json['metrics'] != null ? Metrics.fromJson(json['metrics']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.assetAllocation != null) {
      data['assetAllocation'] = this.assetAllocation!.toJson();
    }
    if (this.holdingsBySector != null) {
      data['holdingsBySector'] =
          this.holdingsBySector!.map((v) => v.toJson()).toList();
    }
    if (this.metrics != null) {
      data['metrics'] = this.metrics!.toJson();
    }
    return data;
  }
}

class AssetAllocation {
  String? stocks;
  String? cash;

  AssetAllocation({this.stocks, this.cash});

  AssetAllocation.fromJson(Map<String, dynamic> json) {
    stocks = json['stocks'];
    cash = json['cash'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['stocks'] = this.stocks;
    data['cash'] = this.cash;
    return data;
  }
}

class HoldingsBySector {
  String? sector;
  String? percent;

  HoldingsBySector({this.sector, this.percent});

  HoldingsBySector.fromJson(Map<String, dynamic> json) {
    sector = json['sector'];
    percent = json['percent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['sector'] = this.sector;
    data['percent'] = this.percent;
    return data;
  }
}

class Metrics {
  String? beta;
  String? peRatio;
  String? dividendYield;
  List<Warnings>? warnings;

  Metrics({this.beta, this.peRatio, this.dividendYield, this.warnings});

  Metrics.fromJson(Map<String, dynamic> json) {
    beta = json['beta'];
    peRatio = json['peRatio'];
    dividendYield = json['dividendYield'];
    if (json['warnings'] != null) {
      warnings = <Warnings>[];
      json['warnings'].forEach((v) {
        warnings!.add(Warnings.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['beta'] = this.beta;
    data['peRatio'] = this.peRatio;
    data['dividendYield'] = this.dividendYield;
    if (this.warnings != null) {
      data['warnings'] = this.warnings!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Warnings {
  String? symbol;
  String? name;

  Warnings({this.symbol, this.name});

  Warnings.fromJson(Map<String, dynamic> json) {
    symbol = json['symbol'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['symbol'] = this.symbol;
    data['name'] = this.name;
    return data;
  }
}
