import 'dart:async';
import 'dart:convert';

import 'package:domain_models/common/searching_data_model.dart';
import 'package:domain_models/response_models/search/search_list_model.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:network_helper/errors/network_exception.dart';
import 'package:network_helper/network_base_models/api_result.dart';
import 'package:origa/models/priority_case_list.dart';
import 'package:origa/utils/base_equatable.dart';
import 'package:repository/search_list_repository.dart';

part 'search_list_event.dart';

part 'search_list_state.dart';

class SearchListBloc extends Bloc<SearchListEvent, SearchListState> {
  SearchListBloc({required this.repository}) : super(SearchListInitial()) {
    on<SearchListEvent>(_onEvent);
  }

  late Map<String, dynamic> getSearchResultData;
  SearchListRepository repository;
  List<Result> resultList = <Result>[];
  int starCount = 0;
  int selectedOption = 0;

  bool showFilterDistance = false;
  bool isShowSearchPincode = false;

  int totalCases = 0;

  Future<void> _onEvent(
      SearchListEvent event, Emitter<SearchListState> emit) async {
    if (event is SearchListInitialEvent) {
      emit(CaseListViewLoadingState());
      final ApiResult<List<SearchListResponse>> data =
          await repository.getSearchResultData(event.searchData);

      await data.when(success: (List<SearchListResponse>? data) async {
        resultList.clear();
        starCount = 0;
        for (var element in data!) {
          resultList.add(Result.fromJson(jsonDecode(jsonEncode(element))));
          if (Result.fromJson(jsonDecode(jsonEncode(element))).starredCase ==
              true) {
            starCount++;
          }
        }
        isShowSearchPincode = true;
        selectedOption = 3;
        showFilterDistance = false;
        emit(SearchSuccessReturnDataState());
      }, failure: (NetworkExceptions? error) async {
        emit(SearchFailureReturnDataState());
      });
    }
  }
}
