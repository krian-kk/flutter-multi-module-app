class DashboardYardingandSelfReleaseModel {
  int? status;
  String? message;
  List<Result>? result;

  DashboardYardingandSelfReleaseModel({this.status, this.message, this.result});

  DashboardYardingandSelfReleaseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['result'] != null) {
      result = [];
      json['result'].forEach((v) {
        result?.add(Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.result != null) {
      data['result'] = this.result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  String? sId;
  int? due;
  String? cust;
  String? collSubStatus;
  String? customerId;
  String? caseId;
  List<Address>? address;

  Result(
      {this.sId,
      this.due,
      this.cust,
      this.collSubStatus,
      this.customerId,
      this.caseId,
      this.address});

  Result.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    due = json['due'];
    cust = json['cust'];
    collSubStatus = json['collSubStatus'];
    customerId = json['customerId'];
    caseId = json['caseId'];
    if (json['address'] != null) {
      address = [];
      json['address'].forEach((v) {
        address!.add(Address.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['due'] = this.due;
    data['cust'] = this.cust;
    data['collSubStatus'] = this.collSubStatus;
    data['customerId'] = this.customerId;
    data['caseId'] = this.caseId;
    if (this.address != null) {
      data['address'] = this.address!.map((v) => v.toJson()).toList();
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
