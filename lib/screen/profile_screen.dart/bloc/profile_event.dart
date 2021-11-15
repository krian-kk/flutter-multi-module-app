part of 'profile_bloc.dart';

class ProfileEvent extends BaseEquatable {}

class ProfileInitialEvent extends ProfileEvent {
  final BuildContext context;
  ProfileInitialEvent(this.context);
}

class ClickNotificationEvent extends ProfileEvent {}

class ClickChangeLaunguageEvent extends ProfileEvent {}

class ClickChangePassswordEvent extends ProfileEvent {}

class ClickMessageEvent extends ProfileEvent {}

class ChangeProfileImageEvent extends ProfileEvent {}
