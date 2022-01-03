import 'package:flutter/material.dart';

class Singleton {
  String? accessToken;
  String? refreshToken;
  String? sessionID;
  String? agentRef;
  String? agentName;
  String? agrRef;
  String? usertype;
  BuildContext? buildContext;
  static final Singleton instance = Singleton.internal();

  factory Singleton() {
    return instance;
  }

  Singleton.internal();
}
