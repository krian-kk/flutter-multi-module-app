part of 'search_bloc.dart';

@immutable
class SearchState extends BaseEquatable {}

class SearchInitial extends SearchState {}

class SearchLoadingState extends SearchState {}

class SearchLoadedState extends SearchState {}

class NavigatePopState extends SearchState {}
