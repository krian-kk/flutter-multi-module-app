import 'package:origa/utils/base_equatable.dart';

abstract class AuthenticationState extends BaseEquatable {}

class AuthenticationUnInitialized extends AuthenticationState {
  @override
  String toString() {
    return "AuthenticationUnInitialized";
  }
}

class AuthenticationUnAuthenticated extends AuthenticationState {
  final dynamic notificationData;
  @override
  String toString() {
    return "AuthenticationUnAuthenticated";
  }

  AuthenticationUnAuthenticated({this.notificationData});
}

class AuthenticationAuthenticated extends AuthenticationState {
  final dynamic notificationData;
  @override
  String toString() {
    return "AuthenticationAuthenticated";
  }

  AuthenticationAuthenticated({this.notificationData});
}

class SplashScreenState extends AuthenticationState {}

class OfflineState extends AuthenticationState {
  @override
  String toString() {
    return "AuthenticationUnAuthenticated";
  }
}
