part of 'priority_bloc.dart';

@immutable
abstract class PriorityEvent {}

/// Loads all the cases for the both type of agents i.e. FOS or Telecaller
/// 1. Fetches all the contract information.
/// 2. App Config like google maps api key, build route & autocalling depends on
/// contract information
/// 3. Load the cases depending on the agent type.
class InitialPriorityEvent extends PriorityEvent {}

class LoadPriorityEvent extends PriorityEvent {}

class LoadMorePriorityEvent extends PriorityEvent {}

class FinishedPriorityEvent extends PriorityEvent {}
