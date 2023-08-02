import 'dart:convert';

import 'package:domain_models/response_models/response_login.dart';
import 'package:flutter/foundation.dart';
import 'package:network/network.dart';
import 'package:network_helper/dio/dio_client.dart';
import 'package:network_helper/network_base_models/base_response.dart';
import 'package:network_helper/errors/network_exception.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:network_helper/network_base_models/api_result.dart';

class LoginApiProvider {
  final _cryptoPlugin = Network();

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
      'data': jsonEncode(object),
    };
    String encryptedText = 'Unknown';
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
}
