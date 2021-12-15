import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:meta/meta.dart';
import 'package:origa/http/api_repository.dart';
import 'package:origa/http/httpurls.dart';
import 'package:origa/models/agent_detail_error_model.dart';
import 'package:origa/models/agent_details_model.dart';
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

    AgentDetailsModel agentDetails =
      AgentDetailsModel();

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
            _prefs.setString(Constants.accessToken, loginResponse.data!.accessToken!);
            _prefs.setInt(Constants.accessTokenExpireTime, loginResponse.data!.expiresIn!);
            _prefs.setString(Constants.refreshToken, loginResponse.data!.refreshToken!);
            _prefs.setInt(Constants.refreshTokenExpireTime, loginResponse.data!.refreshExpiresIn!);
            _prefs.setString(Constants.keycloakId, loginResponse.data!.keycloakId!);
            _prefs.setString(Constants.sessionId, loginResponse.data!.sessionState!);
            _prefs.setString(Constants.agentRef, event.userName!);
            _prefs.setString(Constants.userName, event.userName!);

            if (_prefs.getString(Constants.accessToken) != null) {

             Map<String, dynamic> agentDetail = await APIRepository.apiRequest(
                APIRequestType.GET, HttpUrl.agentDetailUrl + event.userName!);

                agentDetails = AgentDetailsModel.fromJson(agentDetail['data']);

                agentDetailError = AgentDetailErrorModel.fromJson(agentDetail['data']);

                if (agentDetails.data![0].agentType == 'COLLECTOR') {
                  _prefs.setString(Constants.userType, Constants.fieldagent);
                  _prefs.setString(Constants.agentName, agentDetails.data![0].agentName!);
                  _prefs.setString(Constants.mobileNo, agentDetails.data![0].mobNo!);
                  _prefs.setString(Constants.email, agentDetails.data![0].email!);
                  _prefs.setString(Constants.contractor, agentDetails.data![0].contractor!);
                  _prefs.setString(Constants.status, agentDetails.data![0].status!);
                  _prefs.setString(Constants.code, agentDetails.code!);
                  _prefs.setBool(Constants.userAdmin, agentDetails.data![0].userAdmin!);
                } else {
                  _prefs.setString(Constants.userType, Constants.telecaller);
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
