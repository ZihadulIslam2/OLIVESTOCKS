class GetAllNewsResponseModel {
  final bool? status;
  final String? message;
  final List<Data>? data;
  final Meta? meta;

  GetAllNewsResponseModel({
    this.status,
    this.message,
    this.data,
    this.meta,
  });

  factory GetAllNewsResponseModel.fromJson(Map<String, dynamic> json) {
    return GetAllNewsResponseModel(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Data.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: json['meta'] != null ? Meta.fromJson(json['meta']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data?.map((e) => e.toJson()).toList(),
      'meta': meta?.toJson(),
    };
  }
}

class Data {
  final String? id;
  final String? newsTitle;
  final String? newsDescription;
  final String? newsImage;
  final int? views;
  final String? symbol;
  final String? source;
  final bool? isPaid;
  final String? lang;
  final String? createdAt;
  final String? updatedAt;
  final int? v;
  bool? isPinned;

  Data({
    this.id,
    this.newsTitle,
    this.newsDescription,
    this.newsImage,
    this.views,
    this.symbol,
    this.source,
    this.isPaid,
    this.lang,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.isPinned = false,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['_id'] as String?,
      newsTitle: json['newsTitle'] as String?,
      newsDescription: json['newsDescription'] as String?,
      newsImage: json['newsImage'] as String?,
      views: json['views'] as int?,
      symbol: json['symbol'] as String?,
      source: json['source'] as String?,
      isPaid: json['isPaid'] as bool?,
      lang: json['lang'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      v: json['__v'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'newsTitle': newsTitle,
      'newsDescription': newsDescription,
      'newsImage': newsImage,
      'views': views,
      'symbol': symbol,
      'source': source,
      'isPaid': isPaid,
      'lang': lang,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': v,
    };
  }
}

class Meta {
  final int? total;
  final int? page;
  final int? limit;
  final int? totalPages;

  Meta({
    this.total,
    this.page,
    this.limit,
    this.totalPages,
  });

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      total: json['total'] as int?,
      page: json['page'] as int?,
      limit: json['limit'] as int?,
      totalPages: json['totalPages'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total': total,
      'page': page,
      'limit': limit,
      'totalPages': totalPages,
    };
  }
}
