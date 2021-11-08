part of 'borkenptp_bloc.dart';

@immutable
abstract class BrokenptpState extends BaseEquatable {}

class BrokenptpInitial extends BrokenptpState {}

class BrokenptpLoadingState extends BrokenptpState {}

class BrokenptpLoadedState extends BrokenptpState {}