part of 'search_list_bloc.dart';

@immutable
class SearchListEvent extends BaseEquatable {}

class SearchListInitialEvent extends SearchListEvent {
  SearchListInitialEvent({required this.searchData});

  final SearchingDataModel searchData;
}
