part of 'search_bloc.dart';

@immutable
class SearchScreenEvent extends BaseEquatable {}

class SearchScreenInitialEvent extends SearchScreenEvent {
  final BuildContext? context;
  SearchScreenInitialEvent({this.context});
}

class NavigatePopEvent extends SearchScreenEvent {}
