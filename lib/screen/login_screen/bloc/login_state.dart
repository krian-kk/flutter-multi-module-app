part of 'login_bloc.dart';

@immutable
abstract class LoginState extends BaseEquatable {}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginLoadedState extends LoginState {}

class HomeTabState extends LoginState {}

class NoInternetConnectionState extends LoginState {}

class SignInLoadingState extends LoginState {}

class SignInLoadedState extends LoginState {}

class SignInCompletedState extends LoginState {}

class ResendOTPState extends LoginState {}
