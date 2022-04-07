import 'package:flutter/material.dart';
import 'package:origa/utils/base_equatable.dart';

class HomeTabEvent extends BaseEquatable {}

class HomeTabInitialEvent extends HomeTabEvent {
  HomeTabInitialEvent({this.notificationData, required this.context});
  final dynamic notificationData;
  final BuildContext context;
}

// class LoginExpired extends HomeTabEvent {}
