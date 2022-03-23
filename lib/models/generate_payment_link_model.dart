class GeneratePaymentLinkModel {
  String? status;
  String? msg;
  Data? data;

  GeneratePaymentLinkModel({this.status, this.msg, this.data});

  GeneratePaymentLinkModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? msg;
  Data2? data;

  Data({this.msg, this.data});

  Data.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    data = json['data'] != null ? new Data2.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data2 {
  String? paymentId;
  String? paymentLink;
  String? qrLink;

  Data2({this.paymentId, this.paymentLink, this.qrLink});

  Data2.fromJson(Map<String, dynamic> json) {
    paymentId = json['payment_id'];
    paymentLink = json['payment_link'];
    qrLink = json['qr_link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['payment_id'] = paymentId;
    data['payment_link'] = paymentLink;
    data['qr_link'] = qrLink;
    return data;
  }
}

class GeneratePaymentLinkPost {
  String? caseId;
  bool? dynamic_link;

  GeneratePaymentLinkPost({
    required this.caseId,
    required this.dynamic_link,
  });

  GeneratePaymentLinkPost.fromJson(Map<String, dynamic> json) {
    caseId = json['caseId'];
    dynamic_link = json['dynamic_link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['caseId'] = caseId;
    data['dynamic_link'] = dynamic_link;
    return data;
  }
}
