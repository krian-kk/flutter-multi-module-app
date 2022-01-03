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
  dynamic due;
  bool? starredCase;
  String? cust;
  String? collSubStatus;
  String? telSubStatus;
  String? followUpPriority;
  String? customerId;
  String? pincode;
  String? caseId;
  String? agrRef;
  String? bankName;
  String? fieldfollowUpDate;
  int? sortId;
  String? followUpDate;
  String? locationType;
  int? distanceMeters;
  String? repoStatus;
  String? accNo;
  List<Address>? address;

  Result(
      {this.sId,
      this.due,
      this.starredCase,
      this.cust,
      this.collSubStatus,
      this.telSubStatus,
      this.followUpPriority,
      this.customerId,
      this.pincode,
      this.caseId,
      this.agrRef,
      this.bankName,
      this.fieldfollowUpDate,
      this.sortId,
      this.followUpDate,
      this.locationType,
      this.distanceMeters,
      this.repoStatus,
      this.accNo,
      this.address});

  Result.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    due = json['due'];
    starredCase = json['starredCase'];
    cust = json['cust'];
    collSubStatus = json['collSubStatus'];
    telSubStatus = json['telSubStatus'];
    followUpPriority = json['followUpPriority'];
    customerId = json['customerId'];
    pincode = json['pincode'];
    caseId = json['caseId'];
    agrRef = json['agrRef'] ?? '-';
    bankName = json['bankName'] ?? '-';
    fieldfollowUpDate = json['fieldfollowUpDate'];
    sortId = json['sortId'];
    followUpDate = json['followUpDate'];
    locationType = json['locationType'];
    distanceMeters = json['distanceMeters'];
    repoStatus = json['repoStatus'];
    accNo = json['accNo'];
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
    data['telSubStatus'] = telSubStatus;
    data['followUpPriority'] = followUpPriority;
    data['customerId'] = customerId;
    data['pincode'] = pincode;
    data['caseId'] = caseId;
    data['agrRef'] = agrRef;
    data['bankName'] = bankName;
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
