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
import 'package:origa/utils/preference_helper.dart';
import 'package:origa/widgets/jwt_decorder_widget.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationUnInitialized());

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is AppStarted) {
      await Future<dynamic>.delayed(const Duration(seconds: 2));
      Singleton.instance.buildContext = event.context;
      if (ConnectivityResult.none == await Connectivity().checkConnectivity()) {
        if (PreferenceHelper.getString(keyPair: Constants.userType)
                .toString() ==
            Constants.fieldagent) {
          if (PreferenceHelper.getBool(
                  keyPair: Constants.appDataLoadedFromFirebase) as bool ==
              true) {
            Singleton.instance.usertype =
                PreferenceHelper.getString(keyPair: Constants.userType)
                    .toString();
            Singleton.instance.agentRef =
                PreferenceHelper.getString(keyPair: Constants.agentRef)
                    .toString();
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
        String? getToken;
        String? getUserName;
        String? getUserType;
        await PreferenceHelper.getString(keyPair: Constants.accessToken)
            .then((value) {
          getToken = value;
        });

        await PreferenceHelper.getString(keyPair: Constants.userId)
            .then((value) {
          getUserName = value;
        });

        await PreferenceHelper.getString(keyPair: Constants.userType)
            .then((value) {
          getUserType = value;
        });
        if (getToken == 'null' || getToken == null || getToken == '') {
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
                  PreferenceHelper.getString(keyPair: Constants.accessToken)
                      .toString();
              Singleton.instance.refreshToken =
                  PreferenceHelper.getString(keyPair: Constants.refreshToken)
                      .toString();
              Singleton.instance.sessionID =
                  PreferenceHelper.getString(keyPair: Constants.sessionId)
                      .toString();
              Singleton.instance.agentRef =
                  PreferenceHelper.getString(keyPair: Constants.agentRef)
                      .toString();

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
                  await PreferenceHelper.setPreference(
                      Constants.userType, Constants.fieldagent);
                  Singleton.instance.usertype = Constants.fieldagent;
                } else {
                  await PreferenceHelper.setPreference(
                      Constants.userType, Constants.telecaller);
                  Singleton.instance.usertype = Constants.telecaller;
                }

                if (agentDetails.data![0].agentType != null) {
                  Singleton.instance.agentName =
                      agentDetails.data![0].agentName!;
                  await PreferenceHelper.setPreference(
                      Constants.agentName, agentDetails.data![0].agentName!);
                  await PreferenceHelper.setPreference(
                      Constants.mobileNo, agentDetails.data![0].mobNo!);
                  await PreferenceHelper.setPreference(
                      Constants.email, agentDetails.data![0].email!);
                  await PreferenceHelper.setPreference(
                      Constants.contractor, agentDetails.data![0].contractor!);
                  Singleton.instance.contractor =
                      agentDetails.data![0].contractor!;
                  await PreferenceHelper.setPreference(
                      Constants.status, agentDetails.data![0].status!);
                  await PreferenceHelper.setPreference(
                      Constants.code, agentDetails.code!);
                  await PreferenceHelper.setPreference(
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
