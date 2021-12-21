import 'package:flutter/cupertino.dart';

class CustomerMetGridModel {
  String icon;
  String title;
  bool? isCall;

  GestureTapCallback? onTap;

  CustomerMetGridModel(this.icon, this.title, {this.onTap, this.isCall});
}
