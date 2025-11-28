class NotificationResponseModel {
  final String? id;
  final String? userId;
  final String? message;
  final String? type;
  final String? related;
  final bool? isRead;
  final String? link;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  NotificationResponseModel({
    this.id,
    this.userId,
    this.message,
    this.type,
    this.related,
    this.isRead,
    this.link,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory NotificationResponseModel.fromJson(Map<String, dynamic> json) {
    return NotificationResponseModel(
      id: json['_id'],
      userId: json['userId'],
      message: json['message'],
      type: json['type'],
      related: json['related'],
      isRead: json['isRead'],
      link: json['link'],
      createdAt: json['createdAt'] != null ? DateTime.tryParse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.tryParse(json['updatedAt']) : null,
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userId': userId,
      'message': message,
      'type': type,
      'related': related,
      'isRead': isRead,
      'link': link,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      '__v': v,
    };
  }
}
