import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:domain_models/response_models/dashboard/dashboard_data.dart';
import 'package:domain_models/response_models/dashboard/dashboard_mydeposists_model/dashboard_mydeposists_model.dart';
import 'package:domain_models/response_models/dashboard/dashboard_myvisit_model.dart';
import 'package:domain_models/response_models/dashboard/dashboard_yardingandSelfRelease_model/dashboard_yardingand_self_release_model.dart';
import 'package:domain_models/response_models/dashboard/my_receipts_model.dart';
import 'package:domain_models/response_models/dashboard/response_priority_follow_up_model.dart';
import 'package:network_helper/dio/dio_client.dart';
import 'package:network_helper/network_base_models/base_response.dart';
import 'package:network_helper/errors/network_exception.dart';
import 'package:network_helper/network_base_models/api_result.dart';

class DashboardApiProvider {
  static const String dashboardUrl = '${mobileBackendUrl}profile/dashboard?';
  static const String telDashboardUrl =
      '${mobileBackendUrl}profile/telDashboard?';
  static const String priorityFollowUpUrl =
      '${mobileBackendUrl}case-details/priorityFollowUp';
  static const String dashboardBrokenPTPUrl =
      '${mobileBackendUrl}case-details/brokenPtp';
  static const String dashboardUntouchedCasesUrl =
      '${mobileBackendUrl}case-details/untouchedCases';
  static const String dashboardMyVisitsUrl =
      '${mobileBackendUrl}case-details/visits?';
  static const String dashboardMyCallsUrl =
      '${mobileBackendUrl}case-details/myCalls?';
  static const String dashboardMyReceiptsUrl =
      '${mobileBackendUrl}case-details/receipts?';
  static const String dashboardMyDepositsUrl =
      '${mobileBackendUrl}case-details/deposits?';
  static const String dashboardYardingAndSelfReleaseUrl =
      '${mobileBackendUrl}case-details/yardingData';
  static const String bankDeposit =
      '${mobileBackendUrl}case-details-events/bankDeposition?';
  static const String companyBranchDeposit =
      '${mobileBackendUrl}case-details-events/companyDeposition?';
  static const String yarding =
      '${mobileBackendUrl}case-details-events/yarding?';
  static const String selfRelease =
      '${mobileBackendUrl}case-details-events/selfRelease?';

