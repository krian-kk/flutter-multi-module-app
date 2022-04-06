import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:origa/authentication/authentication_event.dart';
import 'package:origa/authentication/authentication_state.dart';
import 'package:origa/http/api_repository.dart';
import 'package:origa/http/httpurls.dart';
import 'package:origa/models/agent_detail_error_model.dart';
import 'package:origa/models/agent_details_model.dart';
import 'package:origa/singleton.dart';
import 'package:origa/utils/app_utils.dart';
import 'package:origa/utils/constants.dart';
import 'package:origa/widgets/jwt_decorder_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationUnInitialized());

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is AppStarted) {
      await Future<dynamic>.delayed(const Duration(seconds: 2));
      // if (response.isNotEmpty) {}
      Singleton.instance.buildContext = event.context;
      final SharedPreferences _pref = await SharedPreferences.getInstance();
      // _pref.setBool(Constants.appDataLoadedFromFirebase, true);
      if (ConnectivityResult.none == await Connectivity().checkConnectivity()) {
        if (_pref.getString(Constants.userType) == Constants.fieldagent) {
          if (_pref.getBool(Constants.appDataLoadedFromFirebase) == true) {
            Singleton.instance.usertype = _pref.getString(Constants.userType);
            Singleton.instance.agentRef = _pref.getString(Constants.agentRef);
            yield OfflineState();
          } else {
            yield AuthenticationUnAuthenticated(
                notificationData: event.notificationData);
          }
        } else {
          yield AuthenticationUnAuthenticated(
              notificationData: event.notificationData);
        }
        // AppUtils.showErrorToast('No Internet Connection');
      } else {
        final SharedPreferences _prefs = await SharedPreferences.getInstance();
        final String? getToken = _prefs.getString(Constants.accessToken) ?? '';
        final String? getUserName = _prefs.getString(Constants.userId);
        final String? getUserType = _prefs.getString(Constants.userType) ?? '';

        if (getToken == '') {
          yield AuthenticationUnAuthenticated(
              notificationData: event.notificationData);
        } else {
          debugPrint('Token Issue is === > $getToken');
          if (JwtDecoderWidget.isExpired(getToken!)) {
            yield AuthenticationUnAuthenticated(
                notificationData: event.notificationData);
          } else {
            if (getUserType == '') {
              yield AuthenticationUnAuthenticated(
                  notificationData: event.notificationData);
            } else {
              Singleton.instance.accessToken =
                  _prefs.getString(Constants.accessToken) ?? '';
              Singleton.instance.refreshToken =
                  _prefs.getString(Constants.refreshToken) ?? '';
              Singleton.instance.sessionID =
                  _prefs.getString(Constants.sessionId) ?? '';
              Singleton.instance.agentRef =
                  _prefs.getString(Constants.agentRef) ?? '';

              final Map<String, dynamic> agentDetail =
                  await APIRepository.apiRequest(APIRequestType.get,
                      HttpUrl.agentDetailUrl + getUserName!);

              if (agentDetail[Constants.success] == false) {
                yield AuthenticationUnAuthenticated(
                    notificationData: event.notificationData);

                if (agentDetail['data'] is String) {
                  AppUtils.showToast(agentDetail['data'],
                      backgroundColor: Colors.red);
                }
                final AgentDetailErrorModel agentDetailError =
                    AgentDetailErrorModel.fromJson(agentDetail['data']);
                AppUtils.showToast(agentDetailError.msg!,
                    backgroundColor: Colors.red);
              } else {
                // if user inactivity means go to login
                if (agentDetail['data']['status'] == 440) {
                  final AgentDetailErrorModel agentInactivityError =
                      AgentDetailErrorModel.fromJson(agentDetail['data']);
                  yield AuthenticationUnAuthenticated(
                      notificationData: event.notificationData);
                  AppUtils.showToast(agentInactivityError.msg!,
                      backgroundColor: Colors.red);
                }

                final dynamic agentDetails =
                    AgentDetailsModel.fromJson(agentDetail['data']);
                if (agentDetails.data![0].agentType == 'COLLECTOR') {
                  await _prefs.setString(
                      Constants.userType, Constants.fieldagent);
                  Singleton.instance.usertype = Constants.fieldagent;
                } else {
                  await _prefs.setString(
                      Constants.userType, Constants.telecaller);
                  Singleton.instance.usertype = Constants.telecaller;
                }

                if (agentDetails.data![0].agentType != null) {
                  Singleton.instance.agentName =
                      agentDetails.data![0].agentName!;
                  await _prefs.setString(
                      Constants.agentName, agentDetails.data![0].agentName!);
                  await _prefs.setString(
                      Constants.mobileNo, agentDetails.data![0].mobNo!);
                  await _prefs.setString(
                      Constants.email, agentDetails.data![0].email!);
                  await _prefs.setString(
                      Constants.contractor, agentDetails.data![0].contractor!);
                  Singleton.instance.contractor =
                      agentDetails.data![0].contractor!;
                  await _prefs.setString(
                      Constants.status, agentDetails.data![0].status!);
                  await _prefs.setString(Constants.code, agentDetails.code!);
                  await _prefs.setBool(
                      Constants.userAdmin, agentDetails.data![0].userAdmin!);

                  yield AuthenticationAuthenticated(
                      notificationData: event.notificationData);
                }
              }
            }
          }
        }
      }
      // yield AuthenticationAuthenticated();
    }

    if (event is UnAuthenticationEvent) {
      yield AuthenticationUnAuthenticated();
    }
  }
}
