class UpdateUserResponseModel {
  bool? success;
  String? message;
  UpdateUserData? data;

  UpdateUserResponseModel({this.success, this.message, this.data});

  UpdateUserResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? UpdateUserData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class UpdateUserData {
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
  String? passwordResetToken;
  String? refreshToken;
  String? address;
  String? fullName;

  UpdateUserData({
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
  });

  UpdateUserData.fromJson(Map<String, dynamic> json) {
    verificationInfo = json['verificationInfo'] != null
        ? VerificationInfo.fromJson(json['verificationInfo'])
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (verificationInfo != null) {
      data['verificationInfo'] = verificationInfo!.toJson();
    }
    data['_id'] = sId;
    data['userName'] = userName;
    data['email'] = email;
    data['phoneNumber'] = phoneNumber;
    data['password'] = password;
    data['role'] = role;
    data['followers'] = followers;
    data['refferCount'] = refferCount;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['password_reset_token'] = passwordResetToken;
    data['refreshToken'] = refreshToken;
    data['address'] = address;
    data['fullName'] = fullName;
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
    final Map<String, dynamic> data = {};
    data['verified'] = verified;
    data['token'] = token;
    return data;
  }
}
