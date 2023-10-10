part of 'allocation_bloc.dart';

@immutable
class AllocationEvent extends BaseEquatable {}

class AllocationInitialEvent extends AllocationEvent {}

class NavigateSearchPageEvent extends AllocationEvent {}

class SearchReturnDataEvent extends AllocationEvent {
  SearchReturnDataEvent({this.returnValue});

  final dynamic returnValue;
}

class GetCurrentLocationEvent extends AllocationEvent {}

class MapViewEvent extends AllocationEvent {
  final BuildRouteDataModel paramValues;

  MapViewEvent({required this.paramValues});
}

class TapAreYouAtOfficeOptionsEvent extends AllocationEvent {}

class TapPriorityEvent extends AllocationEvent {}

class CaseListViewLoadingState extends AllocationState {}

class BuildRouteLoadMoreEvent extends AllocationEvent {
  BuildRouteLoadMoreEvent({this.paramValues});

  final dynamic paramValues;
}

class TapBuildRouteEvent extends AllocationEvent {
  TapBuildRouteEvent({this.paramValues});

  final dynamic paramValues;
}

class NavigateCaseDetailEvent extends AllocationEvent {
  NavigateCaseDetailEvent({this.paramValues});

  final dynamic paramValues;
}

class UpdateStaredCaseEvent extends AllocationEvent {
  UpdateStaredCaseEvent({
    required this.selectedStarIndex,
    required this.caseID,
    // required this.context
  });

  final int selectedStarIndex;
  final String caseID;
// final BuildContext context;
}

class MessageEvent extends AllocationEvent {}

class FilterSelectOptionEvent extends AllocationEvent {}

class PriorityLoadMoreEvent extends AllocationEvent {}

class ShowAutoCallingEvent extends AllocationEvent {}

class CallSuccessfullyConnectedEvent extends AllocationEvent {}

class UpdateNewValuesEvent extends AllocationEvent {
  UpdateNewValuesEvent(
    this.paramValue,
    this.selectedClipValue,
    this.followUpDate,
  );

  final String paramValue;
  final String selectedClipValue;
  final String? followUpDate;
}

class CallUnSuccessfullyConnectedEvent extends AllocationEvent {}

class StartCallingEvent extends AllocationEvent {
  StartCallingEvent({
    this.customerIndex,
    this.phoneIndex,
    this.customerList,
    this.isIncreaseCount = false,
  });

  final int? customerIndex;
  final int? phoneIndex;
  final dynamic? customerList;
  final bool isIncreaseCount;
}

class AutoCallContactHealthUpdateEvent extends AllocationEvent {
  AutoCallContactHealthUpdateEvent({this.contactIndex, this.caseIndex});

  final int? contactIndex;
  final int? caseIndex;
}

class AutoCallingContactSortEvent extends AllocationEvent {}

class ConnectedStopAndSubmitEvent extends AllocationEvent {
  ConnectedStopAndSubmitEvent({required this.customerIndex});

  final int customerIndex;
}
