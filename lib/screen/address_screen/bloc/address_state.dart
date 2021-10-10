part of 'address_bloc.dart';

@immutable
abstract class AddressState {}

class AddressInitial extends AddressState {}

class AddressLoadingState extends AddressState {}

class AddressLoadedState extends AddressState {}

class AddressNavigatePtpState extends AddressState {}
