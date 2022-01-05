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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (result != null) {
      data['result'] = result?.toJson();
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
    cheque = json['cheque'] != null ? Cheque.fromJson(json['cheque']) : null;
    cash = json['cash'] != null ? Cheque.fromJson(json['cash']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    data['totalAmt'] = totalAmt;
    if (cheque != null) {
      data['cheque'] = cheque?.toJson();
    }
    if (cash != null) {
      data['cash'] = cash?.toJson();
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
        cases?.add(Cases.fromJson(v));
      });
    }
    totalAmt = json['totalAmt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    if (cases != null) {
      data['cases'] = cases?.map((v) => v.toJson()).toList();
    }
    data['totalAmt'] = totalAmt;
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
    if (json['contact'] != null) {
      address = [];
      json['contact'].forEach((v) {
        address?.add(Address.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['due'] = due;
    data['cust'] = cust;
    data['collSubStatus'] = collSubStatus;
    data['telSubStatus'] = telSubStatus;
    data['agrRef'] = agrRef;
    data['bankName'] = bankName;
    data['caseId'] = caseId;
    data['fieldfollowUpDate'] = fieldfollowUpDate;
    data['customerId'] = customerId;
    if (address != null) {
      data['contact'] = address?.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cType'] = cType;
    data['value'] = value;
    return data;
  }
}
