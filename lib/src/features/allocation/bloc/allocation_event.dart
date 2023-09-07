part of 'allocation_bloc.dart';

@immutable
class AllocationEvent extends BaseEquatable {}

class AllocationInitialEvent extends AllocationEvent {}

class AllocationTabChangeEvent extends AllocationEvent {
  int index;

  AllocationTabChangeEvent(this.index);
}

class NavigateSearchPageEvent extends AllocationEvent {}

class SearchReturnDataEvent extends AllocationEvent {
  SearchReturnDataEvent({this.returnValue});

  final dynamic returnValue;
}
