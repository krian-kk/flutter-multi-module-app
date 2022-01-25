part of 'allocation_bloc.dart';

class AllocationState extends BaseEquatable {}

class AllocationInitial extends AllocationState {}

class AllocationLoadingState extends AllocationState {}

class AllocationLoadedState extends AllocationState {
  final dynamic successResponse;
  AllocationLoadedState({this.successResponse});
}

class MapViewState extends AllocationState {}

class MessageState extends AllocationState {}

class NavigateSearchPageState extends AllocationState {}

class NavigateCaseDetailState extends AllocationState {
  final dynamic paramValues;
  NavigateCaseDetailState({this.paramValues});
}

class FilterSelectOptionState extends AllocationState {}

class SearchScreenLoadingState extends AllocationState {}

class SearchScreenLoadedState extends AllocationState {}

class SearchScreenNormalState extends AllocationState {}

class TapAreYouAtOfficeOptionsState extends AllocationState {}

class TapPriorityState extends AllocationState {
  final dynamic successResponse;
  TapPriorityState({this.successResponse});
}

class PriorityLoadMoreState extends AllocationState {
  final dynamic successResponse;
  PriorityLoadMoreState({this.successResponse});
}

class TapBuildRouteState extends AllocationState {
  final dynamic successResponse;
  TapBuildRouteState({this.successResponse});
}

class BuildRouteLoadMoreState extends AllocationState {
  final dynamic successResponse;
  BuildRouteLoadMoreState({this.successResponse});
}

class SearchScreenSuccessState extends AllocationState {
  final SearchModel data;
  SearchScreenSuccessState(this.data);
}

class SearchFailedState extends AllocationState {
  final String error;
  SearchFailedState(this.error);
}

class CaseListViewLoadingState extends AllocationState {}

class NoInternetConnectionState extends AllocationState {}

class SearchReturnDataState extends AllocationState {}

class StartCallingState extends AllocationState {
  final int? customerIndex;
  final int? phoneIndex;
  // final Result? customerList;
  StartCallingState({this.customerIndex, this.phoneIndex});
}
