class PaymentConfigurationModel {
  String? status;
  String? msg;
  List<Data>? data;

  PaymentConfigurationModel({this.status, this.msg, this.data});

  PaymentConfigurationModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? sId;
  List<Payment>? payment;

  Data({this.sId, this.payment});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    if (json['payment'] != null) {
      payment = <Payment>[];
      json['payment'].forEach((v) {
        payment!.add(new Payment.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.payment != null) {
      data['payment'] = this.payment!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Payment {
  Audit? audit;
  String? sId;
  String? paymentGateway;
  String? keyId;
  String? keySecret;
  bool? active;
  bool? partialPayment;
  bool? dynamicLink;
  bool? qrCode;
  int? expire;

  Payment(
      {this.audit,
      this.sId,
      this.paymentGateway,
      this.keyId,
      this.keySecret,
      this.active,
      this.partialPayment,
      this.dynamicLink,
      this.qrCode,
      this.expire});

  Payment.fromJson(Map<String, dynamic> json) {
    audit = json['audit'] != null ? new Audit.fromJson(json['audit']) : null;
    sId = json['_id'];
    paymentGateway = json['payment_gateway'];
    keyId = json['key_id'];
    keySecret = json['key_secret'];
    active = json['active'];
    partialPayment = json['partial_payment'];
    dynamicLink = json['dynamic_link'];
    qrCode = json['qr_code'];
    expire = json['expire'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.audit != null) {
      data['audit'] = this.audit!.toJson();
    }
    data['_id'] = this.sId;
    data['payment_gateway'] = this.paymentGateway;
    data['key_id'] = this.keyId;
    data['key_secret'] = this.keySecret;
    data['active'] = this.active;
    data['partial_payment'] = this.partialPayment;
    data['dynamic_link'] = this.dynamicLink;
    data['qr_code'] = this.qrCode;
    data['expire'] = this.expire;
    return data;
  }
}

class Audit {
  String? crAt;
  String? upAt;

  Audit({this.crAt, this.upAt});

  Audit.fromJson(Map<String, dynamic> json) {
    crAt = json['crAt'];
    upAt = json['upAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['crAt'] = this.crAt;
    data['upAt'] = this.upAt;
    return data;
  }
}
