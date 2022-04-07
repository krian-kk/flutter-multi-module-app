import 'package:flutter/cupertino.dart';

class AllocationListModel {
  AllocationListModel({
    this.newlyAdded,
    this.amount,
    this.customerName,
    this.address,
    this.date,
    this.loanID,
    this.onTap,
  });

  bool? newlyAdded;
  String? amount;
  String? customerName;
  String? address;
  String? date;
  String? loanID;
  GestureTapCallback? onTap;
}
