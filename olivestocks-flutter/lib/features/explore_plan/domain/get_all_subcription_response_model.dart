class GetAllSubscriptionPlanResponseModel {
  bool? success;
  String? message;
  List<SubscriptionPlan>? data;

  GetAllSubscriptionPlanResponseModel({this.success, this.message, this.data});

  factory GetAllSubscriptionPlanResponseModel.fromJson(Map<String, dynamic> json) => GetAllSubscriptionPlanResponseModel(
    success: json['success'],
    message: json['message'],
    data: json['data'] != null
        ? List<SubscriptionPlan>.from(
        json['data'].map((item) => SubscriptionPlan.fromJson(item)))
        : null,
  );

  Map<String, dynamic> toJson() => {
    'success': success,
    'message': message,
    'data': data?.map((item) => item.toJson()).toList(),
  };
}

class SubscriptionPlan {
  String? id;
  String? title;
  String? description;
  int? monthlyPrice;
  int? yearlyPrice;
  List<Feature>? features;
  String? duration;
  String? createdAt;
  String? updatedAt;
  int? v;
  String? arDescription;
  String? arTitle;

  SubscriptionPlan({
    this.id,
    this.title,
    this.description,
    this.monthlyPrice,
    this.yearlyPrice,
    this.features,
    this.duration,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.arDescription,
    this.arTitle,
  });

  factory SubscriptionPlan.fromJson(Map<String, dynamic> json) => SubscriptionPlan(
    id: json['_id'],
    title: json['title'],
    description: json['description'],
    monthlyPrice: json['monthly_price'],
    yearlyPrice: json['yearly_price'],
    features: json['features'] != null
        ? List<Feature>.from(
        json['features'].map((item) => Feature.fromJson(item)))
        : null,
    duration: json['duration'],
    createdAt: json['createdAt'],
    updatedAt: json['updatedAt'],
    v: json['__v'],
    arDescription: json['ar_description'],
    arTitle: json['ar_title'],
  );

  Map<String, dynamic> toJson() => {
    '_id': id,
    'title': title,
    'description': description,
    'monthly_price': monthlyPrice,
    'yearly_price': yearlyPrice,
    'features': features?.map((item) => item.toJson()).toList(),
    'duration': duration,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    '__v': v,
    'ar_description': arDescription,
    'ar_title': arTitle,
  };
}

class Feature {
  String? featuresType;
  List<FeatureType>? type;

  Feature({this.featuresType, this.type});

  factory Feature.fromJson(Map<String, dynamic> json) => Feature(
    featuresType: json['featuresType'],
    type: json['type'] != null
        ? List<FeatureType>.from(
        json['type'].map((item) => FeatureType.fromJson(item)))
        : null,
  );

  Map<String, dynamic> toJson() => {
    'featuresType': featuresType,
    'type': type?.map((item) => item.toJson()).toList(),
  };
}

class FeatureType {
  String? name;
  bool? active;
  String? arName;

  FeatureType({this.name, this.active, this.arName});

  factory FeatureType.fromJson(Map<String, dynamic> json) => FeatureType(
    name: json['name'],
    active: json['active'],
    arName: json['ar_name'],
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'active': active,
    'ar_name': arName,
  };
}
