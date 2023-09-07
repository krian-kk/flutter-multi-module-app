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

  static String buildRouteCaseList =
      "${getMobileBackendUrl(apiVersion: 'v1/')}case-details/buildRoute?";

  Future<ApiResult<List<PriorityCaseListModel>>> getCases(
      String accessToken, int limit, int pageNo) async {
    dynamic response;
    try {
      String url = priorityCasesV1;
      url = "${url}pageNo=$pageNo&limit=$limit";
      response = await DioClient(baseUrl, accessToken: accessToken)
          .get(url, decryptResponse: true);
      final mappedResponse =
          ListResponse.fromJson(response, PriorityCaseListModel.fromJson);
      List<PriorityCaseListModel>? list =
          mappedResponse.result?.cast<PriorityCaseListModel>();
      return ApiResult.success(data: list);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<ApiResult<List<PriorityCaseListModel>>> getBuildCases(
      String accessToken, int limit, int pageNo) async {
    dynamic response;
    try {
      String url = buildRouteCaseList;
      url =
          "${url}lat=13.0187&lng=77.6427&maxDistMeters=1000000&page=$pageNo&limit=$limit";
      response = await DioClient(baseUrl, accessToken: accessToken)
          .get(url, decryptResponse: true);
      final mappedResponse =
          ListResponse.fromJson(response, PriorityCaseListModel.fromJson);
      List<PriorityCaseListModel>? list =
          mappedResponse.result?.cast<PriorityCaseListModel>();
      return ApiResult.success(data: list);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }
}
