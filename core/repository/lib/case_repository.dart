import 'dart:async';

import 'package:domain_models/response_models/case/case_detail_models/case_details_response.dart';
import 'package:domain_models/response_models/case/priority_case_response.dart';
import 'package:domain_models/response_models/contractor/contractor_information_model.dart';
import 'package:domain_models/response_models/events/event_details/event_details_response.dart';
import 'package:network_helper/api_services/cases_api_services.dart';
import 'package:network_helper/errors/network_exception.dart';
import 'package:domain_models/common/buildroute_data.dart';
import 'package:network_helper/network_base_models/api_result.dart';
import 'package:network_helper/network_base_models/base_response.dart';
import 'package:repository/repo_utils.dart';

abstract class CaseRepository {
  Future<dynamic> getCaseLists(int limit, int pageNo, bool isOffline);

  Future<ApiResult<CaseDetailsResultModel>> getCasesDetailsFromServer(
      String caseId);

  Future<ApiResult<ContractorResult>> getContractorDetails();

  Future<ApiResult<List<EventDetailsResultsModel>>> getEventDetailsFromServer(
      String caseId);

  Future<ApiResult<List<PriorityCaseListModel>>> getCasesFromServer(
      int limit, int pageNo);

  Future<ApiResult<MappedPaginatedListResponse>>
      getCasesFromServerWithTotalCases(int limit, int pageNo);

  Future<ApiResult<List<PriorityCaseListModel>>> getBuildRouteCases(
      int limit, int pageNo, BuildRouteDataModel paramValues);

  Future<ApiResult<List<PriorityCaseListModel>>> getAutoCallingListData();
}

class CaseRepositoryImpl implements CaseRepository {
  CasesApiService collectApiProvider = CasesApiService();

  @override
  Future<ApiResult<List<PriorityCaseListModel>>> getCaseLists(
      int limit, int pageNo, bool isOffline) async {
    if (isOffline) {}
    return getCasesFromServer(limit, pageNo);
  }

  void getCasesFromOfflineDb(int limit, int pageLimit) {
    //todo
  }

  @override
  Future<ApiResult<List<PriorityCaseListModel>>> getCasesFromServer(
      int limit, int pageNo) async {
    if (pageNo % 10 == 0) {
      pageNo = (pageNo % 10) + 1;
    } else {
      pageNo = pageNo % 10;
    }
    String? accessToken = await getAccessToken();
    ApiResult<List<PriorityCaseListModel>> response =
        await collectApiProvider.getCases(accessToken, limit, pageNo);
    return response;
  }

  @override
  Future<ApiResult<MappedPaginatedListResponse>>
      getCasesFromServerWithTotalCases(int limit, int pageNo) async {
    if (pageNo % 10 == 0) {
      pageNo = (pageNo % 10) + 1;
    } else {
      pageNo = pageNo % 10;
    }
    String? accessToken = await getAccessToken();
    ApiResult<MappedPaginatedListResponse> response = await collectApiProvider
        .getCasesWithTotalNoOfCases(accessToken, limit, pageNo);
    return response;
  }

  @override
  Future<ApiResult<List<PriorityCaseListModel>>>
      getAutoCallingListData() async {
    String? accessToken = await getAccessToken();
    ApiResult<List<PriorityCaseListModel>> response =
        await collectApiProvider.getAutoCallingListDataFromApi(accessToken);
    return response;
  }

  @override
  Future<ApiResult<CaseDetailsResultModel>> getCasesDetailsFromServer(
      String caseId) async {
    String? accessToken = await getAccessToken();
    ApiResult<CaseDetailsResultModel> response = await collectApiProvider
        .getCaseDetails(accessToken, {'caseId': caseId});
    return response;
  }

  @override
  Future<ApiResult<ContractorResult>> getContractorDetails() async {
    String? accessToken = await getAccessToken();
    ApiResult<ContractorResult> response =
        await collectApiProvider.getContractorDetails(accessToken);
    return response;
  }

  @override
  Future<ApiResult<List<EventDetailsResultsModel>>> getEventDetailsFromServer(
      String caseId) async {
    String? accessToken = await getAccessToken();
    ApiResult<List<EventDetailsResultsModel>> response =
        await collectApiProvider.getEventList(accessToken, caseId);
    return response;
  }

  Future<ApiResult<BaseResponse>> postCaseEvent(
      dynamic requestBodyData, String eventName) async {
    //todo move request body here
    String? userType = await getUserType();
    String? accessToken = await getAccessToken();
    ApiResult<BaseResponse> response =
        await collectApiProvider.postCaseEventToServer(
            accessToken, requestBodyData, eventName, userType);
    return response;
  }

  Future<ApiResult<BaseResponse>> postEventWithFile(
      dynamic requestBodyData, String eventName) async {
    //todo move request body here
    String? userType = await getUserType();
    String? accessToken = await getAccessToken();
    ApiResult<BaseResponse> response = await collectApiProvider.postFileEvent(
        accessToken, requestBodyData, eventName, userType);
    return response;
  }

  Future<ApiResult<BaseResponse>> postOts(dynamic requestBodyData) async {
    //todo move request body here
    String? userType = await getUserType();
    String? accessToken = await getAccessToken();
    ApiResult<BaseResponse> response = await collectApiProvider.postOtsEvent(
        accessToken, requestBodyData, userType);
    return response;
  }

  Future<ApiResult<BaseResponse>> postImageCaptureEvent(
      dynamic formData) async {
    //todo move request body here
    String? userType = await getUserType();
    String? accessToken = await getAccessToken();
    ApiResult<BaseResponse> response =
        await collectApiProvider.postImageCaptureEvent(
            accessToken, formData, 'imageCaptured', userType);
    return response;
  }

  @override
  Future<ApiResult<List<PriorityCaseListModel>>> getBuildRouteCases(
      int limit, int pageNo, BuildRouteDataModel paramValues) async {
    String? accessToken = await getAccessToken();
    ApiResult<List<PriorityCaseListModel>> response = await collectApiProvider
        .getBuildCases(accessToken, limit, pageNo, paramValues);
    return response;
  }
}
