part of 'allocation_bloc.dart';

@immutable
class AllocationState extends BaseEquatable {}

class AllocationInitial extends AllocationState {}

class AllocationLoadingState extends AllocationState {}

class AllocationLoadedState extends AllocationState {}

class NavigateSearchPageState extends AllocationState {}
