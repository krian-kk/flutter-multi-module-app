class PriorityCaseListModel {
  int? status;
  String? message;
  List<Result>? result;

  PriorityCaseListModel({this.status, this.message, this.result});

  PriorityCaseListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result?.add(Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (result != null) {
      data['result'] = result?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  String? sId;
  int? due;
  bool? starredCase;
  String? cust;
  String? collSubStatus;
  String? followUpPriority;
  String? customerId;
  String? pincode;
  String? caseId;
  String? fieldfollowUpDate;
  int? sortId;
  List<Address>? address;

  Result(
      {this.sId,
      this.due,
      this.starredCase,
      this.cust,
      this.collSubStatus,
      this.followUpPriority,
      this.customerId,
      this.pincode,
      this.caseId,
      this.fieldfollowUpDate,
      this.sortId,
      this.address});

  Result.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    due = json['due'];
    starredCase = json['starredCase'];
    cust = json['cust'];
    collSubStatus = json['collSubStatus'];
    followUpPriority = json['followUpPriority'];
    customerId = json['customerId'];
    pincode = json['pincode'];
    caseId = json['caseId'];
    fieldfollowUpDate = json['fieldfollowUpDate'];
    sortId = json['sortId'];
    if (json['address'] != null) {
      address = <Address>[];
      json['address'].forEach((v) {
        address?.add(Address.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['due'] = due;
    data['starredCase'] = starredCase;
    data['cust'] = cust;
    data['collSubStatus'] = collSubStatus;
    data['followUpPriority'] = followUpPriority;
    data['customerId'] = customerId;
    data['pincode'] = pincode;
    data['caseId'] = caseId;
    data['fieldfollowUpDate'] = fieldfollowUpDate;
    data['sortId'] = sortId;
    if (address != null) {
      data['address'] = address?.map((v) => v.toJson()).toList();
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