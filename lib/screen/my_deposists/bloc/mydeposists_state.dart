part of 'mydeposists_bloc.dart';

@immutable
abstract class MydeposistsState extends BaseEquatable {}

class MydeposistsInitial extends MydeposistsState {}

class MydeposistsLoadingState extends MydeposistsState {}

class MydeposistsLoadedState extends MydeposistsState {}