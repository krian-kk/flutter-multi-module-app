part of 'profile_bloc.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoadedState extends ProfileState {}

class ProfileLoadingState extends ProfileState {}

class ClickNotificationState extends ProfileState {}

class ClickChangeLaunguageState extends ProfileState {}

class ClickChangePasswordState extends ProfileState {}

class ClickMessageState extends ProfileState {}

class ChangeProfileImageState extends ProfileState {}
