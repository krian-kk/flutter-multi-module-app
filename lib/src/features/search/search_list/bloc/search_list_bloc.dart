import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:domain_models/response_models/search/search_list_model.dart';
import 'package:meta/meta.dart';
import 'package:network_helper/network_base_models/api_result.dart';
import 'package:origa/models/searching_data_model.dart';
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

  Future<void> _onEvent(
      SearchListEvent event, Emitter<SearchListState> emit) async {
    if (event is SearchListInitialEvent) {
      emit(CaseListViewLoadingState());

      final searchData = event.searchData;
      final String urlParams = 'starredOnly=${searchData.isStarCases}&' +
          'recentActivity=${searchData.isMyRecentActivity}&' +
          'accNo=${searchData.accountNumber}&' +
          'cust=${searchData.customerName}&' +
          'bankName=${searchData.bankName}&' +
          'dpdStr=${searchData.dpdBucket}&' +
          'customerId=${searchData.customerID}&' +
          'pincode=${searchData.pincode}&' +
          'collSubStatus=${searchData.status}';
      if (searchData.isStarCases! && searchData.isMyRecentActivity!) {
        final ApiResult<SearchListResponse> data =
            await repository.getSearchResultData(urlParams);


        // getSearchResultData = await APIRepository.apiRequest(
        //     APIRequestType.get,
        //     HttpUrl.searchUrl +
        //         'starredOnly=${data.isStarCases}&' +
        //         'recentActivity=${data.isMyRecentActivity}&' +
        //         'accNo=${data.accountNumber}&' +
        //         'cust=${data.customerName}&' +
        //         'bankName=${data.bankName}&' +
        //         'dpdStr=${data.dpdBucket}&' +
        //         'customerId=${data.customerID}&' +
        //         'pincode=${data.pincode}&' +
        //         'collSubStatus=${data.status}',
        //     encrypt: true);
      } else if (searchData.isStarCases!) {
        // getSearchResultData = await APIRepository.apiRequest(
        //     APIRequestType.get,
        //     HttpUrl.searchUrl +
        //         'starredOnly=${data.isStarCases}&' +
        //         'accNo=${data.accountNumber}&' +
        //         'cust=${data.customerName}&' +
        //         'bankName=${data.bankName}&' +
        //         'dpdStr=${data.dpdBucket}&' +
        //         'customerId=${data.customerID}&' +
        //         'pincode=${data.pincode}&' +
        //         'collSubStatus=${data.status}',
        //     encrypt: true);
      } else if (searchData.isMyRecentActivity!) {
        // getSearchResultData = await APIRepository.apiRequest(
        //     APIRequestType.get,
        //     HttpUrl.searchUrl +
        //         'recentActivity=${data.isMyRecentActivity}&' +
        //         'accNo=${data.accountNumber}&' +
        //         'cust=${data.customerName}&' +
        //         'bankName=${data.bankName}&' +
        //         'dpdStr=${data.dpdBucket}&' +
        //         'customerId=${data.customerID}&' +
        //         'pincode=${data.pincode}&' +
        //         'collSubStatus=${data.status}',
        //     encrypt: true);
      } else {
        // getSearchResultData = await APIRepository.apiRequest(
        //     APIRequestType.get,
        //     HttpUrl.searchUrl +
        //         'accNo=${data.accountNumber}&' +
        //         'cust=${data.customerName}&' +
        //         'bankName=${data.bankName}&' +
        //         'dpdStr=${data.dpdBucket}&' +
        //         'customerId=${data.customerID}&' +
        //         'pincode=${data.pincode}&' +
        //         'collSubStatus=${data.status}',
        //     encrypt: true);
      }

      // resultList.clear();
      // starCount = 0;

      // for (var element in getSearchResultData['data']['result']) {
      //   resultList.add(Result.fromJson(jsonDecode(jsonEncode(element))));
      //   if (Result.fromJson(jsonDecode(jsonEncode(element))).starredCase ==
      //       true) {
      //     starCount++;
      //   }
      // }
      //
      // isShowSearchPincode = true;
      // selectedOption = 3;
      // showFilterDistance = false;
      //
      // yield SearchReturnDataState();
    }
  }
}
