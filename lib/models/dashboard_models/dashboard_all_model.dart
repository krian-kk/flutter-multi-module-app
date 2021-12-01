import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class DashboardAllModel {
  int? status;
  String? message;
  Result? result;

  DashboardAllModel({this.status, this.message, this.result});

  DashboardAllModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    result =
        json['result'] != null ? Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.result != null) {
      data['result'] = this.result?.toJson();
    }
    return data;
  }
}

class Result {
  int? count;
  int? totalAmt;
  List<Cases>? cases;

  Result({this.count, this.totalAmt, this.cases});

  Result.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    totalAmt = json['totalAmt'];
    if (json['cases'] != null) {
      cases = [];
      json['cases'].forEach((v) {
        cases?.add(Cases.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['totalAmt'] = this.totalAmt;
    if (this.cases != null) {
      data['cases'] = this.cases?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Cases {
  String? sId;
  int? due;
  String? cust;
  String? collSubStatus;
  String? followUpDate;
  String? customerId;
  String? caseId;
  List<Address>? address;

  Cases(
      {this.sId,
      this.due,
      this.cust,
      this.collSubStatus,
      this.followUpDate,
      this.customerId,
      this.caseId,
      this.address});

  Cases.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    due = json['due'];
    cust = json['cust'];
    collSubStatus = json['collSubStatus'];
    followUpDate = json['followUpDate'];
    customerId = json['customerId'];
    caseId = json['caseId'];
    if (json['address'] != null) {
      address =  [];
      json['address'].forEach((v) {
        address?.add(Address.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = this.sId;
    data['due'] = this.due;
    data['cust'] = this.cust;
    data['collSubStatus'] = this.collSubStatus;
    data['followUpDate'] = this.followUpDate;
    data['customerId'] = this.customerId;
    data['caseId'] = this.caseId;
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
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['cType'] = this.cType;
    data['value'] = this.value;
    return data;
  }
}