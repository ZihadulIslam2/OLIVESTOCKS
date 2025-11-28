class EmailVerificationResponseModel {
  final bool? success;
  final String? message;

  EmailVerificationResponseModel({this.success, this.message});

  factory EmailVerificationResponseModel.fromJson(Map<String, dynamic> json) {
    return EmailVerificationResponseModel(
      success: json['success'] as bool?,
      message: json['message'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
    };
  }
}
