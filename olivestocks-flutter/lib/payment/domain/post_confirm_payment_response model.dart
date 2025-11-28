class PostConfirmPaymentResponseModel {
  String? paymentIntentId;

  PostConfirmPaymentResponseModel({this.paymentIntentId});

  PostConfirmPaymentResponseModel.fromJson(Map<String, dynamic> json) {
    paymentIntentId = json['paymentIntentId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['paymentIntentId'] = this.paymentIntentId;
    return data;
  }
}
