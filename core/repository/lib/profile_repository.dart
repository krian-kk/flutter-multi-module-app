import 'dart:io';

import 'package:domain_models/common/constants.dart';
import 'package:domain_models/response_models/profile/profile_data.dart';
import 'package:network_helper/api_services/profile_api_service.dart';
import 'package:network_helper/errors/network_exception.dart';
import 'package:network_helper/network_base_models/api_result.dart';
import 'package:network_helper/network_base_models/base_response.dart';
import 'package:preference_helper/preference_constants.dart';
import 'package:preference_helper/preference_helper.dart';
import 'package:repository/repo_utils.dart';

abstract class ProfileRepository {
  Future<void> logoutEvent();

  Future<ApiResult<BaseResponse>> uploadImageToServer(File? imageFile);

  Future<ApiResult<ProfileResponse>> getProfileData();

  Future<int> getLanguageCodeRatioIndex(String val);

  Future<String> getLanguageCode(String val);

  Future<void> setLanguageCode(String ratioIndex, String langCode,
      int ratioIndexVal, String langCodeVal);
}

class ProfileRepositoryImpl extends ProfileRepository {
  ProfileApiProvider apiProvider = ProfileApiProvider();

  @override
  Future<void> logoutEvent() async {
    await PreferenceHelper.setPreference(PreferenceConstants.accessToken, '');
    await PreferenceHelper.setPreference(PreferenceConstants.userType, '');
    await PreferenceHelper.setPreference(
        PreferenceConstants.appDataLoadedFromFirebase, false);
    await PreferenceHelper.setPreference(
        PreferenceConstants.appDataLoadedFromFirebaseTime, '');
    await PreferenceHelper.setPreference(PreferenceConstants.addressValue, '');
    await PreferenceHelper.setPreference(PreferenceConstants.atOffice, true);
  }

  @override
  Future<ApiResult<BaseResponse>> uploadImageToServer(File? imageFile) async {
    String? accessToken = await getAccessToken();
    final ApiResult<BaseResponse> response =
        await apiProvider.changeProfileImageOnServer(accessToken, imageFile);
    return response;
  }

  @override
  Future<ApiResult<ProfileResponse>> getProfileData() async {
    String? accessToken = await getAccessToken();
    final ApiResult<ProfileResponse> response =
        await apiProvider.getInitialProfileData(accessToken);
    return response;
  }

  @override
  Future<int> getLanguageCodeRatioIndex(String val) async {
    return await PreferenceHelper.getInt(keyPair: val) ?? 0;
  }

  @override
  Future<String> getLanguageCode(String val) async {
    return await PreferenceHelper.getString(keyPair: val) ?? "en";
  }

  @override
  Future<void> setLanguageCode(String ratioIndex, String langCode,
      int ratioIndexVal, String langCodeVal) async {
    await PreferenceHelper.setPreference(ratioIndex, ratioIndexVal);
    await PreferenceHelper.setPreference(langCode, langCodeVal);
  }
}
