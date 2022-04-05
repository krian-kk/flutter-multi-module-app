part of 'search_bloc.dart';

@immutable
class SearchScreenEvent extends BaseEquatable {}

class SearchScreenInitialEvent extends SearchScreenEvent {
  SearchScreenInitialEvent({this.context});
  final BuildContext? context;
}

class NavigatePopEvent extends SearchScreenEvent {}
