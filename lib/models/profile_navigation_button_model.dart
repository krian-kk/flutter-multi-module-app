import 'package:flutter/material.dart';

class ProfileNavigation {
  String title;
  int? notificationCount;
  GestureTapCallback? onTap;
  bool isEnable;
  ProfileNavigation({
    required this.title,
    this.onTap,
    this.notificationCount,
    required this.isEnable,
  });
}
