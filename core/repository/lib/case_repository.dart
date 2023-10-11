import 'dart:async';

import 'package:domain_models/response_models/case/priority_case_response.dart';
import 'package:network_helper/api_services/cases_api_services.dart';
import 'package:network_helper/errors/network_exception.dart';
import 'package:domain_models/common/buildroute_data.dart';
import 'package:network_helper/network_base_models/api_result.dart';
import 'package:repository/repo_utils.dart';

abstract class CaseRepository {
  Future<dynamic> getCaseLists(int limit, int pageNo, bool isOffline);

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
    if (isOffline) {
      // return getCasesFromOfflineDb(limit, pageNo);
    }
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
  Future<ApiResult<List<PriorityCaseListModel>>> getBuildRouteCases(
      int limit, int pageNo, BuildRouteDataModel paramValues) async {
    String? accessToken = await getAccessToken();
    ApiResult<List<PriorityCaseListModel>> response = await collectApiProvider
        .getBuildCases(accessToken, limit, pageNo, paramValues);
    return response;
  }
}
