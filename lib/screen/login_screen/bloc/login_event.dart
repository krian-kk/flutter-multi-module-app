part of 'login_bloc.dart';

abstract class LoginEvent extends BaseEquatable {}

class LoginInitialEvent extends LoginEvent {
  LoginInitialEvent({this.context});
  final BuildContext? context;
}

class SignInEvent extends LoginEvent {
  SignInEvent({this.paramValue, this.userId, required this.context});
  final dynamic paramValue;
  final String? userId;
  final BuildContext context;
}

class NoInternetConnectionEvent extends LoginEvent {}

class ResendOTPEvent extends LoginEvent {}

class TriggeredHomeTabEvent extends LoginEvent {
  TriggeredHomeTabEvent(this.userId);
  final String userId;
}
