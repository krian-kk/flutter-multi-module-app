// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';

// import 'package:bloc/bloc.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:device_info/device_info.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:origa/http/api_repository.dart';
// import 'package:origa/http/httpurls.dart';
// import 'package:origa/languages/app_languages.dart';
// import 'package:origa/models/agent_detail_error_model.dart';
// import 'package:origa/models/agent_details_model.dart';
// import 'package:origa/models/device_info_model/android_device_info.dart';
// import 'package:origa/models/device_info_model/ios_device_model.dart';
// import 'package:origa/models/login_error_model.dart';
// import 'package:origa/models/login_response.dart';
// import 'package:origa/singleton.dart';
// import 'package:origa/utils/app_utils.dart';
// import 'package:origa/utils/base_equatable.dart';
// import 'package:origa/utils/constants.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// part 'login_event.dart';
// part 'login_state.dart';

// class LoginBloc extends Bloc<LoginEvent, LoginState> {
//   LoginBloc() : super(LoginInitialState());

//   bool isAnimating = true;
//   bool isSubmit = true;
//   bool isLoading = false;
//   bool isLoaded = false;

//   // share device info
//   static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
//   Map<String, dynamic> _deviceData = <String, dynamic>{};

//   Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
//     return <String, dynamic>{
//       'version.securityPatch': build.version.securityPatch,
//       'version.sdkInt': build.version.sdkInt,
//       'version.release': build.version.release,
//       'version.previewSdkInt': build.version.previewSdkInt,
//       'version.incremental': build.version.incremental,
//       'version.codename': build.version.codename,
//       'version.baseOS': build.version.baseOS,
//       'board': build.board,
//       'bootloader': build.bootloader,
//       'brand': build.brand,
//       'device': build.device,
//       'display': build.display,
//       'fingerprint': build.fingerprint,
//       'hardware': build.hardware,
//       'host': build.host,
//       'id': build.id,
//       'manufacturer': build.manufacturer,
//       'model': build.model,
//       'product': build.product,
//       'supported32BitAbis': build.supported32BitAbis,
//       'supported64BitAbis': build.supported64BitAbis,
//       'supportedAbis': build.supportedAbis,
//       'tags': build.tags,
//       'type': build.type,
//       'isPhysicalDevice': build.isPhysicalDevice,
//       'androidId': build.androidId,
//       'systemFeatures': build.systemFeatures,
//     };
//   }

//   Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data) {
//     return <String, dynamic>{
//       'name': data.name,
//       'systemName': data.systemName,
//       'systemVersion': data.systemVersion,
//       'model': data.model,
//       'localizedModel': data.localizedModel,
//       'identifierForVendor': data.identifierForVendor,
//       'isPhysicalDevice': data.isPhysicalDevice,
//       'utsname.sysname:': data.utsname.sysname,
//       'utsname.nodename:': data.utsname.nodename,
//       'utsname.release:': data.utsname.release,
//       'utsname.version:': data.utsname.version,
//       'utsname.machine:': data.utsname.machine,
//     };
//   }

//   @override
//   Stream<LoginState> mapEventToState(
//     LoginEvent event,
//   ) async* {
//     if (event is LoginInitialEvent) {
//       Singleton.instance.buildContext = event.context;
//       if (ConnectivityResult.none == await Connectivity().checkConnectivity()) {
//         yield NoInternetConnectionState();
//       }
//     }

//     LoginResponseModel loginResponse = LoginResponseModel();

//     LoginErrorMessage loginErrorResponse = LoginErrorMessage();

//     if (event is SignInEvent) {
//       // started the sign in loading
//       yield SignInLoadingState();
//       final SharedPreferences _prefs = await SharedPreferences.getInstance();

//       final Map<String, dynamic> response = await APIRepository.apiRequest(
//           APIRequestType.post, HttpUrl.loginUrl,
//           requestBodydata: event.paramValue);

