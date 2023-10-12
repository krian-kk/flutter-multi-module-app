import 'package:domain_models/response_models/agentInfoPublic/agent_info.dart';
import 'package:domain_models/response_models/auth/sign_in/login_response.dart';
import 'package:network_helper/api_services/authentication_api_service.dart';
import 'package:network_helper/errors/network_exception.dart';
import 'package:network_helper/network_base_models/api_result.dart';
import 'package:network_helper/network_base_models/base_response.dart';
import 'package:preference_helper/preference_constants.dart';
import 'package:preference_helper/preference_helper.dart';

abstract class AuthRepository {
  Future<ApiResult<LoginResponse>> login(
      String userName, String password, String fcmToken);

  Future<void> intialSetPref();

  Future<ApiResult<bool>?> sendOtpRequestToServer(String agentRef);

  Future<ApiResult<ShortAgentDetails>?> getAgentDataForPrefill(String agentRef);

  Future<ApiResult<bool>?> verifyOtpRequestToServer(
      String agentRef, String pin);

  Future<ApiResult<bool>?> resetPasswordForAgent(
      String agentRef, String password, String otp);

  Future<ApiResult> setPasswordForAgent(String userName, String password);
}

class AuthRepositoryImpl extends AuthRepository {
  AuthenticationApiProvider provider = AuthenticationApiProvider();

  @override
  Future<ApiResult<LoginResponse>> login(
      String userName, String password, String fcmToken) async {
    try {
      final ApiResult<dynamic> response =
          await provider.signIn(userName, password, fcmToken);
      LoginResponse? loginData;
      response.map(
          success: (value) {
            loginData = LoginResponse.fromJson(value.data);
          },
          failure: (error) => throw NetworkExceptions.getDioException(error));
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
      await PreferenceHelper.getString(keyPair: PreferenceConstants.agentRef);
      return ApiResult.success(data: loginData);
    } catch (error) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(error));
    }
  }

  @override
  Future<ApiResult<ShortAgentDetails>?> getAgentDataForPrefill(
      String agentRef) async {
    try {
      final ApiResult<dynamic> response =
          await provider.getAgentDataFromApi(agentRef);
      PublicAgentInfoModel? agentData;
      response.map(
          success: (value) {
            agentData = PublicAgentInfoModel.fromJson(value.data);
          },
          failure: (error) => throw error);
      String? phoneNumber = '';
      String? email = '';
      agentData?.contact?.forEach((element) {
        if (element.cType == 'mobile') {
          phoneNumber = element.value;
        }
        if (element.cType == 'email') {
          email = element.value;
        }
      });
      ShortAgentDetails agentMiniDetails = ShortAgentDetails(
          agentData?.name ?? '', email ?? '', phoneNumber ?? '');
      if (agentData?.type == 'COLLECTOR') {
        await PreferenceHelper.setPreference(
            PreferenceConstants.userType, PreferenceConstants.fieldagent);
      } else {
        await PreferenceHelper.setPreference(
            PreferenceConstants.userType, PreferenceConstants.telecaller);
      }

      return ApiResult.success(data: agentMiniDetails);
    } catch (error) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(error));
    }
  }

  @override
  Future<void> intialSetPref() async {
    try {
      String agentRef = await PreferenceHelper.getString(
              keyPair: PreferenceConstants.agentRef) ??
          "";
      final ApiResult<dynamic> response =
          await provider.getAgentDataFromApi(agentRef);

      PublicAgentInfoModel? agentData;

      response.map(
          success: (value) {
            agentData = PublicAgentInfoModel.fromJson(value.data);
          },
          failure: (error) => throw error);
      if ((agentData?.type).toString() == 'COLLECTOR') {
        await PreferenceHelper.setPreference(
            PreferenceConstants.userType, PreferenceConstants.fieldagent);
      } else {
        await PreferenceHelper.setPreference(
            PreferenceConstants.userType, PreferenceConstants.telecaller);
      }
    } catch (error) {
      // return ApiResult.failure(error: NetworkExceptions.getDioException(error));
    }
  }

  @override
  Future<ApiResult<bool>?> sendOtpRequestToServer(String agentRef) async {
    final ApiResult<bool> response =
        await provider.resendOtpApiForResetPassword(agentRef);
    return response;
  }

  @override
  Future<ApiResult<bool>?> verifyOtpRequestToServer(
      String agentRef, String pin) async {
    final ApiResult<BaseResponse> response =
        await provider.verifyOtpApiFromServer(agentRef, pin);
    await response.when(success: (BaseResponse? agentData) async {
      return const ApiResult.success(data: true);
    }, failure: (NetworkExceptions? error) async {
      return ApiResult.failure(error: NetworkExceptions.getDioException(error));
    });
  }

  @override
  Future<ApiResult<bool>?> resetPasswordForAgent(
      String agentRef, String password, String otp) async {
    final ApiResult<BaseResponse> response =
        await provider.resetPasswordForAgent(agentRef, password, otp);
    await response.when(success: (BaseResponse? agentData) async {
      return const ApiResult.success(data: true);
    }, failure: (NetworkExceptions? error) async {
      return ApiResult.failure(error: NetworkExceptions.getDioException(error));
    });
  }

  @override
  Future<ApiResult> setPasswordForAgent(
      String userName, String password) async {
    final ApiResult response =
        await provider.setPasswordForAgent(userName, password);
    return response;
  }
}

class ShortAgentDetails {
  String name = '';
  String email = '';
  String mobile = '';

  ShortAgentDetails(this.name, this.email, this.mobile);
}
