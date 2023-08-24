import 'package:domain_models/response_models/case/priority_case_response.dart';
import 'package:network_helper/dio/dio_client.dart';
import 'package:network_helper/errors/network_exception.dart';
import 'package:network_helper/network_base_models/api_result.dart';
import 'package:network_helper/network_base_models/base_response.dart';

class CasesApiService {
  static String priorityCasesV1 =
      "${getMobileBackendUrl(apiVersion: 'v1/')}case-details/priority?";
  static String priorityCasesV2 =
      "${getMobileBackendUrl(apiVersion: 'v2/')}case-details/priority?";

  Future<ApiResult<List<PriorityCaseListModel>>> getCases(
      String accessToken, int limit, int pageNo) async {
    dynamic response;
    try {
      String url = priorityCasesV1;
      url = "${url}pageNo=$pageNo&limit=$limit";
      response = await DioClient(baseUrl, accessToken: accessToken)
          .post(url, decryptResponse: true);
      final mappedResponse =
          ListResponse.fromJson(response, PriorityCaseListModel.fromJson);
      return ApiResult.success(
          data: mappedResponse.result as List<PriorityCaseListModel>);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }
}
