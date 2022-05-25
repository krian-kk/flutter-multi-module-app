part of 'allocation_bloc.dart';

class AllocationState extends BaseEquatable {}

class AllocationInitial extends AllocationState {}

class AllocationLoadingState extends AllocationState {}

class LoadingState extends AllocationState {}

class AllocationLoadedState extends AllocationState {
  AllocationLoadedState({this.successResponse});
  final dynamic successResponse;
}

class AllocationOfflineState extends AllocationState {
  AllocationOfflineState({this.successResponse});
  final dynamic successResponse;
}

class MapViewState extends AllocationState {}

class MessageState extends AllocationState {}

class NavigateSearchPageState extends AllocationState {}

class NavigateCaseDetailState extends AllocationState {
  NavigateCaseDetailState({this.paramValues});
  final dynamic paramValues;
}

class FilterSelectOptionState extends AllocationState {}

class TapAreYouAtOfficeOptionsState extends AllocationState {}

class UpdateNewValueState extends AllocationState {
  UpdateNewValueState(
      {this.selectedEventValue,
      this.updateFollowUpdate,
      this.value,
      this.paramValue});
  final String? selectedEventValue;
  final String? updateFollowUpdate;
  final dynamic paramValue;
  final dynamic value;
}

class AutoCallingLoadingState extends AllocationState {}

class AutoCallingLoadedState extends AllocationState {}

class TapPriorityState extends AllocationState {
  TapPriorityState({this.successResponse});
  final dynamic successResponse;
}

class PriorityLoadMoreState extends AllocationState {
  PriorityLoadMoreState({this.successResponse});
  final dynamic successResponse;
}

class TapBuildRouteState extends AllocationState {
  TapBuildRouteState({this.successResponse});
  final dynamic successResponse;
}

class BuildRouteLoadMoreState extends AllocationState {
  BuildRouteLoadMoreState({this.successResponse});
  final dynamic successResponse;
}

class CaseListViewLoadingState extends AllocationState {}

class NoInternetConnectionState extends AllocationState {}

class SearchReturnDataState extends AllocationState {}

class UpdateStaredCaseState extends AllocationState {
  UpdateStaredCaseState(
      {required this.caseId,
      required this.isStared,
      required this.selectedIndex});
  final String caseId;
  final bool isStared;
  final int selectedIndex;
}

class StartCallingState extends AllocationState {
  StartCallingState({this.customerIndex, this.phoneIndex});
  final int? customerIndex;
  final int? phoneIndex;
}

class AutoCallContactHealthUpdateState extends AllocationState {
  AutoCallContactHealthUpdateState({this.contactIndex, this.caseIndex});
  final int? contactIndex;
  final int? caseIndex;
}

class MapInitiateState extends AllocationState {}

class AutoCallingContactSortState extends AllocationState {}
