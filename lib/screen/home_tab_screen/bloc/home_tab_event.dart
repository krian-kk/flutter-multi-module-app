import 'package:flutter/material.dart';
import 'package:origa/utils/base_equatable.dart';

class HomeTabEvent extends BaseEquatable {}

class HomeTabInitialEvent extends HomeTabEvent {
  final dynamic notificationData;
  final BuildContext context;
  HomeTabInitialEvent({this.notificationData, required this.context});
}

// class LoginExpired extends HomeTabEvent {}
