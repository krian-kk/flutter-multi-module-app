import 'package:flutter/material.dart';
import 'package:origa/utils/base_equatable.dart';

abstract class AuthenticationEvent extends BaseEquatable {}

class AppStarted extends AuthenticationEvent {
  @override
  String toString() => 'AppStarted';
  BuildContext? context;
  AppStarted({this.context});
}

class UnAuthenticationEvent extends AuthenticationEvent {}
