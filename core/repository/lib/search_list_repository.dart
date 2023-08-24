import 'package:domain_models/response_models/search/search_list_model.dart';
import 'package:network_helper/api_services/search_list_api_service.dart';
import 'package:preference_helper/preference_constants.dart';
import 'package:preference_helper/preference_helper.dart';
import 'package:network_helper/network_base_models/api_result.dart';

abstract class SearchListRepository {
  Future<ApiResult<List<SearchListResponse>>> getSearchResultData(String urlParams);
}

class SearchListRepositoryImpl extends SearchListRepository {
  SearchListApiProvider apiProvider = SearchListApiProvider();

  @override
  Future<ApiResult<List<SearchListResponse>>> getSearchResultData(String urlParams) async {
    String? accessToken = await getAccessToken();
    final ApiResult<List<SearchListResponse>> response =
        await apiProvider.getSearchCaseListData(accessToken,urlParams);
    return response;
  }

  //Helper methods
  Future<String> getAccessToken() async {
    return await PreferenceHelper.getString(
            keyPair: PreferenceConstants.accessToken) ??
        '';
  }
}
