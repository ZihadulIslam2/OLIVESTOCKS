class GetASingleNewsResponseModel {
  bool? status;
  String? message;
  Data? data;

  GetASingleNewsResponseModel({this.status, this.message, this.data});

  GetASingleNewsResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? sId;
  String? newsTitle;
  String? newsDescription;
  String? newsImage;
  int? views;
  String? source;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Data(
      {this.sId,
        this.newsTitle,
        this.newsDescription,
        this.newsImage,
        this.views,
        this.source,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    newsTitle = json['newsTitle'];
    newsDescription = json['newsDescription'];
    newsImage = json['newsImage'];
    views = json['views'];
    source = json['source'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['newsTitle'] = newsTitle;
    data['newsDescription'] = newsDescription;
    data['newsImage'] = newsImage;
    data['views'] = views;
    data['source'] = source;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
