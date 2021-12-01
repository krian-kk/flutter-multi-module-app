part of 'allocation_bloc.dart';

class AllocationState extends BaseEquatable {}

class AllocationInitial extends AllocationState {}

class AllocationLoadingState extends AllocationState {}

class AllocationLoadedState extends AllocationState {
  dynamic? successResponse;
  AllocationLoadedState({this.successResponse});
}

class MapViewState extends AllocationState {}

class MessageState extends AllocationState {}

class NavigateSearchPageState extends AllocationState {}

class NavigateCaseDetailState extends AllocationState {}

class FilterSelectOptionState extends AllocationState {}

class SearchScreenLoadingState extends AllocationState {}

class SearchAllocationScreenLoadedState extends AllocationState {}

class SearchScreenNormalState extends AllocationState {}

class SearchAllocationScreenSuccessState extends AllocationState {
  final SearchModel data;
  SearchAllocationScreenSuccessState(this.data);
}

class SearchAllocationFailedState extends AllocationState {
  final String error;
  SearchAllocationFailedState(this.error);
}

class ClickSearchButtonState extends AllocationState {}