  Future<ApiResult<DashCountResult>> getDashboardData(
      String agentType, String accessToken) async {
    dynamic response;
    try {
      response = await DioClient(baseUrl, accessToken: accessToken)
          .get('${dashboardUrl}userType=$agentType', decryptResponse: false);
      final mappedResponse =
          SingleResponse.fromJson(response, DashCountResult.fromJson);
      return ApiResult.success(data: mappedResponse.result);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<ApiResult<DashboardEventsCaseResults>> getDashboardEventData(
      String accessToken, String event) async {
    dynamic response;
    try {
      String url = '';
      if (event == "priority") {
        url = priorityFollowUpUrl;
      } else if (event == "broken") {
        url = dashboardBrokenPTPUrl;
      } else if (event == "untouched") {
        url = dashboardUntouchedCasesUrl;
      }
      response = await DioClient(baseUrl, accessToken: accessToken)
          .get(url, decryptResponse: true);
      final mappedResponse = SingleResponse.fromJson(
          response, DashboardEventsCaseResults.fromJson);
      return ApiResult.success(data: mappedResponse.result);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<ApiResult<MyReceiptResult>> getMyReceiptDataFromApi(
      String accessToken, String selectedFilter) async {
    dynamic response;
    try {
      response = await DioClient(baseUrl, accessToken: accessToken).get(
          '${dashboardMyReceiptsUrl}timePeriod=$selectedFilter',
          decryptResponse: true);
      final mappedResponse =
          SingleResponse.fromJson(response, MyReceiptResult.fromJson);
      return ApiResult.success(data: mappedResponse.result);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<ApiResult<MyVisitResult>> getVisitsOrCallDataFromApi(
      String accessToken, String selectedFilter, String agentType) async {
    dynamic response;
    try {
      String url = '';
      if (agentType == "FIELDAGENT") {
        url = dashboardMyVisitsUrl;
      } else {
        url = dashboardMyCallsUrl;
      }
      response = await DioClient(baseUrl, accessToken: accessToken)
          .get('${url}timePeriod=$selectedFilter', decryptResponse: true);
      final mappedResponse =
          SingleResponse.fromJson(response, MyVisitResult.fromJson);
      return ApiResult.success(data: mappedResponse.result);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<ApiResult<DepositResult>> getMyDepositsFromApi(
      String accessToken, String selectedFilter, String agentType) async {
    dynamic response;
    try {
      response = await DioClient(baseUrl, accessToken: accessToken)
          .get('${dashboardMyDepositsUrl}timePeriod=$selectedFilter');
      final mappedResponse =
          SingleResponse.fromJson(response, DepositResult.fromJson);
      return ApiResult.success(data: mappedResponse.result);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<ApiResult<List<YardingResult>>> getYardingDataFromApi(
      String accessToken) async {
    dynamic response;
    try {
      response = await DioClient(baseUrl, accessToken: accessToken)
          .get(dashboardYardingAndSelfReleaseUrl);
      ListResponse<List<YardingResult>> mappedResponse =

      ListResponse.fromJson(response, YardingResult.fromJson);
      return ApiResult.success(data: mappedResponse.result as dynamic);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<dynamic> syncPostBankDepositData(String accessToken,
      List<File>? fileData, dynamic postFormData, String agentType) async {
    final Map<String, dynamic> postData =
        jsonDecode(jsonEncode(postFormData.toJson())) as Map<String, dynamic>;
    final List<dynamic> value = [];
    for (var element in fileData!) {
      value.add(await MultipartFile.fromFile(element.path.toString()));
    }
    postData.addAll({
      'files': value,
    });

    dynamic response;
    try {
      response = await DioClient(baseUrl, accessToken: accessToken).post(
          '${bankDeposit}userType=$agentType',
          data: FormData.fromMap(postData));
      final mappedResponse =
          SingleResponse.fromJson(response, BaseResponse.fromJson);
      return ApiResult.success(data: mappedResponse.result);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<dynamic> syncCompanyBranchData(String accessToken,
      List<File>? fileData, dynamic postFormData, String agentType) async {
    final Map<String, dynamic> postData =
        jsonDecode(jsonEncode(postFormData.toJson())) as Map<String, dynamic>;
    final List<dynamic> value = [];
    for (var element in fileData!) {
      value.add(await MultipartFile.fromFile(element.path.toString()));
    }
    postData.addAll({
      'files': value,
    });

    dynamic response;
    try {
      response = await DioClient(baseUrl, accessToken: accessToken).post(
          '${companyBranchDeposit}userType=$agentType',
          data: FormData.fromMap(postData));
      final mappedResponse =
          SingleResponse.fromJson(response, BaseResponse.fromJson);
      return ApiResult.success(data: mappedResponse.result);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<dynamic> syncYardReleaseData(String accessToken, List<File>? fileData,
      dynamic postFormData, String agentType, String event) async {
    final Map<String, dynamic> postData =
        jsonDecode(jsonEncode(postFormData.toJson())) as Map<String, dynamic>;
    final List<dynamic> value = [];
    for (var element in fileData!) {
      value.add(await MultipartFile.fromFile(element.path.toString()));
    }
    postData.addAll({
      'files': value,
    });
    String url;
    if (event == "yarding") {
      url = yarding;
    } else {
      url = selfRelease;
    }
    dynamic response;
    try {
      response = await DioClient(baseUrl, accessToken: accessToken)
          .post('${url}userType=$agentType', data: FormData.fromMap(postData));
      final mappedResponse =
          SingleResponse.fromJson(response, BaseResponse.fromJson);
      return ApiResult.success(data: mappedResponse.result);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }
}
