part of 'login_bloc.dart';

abstract class LoginEvent extends BaseEquatable {}

class LoginInitialEvent extends LoginEvent {}

class SignInEvent extends LoginEvent {
  dynamic paramValue;
  String? userName;
  SignInEvent({this.paramValue, this.userName});
}

class HomeTabEvent extends LoginEvent {}

class NoInternetConnectionEvent extends LoginEvent {}

// class SignInLoadingEvent extends LoginEvent {}

// class SignInLoadedEvent extends LoginEvent {}

class ResendOTPEvent extends LoginEvent {}
