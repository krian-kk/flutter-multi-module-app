import 'package:domain_models/response_models/case/case_detail_models/case_details_response.dart';
import 'package:domain_models/response_models/case/priority_case_response.dart';
import 'package:domain_models/response_models/contractor/contractor_information_model.dart';
import 'package:domain_models/response_models/events/event_details/event_details_response.dart';
import 'package:network_helper/dio/dio_client.dart';
import 'package:network_helper/errors/network_exception.dart';
import 'package:network_helper/network_base_models/api_result.dart';
import 'package:network_helper/network_base_models/base_response.dart';
import 'package:domain_models/common/buildroute_data.dart';

class CasesApiService {
  static String priorityCasesV1 =
      "${getMobileBackendUrl(apiVersion: 'v1/')}case-details/priority?";
  static String priorityCasesV2 =
      "${getMobileBackendUrl(apiVersion: 'v2/')}case-details/priority?";
  static String caseDetailsUrl =
      "${getMobileBackendUrl()}case-details/caseDetails";
  static String contractorDetails =
      "${getMobileBackendUrl()}case-details-events/contractorDetails";
  static String eventsUrl =
      "${getMobileBackendUrl()}case-details-events/eventDetails?caseId=";

  static String eventsPostUrl(String selectValue, String userTypeValue) =>
      '${getMobileBackendUrl()}case-details-events/$selectValue?userType=$userTypeValue';

  static final String otsPostUrl =
      '${getMobileBackendUrl()}case-details-events/ots';

  static String reminderPostUrl(String selectValue, String userTypeValue) =>
      '${getMobileBackendUrl()}case-details-events/$selectValue?userType=$userTypeValue';

  static String unreachableUrl(String selectValue, String userTypeValue) =>
      '${getMobileBackendUrl()}case-details-events/$selectValue?userType=$userTypeValue';

  static String leftMessageUrl(String selectValue, String userTypeValue) =>
      '${getMobileBackendUrl()}case-details-events/$selectValue?userType=$userTypeValue';

  static String doorLockedUrl(String selectValue, String userTypeValue) =>
      '${getMobileBackendUrl()}case-details-events/$selectValue?userType=$userTypeValue';

  static String entryRestrictedUrl(String selectValue, String userTypeValue) =>
      '${getMobileBackendUrl()}case-details-events/$selectValue?userType=$userTypeValue';

  static String wrongAddressUrl(String selectValue, String userTypeValue) =>
      '${getMobileBackendUrl()}case-details-events/$selectValue?userType=$userTypeValue';

  static String shiftedUrl(String selectValue, String userTypeValue) =>
      '${getMobileBackendUrl()}case-details-events/$selectValue?userType=$userTypeValue';

  static String addressNotFoundUrl(String selectValue, String userTypeValue) =>
      '${getMobileBackendUrl()}case-details-events/$selectValue?userType=$userTypeValue';

  static String doesNotExistUrl(String selectValue, String userTypeValue) =>
      '${getMobileBackendUrl()}case-details-events/$selectValue?userType=$userTypeValue';

  static String incorrectNumberUrl(String selectValue, String userTypeValue) =>
      '${getMobileBackendUrl()}case-details-events/$selectValue?userType=$userTypeValue';

  static String numberNotWorkingUrl(String selectValue, String userTypeValue) =>
      '${getMobileBackendUrl()}case-details-events/$selectValue?userType=$userTypeValue';

  static String notOperationalUrl(String selectValue, String userTypeValue) =>
      '${getMobileBackendUrl()}case-details-events/$selectValue?userType=$userTypeValue';

  static String buildRouteCaseList =
      "${getMobileBackendUrl(apiVersion: 'v1/')}case-details/buildRoute?";

  Future<ApiResult<List<PriorityCaseListModel>>> getCases(
      String accessToken, int limit, int pageNo) async {
    dynamic response;
    try {
      String url = priorityCasesV1;
      url = "${url}pageNo=${pageNo}&limit=$limit";

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
      String accessToken,
      int limit,
      int pageNo,
      BuildRouteDataModel paramValues) async {
    dynamic response;
    try {
      String url = buildRouteCaseList;
      url =
          "${url}lat=${paramValues.lat}&lng=${paramValues.long}&maxDistMeters=${paramValues.maxDistMeters}&page=${pageNo}&limit=$limit";
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

  Future<ApiResult<List<EventDetailsResultsModel>>> getEventList(
      String accessToken, String caseId) async {
    dynamic response;
    try {
      response = await DioClient(baseUrl, accessToken: accessToken)
          .get(eventsUrl + caseId, decryptResponse: false);
      final mappedResponse =
          ListResponse.fromJson(response, EventDetailsResultsModel.fromJson);
      List<EventDetailsResultsModel>? list =
          mappedResponse.result?.cast<EventDetailsResultsModel>();
      return ApiResult.success(data: list);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<ApiResult<CaseDetailsResultModel>> getCaseDetails(
      String accessToken, dynamic requestBody) async {
    dynamic response;
    try {
      response = await DioClient(baseUrl, accessToken: accessToken).post(
          caseDetailsUrl,
          data: requestBody,
          decryptResponse: true,
          encryptRequestBody: true);
      final mappedResponse =
          SingleResponse.fromJson(response, CaseDetailsResultModel.fromJson);
      return ApiResult.success(data: mappedResponse.result);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<ApiResult<ContractorResult>> getContractorDetails(
      String accessToken) async {
    dynamic response;
    try {
      response = await DioClient(baseUrl, accessToken: accessToken)
          .get(contractorDetails, decryptResponse: true);
      final mappedResponse =
          SingleResponse.fromJson(response, ContractorResult.fromJson);
      return ApiResult.success(data: mappedResponse.result);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<ApiResult<BaseResponse>> postCaseEventToServer(String accessToken,
      dynamic requestBodyData, String eventType, String userType) async {
    dynamic response;
    try {
      response = await DioClient(baseUrl, accessToken: accessToken)
          .post(eventsPostUrl(eventType, userType), data: requestBodyData);
      final mappedResponse =
          SingleResponse.fromJson(response, BaseResponse.fromJson);
      return ApiResult.success(data: mappedResponse.result);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<ApiResult<BaseResponse>> postFileEvent(String accessToken,
      dynamic requestBodyData, String eventType, String userType) async {
    dynamic response;
    try {
      response = await DioClient(baseUrl,
              accessToken: accessToken, isMultiFormRequest: true)
          .post(eventsPostUrl(eventType, userType), data: requestBodyData);
      final mappedResponse =
          SingleResponse.fromJson(response, BaseResponse.fromJson);
      return ApiResult.success(data: mappedResponse.result);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<ApiResult<BaseResponse>> postOtsEvent(
      String accessToken, dynamic requestBodyData, String userType) async {
    dynamic response;
    try {
      response = await DioClient(baseUrl,
              accessToken: accessToken, isMultiFormRequest: true)
          .post(otsPostUrl, data: requestBodyData);
      final mappedResponse =
          SingleResponse.fromJson(response, BaseResponse.fromJson);
      return ApiResult.success(data: mappedResponse.result);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<ApiResult<BaseResponse>> postImageCaptureEvent(String accessToken,
      dynamic requestBodyData, String eventType, String userType) async {
    dynamic response;
    try {
      response = await DioClient(baseUrl,
              accessToken: accessToken, isMultiFormRequest: true)
          .post(eventsPostUrl(eventType, userType), data: requestBodyData);
      final mappedResponse =
          SingleResponse.fromJson(response, BaseResponse.fromJson);
      return ApiResult.success(data: mappedResponse.result);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }
}
