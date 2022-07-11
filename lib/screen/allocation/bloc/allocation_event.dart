part of 'allocation_bloc.dart';

class AllocationEvent extends BaseEquatable {}

class AllocationInitialEvent extends AllocationEvent {
  AllocationInitialEvent(this.context, {this.myValueSetter});

  final ValueSetter<int>? myValueSetter;
  final BuildContext context;
// final bool isOfflineAPI;
}

class MapViewEvent extends AllocationEvent {
  MapViewEvent({this.paramValues});

  final dynamic paramValues;
}

class MessageEvent extends AllocationEvent {}

class NavigateSearchPageEvent extends AllocationEvent {}

class NavigateCaseDetailEvent extends AllocationEvent {
  NavigateCaseDetailEvent({this.paramValues});

  final dynamic paramValues;
}

class FilterSelectOptionEvent extends AllocationEvent {}

class TapPriorityEvent extends AllocationEvent {}

class TapAreYouAtOfficeOptionsEvent extends AllocationEvent {}

class TapBuildRouteEvent extends AllocationEvent {
  TapBuildRouteEvent({this.paramValues});

  final dynamic paramValues;
}

class SearchReturnDataEvent extends AllocationEvent {
  SearchReturnDataEvent({this.returnValue});

  final dynamic returnValue;
}

class PriorityLoadMoreEvent extends AllocationEvent {}

class BuildRouteLoadMoreEvent extends AllocationEvent {
  BuildRouteLoadMoreEvent({this.paramValues});

  final dynamic paramValues;
}

class ShowAutoCallingEvent extends AllocationEvent {}

class UpdateStaredCaseEvent extends AllocationEvent {
  UpdateStaredCaseEvent(
      {required this.selectedStarIndex,
      required this.caseID,
      required this.context});

  final int selectedStarIndex;
  final String caseID;
  final BuildContext context;
}

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
  final Result? customerList;
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
