part of 'search_bloc.dart';

@immutable
class SearchScreenEvent extends BaseEquatable {}

class SearchScreenInitialEvent extends SearchScreenEvent {}

class NavigatePopEvent extends SearchScreenEvent {}
