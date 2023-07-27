import 'package:flutter/material.dart';

abstract class SignInEvent {}

class SignInUsernameChanged extends SignInEvent {
  final String username;

  SignInUsernameChanged({required this.username});
}

class SignInPasswordChanged extends SignInEvent {
  final String password;

  SignInPasswordChanged({required this.password});
}

class SignInSubmitted extends SignInEvent {
  SignInSubmitted({this.paramValue});

  final dynamic paramValue;
}