//       if (response['success'] == false) {
//         yield SignInLoadedState();
//         AppUtils.showToast(response['data'], backgroundColor: Colors.red);
//       } else if (response['statusCode'] == 401) {
//         loginErrorResponse = LoginErrorMessage.fromJson(response['data']);
//         // if SignIn error to show again SignIn button
//         yield SignInLoadedState();
//         if (loginErrorResponse.msg ==
//             'Invalid Credentails, Please contact the administrator') {
//           AppUtils.showToast(
//             Languages.of(event.context)!.userIDDoesNotExist,
//             backgroundColor: Colors.red,
//           );
//         } else if (loginErrorResponse.msg ==
//             'Invalid password, Please enter correct password') {
//           AppUtils.showToast(
//             Languages.of(event.context)!.invalidPassword,
//             backgroundColor: Colors.red,
//           );
//         } else {
//           AppUtils.showToast(loginErrorResponse.msg.toString(),
//               backgroundColor: Colors.red);
//         }
//       } else {
//         if (response['data']['data'] != null) {
//           loginResponse = LoginResponseModel.fromJson(response['data']);
//           // Store the access-token in local storage
//           await _prefs.setString(
//               Constants.accessToken, loginResponse.data!.accessToken!);
//           await _prefs.setInt(
//               Constants.accessTokenExpireTime, loginResponse.data!.expiresIn!);
//           await _prefs.setString(
//               Constants.refreshToken, loginResponse.data!.refreshToken!);
//           await _prefs.setInt(Constants.refreshTokenExpireTime,
//               loginResponse.data!.refreshExpiresIn!);
//           await _prefs.setString(
//               Constants.keycloakId, loginResponse.data!.keycloakId!);
//           await _prefs.setString(
//               Constants.sessionId, loginResponse.data!.sessionState!);
//           await _prefs.setString(Constants.agentRef, event.userId!);
//           await _prefs.setString(Constants.userId, event.userId!);
//           Singleton.instance.accessToken = loginResponse.data!.accessToken!;
//           Singleton.instance.refreshToken = loginResponse.data!.refreshToken!;
//           Singleton.instance.sessionID = loginResponse.data!.sessionState!;
//           Singleton.instance.agentRef = event.userId!;

//           if (loginResponse.data!.accessToken != null) {
//             // Execute agent detail URl to get Agent details
//             final Map<String, dynamic> agentDetail =
//                 await APIRepository.apiRequest(
//                     APIRequestType.get, HttpUrl.agentDetailUrl + event.userId!);

//             if (agentDetail['success'] == false) {
//               // Here facing error so close the loading
//               yield SignInLoadedState();
//               if (agentDetail['data'] is String) {
//                 AppUtils.showToast(agentDetail['data'],
//                     backgroundColor: Colors.red);
//               }
//               final AgentDetailErrorModel agentDetailError =
//                   AgentDetailErrorModel.fromJson(agentDetail['data']);

//               AppUtils.showToast(agentDetailError.msg!,
//                   backgroundColor: Colors.red);
//             } else {
//               // getting Agent Details
//               final agentDetails =
//                   AgentDetailsModel.fromJson(agentDetail['data']);
//               // chech agent type COLLECTOR or TELECALLER then store agent-type in local storage
//               if (agentDetails.status == 200) {
//                 if (agentDetails.data!.first.agentType == 'COLLECTOR') {
//                   await _prefs.setString(
//                       Constants.userType, Constants.fieldagent);
//                   Singleton.instance.usertype = Constants.fieldagent;
//                 } else {
//                   await _prefs.setString(
//                       Constants.userType, Constants.telecaller);
//                   Singleton.instance.usertype = Constants.telecaller;
//                 }
//                 // here storing all agent details in local storage
//                 if (agentDetails.data!.first.agentType != null) {
//                   Singleton.instance.agentName =
//                       agentDetails.data!.first.agentName!;
//                   await _prefs.setString(
//                       Constants.agentName, agentDetails.data!.first.agentName!);
//                   await _prefs.setString(
//                       Constants.mobileNo, agentDetails.data!.first.mobNo!);
//                   await _prefs.setString(
//                       Constants.email, agentDetails.data!.first.email!);
//                   await _prefs.setString(Constants.contractor,
//                       agentDetails.data!.first.contractor!);
//                   Singleton.instance.contractor =
//                       agentDetails.data!.first.contractor!;
//                   await _prefs.setString(
//                       Constants.status, agentDetails.data!.first.status!);
//                   await _prefs.setString(Constants.code, agentDetails.code!);
//                   await _prefs.setBool(
//                       Constants.userAdmin, agentDetails.data!.first.userAdmin!);

