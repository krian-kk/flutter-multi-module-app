part of 'allocation_t_bloc.dart';

class AllocationTEvent extends BaseEquatable {}

class AllocationTInitialEvent extends AllocationTEvent {}

class NavigateSearchPageTEvent extends AllocationTEvent {}

class ClickCaseDetailsEvent extends AllocationTEvent {
  final dynamic paramValue;
  ClickCaseDetailsEvent(this.paramValue);
}

class ClickPhoneTelecallerEvent extends AllocationTEvent {}

class NavigateCaseDetailTEvent extends AllocationTEvent {
  final dynamic paramValue;
  NavigateCaseDetailTEvent(this.paramValue);
}
