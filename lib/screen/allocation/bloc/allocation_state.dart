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

class SearchScreenLoadedState extends AllocationState {}

class SearchScreenNormalState extends AllocationState {}

class SearchScreenSuccessState extends AllocationState {
  final SearchModel data;
  SearchScreenSuccessState(this.data);
}

class SearchFailedState extends AllocationState {
  final String error;
  SearchFailedState(this.error);
}

class ClickSearchButtonState extends AllocationState {}
