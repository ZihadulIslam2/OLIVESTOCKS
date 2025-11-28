class UpdateUserResponseModel {
  bool? success;
  String? message;
  Data? data;

  UpdateUserResponseModel({this.success, this.message, this.data});

  UpdateUserResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
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
  Null? passwordResetToken;
  String? refreshToken;
  String? address;
  String? fullName;
  String? profilePhoto;

  Data(
      {this.verificationInfo,
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
        this.profilePhoto});

  Data.fromJson(Map<String, dynamic> json) {
    verificationInfo = json['verificationInfo'] != null
        ? new VerificationInfo.fromJson(json['verificationInfo'])
        : null;
    sId = json['_id'];
    userName = json['userName'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    password = json['password'];
    role = json['role'];
    followers = json['followers'];
    refferCount = json['refferCount'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    passwordResetToken = json['password_reset_token'];
    refreshToken = json['refreshToken'];
    address = json['address'];
    fullName = json['fullName'];
    profilePhoto = json['profilePhoto'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.verificationInfo != null) {
      data['verificationInfo'] = this.verificationInfo!.toJson();
    }
    data['_id'] = this.sId;
    data['userName'] = this.userName;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    data['password'] = this.password;
    data['role'] = this.role;
    data['followers'] = this.followers;
    data['refferCount'] = this.refferCount;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['password_reset_token'] = this.passwordResetToken;
    data['refreshToken'] = this.refreshToken;
    data['address'] = this.address;
    data['fullName'] = this.fullName;
    data['profilePhoto'] = this.profilePhoto;
    return data;
  }
}

class VerificationInfo {
  bool? verified;
  String? token;

  VerificationInfo({this.verified, this.token});

  VerificationInfo.fromJson(Map<String, dynamic> json) {
    verified = json['verified'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['verified'] = this.verified;
    data['token'] = this.token;
    return data;
  }
}
