part of 'login_bloc.dart';

@immutable
abstract class LoginState extends BaseEquatable {}

class LoginInitialState extends LoginState {}

class HomeTabState extends LoginState {}

class NoInternetConnectionState extends LoginState {}

class SignInLoadingState extends LoginState {}

class SignInLoadedState extends LoginState {}

class SignInCompletedState extends LoginState {}

class ResendOTPState extends LoginState {}

class EnterSecurePinState extends LoginState {
  EnterSecurePinState({this.securePin, this.userName});
  final int? securePin;
  final String? userName;
}
