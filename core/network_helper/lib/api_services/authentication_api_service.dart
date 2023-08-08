import 'dart:convert';

import 'package:cross_platform_crypto/cross_platform_crypto.dart';
import 'package:domain_models/request_body/authentication/reset_password_request_body.dart';
import 'package:domain_models/response_models/agentInfoPublic/agent_info.dart';
import 'package:domain_models/response_models/response_login.dart';
import 'package:flutter/foundation.dart';
import 'package:network_helper/dio/dio_client.dart';
import 'package:network_helper/errors/network_exception.dart';
import 'package:network_helper/network_base_models/base_response.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:network_helper/network_base_models/api_result.dart';

class AuthenticationApiProvider {
  final _cryptoPlugin = CrossPlatformCrypto();

  Future<ApiResult<LoginResponseModel>> signIn(
      String userName, String password, String fcmToken) async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    final object = <String, dynamic>{
      'userName': userName,
      'agentRef': userName,
      'password': password,
      'appVersion': packageInfo.version
    };
    final Map<String, dynamic> requestData = {
      responseResultDataKey: jsonEncode(object),
    };
    String encryptedText = '';
    dynamic response;
    try {
      if (kDebugMode) {
        print(requestData);
      }
      encryptedText = await _cryptoPlugin.sendEncryptedData(requestData) ?? '';
      response = await DioClient(baseUrl).post('$mobileBackendUrl/login',
          data: {'encryptedData': encryptedText});
      final mappedResponse =
          SingleResponse.fromJson(response, LoginResponseModel.fromJson);
      return ApiResult.success(data: mappedResponse.result);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<dynamic> getAgentDataFromApi(String agentRef) async {
    final object = <String, dynamic>{'aRef': agentRef};
    final Map<String, dynamic> requestData = {
      responseResultDataKey: jsonEncode(object),
    };
    String encryptedText = '';
    dynamic response;
    try {
      if (kDebugMode) {
        print(requestData);
      }
      encryptedText = await _cryptoPlugin.sendEncryptedData(requestData) ?? '';
      response = await DioClient(baseUrl).post(
          '$baseUrl${apiType}public/agentDetails',
          data: {'encryptedData': encryptedText});
      final mappedResponse =
          SingleResponse.fromJson(response, PublicAgentInfoModel.fromJson);
      return ApiResult.success(data: mappedResponse);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<dynamic> resendOtpApiForResetPassword(String agentRef) async {
    final object = <String, dynamic>{'aRef': agentRef};
    final Map<String, dynamic> requestData = {
      responseResultDataKey: jsonEncode(object),
    };
    String encryptedText = '';
    dynamic response;
    try {
      if (kDebugMode) {
        print(requestData);
      }
      encryptedText = await _cryptoPlugin.sendEncryptedData(requestData) ?? '';
      response = await DioClient(baseUrl).post(
          '$baseUrl${apiType}public/requestOtp',
          data: {'encryptedData': encryptedText});
      final mappedResponse =
          SingleResponse.fromJson(response, BaseResponse.fromJson);
      return ApiResult.success(data: mappedResponse);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<dynamic> verifyOtpApiFromServer(String agentRef, String pin) async {
    final object = <String, dynamic>{'aRef': agentRef, 'otp': pin};
    dynamic response;
    try {
      response = await DioClient(baseUrl)
          .post('$baseUrl${apiType}public/verifyOtp', data: object);
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
    final Map<String, dynamic> requestData = {
      'data': jsonEncode(requestBodyData)
    };
    String encryptedText = '';
    dynamic response;
    try {
      if (kDebugMode) {
        print(requestData);
      }
      encryptedText = await _cryptoPlugin.sendEncryptedData(requestData) ?? '';
      response = await DioClient(baseUrl).post(
          '$baseUrl${apiType}public/resetPassword',
          data: {'encryptedData': encryptedText});
      final mappedResponse =
          SingleResponse.fromJson(response, BaseResponse.fromJson);
      return ApiResult.success(data: mappedResponse);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }
}