//                   yield SignInCompletedState();

//                   // Here call share device info api
//                   Map<String, dynamic> deviceData = <String, dynamic>{};

//                   try {
//                     if (Platform.isAndroid) {
//                       deviceData = _readAndroidBuildData(
//                           await deviceInfoPlugin.androidInfo);
//                     } else if (Platform.isIOS) {
//                       deviceData =
//                           _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
//                     }
//                   } on PlatformException {
//                     deviceData = <String, dynamic>{
//                       'Error:': 'Failed to get platform version.'
//                     };
//                   }
//                   _deviceData = deviceData;

//                   if (_deviceData.isNotEmpty) {
//                     try {
//                       if (Platform.isAndroid) {
//                         final requestBodyData = AndoridDeviceInfoModel(
//                           board: _deviceData['board'],
//                           bootloader: _deviceData['bootloader'],
//                           brand: _deviceData['brand'],
//                           device: _deviceData['device'],
//                           dislay: _deviceData['display'],
//                           fingerprint: _deviceData['fingerprint'],
//                           hardware: _deviceData['hardware'],
//                           host: _deviceData['host'],
//                           id: _deviceData['id'],
//                           manufacturer: _deviceData['manufacturer'],
//                           model: _deviceData['model'],
//                           product: _deviceData['product'],
//                           supported32BitAbis: _deviceData['supported32BitAbis'],
//                           supported64BitAbis: _deviceData['supported64BitAbis'],
//                           supportedAbis: _deviceData['supportedAbis'],
//                           tags: _deviceData['tags'],
//                           type: _deviceData['type'],
//                           isPhysicalDevice:
//                               _deviceData['isPhysicalDevice'] as bool,
//                           androidId: _deviceData['androidId'],
//                           systemFeatures: [],
//                           version: Version(
//                             securityPatch: _deviceData['version.securityPatch'],
//                             sdkInt: _deviceData['version.sdkInt'].toString(),
//                             previewSdkInt:
//                                 _deviceData['version.previewSdkInt'].toString(),
//                             codename: _deviceData['version.codename'],
//                             release: _deviceData['version.release'],
//                             incremental: _deviceData['version.incremental'],
//                             baseOs: _deviceData['version.baseOS'],
//                           ),
//                         );
//                         await APIRepository.apiRequest(
//                           APIRequestType.post,
//                           HttpUrl.mobileInfoUrl,
//                           requestBodydata: jsonEncode(requestBodyData.toJson()),
//                         );
//                       } else if (Platform.isIOS) {
//                         final requestBodyData = IOSDeviceInfoModel(
//                           name: _deviceData['name'],
//                           systemName: _deviceData['systemName'],
//                           systemVersion: _deviceData['systemVersion'],
//                           model: _deviceData['model'],
//                           localizedModel: _deviceData['localizedModel'],
//                           identifierForVendor:
//                               _deviceData['identifierForVendor'],
//                           isPhysicalDevice: _deviceData['isPhysicalDevice'],
//                           utsname: Utsname(
//                             sysname: _deviceData['utsname.sysname:'],
//                             nodename: _deviceData['utsname.nodename:'],
//                             release: _deviceData['utsname.release:'],
//                             version: _deviceData['utsname.version:'],
//                             machine: _deviceData['utsname.machine:'],
//                           ),
//                           created: _deviceData['utsname.sysname'],
//                         );
//                         await APIRepository.apiRequest(
//                           APIRequestType.post,
//                           HttpUrl.mobileInfoUrl,
//                           requestBodydata: jsonEncode(requestBodyData.toJson()),
//                         );
//                       }
//                       // AppUtils.showErrorToast('Success Getting devide info');
//                     } on PlatformException {
//                       AppUtils.showErrorToast('Error Getting devide info');
//                     }
//                   } else {
//                     AppUtils.showErrorToast('Device info is empty!');
//                   }

