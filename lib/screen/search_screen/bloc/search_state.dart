part of 'search_bloc.dart';

@immutable
class SearchScreenState extends BaseEquatable {}

class SearchScreenInitial extends SearchScreenState {}

class SearchScreenLoadingState extends SearchScreenState {}

class SearchScreenLoadedState extends SearchScreenState {}

class NavigatePopState extends SearchScreenState {}
