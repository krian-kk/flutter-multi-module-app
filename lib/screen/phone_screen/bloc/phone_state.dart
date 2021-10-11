part of 'phone_bloc.dart';

@immutable
abstract class PhoneState {}

class PhoneInitial extends PhoneState {}

class PhoneLoadingState extends PhoneState {}

class PhoneLoadedState extends PhoneState {}

class PhoneNavigatePtpState extends PhoneState {}
