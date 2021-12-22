class DashboardYardingandSelfReleaseModel {
  int? status;
  String? message;
  List<YardingResult>? result;

  DashboardYardingandSelfReleaseModel({this.status, this.message, this.result});

  DashboardYardingandSelfReleaseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['result'] != null) {
      result = [];
      json['result'].forEach((v) {
        result?.add(YardingResult.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (result != null) {
      data['result'] = result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class YardingResult {
  String? sId;
  int? due;
  String? cust;
  String? collSubStatus;
  String? customerId;
  String? caseId;
  List<Address>? address;

  YardingResult(
      {this.sId,
      this.due,
      this.cust,
      this.collSubStatus,
      this.customerId,
      this.caseId,
      this.address});

  YardingResult.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['due'] = due;
    data['cust'] = cust;
    data['collSubStatus'] = collSubStatus;
    data['customerId'] = customerId;
    data['caseId'] = caseId;
    if (address != null) {
      data['address'] = address!.map((v) => v.toJson()).toList();
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
