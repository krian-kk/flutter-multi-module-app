part of 'profile_bloc.dart';

class ProfileState extends BaseEquatable {}

class ProfileInitial extends ProfileState {}

class ProfileLoadedState extends ProfileState {}

class ProfileLoadingState extends ProfileState {}

class AuthorizationLoadingState extends ProfileState {}

class ClickNotificationState extends ProfileState {}

class ClickAuthorizationLetterState extends ProfileState {}

class ClickIDCardState extends ProfileState {}

class CustomerLanguagePreferenceState extends ProfileState {}

class ClickChangePasswordState extends ProfileState {}

class ClickChangeSecurityPinState extends ProfileState {}

class ClickMessageState extends ProfileState {
  ClickMessageState({this.fromId, this.toId});

  final String? fromId;
  final String? toId;
}

class ClickMarkAsHomeState extends ProfileState {}


class LoginState extends ProfileState {}

class NoInternetState extends ProfileState {}


class SwitchCardState extends ProfileState {}

class SuccessUpdatedProfileImageState extends ProfileState {}

class FailureUpdateProfileImageState extends ProfileState {}

class ImagePopUpState extends ProfileState {}

class OpenChangeLanguagePopUpState extends ProfileState {}

class ClickChangeLanguageState extends ProfileState {}
