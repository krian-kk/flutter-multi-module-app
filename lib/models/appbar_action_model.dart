import 'package:flutter/cupertino.dart';

class AppbarActionModel {
  bool switchAction;
  String title;
  String image;

  AppbarActionModel({
    this.switchAction: true,
    required this.title,
    required this.image,
  });
}