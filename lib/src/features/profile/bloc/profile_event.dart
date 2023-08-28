part of 'profile_bloc.dart';

class ProfileEvent extends BaseEquatable {}

class ProfileInitialEvent extends ProfileEvent {
  ProfileInitialEvent();
}

class ClickNotificationEvent extends ProfileEvent {}

class ClickAuthorizationLetterEvent extends ProfileEvent {}

class ClickIDCardEvent extends ProfileEvent {}

class ClickChangePassswordEvent extends ProfileEvent {}

class ClickChangeSecurityPinEvent extends ProfileEvent {}

class ClickMessageEvent extends ProfileEvent {
  ClickMessageEvent({this.fromId, this.toId});

  final String? fromId;
  final String? toId;
}

class ClickMarkAsHomeEvent extends ProfileEvent {}

class ChangeProfileImageEvent extends ProfileEvent {}

class ChangePasswordEvent extends ProfileEvent {}

class LoginEvent extends ProfileEvent {}

class PostProfileImageEvent extends ProfileEvent {
  PostProfileImageEvent({this.postValue});

  final dynamic postValue;
}

class SwitchCardEvent extends ProfileEvent {}

class InitialImageTapEvent extends ProfileEvent {}

class InitialImageEvent extends ProfileEvent {
  final String imageType;

  InitialImageEvent({required this.imageType});
}

class UpdateImagePathEvent extends ProfileEvent {
  final String imagePath;

  UpdateImagePathEvent({required this.imagePath});
}

class InitialClickChangeLanguageEvent extends ProfileEvent {}

class ClickChangeLanguageEvent extends ProfileEvent {}

class InitialCustomerLanguagePreferenceEvent extends ProfileEvent {}

class CustomerLanguagePreferenceEvent extends ProfileEvent {}
