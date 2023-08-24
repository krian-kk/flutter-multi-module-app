part of 'priority_bloc.dart';

@immutable
abstract class PriorityState {}

class PriorityInitial extends PriorityState {}

class PriorityLoadingState extends PriorityState {}

class PriorityCompletedState extends PriorityState {}
