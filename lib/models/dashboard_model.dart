import 'package:flutter/cupertino.dart';

class DashboardListModel {
  String? title;
  String? image;
  String? count;
  String? countNum;
  String? amount;
  String?  amountRs;
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