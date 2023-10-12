import 'dart:async';

import 'package:domain_models/response_models/case/case_detail_models/case_details_response.dart';
import 'package:domain_models/response_models/case/priority_case_response.dart';
import 'package:domain_models/response_models/contractor/contractor_information_model.dart';
import 'package:domain_models/response_models/events/event_details/event_details_response.dart';
import 'package:network_helper/api_services/cases_api_services.dart';
import 'package:network_helper/network_base_models/api_result.dart';
import 'package:repository/repo_utils.dart';

abstract class EventRepository {
  Future<ApiResult<List<EventDetailsResultsModel>>> getEventDetailsFromServer(
      String caseId);
}

class EventRepositoryImpl implements EventRepository {
  CasesApiService collectApiProvider = CasesApiService();

  @override
  Future<ApiResult<List<EventDetailsResultsModel>>> getEventDetailsFromServer(
      String caseId) async {
    String? accessToken = await getAccessToken();
    ApiResult<List<EventDetailsResultsModel>> response =
        await collectApiProvider.getEventList(accessToken, caseId);
    return response;
  }
}
