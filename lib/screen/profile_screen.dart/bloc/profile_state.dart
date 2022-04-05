part of 'profile_bloc.dart';

class ProfileState extends BaseEquatable {}

class ProfileInitial extends ProfileState {}

class ProfileLoadedState extends ProfileState {}

class ProfileLoadingState extends ProfileState {}

class ClickNotificationState extends ProfileState {}

class ClickChangeLaunguageState extends ProfileState {}

class CustomerLaunguagePrefrerenceState extends ProfileState {}

class ClickChangePasswordState extends ProfileState {}

class ClickChangeSecurityPinState extends ProfileState {}

class ClickMessageState extends ProfileState {
  ClickMessageState({this.fromId, this.toId});
  final String? fromId;
  final String? toId;
}

class ClickMarkAsHomeState extends ProfileState {}

class ChangeProfileImageState extends ProfileState {}

class LoginState extends ProfileState {}

class NoInternetState extends ProfileState {}

class PostDataApiSuccessState extends ProfileState {}
