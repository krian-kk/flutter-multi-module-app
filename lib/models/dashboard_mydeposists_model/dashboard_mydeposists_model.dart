class MyDeposistModel {
  int? status;
  String? message;
  MyDepositResult? result;

  MyDeposistModel({this.status, this.message, this.result});

  MyDeposistModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    result = json['result'] != null
        ? MyDepositResult.fromJson(json['result'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.result != null) {
      data['result'] = this.result?.toJson();
    }
    return data;
  }
}

class MyDepositResult {
  int? count;
  int? totalAmt;
  Cheque? cheque;
  Cheque? cash;

  MyDepositResult({this.count, this.totalAmt, this.cheque, this.cash});

  MyDepositResult.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    totalAmt = json['totalAmt'];
    cheque =
        json['cheque'] != null ? new Cheque.fromJson(json['cheque']) : null;
    cash = json['cash'] != null ? new Cheque.fromJson(json['cash']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['totalAmt'] = this.totalAmt;
    if (this.cheque != null) {
      data['cheque'] = this.cheque?.toJson();
    }
    if (this.cash != null) {
      data['cash'] = this.cash?.toJson();
    }
    return data;
  }
}

class Cheque {
  int? count;
  List<Cases>? cases;
  int? totalAmt;

  Cheque({this.count, this.cases, this.totalAmt});

  Cheque.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['cases'] != null) {
      cases = [];
      json['cases'].forEach((v) {
        cases?.add(new Cases.fromJson(v));
      });
    }
    totalAmt = json['totalAmt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    if (this.cases != null) {
      data['cases'] = this.cases?.map((v) => v.toJson()).toList();
    }
    data['totalAmt'] = this.totalAmt;
    return data;
  }
}

class Cases {
  String? sId;
  double? due;
  String? cust;
  String? collSubStatus;
  String? telSubStatus;
  String? agrRef;
  String? bankName;
  String? caseId;
  String? fieldfollowUpDate;
  String? customerId;
  List<Address>? address;

  Cases(
      {this.sId,
      this.due,
      this.cust,
      this.collSubStatus,
      this.telSubStatus,
      this.agrRef,
      this.bankName,
      this.caseId,
      this.fieldfollowUpDate,
      this.customerId,
      this.address});

  Cases.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    due = json['due'];
    cust = json['cust'];
    collSubStatus = json['collSubStatus'];
    telSubStatus = json['telSubStatus'];
    agrRef = json['agrRef'] ?? '-';
    bankName = json['bankName'] ?? '-';
    caseId = json['caseId'];
    fieldfollowUpDate = json['fieldfollowUpDate'] ?? '-';
    customerId = json['customerId'];
    if (json['address'] != null) {
      address = [];
      json['address'].forEach((v) {
        address?.add(Address.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['due'] = this.due;
    data['cust'] = this.cust;
    data['collSubStatus'] = this.collSubStatus;
    data['telSubStatus'] = telSubStatus;
    data['agrRef'] = agrRef;
    data['bankName'] = bankName;
    data['caseId'] = this.caseId;
    data['fieldfollowUpDate'] = this.fieldfollowUpDate;
    data['customerId'] = this.customerId;
    if (this.address != null) {
      data['address'] = this.address?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Address {
  String? cType;
  String? value;

  Address({this.cType, this.value});

  Address.fromJson(Map<String, dynamic> json) {
    cType = json['cType'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cType'] = this.cType;
    data['value'] = this.value;
    return data;
  }
}
