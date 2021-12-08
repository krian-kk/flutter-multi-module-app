part of 'allocation_t_bloc.dart';

@immutable
class AllocationTState extends BaseEquatable {}

class AllocationTInitial extends AllocationTState {}

class AllocationTLoadingState extends AllocationTState {}

class AllocationTLoadedState extends AllocationTState {}

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
