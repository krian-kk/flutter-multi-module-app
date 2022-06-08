part of 'profile_bloc.dart';

class ProfileEvent extends BaseEquatable {}

class ProfileInitialEvent extends ProfileEvent {
  ProfileInitialEvent(this.context);
  final BuildContext context;
}

class ClickNotificationEvent extends ProfileEvent {}

class ClickChangeLaunguageEvent extends ProfileEvent {}

class ClickAuthorizationLetterEvent extends ProfileEvent {}

class ClickIDCardEvent extends ProfileEvent {}

class CustomerLaunguagePrefrerenceEvent extends ProfileEvent {
  CustomerLaunguagePrefrerenceEvent(this.context);
  final BuildContext context;
}

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
