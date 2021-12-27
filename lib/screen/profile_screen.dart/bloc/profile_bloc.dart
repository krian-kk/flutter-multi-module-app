import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:origa/http/api_repository.dart';
import 'package:origa/http/httpurls.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/models/language_model.dart';
import 'package:origa/models/notification_model.dart';
import 'package:origa/models/profile_api_result_model/profile_api_result_model.dart';
import 'package:origa/models/profile_api_result_model/result.dart';
import 'package:origa/offline_helper/dynamic_table.dart';
import 'package:origa/singleton.dart';
import 'package:origa/utils/base_equatable.dart';
import 'package:origa/utils/constants.dart';
import 'package:origa/utils/preference_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial());

  ProfileApiModel profileAPIValue = ProfileApiModel();
  // it's manage the Refresh the page basaed on Internet connection
  bool isNoInternetAndServerError = false;
  String? noInternetAndServerErrorMsg = '';
  // ProfileResultModel offlineProfileValue = ProfileResultModel();
  // Future<Box<OrigoMapDynamicTable>> profileHiveBox =
  //     Hive.openBox<OrigoMapDynamicTable>('ProfileHiveApiResultsBox');

  List<NotificationMainModel> notificationList = [];
  List<LanguageModel> languageList = [];
  String? userType;
  dynamic languageValue = PreferenceHelper.getPreference('mainLanguage');

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is ProfileInitialEvent) {
      yield ProfileLoadingState();
      print('Authorized Token => ${Singleton.instance.accessToken}');

      SharedPreferences _pref = await SharedPreferences.getInstance();
      userType = _pref.getString(Constants.userType);
      Singleton.instance.buildContext = event.context;

      if (ConnectivityResult.none == await Connectivity().checkConnectivity()) {
        isNoInternetAndServerError = true;
        noInternetAndServerErrorMsg =
            Languages.of(event.context)!.noInternetConnection;
        yield NoInternetState();
      } else {
        isNoInternetAndServerError = false;
        Map<String, dynamic> getProfileData = await APIRepository.apiRequest(
            APIRequestType.GET, HttpUrl.profileUrl);

        if (getProfileData['success']) {
          Map<String, dynamic> jsonData = getProfileData['data'];
          profileAPIValue = ProfileApiModel.fromJson(jsonData);

          // profileHiveBox.then((value) => value.put(
          //     'EventDetails1',
          //     OrigoMapDynamicTable(
          //       status: jsonData['status'],
          //       message: jsonData['message'],
          //       result: jsonData['result'][0],
          //     )));
        } else if (getProfileData['statusCode'] == 401 ||
            getProfileData['statusCode'] == 502) {
          isNoInternetAndServerError = true;
          noInternetAndServerErrorMsg = getProfileData['data'];
        }
      }
      // await profileHiveBox.then(
      //   (value) => offlineProfileValue = ProfileResultModel.fromJson(
      //       Map<String, dynamic>.from(value.get('EventDetails1')!.result)),
      // );

      notificationList.addAll([
        NotificationMainModel('Today Sep 15   7:04 PM', [
          NotificationChildModel('Mr. Debashish Sr. Manager',
              'Hi, Check Case Details with all in pincode 600054 .')
        ]),
        NotificationMainModel('Yesterday Sep 14   7:04 PM', [
          NotificationChildModel('Mr. Debashish Sr. Manager',
              'Hi, Check Case Details with all in pincode 600054 .'),
          NotificationChildModel('Mr. Debashish Sr. Manager',
              'Hi, Check Case Details with all in pincode 600054 .')
        ]),
      ]);
      yield ProfileLoadedState();
    }
    if (event is ClickNotificationEvent) {
      yield ClickNotificationState();
    }
    if (event is ClickChangeLaunguageEvent) {
      yield ClickChangeLaunguageState();
    }
    if (event is ClickChangePassswordEvent) {
      yield ClickChangePasswordState();
    }
    if (event is ClickMessageEvent) {
      yield ClickMessageState();
    }
    if (event is ChangePasswordEvent) {
      yield ClickChangePasswordState();
    }
    if (event is ChangeProfileImageEvent) {
      yield ChangeProfileImageState();
    }
    if (event is LoginEvent) {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      await _prefs.setString(Constants.accessToken, "");
      await _prefs.setString(Constants.userType, "");
      // await _prefs.setBool(Constants.rememberMe, false);
      yield LoginState();
    }
    if (event is ClickMarkAsHomeEvent) {
      yield ClickMarkAsHomeState();
    }

    if (event is PostProfileImageEvent) {
      Map<String, dynamic> postResult = await APIRepository.apiRequest(
          APIRequestType.POST, HttpUrl.changeProfileImage,
          requestBodydata:
              jsonEncode({"profileImgUrl": event.postValue.toString()}));
      if (postResult[Constants.success]) {
        yield PostDataApiSuccessState();
      }
    }
  }
}
