import 'package:flutter/material.dart';
import 'package:origa/utils/base_equatable.dart';

abstract class AuthenticationEvent extends BaseEquatable {}

class AppStarted extends AuthenticationEvent {
  @override
  String toString() => 'AppStarted';
  final BuildContext? context;
  final dynamic notificationData;
  AppStarted({this.context, this.notificationData});
}

class UnAuthenticationEvent extends AuthenticationEvent {}
