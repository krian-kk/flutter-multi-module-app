
import 'package:origa/utils/base_equatable.dart';

abstract class AuthenticationState extends BaseEquatable {}

class AuthenticationUnInitialized extends AuthenticationState {
  @override
  String toString() {
    return 'AuthenticationUnInitialized';
  }
}

class AuthenticationUnAuthenticated extends AuthenticationState {
  AuthenticationUnAuthenticated({this.notificationData});

  final dynamic notificationData;

  @override
  String toString() {
    return 'AuthenticationUnAuthenticated';
  }
}

class AuthenticationAuthenticated extends AuthenticationState {
  AuthenticationAuthenticated({this.notificationData});

  final dynamic notificationData;

  @override
  String toString() {
    return 'AuthenticationAuthenticated';
  }
}

class SplashScreenState extends AuthenticationState {}

class OfflineState extends AuthenticationState {
  @override
  String toString() {
    return 'AuthenticationUnAuthenticated';
  }
}
