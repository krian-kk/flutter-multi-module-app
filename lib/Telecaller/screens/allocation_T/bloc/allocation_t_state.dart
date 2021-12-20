part of 'allocation_t_bloc.dart';

@immutable
class AllocationTState extends BaseEquatable {}

class AllocationTInitial extends AllocationTState {}

class AllocationTLoadingState extends AllocationTState {}

class AllocationTLoadedState extends AllocationTState {
  final dynamic successResponse;
  AllocationTLoadedState({this.successResponse});
}

class NavigateSearchPageTState extends AllocationTState {}

class ClickCaseDetailsState extends AllocationTState {
  final dynamic paramValue;
  ClickCaseDetailsState(this.paramValue);
}

class ClickPhoneTelecallerState extends AllocationTState {}

class NavigateCaseDetailTState extends AllocationTState {
  final dynamic paramValue;
  NavigateCaseDetailTState(this.paramValue);
}

class NoInternetConnectionState extends AllocationTState {}

class TapPriorityTState extends AllocationTState {
  final dynamic successResponse;
  TapPriorityTState({this.successResponse});
}

class CaseListViewLoadingState extends AllocationTState {}

class PriorityLoadMoreTState extends AllocationTState {
  final dynamic successResponse;
  PriorityLoadMoreTState({this.successResponse});
}
