import 'package:domain_models/request_body/authentication/reset_password_request_body.dart';
import 'package:domain_models/request_body/authentication/set_password_request.dart';
import 'package:flutter/cupertino.dart';
import 'package:network_helper/dio/dio_client.dart';
import 'package:network_helper/errors/network_exception.dart';
import 'package:network_helper/network_base_models/base_response.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:network_helper/network_base_models/api_result.dart';

class AuthenticationApiProvider {
  static const String loginEndPoint = "${mobileBackendUrl}login";
  static const String agentDetailsEndPoint =
      '$baseUrl${apiType}public/agentDetails';
  static const String resendOtpEndPoint = '$baseUrl${apiType}public/requestOtp';
  static const String verifyOtpEndPoint = '$baseUrl${apiType}public/verifyOtp';
  static const String resetPasswordEndPoint =
      '$baseUrl${apiType}public/resetPassword';
  static const String setPasswordUrl = '$baseUrl${apiType}public/setPassword';
  static const jsonKeyAref = 'aRef';

  Future<dynamic> signIn(
      String userName, String password, String fcmToken) async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    final requestObject = <String, dynamic>{
      'userName': userName,
      'agentRef': userName,
      'password': password,
      'appVersion': packageInfo.version
    };
    dynamic response;
    try {
      response = await DioClient(baseUrl)
          .post(loginEndPoint, data: requestObject, encryptRequestBody: true);
      final mappedResponse = SingleResponse.fromJson2(response);
      return ApiResult.success(data: mappedResponse.result);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<dynamic> getAgentDataFromApi(String agentRef) async {
    final requestObject = <String, dynamic>{jsonKeyAref: agentRef};
    dynamic response;
    try {
      response = await DioClient(baseUrl).post(agentDetailsEndPoint,
          data: requestObject, decryptResponse: true, encryptRequestBody: true);
      final mappedResponse = SingleResponse.fromJson2(response);
      return ApiResult.success(data: mappedResponse.result);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<ApiResult<bool>> resendOtpApiForResetPassword(String agentRef) async {
    final requestObject = <String, dynamic>{jsonKeyAref: agentRef};
    dynamic response;
    try {
      response = await DioClient(baseUrl).post(resendOtpEndPoint,
          data: requestObject, encryptRequestBody: true);
      final mappedResponse = SingleResponse.fromJson2(response);
      return ApiResult.success(data: mappedResponse.result as bool);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<dynamic> verifyOtpApiFromServer(String agentRef, String pin) async {
    final object = <String, dynamic>{'aRef': agentRef, 'otp': pin};
    dynamic response;
    try {
      response = await DioClient(baseUrl).post(verifyOtpEndPoint, data: object);
      final mappedResponse =
          SingleResponse.fromJson(response, BaseResponse.fromJson);
      return ApiResult.success(data: mappedResponse);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<dynamic> resetPasswordForAgent(
      String agentRef, String password, String otp) async {
    ResetPasswordModel requestBodyData =
        ResetPasswordModel(otp: otp, username: agentRef, newPassword: password);
    dynamic response;
    try {
      response = await DioClient(baseUrl)
          .post(resetPasswordEndPoint, data: requestBodyData);
      final mappedResponse =
          SingleResponse.fromJson(response, BaseResponse.fromJson);
      return ApiResult.success(data: mappedResponse);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<dynamic> setPasswordForAgent(String userName, String password) async {
    SetPasswordModel requestBodyData =
        SetPasswordModel(username: userName, newPassword: password);
    dynamic response;
    try {
      response = await DioClient(baseUrl).post(setPasswordUrl,
          data: requestBodyData, encryptRequestBody: true);
      final mappedResponse = SingleResponse.fromJson2(response);
      debugPrint(mappedResponse.toString());
      return const ApiResult.success(data: true);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }
}
