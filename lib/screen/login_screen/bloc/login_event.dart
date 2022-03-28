part of 'login_bloc.dart';

abstract class LoginEvent extends BaseEquatable {}

class LoginInitialEvent extends LoginEvent {
  final BuildContext? context;
  LoginInitialEvent({this.context});
}

class SignInEvent extends LoginEvent {
  final dynamic paramValue;
  final String? userId;
  final BuildContext context;
  SignInEvent({this.paramValue, this.userId, required this.context});
}

class NoInternetConnectionEvent extends LoginEvent {}

class ResendOTPEvent extends LoginEvent {}

class TriggeredHomeTabEvent extends LoginEvent {
  final String userId;
  TriggeredHomeTabEvent(this.userId);
}
