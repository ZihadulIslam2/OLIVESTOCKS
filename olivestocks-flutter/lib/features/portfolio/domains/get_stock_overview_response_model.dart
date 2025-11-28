class GetStockOverviewResponseModel {
  String? company;
  String? logo;
  String? exchange;
  String? quadrant;
  Olives? olives;
  bool? shariaCompliant;
  String? reason;
  ValuationBar? valuationBar;

  GetStockOverviewResponseModel(
      {this.company,
        this.logo,
        this.exchange,
        this.quadrant,
        this.olives,
        this.shariaCompliant,
        this.reason,
        this.valuationBar});

  GetStockOverviewResponseModel.fromJson(Map<String, dynamic> json) {
    company = json['company'];
    logo = json['logo'];
    exchange = json['exchange'];
    quadrant = json['quadrant'];
    olives =
    json['olives'] != null ? new Olives.fromJson(json['olives']) : null;
    shariaCompliant = json['shariaCompliant'];
    reason = json['reason'];
    valuationBar = json['valuationBar'] != null
        ? new ValuationBar.fromJson(json['valuationBar'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['company'] = this.company;
    data['logo'] = this.logo;
    data['exchange'] = this.exchange;
    data['quadrant'] = this.quadrant;
    if (this.olives != null) {
      data['olives'] = this.olives!.toJson();
    }
    data['shariaCompliant'] = this.shariaCompliant;
    data['reason'] = this.reason;
    if (this.valuationBar != null) {
      data['valuationBar'] = this.valuationBar!.toJson();
    }
    return data;
  }
}

class Olives {
  String? financialHealth;
  String? competitiveAdvantage;
  String? valuation;

  Olives({this.financialHealth, this.competitiveAdvantage, this.valuation});

  Olives.fromJson(Map<String, dynamic> json) {
    financialHealth = json['financialHealth'];
    competitiveAdvantage = json['competitiveAdvantage'];
    valuation = json['valuation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['financialHealth'] = this.financialHealth;
    data['competitiveAdvantage'] = this.competitiveAdvantage;
    data['valuation'] = this.valuation;
    return data;
  }
}

class ValuationBar {
  String? percent;
  String? color;
  double? currentPrice;
  int? fairValue;

  ValuationBar({this.percent, this.color, this.currentPrice, this.fairValue});

  ValuationBar.fromJson(Map<String, dynamic> json) {
    percent = json['percent'];
    color = json['color'];
    currentPrice = json['currentPrice'];
    fairValue = json['fairValue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['percent'] = this.percent;
    data['color'] = this.color;
    data['currentPrice'] = this.currentPrice;
    data['fairValue'] = this.fairValue;
    return data;
  }
}
