part of 'search_bloc.dart';

@immutable
class SearchEvent extends BaseEquatable {}

class SearchInitialEvent extends SearchEvent {}

class NavigatePopEvent extends SearchEvent {}

class SearchReturnDataEvent extends SearchEvent {
  SearchReturnDataEvent({this.returnValue});

  final dynamic returnValue;
}
