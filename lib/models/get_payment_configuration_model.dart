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
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['msg'] = msg;
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
        payment!.add(Payment.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    if (payment != null) {
      data['payment'] = payment!.map((v) => v.toJson()).toList();
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
    audit = json['audit'] != null ? Audit.fromJson(json['audit']) : null;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    if (audit != null) {
      data['audit'] = audit!.toJson();
    }
    data['_id'] = sId;
    data['payment_gateway'] = paymentGateway;
    data['key_id'] = keyId;
    data['key_secret'] = keySecret;
    data['active'] = active;
    data['partial_payment'] = partialPayment;
    data['dynamic_link'] = dynamicLink;
    data['qr_code'] = qrCode;
    data['expire'] = expire;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['crAt'] = crAt;
    data['upAt'] = upAt;
    return data;
  }
}
