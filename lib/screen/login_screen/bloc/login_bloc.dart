import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:meta/meta.dart';
import 'package:origa/http/api_repository.dart';
import 'package:origa/http/httpurls.dart';
import 'package:origa/models/agent_detail_error_model.dart';
import 'package:origa/models/login_response.dart';
import 'package:origa/utils/app_utils.dart';
import 'package:origa/utils/base_equatable.dart';
import 'package:origa/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitialState());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginInitialEvent) {
      if (ConnectivityResult.none == await Connectivity().checkConnectivity()) {
        yield NoInternetConnectionState();
      }
    }

    LoginResponseModel loginResponse =
      LoginResponseModel();

      AgentDetailErrorModel agentDetailError =
      AgentDetailErrorModel();

    if (event is SignInEvent) {
      SharedPreferences _prefs = await SharedPreferences.getInstance();

       Map<String, dynamic> response = await APIRepository.apiRequest(
          APIRequestType.POST,
          HttpUrl.loginUrl,
          requestBodydata: event.paramValue);

          if(response['data']['msg'] != null) {
            AppUtils.showToast(response['data']['msg']);
          }

           if(response['success']) {
            loginResponse = LoginResponseModel.fromJson(response['data']);
            _prefs.setString('accessToken', loginResponse.data!.accessToken!);
            _prefs.setInt('accessTokenExpireTime', loginResponse.data!.expiresIn!);
            _prefs.setString('refreshToken', loginResponse.data!.refreshToken!);
            _prefs.setInt('refreshTokenExpireTime', loginResponse.data!.refreshExpiresIn!);
            _prefs.setString('keycloakId', loginResponse.data!.keycloakId!);

            _prefs.setString('userName', event.userName!);

            if (_prefs.getString('accessToken') != null) {

             Map<String, dynamic> agentDetail = await APIRepository.apiRequest(
                APIRequestType.GET, HttpUrl.agentDetailUrl + event.userName!);

                agentDetailError = AgentDetailErrorModel.fromJson(agentDetail['data']);

                if (event.userName == 'HAR_fos3' || event.userName == 'HAR_fos4' || event.userName == 'HAR_fos1' || event.userName == 'YES_suvodeepcollector') {
                  _prefs.setString('userType', Constants.fieldagent);
                } else {
                  _prefs.setString('userType', Constants.telecaller);
                }

                // print("----------Agent Details-------------");
                // print(agentDetailError.msg);
                // print("----------Return Agent Details-------------");

          yield HomeTabState();
        }

      }

      // yield HomeTabState();
    }

    // if (event is HomeTabEvent) {
    //   yield HomeTabState();
    // }

    if (event is NoInternetConnectionEvent) {
      yield NoInternetConnectionState();
    }
  }
}
