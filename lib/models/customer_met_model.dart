import 'package:flutter/cupertino.dart';

class CustomerMetGridModel {
  String icon;
  String title;
  GestureTapCallback? onTap;

  CustomerMetGridModel(this.icon, this.title, {this.onTap});
}
