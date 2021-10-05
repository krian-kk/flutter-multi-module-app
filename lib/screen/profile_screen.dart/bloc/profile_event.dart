part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent {}

class ProfileInitialEvent extends ProfileEvent {}

class ClickNotificationEvent extends ProfileEvent {}

class ClickChangeLaunguageEvent extends ProfileEvent {}

class ClickChangePassswordEvent extends ProfileEvent {}

class ClickMessageEvent extends ProfileEvent {}

class ChangeProfileImageEvent extends ProfileEvent {}
