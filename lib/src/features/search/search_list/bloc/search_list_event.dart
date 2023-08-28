part of 'search_list_bloc.dart';

@immutable
class SearchListEvent extends BaseEquatable {}

class SearchListInitialEvent extends SearchListEvent {
  final SearchingDataModel searchData;

  SearchListInitialEvent({required this.searchData});
}
