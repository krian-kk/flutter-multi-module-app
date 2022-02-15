part of 'login_bloc.dart';

abstract class LoginEvent extends BaseEquatable {}

class LoginInitialEvent extends LoginEvent {
  final BuildContext? context;
  LoginInitialEvent({this.context});
}

class SignInEvent extends LoginEvent {
  final dynamic paramValue;
  final String? userId;
  SignInEvent({this.paramValue, this.userId});
}

class NoInternetConnectionEvent extends LoginEvent {}

class ResendOTPEvent extends LoginEvent {}
