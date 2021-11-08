import 'package:flutter/cupertino.dart';

class DashboardListModel {
  String? title;
  String? image;
  String? count;
  String? countNum;
  String? amount;
  String? amountRs;
  GestureTapCallback? onTap;

  DashboardListModel({
    this.title,
    this.image,
    this.count,
    this.countNum,
    this.amount,
    this.amountRs,
    this.onTap,
  });
}

class CaseListModel {
  bool? newlyAdded;
  String? amount;
  String? customerName;
  String? address;
  String? date;
  String? loanID;
  GestureTapCallback? onTap;

  CaseListModel({
    this.newlyAdded,
    this.amount,
    this.customerName,
    this.address,
    this.date,
    this.loanID,
    this.onTap,
  });
}
