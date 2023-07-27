import 'package:origa/src/services/network_utils/network_base_models/api_result.dart';
import 'package:origa/src/services/network_utils/http.dart';
import 'package:origa/src/services/network_utils/network_exception.dart';
import 'package:flutter/foundation.dart';
import 'package:origa/http/dio_client.dart';
import 'package:origa/src/features/authentication/domain/response_login.dart';
import 'package:origa/src/services/network_utils/network_base_models/api_result.dart';

class LoginApiProvider {
  Future<ApiResult<LoginResponseModel>> signIn(url, dynamic requestBody) async {
    try {
      print(requestBody);
      final response = await dio.post(url, data: requestBody);
      final value = LoginResponseModel.fromJson(response.data);
      if (kDebugMode) {
        print(response);
      }
      return ApiResult.success(data: value);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }
}

class ResponseLogin {}
