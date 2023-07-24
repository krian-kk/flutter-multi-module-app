class GeneratePaymentLinkModel {

  GeneratePaymentLinkModel({this.status, this.message, this.data});

  GeneratePaymentLinkModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  int? status;
  String? message;
  Data? data;

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

class GenerateQrLinkModel {

  GenerateQrLinkModel({this.status, this.message, this.data});

  GenerateQrLinkModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? QRData.fromJson(json['data']) : null;
  }
  int? status;
  String? message;
  QRData? data;

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

  Data({this.paymentId, this.paymentLink});

  Data.fromJson(Map<String, dynamic> json) {
    paymentId = json['payment_id'];
    paymentLink = json['payment_link'];
  }
  String? paymentId;
  String? paymentLink;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['payment_id'] = paymentId;
    data['payment_link'] = paymentLink;
    return data;
  }
}

class QRData {

  QRData({this.paymentId, this.qrLink});

  QRData.fromJson(Map<String, dynamic> json) {
    paymentId = json['payment_id'];
    qrLink = json['qr_link'];
  }
  String? paymentId;
  String? qrLink;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['payment_id'] = paymentId;
    data['qr_link'] = qrLink;
    return data;
  }
}

class GeneratePaymentLinkPost {
  GeneratePaymentLinkPost({
    required this.caseId,
    required this.dynamicLink,
  });

  GeneratePaymentLinkPost.fromJson(Map<String, dynamic> json) {
    caseId = json['caseId'];
    dynamicLink = json['dynamic_link'];
  }
  String? caseId;
  bool? dynamicLink;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['caseId'] = caseId;
    data['dynamic_link'] = dynamicLink;
    return data;
  }
}
