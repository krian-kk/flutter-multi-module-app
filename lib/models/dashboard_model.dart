// import 'package:flutter/cupertino.dart';

class DashboardListModel {
  DashboardListModel({
    this.title,
    this.subTitle,
    this.image,
    this.count,
    this.amountRs,
  });
  String? title;
  String? subTitle;
  String? image;
  String? count;
  String? amountRs;
}

// class CaseListModel {
//   bool? newlyAdded;
//   String? amount;
//   String? customerName;
//   String? address;
//   String? date;
//   String? loanID;
//   GestureTapCallback? onTap;

//   CaseListModel({
//     this.newlyAdded,
//     this.amount,
//     this.customerName,
//     this.address,
//     this.date,
//     this.loanID,
//     this.onTap,
//   });
// }

class FilterCasesByTimeperiod {
  FilterCasesByTimeperiod({
    this.timeperiodText,
    this.value,
  });
  String? timeperiodText;
  String? value;
}
