import 'package:flutter/cupertino.dart';

class CustomerMetGridModel {
  CustomerMetGridModel(this.icon, this.title, {this.onTap, this.isCall});
  String icon;
  String title;
  bool? isCall;
  GestureTapCallback? onTap;
}
