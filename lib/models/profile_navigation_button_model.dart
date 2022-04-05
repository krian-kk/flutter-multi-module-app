import 'package:flutter/material.dart';

class ProfileNavigation {
  ProfileNavigation({
    required this.title,
    this.onTap,
    this.notificationCount,
    required this.isEnable,
  });
  String title;
  int? notificationCount;
  GestureTapCallback? onTap;
  bool isEnable;
}
