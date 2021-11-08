part of 'myvisits_bloc.dart';

@immutable
abstract class MyvisitsState extends BaseEquatable {}

class MyvisitsInitial extends MyvisitsState {}

class MyvisitsLoadingState extends MyvisitsState {}

class MyvisitsLoadedState extends MyvisitsState {}