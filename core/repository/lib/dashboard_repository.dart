import 'dart:io';

import 'package:domain_models/response_models/dashboard/dashboard_data.dart';
import 'package:domain_models/response_models/dashboard/dashboard_mydeposists_model/dashboard_mydeposists_model.dart';
import 'package:domain_models/response_models/dashboard/dashboard_myvisit_model.dart';
import 'package:domain_models/response_models/dashboard/dashboard_yardingandSelfRelease_model/dashboard_yardingand_self_release_model.dart';
import 'package:domain_models/response_models/dashboard/my_receipts_model.dart';
import 'package:domain_models/response_models/dashboard/my_self_release_model.dart';
import 'package:domain_models/response_models/dashboard/response_priority_follow_up_model.dart';
import 'package:network_helper/api_services/dashboard_api_service.dart';
import 'package:network_helper/network_base_models/api_result.dart';
import 'package:preference_helper/preference_constants.dart';
import 'package:preference_helper/preference_helper.dart';
import 'package:repository/repo_utils.dart';

abstract class DashBoardRepository {
  Future<ApiResult<DashCountResult>> getDashboardData(String agentType);

  Future<ApiResult<DashboardEventsCaseResults>> getDashboardEventData(
      String event);

  Future<ApiResult<MyReceiptResult>> getMyReceiptData(String? selectedFilter);

  Future<ApiResult<MySelfReleaseResult>> getMySelfReleaseData(String? selectedFilter);

  Future<ApiResult<MyVisitResult>> getVisitsOrCallData(String? selectedFilter);

  Future<ApiResult<DepositResult>> getMyDeposits(String? selectedFilter);

  Future<ApiResult<List<YardingResult>?>> getYardingData();

  Future<dynamic> postBankDepositData(
      List<File>? fileData, dynamic postFormData);

  Future<dynamic> postCompanyBranchData(
      List<File>? fileData, dynamic postFormData);

  Future<dynamic> yardReleaseData(
      List<File>? fileData, dynamic postFormData, String event);
}

class DashBoardRepositoryImpl extends DashBoardRepository {
  DashboardApiProvider provider = DashboardApiProvider();

  Future<String> getAgentType() async {
    return await PreferenceHelper.getString(
            keyPair: PreferenceConstants.accessToken) ??
        '';
  }

  @override
  Future<ApiResult<DashCountResult>> getDashboardData(String agentType) async {
    String? accessToken = await getAccessToken();
    final ApiResult<DashCountResult> response =
        await provider.getDashboardData(agentType, accessToken);

    return response;
  }

  @override
  Future<ApiResult<DashboardEventsCaseResults>> getDashboardEventData(
      String event) async {
    String? accessToken = await getAccessToken();
    final ApiResult<DashboardEventsCaseResults> response =
        await provider.getDashboardEventData(accessToken, event);
    return response;
  }

  @override
  Future<ApiResult<MyReceiptResult>> getMyReceiptData(
      String? selectedFilter) async {
    String? accessToken = await getAccessToken();
    final ApiResult<MyReceiptResult> response =
        await provider.getMyReceiptDataFromApi(accessToken, selectedFilter!);
    return response;
  }

@override
Future<ApiResult<MySelfReleaseResult>> getMySelfReleaseData(String? selectedFilter) async {
    String? accessToken = await getAccessToken();
    final ApiResult<MySelfReleaseResult> response =
        await provider.getMySelfReleaseDataFromApi(accessToken, selectedFilter!);
    return response;
  }




  @override
  Future<ApiResult<MyVisitResult>> getVisitsOrCallData(
      String? selectedFilter) async {
    String? accessToken = await getAccessToken();
    String userType = await getUserType();

    final ApiResult<MyVisitResult> response = await provider
        .getVisitsOrCallDataFromApi(accessToken, selectedFilter!, userType);
    return response;
  }

  @override
  Future<ApiResult<DepositResult>> getMyDeposits(String? selectedFilter) async {
    String? accessToken = await getAccessToken();
    String userType = await getUserType();
    final ApiResult<DepositResult> response = await provider
        .getMyDepositsFromApi(accessToken, selectedFilter!, userType);
    return response;
  }

  @override
  Future<ApiResult<List<YardingResult>?>> getYardingData() async {
    String? accessToken = await getAccessToken();
    final ApiResult<List<YardingResult>?> response =
        await provider.getYardingDataFromApi(accessToken);
    return response;
  }

  @override
  Future<dynamic> postBankDepositData(
      List<File>? fileData, dynamic postFormData) async {
    String? accessToken = await getAccessToken();
    String userType = await getUserType();
    final ApiResult<dynamic> response = await provider.syncPostBankDepositData(
        accessToken, fileData, postFormData, userType);
    return response;
  }

  @override
  Future<dynamic> postCompanyBranchData(
      List<File>? fileData, dynamic postFormData) async {
    String? accessToken = await getAccessToken();
    String userType = await getUserType();
    final ApiResult<dynamic> response = await provider.syncCompanyBranchData(
        accessToken, fileData, postFormData, userType);
    return response;
  }

  @override
  Future<dynamic> yardReleaseData(
      List<File>? fileData, dynamic postFormData, String event) async {
    String? accessToken = await getAccessToken();
    String userType = await getUserType();
    final ApiResult<dynamic> response = await provider.syncYardReleaseData(
        accessToken, fileData, postFormData, userType, event);
    return response;
  }
}
