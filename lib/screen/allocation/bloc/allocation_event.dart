part of 'allocation_bloc.dart';

class AllocationEvent extends BaseEquatable {}

class AllocationInitialEvent extends AllocationEvent {
  final BuildContext context;
  bool isOfflineAPI = false;

  AllocationInitialEvent(this.context, {required this.isOfflineAPI});
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
  final BuildContext context;

  UpdateStaredCaseEvent(
      {required this.selectedStarIndex,
      required this.caseID,
      required this.context});
}

class CallSuccessfullyConnectedEvent extends AllocationEvent {}

class UpdateNewValuesEvent extends AllocationEvent {
  final String paramValue;
  final String selectedClipValue;
  final String? followUpDate;

  UpdateNewValuesEvent(
    this.paramValue,
    this.selectedClipValue,
    this.followUpDate,
  );
}

class CallUnSuccessfullyConnectedEvent extends AllocationEvent {}

class StartCallingEvent extends AllocationEvent {
  final int? customerIndex;
  final int? phoneIndex;
  final Result? customerList;
  final bool isIncreaseCount;

  StartCallingEvent({
    this.customerIndex,
    this.phoneIndex,
    this.customerList,
    this.isIncreaseCount = false,
  });
}

class AutoCallContactHealthUpdateEvent extends AllocationEvent {
  final int? contactIndex;
  final int? caseIndex;

  AutoCallContactHealthUpdateEvent({this.contactIndex, this.caseIndex});
}

class AutoCallingContactSortEvent extends AllocationEvent {}

class ConnectedStopAndSubmitEvent extends AllocationEvent {
  final int customerIndex;

  ConnectedStopAndSubmitEvent({required this.customerIndex});
}
