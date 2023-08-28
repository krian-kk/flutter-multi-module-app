import 'dart:io';
import 'package:dio/dio.dart';
import 'package:domain_models/response_models/profile/profile_data.dart';
import 'package:network/network.dart';
import 'package:network_helper/dio/dio_client.dart';
import 'package:network_helper/errors/network_exception.dart';
import 'package:network_helper/network_base_models/api_result.dart';
import 'package:network_helper/network_base_models/base_response.dart';

class ProfileApiProvider {
  static const String changeProfileImageUrl =
      '${mobileBackendUrl}profile/profileImgUrl';
  static const String profileUrl = '${mobileBackendUrl}profile/userDetails';

  Future<ApiResult<BaseResponse>> changeProfileImageOnServer(
      String accessToken, File? imageFile) async {
    dynamic response;
    try {
      final FormData data = FormData.fromMap(
          {'file': await MultipartFile.fromFile(imageFile!.path)});
      response = await DioClient(baseUrl, accessToken: accessToken)
          .post(changeProfileImageUrl, data: data, decryptResponse: false);
      final mappedResponse =
          SingleResponse.fromJson(response, BaseResponse.fromJson);

      return ApiResult.success(data: mappedResponse.result);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<ApiResult<ProfileResponse>> getInitialProfileData(
      String accessToken) async {
    dynamic response;

    try {
      response = await DioClient(baseUrl, accessToken: accessToken)
          .get(profileUrl, decryptResponse: true);

      final mappedResponse =
          ListResponse.fromJson(response, ProfileResponse.fromJson);

      return ApiResult.success(data: mappedResponse.result?[0]);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }
}
