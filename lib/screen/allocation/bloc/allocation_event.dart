part of 'allocation_bloc.dart';

class AllocationEvent extends BaseEquatable {}

class AllocationInitialEvent extends AllocationEvent {}

class MapViewEvent extends AllocationEvent {}

class MessageEvent extends AllocationEvent {}

class NavigateSearchPageEvent extends AllocationEvent {}

class NavigateCaseDetailEvent extends AllocationEvent {
  dynamic paramValues;
  NavigateCaseDetailEvent({this.paramValues});
}

class FilterSelectOptionEvent extends AllocationEvent {}

class CaseListViewLoadingEvent extends AllocationEvent {}

class TapPriorityEvent extends AllocationEvent {}

class TapAreYouAtOfficeOptionsEvent extends AllocationEvent {}

class TapBuildRouteEvent extends AllocationEvent {
  dynamic paramValues;
  TapBuildRouteEvent({this.paramValues});
}

class SearchReturnDataEvent extends AllocationEvent {
  dynamic returnValue;
  SearchReturnDataEvent({this.returnValue});
}

class PriorityLoadMoreEvent extends AllocationEvent {}
