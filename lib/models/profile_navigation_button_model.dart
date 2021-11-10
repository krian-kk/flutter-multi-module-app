import 'package:flutter/material.dart';

class ProfileNavigation {
  String title;
  int? notificationCount;
  GestureTapCallback? onTap;
  ProfileNavigation({
    required this.title,
    this.onTap,
    this.notificationCount,
  });
}
