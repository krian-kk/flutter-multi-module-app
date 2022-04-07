import 'package:flutter/material.dart';

class SelectedClipModel {
  SelectedClipModel(this.clipTitle);
  String clipTitle;
  GestureTapCallback? onTap;
}
