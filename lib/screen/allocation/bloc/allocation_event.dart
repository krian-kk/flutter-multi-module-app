part of 'allocation_bloc.dart';

class AllocationEvent extends BaseEquatable {}

class AllocationInitialEvent extends AllocationEvent {}

class MapViewEvent extends AllocationEvent {}

class MessageEvent extends AllocationEvent {}

class NavigateSearchPageEvent extends AllocationEvent {}

class NavigateCaseDetailEvent extends AllocationEvent {}

class FilterSelectOptionEvent extends AllocationEvent {}

class ClickSearchButtonEvent extends AllocationEvent {
  final bool isStaredOnly;
  final String searchField;
  ClickSearchButtonEvent(this.isStaredOnly, this.searchField);
}
