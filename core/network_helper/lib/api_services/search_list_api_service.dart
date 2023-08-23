import 'package:domain_models/response_models/search/search_list_model.dart';
import 'package:network_helper/dio/dio_client.dart';
import 'package:network_helper/errors/network_exception.dart';
import 'package:network_helper/network_base_models/api_result.dart';
import 'package:network_helper/network_base_models/base_response.dart';

class SearchListApiProvider {
  static const String searchBaseUrl = '${mobileBackendUrl}case-details/search?';

  Future<ApiResult<SearchListResponse>> getSearchCaseListData(
      String accessToken, String urlParams) async {
    dynamic response;

    try {
      final String searchUrl = searchBaseUrl + urlParams;
      print(searchUrl);
      response = await DioClient(baseUrl, accessToken: accessToken)
          .get(searchUrl, decryptResponse: true);
      final mappedResponse =
          ListResponse.fromJson(response, SearchListResponse.fromJson);

      //fix this
      return ApiResult.success(data: mappedResponse.result?[0]);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }
}
