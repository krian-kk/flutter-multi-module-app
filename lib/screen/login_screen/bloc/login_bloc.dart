import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:meta/meta.dart';
import 'package:origa/http/api_repository.dart';
import 'package:origa/http/httpurls.dart';
import 'package:origa/models/agent_detail_error_model.dart';
import 'package:origa/models/agent_details_model.dart';
import 'package:origa/models/login_error_model.dart';
import 'package:origa/models/login_response.dart';
import 'package:origa/singleton.dart';
import 'package:origa/utils/app_utils.dart';
import 'package:origa/utils/base_equatable.dart';
import 'package:origa/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitialState());

  bool isAnimating = true;
  bool isSubmit = true;
  bool isLoading = false;
  bool isLoaded = false;

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginInitialEvent) {
      if (ConnectivityResult.none == await Connectivity().checkConnectivity()) {
        yield NoInternetConnectionState();
      }
    }

    LoginResponseModel loginResponse = LoginResponseModel();

    LoginErrorMessage loginErrorResponse = LoginErrorMessage();

    if (event is SignInEvent) {
      // started the sign in loading
      yield SignInLoadingState();
      SharedPreferences _prefs = await SharedPreferences.getInstance();

      Map<String, dynamic> response = await APIRepository.apiRequest(
          APIRequestType.POST, HttpUrl.loginUrl,
          requestBodydata: event.paramValue);

      if (response['data'] is LoginErrorMessage) {
        loginErrorResponse = LoginErrorMessage.fromJson(response['data']);
        // if SignIn error to show again SignIn button
        yield SignInLoadedState();
        AppUtils.showToast(loginErrorResponse.msg.toString());
      } else {
        // Successfully getting access-token
        if (response['data'] is String) {
          AppUtils.showToast(response['data']);
        } else {
          loginResponse = LoginResponseModel.fromJson(response['data']);
          // Store the access-token in local storage
          _prefs.setString(
              Constants.accessToken, loginResponse.data!.accessToken!);
          _prefs.setInt(
              Constants.accessTokenExpireTime, loginResponse.data!.expiresIn!);
          _prefs.setString(
              Constants.refreshToken, loginResponse.data!.refreshToken!);
          _prefs.setInt(Constants.refreshTokenExpireTime,
              loginResponse.data!.refreshExpiresIn!);
          _prefs.setString(
              Constants.keycloakId, loginResponse.data!.keycloakId!);
          _prefs.setString(
              Constants.sessionId, loginResponse.data!.sessionState!);
          _prefs.setString(Constants.agentRef, event.userId!);
          _prefs.setString(Constants.userId, event.userId!);
          Singleton.instance.accessToken = loginResponse.data!.accessToken!;
          Singleton.instance.refreshToken = loginResponse.data!.refreshToken!;
          Singleton.instance.sessionID = loginResponse.data!.sessionState!;
          Singleton.instance.agentRef = event.userId!;

          if (loginResponse.data!.accessToken != null) {
            // Execute agent detail URl to get Agent details
            Map<String, dynamic> agentDetail = await APIRepository.apiRequest(
                APIRequestType.GET, HttpUrl.agentDetailUrl + event.userId!);

            if (agentDetail['data'] is AgentDetailErrorModel) {
              // Error getting Agent Details
              // user inactivity (or) already loggined another device
              dynamic agentDetailError =
                  AgentDetailErrorModel.fromJson(agentDetail['data']);
              // Here facing error so close the loading
              yield SignInLoadedState();
              AppUtils.showToast(agentDetailError.msg!);
            } else {
              // getting Agent Details
              dynamic agentDetails =
                  AgentDetailsModel.fromJson(agentDetail['data']);
              // chech agent type COLLECTOR or TELECALLER then store agent-type in local storage
              if (agentDetails.data![0].agentType == 'COLLECTOR') {
                await _prefs.setString(
                    Constants.userType, Constants.fieldagent);
              } else {
                await _prefs.setString(
                    Constants.userType, Constants.telecaller);
              }
              // here storing all agent details in local storage
              if (agentDetails.data![0].agentType != null) {
                await _prefs.setString(
                    Constants.agentName, agentDetails.data![0].agentName!);
                await _prefs.setString(
                    Constants.mobileNo, agentDetails.data![0].mobNo!);
                await _prefs.setString(
                    Constants.email, agentDetails.data![0].email!);
                await _prefs.setString(
                    Constants.contractor, agentDetails.data![0].contractor!);
                await _prefs.setString(
                    Constants.status, agentDetails.data![0].status!);
                await _prefs.setString(Constants.code, agentDetails.code!);
                await _prefs.setBool(
                    Constants.userAdmin, agentDetails.data![0].userAdmin!);

                yield SignInCompletedState();
                await Future.delayed(const Duration(milliseconds: 200));

                yield HomeTabState();
              }
            }
          }
        }
      }
    }

    if (event is ResendOTPEvent) {
      yield ResendOTPState();
    }

    if (event is NoInternetConnectionEvent) {
      yield NoInternetConnectionState();
    }
  }
}
