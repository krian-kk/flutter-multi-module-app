import 'package:domain_models/response_models/response_login.dart';
import 'package:network_helper/api_services/login_api_service.dart';
import 'package:network_helper/errors/network_exception.dart';
import 'package:network_helper/network_base_models/api_result.dart';
import 'package:preference_helper/preference_constants.dart';
import 'package:preference_helper/preference_helper.dart';

abstract class AuthRepository {
  Future<ApiResult<LoginResponseModel>> login(
      String userName, String password, String fcmToken);
}

class AuthRepositoryImpl extends AuthRepository {
  LoginApiProvider provider = LoginApiProvider();

  @override
  Future<ApiResult<LoginResponseModel>> login(
      String userName, String password, String fcmToken) async {
    final ApiResult<LoginResponseModel> response =
        await provider.signIn(userName, password, fcmToken);
    await response.when(
        success: (LoginResponseModel? loginData) async {
          await PreferenceHelper.setPreference(
              PreferenceConstants.accessToken, loginData?.accessToken ?? '');
          await PreferenceHelper.setPreference(
              PreferenceConstants.accessTokenExpireTime,
              loginData?.expiresIn ?? '');
          await PreferenceHelper.setPreference(
              PreferenceConstants.refreshToken, loginData?.refreshToken ?? '');
          await PreferenceHelper.setPreference(
              PreferenceConstants.refreshTokenExpireTime,
              loginData?.refreshExpiresIn ?? '');
          await PreferenceHelper.setPreference(
              PreferenceConstants.sessionId, loginData?.sessionState ?? '');
          await PreferenceHelper.setPreference(
              PreferenceConstants.agentRef, userName);
          await PreferenceHelper.setPreference(
              PreferenceConstants.userId, userName);
          await PreferenceHelper.getString(
              keyPair: PreferenceConstants.agentRef);
        },
        failure: (NetworkExceptions? error) async {});
    return response;
  }
}
