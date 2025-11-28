class PostCreatePaymentResponseModel {
  bool? success;
  String? clientSecret;
  String? message;

  PostCreatePaymentResponseModel(
      {this.success, this.clientSecret, this.message});

  PostCreatePaymentResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    clientSecret = json['clientSecret'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['clientSecret'] = this.clientSecret;
    data['message'] = this.message;
    return data;
  }
}
