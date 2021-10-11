part of 'phone_bloc.dart';

@immutable
abstract class PhoneEvent {}

class PhoneInitialEvent extends PhoneEvent {}

class PhoneNavigatePtpEvent extends PhoneEvent {}

class PhoneNavigateRtpEvent extends PhoneEvent {}

class PhoneNavigateDisputeEvent extends PhoneEvent {}

class PhoneNavigateReminderEvent extends PhoneEvent {}

class PhoneNavigatecollectionsEvent extends PhoneEvent {}

class PhoneNavigateOtsEvent extends PhoneEvent {}
