import 'package:flutter/material.dart';

class ProfileNavigation {
  String title;
  bool count;
  GestureTapCallback? onTap;
  ProfileNavigation({required this.title, required this.count, this.onTap});
}
