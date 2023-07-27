import 'dart:convert';

import 'package:origa/src/features/authentication/domain/response_login.dart';
import 'package:origa/src/services/network_utils/collect_app_service.dart';
import 'package:origa/src/services/network_utils/http.dart';
import 'package:origa/src/services/network_utils/network_base_models/api_result.dart';
import 'package:origa/src/services/network_utils/network_base_models/base_response.dart';
import 'package:origa/src/services/network_utils/network_exception.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:network/network.dart';
import 'package:package_info_plus/package_info_plus.dart';

abstract class AuthRepository {
  Future<ApiResult<LoginResponseModel>?> login();
}

class AuthRepositoryImpl implements AuthRepository {
  final _provider = LoginApiProvider();
  final _cryptoPlugin = Network();

  @override
  Future<ApiResult<LoginResponseModel>?> login() async {
    if (ConnectivityResult.none == await Connectivity().checkConnectivity()) {
      // bloc.add(NoInternetConnectionEvent());
    } else {
      final PackageInfo packageInfo = await PackageInfo.fromPlatform();
      final object = <String, dynamic>{
        // 'username': context.read<SignInBloc>().username
        'userName': 'DM_fos',
        'agentRef': 'DM_fos',
        'password': 'Agent@123',
        'fcmToken':
            'hghjgjhgjhgjgjhgjhgjhgjhgjhgjhgjhgjhgjhgjgjhgjhgjhgjhgjhgjhgjhgjhgjhgjhgjhgjhgjhgjhgjhgjgj',
        'appVersion': packageInfo.version
      };
      final Map<String, dynamic> requestData = {
        'data': jsonEncode(object),
      };

      String encryptedText = 'Unknown';
      Response? response;
      try {
        encryptedText =
            await _cryptoPlugin.sendEncryptedData(requestData) ?? '';
        response = await dio.post(
            "https://collect-poc.m2pfintech.com/mobile-backend/v1/agent/login",
            data: {'encryptedData': encryptedText});
        var mappedResponse = SingleResponse.fromJson(response.data,LoginResponseModel.fromJson);
        return ApiResult.success(data: mappedResponse.result);
      } on DioException catch (e) {
        return ApiResult.failure(error: NetworkExceptions.getDioException(e));
      }
    }
  }
}
