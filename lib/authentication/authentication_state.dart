import 'package:origa/utils/base_equatable.dart';

abstract class AuthenticationState extends BaseEquatable {}

class AuthenticationUnInitialized extends AuthenticationState {
  @override
  String toString() {
    return "AuthenticationUnInitialized";
  }
}

class AuthenticationUnAuthenticated extends AuthenticationState {
  @override
  String toString() {
    return "AuthenticationUnAuthenticated";
  }
}

class AuthenticationAuthenticated extends AuthenticationState {
  @override
  String toString() {
    return "AuthenticationAuthenticated";
  }
}
