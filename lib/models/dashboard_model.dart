import 'package:flutter/cupertino.dart';

class DashboardListModel {
  String? title;
  String? subTitle;
  String? image;
  String? count;
  String? amountRs;

  DashboardListModel({
    this.title,
    this.subTitle,
    this.image,
    this.count,
    this.amountRs,
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

class FilterCasesByTimeperiod {
  String? timeperiodText;
  String? value;

  FilterCasesByTimeperiod({
    this.timeperiodText,
    this.value,
  });
}
