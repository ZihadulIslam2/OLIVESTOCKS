class UpComingEventsResponseModel {
  int? total;
  List<Events>? events;

  UpComingEventsResponseModel({this.total, this.events});

  UpComingEventsResponseModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    if (json['events'] != null) {
      events = <Events>[];
      json['events'].forEach((v) {
        events!.add(Events.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['total'] = this.total;
    if (this.events != null) {
      data['events'] = this.events!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Events {
  String? symbol;
  String? type;
  String? date;

  Events({this.symbol, this.type, this.date});

  Events.fromJson(Map<String, dynamic> json) {
    symbol = json['symbol'];
    type = json['type'];
    date = json['date'];
  }

  get length => null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['symbol'] = this.symbol;
    data['type'] = this.type;
    data['date'] = this.date;
    return data;
  }
}
