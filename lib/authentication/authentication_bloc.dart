import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:origa/authentication/authentication_event.dart';
import 'package:origa/authentication/authentication_state.dart';
import 'package:origa/http/api_repository.dart';
import 'package:origa/http/httpurls.dart';
import 'package:origa/models/agentInfoPublic/agent_info.dart';
import 'package:origa/models/agent_detail_error_model.dart';
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
        bool appDataLoadedFromFirebase = false;
        await PreferenceHelper.getString(keyPair: Constants.agentRef)
            .then((value) {
          Singleton.instance.agentRef = value;
        });

        await PreferenceHelper.getString(keyPair: Constants.userType)
            .then((value) {
          Singleton.instance.usertype = value;
        });

        await PreferenceHelper.getBool(
                keyPair: Constants.appDataLoadedFromFirebase)
            .then((value) {
          appDataLoadedFromFirebase = value;
        });
        if (Singleton.instance.usertype == Constants.fieldagent &&
            appDataLoadedFromFirebase) {
          // await FirebaseDatabase.instanceFor(app: firebaseApp)
          //     .ref(Singleton.instance.firebaseDatabaseName)
          //     .keepSynced(true);
          yield OfflineState();
        } else {
          yield AuthenticationUnAuthenticated(
              notificationData: event.notificationData);
        }
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
              await PreferenceHelper.getString(keyPair: Constants.accessToken)
                  .then((value) {
                Singleton.instance.accessToken = value;
              });

              await PreferenceHelper.getString(keyPair: Constants.refreshToken)
                  .then((value) {
                Singleton.instance.refreshToken = value;
              });
              await PreferenceHelper.getString(keyPair: Constants.sessionId)
                  .then((value) {
                Singleton.instance.sessionID = value;
              });
              await PreferenceHelper.getString(keyPair: Constants.agentRef)
                  .then((value) {
                Singleton.instance.agentRef = value;
              });

              debugPrint('AccessToken--> ${Singleton.instance.accessToken}');
              debugPrint('refreshToken--> ${Singleton.instance.refreshToken}');
              // final Map<String, dynamic> agentDetail =
              //     await APIRepository.apiRequest(APIRequestType.get,
              //         HttpUrl.agentInformation + 'aRef=$getUserName', encrypt: true);
              const MethodChannel platform =
                  MethodChannel('recordAudioChannel');

              final object = <String, dynamic>{'aRef': getUserName};
              final Map<String, dynamic> requestData = {
                'data': jsonEncode(object)
              };
              final String text =
                  await platform.invokeMethod('sendEncryptedData', requestData);
              final Map<String, dynamic> agentDetail =
                  await APIRepository.apiRequest(
                      APIRequestType.post, HttpUrl.getPublicAgentInfo(),
                      encrypt: true, requestBodydata: {'encryptedData': text});

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
                } else if (agentDetail['data']['status'] == 400) {
                  final AgentDetailErrorModel agentInactivityError =
                      AgentDetailErrorModel.fromJson(agentDetail['data']);
                  yield AuthenticationUnAuthenticated(
                      notificationData: event.notificationData);
                  AppUtils.showToast(agentInactivityError.msg!,
                      backgroundColor: Colors.red);
                }

                PublicAgentInfoModel agentInfo = PublicAgentInfoModel.fromJson(
                    agentDetail['data']['result']);
                // Set agentDetails

                // Singleton.instance.agentDetailsInfo =
                //     AgentInformation.fromJson(agentDetail['data']);
                if (agentInfo.type == 'COLLECTOR') {
                  await PreferenceHelper.setPreference(
                      Constants.userType, Constants.fieldagent);
                  Singleton.instance.usertype = Constants.fieldagent;
                } else {
                  await PreferenceHelper.setPreference(
                      Constants.userType, Constants.telecaller);
                  Singleton.instance.usertype = Constants.telecaller;
                }

                if (agentInfo.type != null) {
                  Singleton.instance.agentName = agentInfo.name;
                  await PreferenceHelper.setPreference(
                      Constants.agentName, agentInfo.name);
                  // await PreferenceHelper.setPreference(
                  //     Constants.mobileNo, agentDetails.result!.first.mobNo!);
                  // await PreferenceHelper.setPreference(
                  //     Constants.email, agentDetails.data![0].email!);
                  await PreferenceHelper.setPreference(
                      Constants.contractor, agentInfo.contractor);
                  Singleton.instance.contractor = agentInfo.contractor;
                  await PreferenceHelper.setPreference(
                      Constants.status, agentInfo.status);
                  // await PreferenceHelper.setPreference(
                  //     Constants.code, agentDetails.code!);
                  await PreferenceHelper.setPreference(
                      Constants.userAdmin, agentInfo.userAdmin);
                  yield AuthenticationAuthenticated(
                      notificationData: event.notificationData);
                } else {
                  yield AuthenticationUnAuthenticated(
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
