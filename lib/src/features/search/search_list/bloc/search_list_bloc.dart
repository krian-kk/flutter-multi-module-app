import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:domain_models/response_models/search/search_list_model.dart';
import 'package:meta/meta.dart';
import 'package:network_helper/errors/network_exception.dart';
import 'package:network_helper/network_base_models/api_result.dart';
import 'package:origa/models/searching_data_model.dart';
import 'package:origa/utils/base_equatable.dart';
import 'package:repository/search_list_repository.dart';

import '../../../../../models/priority_case_list.dart';

part 'search_list_event.dart';

part 'search_list_state.dart';

class SearchListBloc extends Bloc<SearchListEvent, SearchListState> {
  SearchListBloc({required this.repository}) : super(SearchListInitial()) {
    on<SearchListEvent>(_onEvent);
  }

  late Map<String, dynamic> getSearchResultData;
  late String urlParams;
  SearchListRepository repository;
  List<Result> resultList = <Result>[];
  int starCount = 0;

  Future<void> _onEvent(
      SearchListEvent event, Emitter<SearchListState> emit) async {
    if (event is SearchListInitialEvent) {
      emit(CaseListViewLoadingState());

      final searchData = event.searchData;

      if (searchData.isStarCases! && searchData.isMyRecentActivity!) {
        urlParams = 'starredOnly=${searchData.isStarCases}&' +
            'recentActivity=${searchData.isMyRecentActivity}&' +
            'accNo=${searchData.accountNumber}&' +
            'cust=${searchData.customerName}&' +
            'bankName=${searchData.bankName}&' +
            'dpdStr=${searchData.dpdBucket}&' +
            'customerId=${searchData.customerID}&' +
            'pincode=${searchData.pincode}&' +
            'collSubStatus=${searchData.status}';
      } else if (searchData.isStarCases!) {
        urlParams = 'starredOnly=${searchData.isStarCases}&' +
            'accNo=${searchData.accountNumber}&' +
            'cust=${searchData.customerName}&' +
            'bankName=${searchData.bankName}&' +
            'dpdStr=${searchData.dpdBucket}&' +
            'customerId=${searchData.customerID}&' +
            'pincode=${searchData.pincode}&' +
            'collSubStatus=${searchData.status}';
      } else if (searchData.isMyRecentActivity!) {
        urlParams = 'recentActivity=${searchData.isMyRecentActivity}&' +
            'accNo=${searchData.accountNumber}&' +
            'cust=${searchData.customerName}&' +
            'bankName=${searchData.bankName}&' +
            'dpdStr=${searchData.dpdBucket}&' +
            'customerId=${searchData.customerID}&' +
            'pincode=${searchData.pincode}&' +
            'collSubStatus=${searchData.status}';
      } else {
        urlParams = 'accNo=${searchData.accountNumber}&' +
            'cust=${searchData.customerName}&' +
            'bankName=${searchData.bankName}&' +
            'dpdStr=${searchData.dpdBucket}&' +
            'customerId=${searchData.customerID}&' +
            'pincode=${searchData.pincode}&' +
            'collSubStatus=${searchData.status}';
      }

      final ApiResult<List<SearchListResponse>> data =
          await repository.getSearchResultData(urlParams);

      await data.when(success: (List<SearchListResponse>? data) async {
        print("the data is ${data}");
        resultList.clear();
        starCount = 0;
        for (var element in data!) {
          print(element);
          resultList.add(Result.fromJson(jsonDecode(jsonEncode(element))));
          if (Result.fromJson(jsonDecode(jsonEncode(element))).starredCase ==
              true) {
            starCount++;
          }
        }

        // isShowSearchPincode = true;
        // selectedOption = 3;
        // showFilterDistance = false;
        emit(SearchSuccessReturnDataState());
      }, failure: (NetworkExceptions? error) async {
        emit(SearchFailureReturnDataState());
      });
    }
  }
}
