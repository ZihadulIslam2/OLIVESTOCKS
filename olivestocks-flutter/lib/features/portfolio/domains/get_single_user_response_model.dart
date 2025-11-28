import 'package:path/path.dart';

class GetSingleUserResponseModel {
  bool? status;
  String? message;
  Data? data;
  String? payment;
  dynamic expiryDate; // Replaced Null? with dynamic?

  GetSingleUserResponseModel({
    this.status,
    this.message,
    this.data,
    this.payment,
    this.expiryDate,
  });

  factory GetSingleUserResponseModel.fromJson(Map<String, dynamic> json) {

    print(DateTime.now().subtract(Duration(days: 1)).toUtc().toIso8601String());

    return GetSingleUserResponseModel(
      status: json['status'],
      message: json['message'],
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
      payment: json['payment'],
      expiryDate: json['expiryDate'] != null ? json['expiryDate'] : DateTime.now().subtract(Duration(days: 1)).toUtc().toIso8601String(),
      //expiryDate: json['expiryDate'],
    );

  }



  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data?.toJson(),
      'payment': payment,
      'expiryDate': expiryDate,
    };
  }
}

class Data {
  VerificationInfo? verificationInfo;
  String? sId;
  String? userName;
  String? email;
  String? phoneNumber;
  String? password;
  String? role;
  int? followers;
  int? refferCount;
  String? createdAt;
  String? updatedAt;
  int? iV;
  dynamic passwordResetToken;
  String? refreshToken;
  String? address;
  String? fullName;
  String? profilePhoto;

  Data({
    this.verificationInfo,
    this.sId,
    this.userName,
    this.email,
    this.phoneNumber,
    this.password,
    this.role,
    this.followers,
    this.refferCount,
    this.createdAt,
    this.updatedAt,
    this.iV,
    this.passwordResetToken,
    this.refreshToken,
    this.address,
    this.fullName,
    this.profilePhoto,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      verificationInfo: json['verificationInfo'] != null
          ? VerificationInfo.fromJson(json['verificationInfo'])
          : null,
      sId: json['_id'],
      userName: json['userName'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      password: json['password'],
      role: json['role'],
      followers: json['followers'],
      refferCount: json['refferCount'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      iV: json['__v'],
      passwordResetToken: json['password_reset_token'],
      refreshToken: json['refreshToken'],
      address: json['address'],
      fullName: json['fullName'],
      profilePhoto: json['profilePhoto'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'verificationInfo': verificationInfo?.toJson(),
      '_id': sId,
      'userName': userName,
      'email': email,
      'phoneNumber': phoneNumber,
      'password': password,
      'role': role,
      'followers': followers,
      'refferCount': refferCount,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': iV,
      'password_reset_token': passwordResetToken,
      'refreshToken': refreshToken,
      'address': address,
      'fullName': fullName,
      'profilePhoto': profilePhoto,
    };
  }
}

class VerificationInfo {
  bool? verified;
  String? token;

  VerificationInfo({this.verified, this.token});

  factory VerificationInfo.fromJson(Map<String, dynamic> json) {
    return VerificationInfo(
      verified: json['verified'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'verified': verified,
      'token': token,
    };
  }
}
