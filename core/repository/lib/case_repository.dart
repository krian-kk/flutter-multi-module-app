import 'dart:async';

import 'package:domain_models/response_models/case/priority_case_response.dart';
import 'package:network_helper/api_services/cases_api_services.dart';
import 'package:network_helper/errors/network_exception.dart';
import 'package:network_helper/network_base_models/api_result.dart';
import 'package:repository/repo_utils.dart';

abstract class CaseRepository {
  Future<dynamic> getCaseLists(int limit, int pageNo, bool isOffline);
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

  Future<ApiResult<List<PriorityCaseListModel>>> getCasesFromServer(
      int limit, int pageNo) async {
    String? accessToken = await getAccessToken();
    ApiResult<List<PriorityCaseListModel>> response =
        await collectApiProvider.getCases(accessToken, limit, pageNo);
    return response;
  }
}
