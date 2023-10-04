part of 'allocation_bloc.dart';

@immutable
class AllocationState extends BaseEquatable {}

class AllocationInitial extends AllocationState {}

class AllocationLoadingState extends AllocationState {}

class AllocationLoadedState extends AllocationState {}

class NavigateSearchPageState extends AllocationState {}

class MapViewLoadingState extends AllocationState {}

class AllocationTabLoadedState extends AllocationState {
  final String loadedTab;

  AllocationTabLoadedState(this.loadedTab);
}

class MapViewState extends AllocationState {}

class AllocationTabClickedState extends AllocationState {}

class BuildRouteFilterClickedState extends AllocationState {}

class AreYouAtOfficeLoadingState extends AllocationState {}

class TapAreYouAtOfficeOptionsSuccessState extends AllocationState {}

class TapAreYouAtOfficeOptionsFailureState extends AllocationState {}

class UpdatedCurrentLocationState extends AllocationState {}