//                   await Future.delayed(const Duration(milliseconds: 100));

//                   yield HomeTabState();
//                 }
//               } else {
//                 yield SignInLoadedState();
//                 AppUtils.showToast(agentDetails.msg!,
//                     backgroundColor: Colors.red);
//               }
//             }
//           }
//         } else {
//           loginErrorResponse = LoginErrorMessage.fromJson(response['data']);
//           yield SignInLoadedState();
//           AppUtils.showToast(loginErrorResponse.msg.toString(),
//               backgroundColor: Colors.red);
//         }
//       }
//     }

//     if (event is ResendOTPEvent) {
//       yield ResendOTPState();
//     }

//     if (event is NoInternetConnectionEvent) {
//       yield NoInternetConnectionState();
//     }
//   }
// }

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info/device_info.dart';
// import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:origa/http/api_repository.dart';
import 'package:origa/http/httpurls.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/main.dart';
import 'package:origa/models/agent_detail_error_model.dart';
import 'package:origa/models/agent_details_model.dart';
import 'package:origa/models/agent_information_model.dart';
import 'package:origa/models/device_info_model/android_device_info.dart';
import 'package:origa/models/device_info_model/ios_device_model.dart';
import 'package:origa/models/login_error_model.dart';
import 'package:origa/models/login_response.dart';
import 'package:origa/models/profile_api_result_model/profile_api_result_model.dart';
import 'package:origa/singleton.dart';
import 'package:origa/utils/app_utils.dart';
import 'package:origa/utils/base_equatable.dart';
import 'package:origa/utils/constants.dart';
import 'package:origa/utils/preference_helper.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitialState());

  bool isAnimating = true;
  bool isSubmit = true;
  bool isLoading = false;
  bool isLoaded = false;

  // share device info
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  Map<String, dynamic> _deviceData = <String, dynamic>{};

  Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'version.securityPatch': build.version.securityPatch,
      'version.sdkInt': build.version.sdkInt,
      'version.release': build.version.release,
      'version.previewSdkInt': build.version.previewSdkInt,
      'version.incremental': build.version.incremental,
      'version.codename': build.version.codename,
      'version.baseOS': build.version.baseOS,
      'board': build.board,
      'bootloader': build.bootloader,
      'brand': build.brand,
      'device': build.device,
      'display': build.display,
      'fingerprint': build.fingerprint,
      'hardware': build.hardware,
      'host': build.host,
      'id': build.id,
      'manufacturer': build.manufacturer,
      'model': build.model,
      'product': build.product,
      'supported32BitAbis': build.supported32BitAbis,
      'supported64BitAbis': build.supported64BitAbis,
      'supportedAbis': build.supportedAbis,
      'tags': build.tags,
      'type': build.type,
      'isPhysicalDevice': build.isPhysicalDevice,
      'androidId': build.androidId,
      'systemFeatures': build.systemFeatures,
    };
  }

  Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data) {
    return <String, dynamic>{
      'name': data.name,
      'systemName': data.systemName,
      'systemVersion': data.systemVersion,
      'model': data.model,
      'localizedModel': data.localizedModel,
      'identifierForVendor': data.identifierForVendor,
      'isPhysicalDevice': data.isPhysicalDevice,
      'utsname.sysname:': data.utsname.sysname,
      'utsname.nodename:': data.utsname.nodename,
      'utsname.release:': data.utsname.release,
      'utsname.version:': data.utsname.version,
      'utsname.machine:': data.utsname.machine,
    };
  }

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginInitialEvent) {
      Singleton.instance.buildContext = event.context;
      if (ConnectivityResult.none == await Connectivity().checkConnectivity()) {
        yield NoInternetConnectionState();
      }
    }

    LoginResponseModel loginResponse = LoginResponseModel();

    LoginErrorMessage loginErrorResponse = LoginErrorMessage();

    if (event is SignInEvent) {
      // started the sign in loading
      yield SignInLoadingState();
      // final SharedPreferences _prefs = await SharedPreferences.getInstance();
      debugPrint(event.paramValue);
      final Map<String, dynamic> response = await APIRepository.apiRequest(
          APIRequestType.post, HttpUrl.loginUrl,
          requestBodydata: {'encryptedData': event.paramValue});

      if (response['success'] == false) {
        yield SignInLoadedState();
        AppUtils.showToast(response['message'], backgroundColor: Colors.red);
      } else if (response['statusCode'] == 401) {
        loginErrorResponse = LoginErrorMessage.fromJson(response['data']);
        // if SignIn error to show again SignIn button
        yield SignInLoadedState();
        if (loginErrorResponse.msg ==
            'Invalid Credentails, Please contact the administrator') {
          AppUtils.showToast(
            Languages.of(event.context)!.userIDDoesNotExist,
            backgroundColor: Colors.red,
          );
        } else if (loginErrorResponse.msg ==
            'Invalid password, Please enter correct password') {
          AppUtils.showToast(
            Languages.of(event.context)!.invalidPassword,
            backgroundColor: Colors.red,
          );
        } else {
          AppUtils.showToast(loginErrorResponse.msg.toString(),
              backgroundColor: Colors.red);
        }
      } else {
        if (response['data']['result'] != null) {
          loginResponse = LoginResponseModel.fromJson(response['data']);
          if(loginResponse.data?.setPassword == true){
            yield SetPasswordState(name: event.userId);
          }
          // Store the access-token in local storage
          // await _prefs.setString(
          //     Constants.accessToken, loginResponse.data!.accessToken!);
          await PreferenceHelper.setPreference(
              Constants.accessToken, loginResponse.data?.accessToken ?? '');
          await PreferenceHelper.setPreference(Constants.accessTokenExpireTime,
              loginResponse.data?.expiresIn ?? '');
          await PreferenceHelper.setPreference(
              Constants.refreshToken, loginResponse.data?.refreshToken ?? '');
          await PreferenceHelper.setPreference(Constants.refreshTokenExpireTime,
              loginResponse.data?.refreshExpiresIn ?? '');
          // await PreferenceHelper.setPreference(
          //     Constants.keycloakId, loginResponse.data!.keycloakId!);
          await PreferenceHelper.setPreference(
              Constants.sessionId, loginResponse.data?.sessionState ?? '');
          await PreferenceHelper.setPreference(
              Constants.agentRef, event.userId!);
          await PreferenceHelper.setPreference(Constants.userId, event.userId!);
          Singleton.instance.accessToken =
              loginResponse.data?.accessToken ?? '';
          Singleton.instance.refreshToken =
              loginResponse.data?.refreshToken ?? '';
          Singleton.instance.sessionID = loginResponse.data?.sessionState ?? '';
          Singleton.instance.agentRef = event.userId!;
          await PreferenceHelper.getString(keyPair: Constants.agentRef)
              .then((value) {
            Singleton.instance.agentRef = value;
          });
          // Singleton.instance.agentRef =
          //     PreferenceHelper.getString(keyPair: Constants.agentRef)
          //         .toString();

          if (loginResponse.data?.accessToken != null) {
            // Here check mpin flow show or not (offline or Online)

            final Map<String, dynamic> getProfileData =
                await APIRepository.apiRequest(
                    APIRequestType.get, HttpUrl.profileUrl,
                    encrypt: true);
            if (getProfileData['success']) {
              yield SignInCompletedState();
              final Map<String, dynamic> jsonData = getProfileData['data'];
              print(jsonData);
              final profileAPIValue = ProfileApiModel.fromJson(jsonData);
              Singleton.instance.usertype = Constants.telecaller;
              if (profileAPIValue.result!.first.type == 'COLLECTOR') {
                Singleton.instance.isOfflineEnabledContractorBased =
                    profileAPIValue.enableOffline!;
                await PreferenceHelper.setPreference(
                    Constants.isOfflineStorage, profileAPIValue.enableOffline!);
                Singleton.instance.usertype = Constants.fieldagent;
              }

              /* Here (profileAPIValue.result!.first.type == 'COLLECTOR') mean collector is field agent
              Filed agent only having offline concept - When app is going to work with offline app required mPin flow */
              if (Singleton.instance.isOfflineEnabledContractorBased &&
                  Singleton.instance.usertype == Constants.fieldagent) {
                // FirebaseDatabase.instanceFor(app: firebaseApp).setPersistenceEnabled(true);
                if (getProfileData['success']) {
                  yield EnterSecurePinState(
                      securePin: profileAPIValue.result?.first.mPin,
                      userName: profileAPIValue.result?.first.aRef);
                }
              } else {
                yield TriggerHomeTabState();
              }
            } else {
            }
          }
        } else {
          loginErrorResponse = LoginErrorMessage.fromJson(response['data']);
          yield SignInLoadedState();
          AppUtils.showToast(loginErrorResponse.msg.toString(),
              backgroundColor: Colors.red);
        }
      }
    }
    if (event is ResendOTPEvent) {
      yield ResendOTPState();
    }
    if (event is TriggeredHomeTabEvent) {
      yield SignInLoadingState();
      // Execute agent detail URl to get Agent details
      debugPrint('Agent type--> TriggeredHomeTabEvent');
      debugPrint(
          'Singleton.instance.accessToken Login bloc ${Singleton.instance.accessToken}');
      debugPrint(
          'Singleton.instance.accessToken Login bloc ${Singleton.instance.refreshToken}');
      debugPrint(
          'Singleton.instance.accessToken Login bloc ${Singleton.instance.sessionID}');
      debugPrint(
          'Singleton.instance.accessToken Login bloc ${Singleton.instance.sessionID}');

      // final Map<String, dynamic> agentDetail = await APIRepository.apiRequest(
      //     APIRequestType.get, HttpUrl.agentDetailUrl + event.userId);


      /** Agent Details*/
      final Map<String, dynamic> agentDetail = await APIRepository.apiRequest(
          APIRequestType.get,
          HttpUrl.agentInformation + 'aRef=${event.userId}',encrypt: true);

      if (agentDetail['success'] == false) {
        // Here facing error so close the loading
        yield SignInLoadedState();
        if (agentDetail['data'] is String) {
          AppUtils.showToast(agentDetail['data'], backgroundColor: Colors.red);
        }
        final AgentDetailErrorModel agentDetailError =
            AgentDetailErrorModel.fromJson(agentDetail['data']);

        AppUtils.showToast(agentDetailError.msg!, backgroundColor: Colors.red);
      } else {
        yield SignInCompletedState();

        // getting Agent Details
        final agentDetails = AgentInformation.fromJson(agentDetail['data']);
        Singleton.instance.agentDetailsInfo =
            AgentInformation.fromJson(agentDetail['data']);
        // each agent type COLLECTOR or TELECALLER then store agent-type in local storage
        if (agentDetails.status == 200) {
          if (agentDetails.result!.first.type == 'COLLECTOR') {
            await PreferenceHelper.setPreference(
                Constants.userType, Constants.fieldagent);
            Singleton.instance.usertype = Constants.fieldagent;
          } else {
            await PreferenceHelper.setPreference(
                Constants.userType, Constants.telecaller);
            Singleton.instance.usertype = Constants.telecaller;
          }
          // here storing all agent details in local storage
          debugPrint('Agent type--> ${agentDetails.result!.first.type}');
          if (agentDetails.result!.first.type != null) {
            Singleton.instance.agentName = agentDetails.result!.first.name!;
            await PreferenceHelper.setPreference(
                Constants.agentName, agentDetails.result!.first.name!);
            // await PreferenceHelper.setPreference(
            //     Constants.mobileNo, agentDetails.result!.first.!);
            // await PreferenceHelper.setPreference(
            //     Constants.email, agentDetails.result!.first.!);
            await PreferenceHelper.setPreference(
                Constants.contractor, agentDetails.result!.first.contractor!);
            Singleton.instance.contractor =
                agentDetails.result!.first.contractor!;
            await PreferenceHelper.setPreference(
                Constants.status, agentDetails.result!.first.status!);
            // await PreferenceHelper.setPreference(
            //     Constants.code, agentDetails.result.first!);
            await PreferenceHelper.setPreference(
                Constants.userAdmin, agentDetails.result!.first.userAdmin!);


            /** Here call share device info api*/
            Map<String, dynamic> deviceData = <String, dynamic>{};

            try {
              if (Platform.isAndroid) {
                deviceData =
                    _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
              } else if (Platform.isIOS) {
                deviceData = _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
              }
            } on PlatformException {
              deviceData = <String, dynamic>{
                'Error:': 'Failed to get platform version.'
              };
            }
            _deviceData = deviceData;

            if (_deviceData.isNotEmpty) {
              try {
                if (Platform.isAndroid) {
                  final requestBodyData = AndoridDeviceInfoModel(
                    board: _deviceData['board'],
                    bootloader: _deviceData['bootloader'],
                    brand: _deviceData['brand'],
                    device: _deviceData['device'],
                    dislay: _deviceData['display'],
                    fingerprint: _deviceData['fingerprint'],
                    hardware: _deviceData['hardware'],
                    host: _deviceData['host'],
                    id: _deviceData['id'],
                    manufacturer: _deviceData['manufacturer'],
                    model: _deviceData['model'],
                    product: _deviceData['product'],
                    supported32BitAbis: _deviceData['supported32BitAbis'],
                    supported64BitAbis: _deviceData['supported64BitAbis'],
                    supportedAbis: _deviceData['supportedAbis'],
                    tags: _deviceData['tags'],
                    type: _deviceData['type'],
                    isPhysicalDevice: _deviceData['isPhysicalDevice'] as bool,
                    androidId: _deviceData['androidId'],
                    systemFeatures: [],
                    version: Version(
                      securityPatch: _deviceData['version.securityPatch'],
                      sdkInt: _deviceData['version.sdkInt'].toString(),
                      previewSdkInt:
                          _deviceData['version.previewSdkInt'].toString(),
                      codename: _deviceData['version.codename'],
                      release: _deviceData['version.release'],
                      incremental: _deviceData['version.incremental'],
                      baseOs: _deviceData['version.baseOS'],
                    ),
                  );
                  await APIRepository.apiRequest(
                    APIRequestType.post,
                    HttpUrl.mobileInfoUrl,
                    requestBodydata: requestBodyData,
                  );
                } else if (Platform.isIOS) {
                  final requestBodyData = IOSDeviceInfoModel(
                    name: _deviceData['name'],
                    systemName: _deviceData['systemName'],
                    systemVersion: _deviceData['systemVersion'],
                    model: _deviceData['model'],
                    localizedModel: _deviceData['localizedModel'],
                    identifierForVendor: _deviceData['identifierForVendor'],
                    isPhysicalDevice: _deviceData['isPhysicalDevice'],
                    utsname: Utsname(
                      sysname: _deviceData['utsname.sysname:'],
                      nodename: _deviceData['utsname.nodename:'],
                      release: _deviceData['utsname.release:'],
                      version: _deviceData['utsname.version:'],
                      machine: _deviceData['utsname.machine:'],
                    ),
                    created: _deviceData['utsname.sysname'],
                  );
                  await APIRepository.apiRequest(
                    APIRequestType.post,
                    HttpUrl.mobileInfoUrl,
                    requestBodydata: requestBodyData,
                  );
                }
                // AppUtils.showErrorToast('Success Getting devide info');
              } on PlatformException {
                AppUtils.showErrorToast('Error Getting device info');
              }
            } else {
              AppUtils.showErrorToast('Device info is empty!');
            }

            await Future.delayed(const Duration(milliseconds: 100));

            // For Secure Pin Flow API Call
            // Get the Secure Pin

            // yield HomeTabState();
          }
        } else {
          yield SignInLoadedState();
          AppUtils.showToast(agentDetails.message!,
              backgroundColor: Colors.red);
        }
      }
      yield HomeTabState();
    }
    if (event is NoInternetConnectionEvent) {
      yield NoInternetConnectionState();
    }
  }
}
