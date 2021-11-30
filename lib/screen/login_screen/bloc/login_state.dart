part of 'login_bloc.dart';

@immutable
abstract class LoginState extends BaseEquatable {}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginLoadedState extends LoginState {}

class HomeTabState extends LoginState {}
