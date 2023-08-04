import 'package:flutter/material.dart';
import 'package:origa/utils/base_equatable.dart';

abstract class AuthenticationEvent extends BaseEquatable {}

class AppStarted extends AuthenticationEvent {
  AppStarted({this.context, this.notificationData});
  @override
  String toString() => 'AppStarted';
  final BuildContext? context;
  final dynamic notificationData;
}

class UnAuthenticationEvent extends AuthenticationEvent {}
