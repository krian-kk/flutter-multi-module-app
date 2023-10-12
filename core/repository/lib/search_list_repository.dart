import 'package:domain_models/common/searching_data_model.dart';
import 'package:domain_models/response_models/search/search_list_model.dart';
import 'package:network_helper/api_services/search_list_api_service.dart';
import 'package:preference_helper/preference_constants.dart';
import 'package:preference_helper/preference_helper.dart';
import 'package:network_helper/network_base_models/api_result.dart';

abstract class SearchListRepository {
  Future<ApiResult<List<SearchListResponse>>> getSearchResultData(
      SearchingDataModel searchData);
}

class SearchListRepositoryImpl extends SearchListRepository {
  SearchListApiProvider apiProvider = SearchListApiProvider();
  late String urlParams;

  @override
  Future<ApiResult<List<SearchListResponse>>> getSearchResultData(
      SearchingDataModel searchData) async {
    String? accessToken = await getAccessToken();
    if (searchData.isStarCases! && searchData.isMyRecentActivity!) {
      urlParams = 'starredOnly=${searchData.isStarCases}&recentActivity=${searchData.isMyRecentActivity}&accNo=${searchData.accountNumber}&cust=${searchData.customerName}&bankName=${searchData.bankName}&dpdStr=${searchData.dpdBucket}&customerId=${searchData.customerID}&pincode=${searchData.pincode}&collSubStatus=${searchData.status}';
    } else if (searchData.isStarCases!) {
      urlParams = 'starredOnly=${searchData.isStarCases}&accNo=${searchData.accountNumber}&cust=${searchData.customerName}&bankName=${searchData.bankName}&dpdStr=${searchData.dpdBucket}&customerId=${searchData.customerID}&pincode=${searchData.pincode}&collSubStatus=${searchData.status}';
    } else if (searchData.isMyRecentActivity!) {
      urlParams = 'recentActivity=${searchData.isMyRecentActivity}&accNo=${searchData.accountNumber}&cust=${searchData.customerName}&bankName=${searchData.bankName}&dpdStr=${searchData.dpdBucket}&customerId=${searchData.customerID}&pincode=${searchData.pincode}&collSubStatus=${searchData.status}';
    } else {
      urlParams = 'accNo=${searchData.accountNumber}&cust=${searchData.customerName}&bankName=${searchData.bankName}&dpdStr=${searchData.dpdBucket}&customerId=${searchData.customerID}&pincode=${searchData.pincode}&collSubStatus=${searchData.status}';
    }

    final ApiResult<List<SearchListResponse>> response =
        await apiProvider.getSearchCaseListData(accessToken, urlParams);
    return response;
  }

  //Helper methods
  Future<String> getAccessToken() async {
    return await PreferenceHelper.getString(
            keyPair: PreferenceConstants.accessToken) ??
        '';
  }
}
