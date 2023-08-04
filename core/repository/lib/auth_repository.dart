import 'package:domain_models/response_models/agentInfoPublic/agent_info.dart';
import 'package:domain_models/response_models/response_login.dart';
import 'package:network_helper/api_services/authentication_api_service.dart';
import 'package:network_helper/errors/network_exception.dart';
import 'package:network_helper/network_base_models/api_result.dart';
import 'package:network_helper/network_base_models/base_response.dart';
import 'package:preference_helper/preference_constants.dart';
import 'package:preference_helper/preference_helper.dart';

abstract class AuthRepository {
  Future<ApiResult<LoginResponseModel>> login(
      String userName, String password, String fcmToken);

  Future<ApiResult<bool>?> sendOtpRequestToServer(String agentRef);

  Future<ApiResult<ShortAgentDetails>?> getAgentDataForPrefill(String agentRef);

  Future<ApiResult<bool>?> verifyOtpRequestToServer(
      String agentRef, String pin);

  Future<ApiResult<bool>?> resetPasswordForAgent(
      String agentRef, String password, String otp);
}

class AuthRepositoryImpl extends AuthRepository {
  AuthenticationApiProvider provider = AuthenticationApiProvider();

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

  @override
  Future<ApiResult<ShortAgentDetails>?> getAgentDataForPrefill(
      String agentRef) async {
    final ApiResult<PublicAgentInfoModel> response =
        await provider.getAgentDataFromApi(agentRef);
    await response.when(success: (PublicAgentInfoModel? agentData) async {
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
      return ApiResult.success(data: agentMiniDetails);
    }, failure: (NetworkExceptions? error) async {
      return ApiResult.failure(error: NetworkExceptions.getDioException(error));
    });
    return null;
  }

  @override
  Future<ApiResult<bool>?> sendOtpRequestToServer(String agentRef) async {
    final ApiResult<BaseResponse> response =
        await provider.resendOtpApiForResetPassword(agentRef);
    await response.when(success: (BaseResponse? agentData) async {
      return const ApiResult.success(data: true);
    }, failure: (NetworkExceptions? error) async {
      return ApiResult.failure(error: NetworkExceptions.getDioException(error));
    });
    return null;
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
    return null;
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
    return null;
  }
}

class ShortAgentDetails {
  String name = '';
  String email = '';
  String mobile = '';

  ShortAgentDetails(this.name, this.email, this.mobile);
}