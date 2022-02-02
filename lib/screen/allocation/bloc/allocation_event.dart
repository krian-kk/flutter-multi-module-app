part of 'allocation_bloc.dart';

class AllocationEvent extends BaseEquatable {}

class AllocationInitialEvent extends AllocationEvent {
  final BuildContext context;
  AllocationInitialEvent(this.context);
}

class MapViewEvent extends AllocationEvent {
  final dynamic paramValues;
  MapViewEvent({this.paramValues});
}

class MessageEvent extends AllocationEvent {}

class NavigateSearchPageEvent extends AllocationEvent {}

class NavigateCaseDetailEvent extends AllocationEvent {
  final dynamic paramValues;
  NavigateCaseDetailEvent({this.paramValues});
}

class FilterSelectOptionEvent extends AllocationEvent {}

class CaseListViewLoadingEvent extends AllocationEvent {}

class TapPriorityEvent extends AllocationEvent {}

class TapAreYouAtOfficeOptionsEvent extends AllocationEvent {}

class TapBuildRouteEvent extends AllocationEvent {
  final dynamic paramValues;
  TapBuildRouteEvent({this.paramValues});
}

class SearchReturnDataEvent extends AllocationEvent {
  final dynamic returnValue;
  SearchReturnDataEvent({this.returnValue});
}

class PriorityLoadMoreEvent extends AllocationEvent {}

class BuildRouteLoadMoreEvent extends AllocationEvent {
  final dynamic paramValues;
  BuildRouteLoadMoreEvent({this.paramValues});
}

class ShowAutoCallingEvent extends AllocationEvent {}

class UpdateStaredCaseEvent extends AllocationEvent {
  final int selectedStarIndex;
  final String caseID;
  UpdateStaredCaseEvent({required this.selectedStarIndex, required this.caseID});
}
