part of 'login_bloc.dart';

abstract class LoginEvent extends BaseEquatable {}

class LoginInitialEvent extends LoginEvent {}

class SignInEvent extends LoginEvent {
  dynamic paramValue;
  String? userId;
  SignInEvent({this.paramValue, this.userId});
}

class HomeTabEvent extends LoginEvent {}

class NoInternetConnectionEvent extends LoginEvent {}

class ResendOTPEvent extends LoginEvent {}
