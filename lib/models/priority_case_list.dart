import 'package:cloud_firestore/cloud_firestore.dart';

import '../singleton.dart';
import '../utils/constants.dart';

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
  late bool starredCase;
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
  dynamic sortId;
  String? followUpDate;
  String? locationType;
  dynamic distanceMeters;
  String? repoStatus;
  String? accNo;
  List<Address>? address;
  Location? location;
  bool? isCompletedSuccess = false;

  Result({
    this.sId,
    this.due,
    this.starredCase = false,
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
    this.address,
    this.location,
  });

  Result.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    due = json['due'];
    starredCase = json['starredCase'] ?? false;
    cust = json['cust'];
    collSubStatus = json['collSubStatus'];
    telSubStatus = json['telSubStatus'];
    followUpPriority = json['followUpPriority'];
    customerId = json['customerId'];
    pincode = json['pincode'];
    caseId = json['caseId'];
    agrRef = json['agrRef'] ?? '-';
    bankName = json['bankName'] ?? '-';

    sortId = json['sortId'];
    // followUpDate = json['followUpDate'];
    // Here we will check which user logged in then only set followUpDate
    if (Singleton.instance.usertype == Constants.fieldagent) {
      if (json['collSubStatus'] != null &&
          json['collSubStatus'].toString().toLowerCase() == 'new') {
        if (json['fieldfollowUpDate'] != null) {
          fieldfollowUpDate = DateTime.now().toString();
        } else {
          fieldfollowUpDate = json['fieldfollowUpDate'];
        }
      } else {
        fieldfollowUpDate = json['fieldfollowUpDate'];
      }
    } else {
      if (json['telSubStatus'] != null &&
          json['telSubStatus'].toString().toLowerCase() == 'new') {
        if (json['followUpDate'] != null) {
          followUpDate = DateTime.now().toString();
        } else {
          followUpDate = json['followUpDate'];
        }
      } else {
        followUpDate = json['followUpDate'];
      }
    }

    locationType = json['locationType'];
    distanceMeters = json['distanceMeters'];
    repoStatus = json['repoStatus'];
    accNo = json['accNo'];
    if (json['contact'] != null) {
      address = <Address>[];
      json['contact'].forEach((v) {
        address?.add(Address.fromJson(v));
      });
      if (address!.isNotEmpty) {
        address
            ?.sort((a, b) => (b.health ?? '1.5').compareTo(a.health ?? '1.5'));
      }
    } else {
      address = <Address>[];
      json['address'].forEach((v) {
        address?.add(Address.fromJson(v));
      });
    }
    if (json['location'] != null && json['location'] is! String) {
      location = Location.fromJson(json['location']);
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
    if (location != null) {
      data['location'] = location!.toJson();
    }
    return data;
  }
}

class Address {
  String? cType;
  String? value;
  String? health;

  Address({this.cType, this.value, this.health});

  Address.fromJson(Map<String, dynamic> json) {
    cType = json['cType'];
    value = json['value'];
    health = json['health'] ?? '1.5';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cType'] = cType;
    data['value'] = value;
    data['health'] = health;
    return data;
  }
}

class Location {
  double? lat;
  double? lng;

  Location({this.lat, this.lng});

  Location.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lat'] = lat;
    data['lng'] = lng;
    return data;
  }
}
