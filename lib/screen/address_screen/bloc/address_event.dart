part of 'address_bloc.dart';

@immutable
abstract class AddressEvent {}

class AddressInitialEvent extends AddressEvent {}

class AddressNavigatePtpEvent extends AddressEvent {}

class AddressNavigateRtpEvent extends AddressEvent {}

class AddressNavigateDisputeEvent extends AddressEvent {}

class AddressNavigateReminderEvent extends AddressEvent {}

class AddressNavigatecollectionsEvent extends AddressEvent {}

class AddressNavigateOtsEvent extends AddressEvent {}
