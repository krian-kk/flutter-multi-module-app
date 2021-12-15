import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:origa/http/api_repository.dart';
import 'package:origa/http/httpurls.dart';
import 'package:origa/models/language_model.dart';
import 'package:origa/models/notification_model.dart';
import 'package:origa/models/profile_api_result_model/result.dart';
import 'package:origa/offline_helper/dynamic_table.dart';
import 'package:origa/utils/base_equatable.dart';
import 'package:origa/utils/constants.dart';
import 'package:origa/utils/preference_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial());

  // For Offline Purpose
  ProfileResultModel offlineProfileValue = ProfileResultModel();
  Future<Box<OrigoMapDynamicTable>> profileHiveBox =
      Hive.openBox<OrigoMapDynamicTable>('ProfileHiveApiResultsBox');

  List<NotificationMainModel> notificationList = [];
  List<LanguageModel> languageList = [];
  String? userType;
  dynamic languageValue = PreferenceHelper.getPreference('mainLanguage');

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is ProfileInitialEvent) {
      yield ProfileLoadingState();

      SharedPreferences _pref = await SharedPreferences.getInstance();
      userType = _pref.getString('userType');

      if (ConnectivityResult.none == await Connectivity().checkConnectivity()) {
        yield NoInternetState();
      } else {
        Map<String, dynamic> getProfileData = await APIRepository.apiRequest(
            APIRequestType.GET, HttpUrl.profileUrl);

        if (getProfileData['success']) {
          Map<String, dynamic> jsonData = getProfileData['data'];

          profileHiveBox.then((value) => value.put(
              'EventDetails1',
              OrigoMapDynamicTable(
                status: jsonData['status'],
                message: jsonData['message'],
                result: jsonData['result'][0],
              )));
        } else {
          // message = weatherData["data"];
          // yield SevenDaysFailureState();
        }
      }
      await profileHiveBox.then(
        (value) => offlineProfileValue = ProfileResultModel.fromJson(
            Map<String, dynamic>.from(value.get('EventDetails1')!.result)),
      );

      // print(
      //     'Offline Profile Value => ${jsonEncode(offlineProfileValue.address?.last)}');

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
      await _prefs.clear();
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
  // {
  //   on<ProfileEvent>((event, emit) {
  //     if (event is ProfileInitialEvent) {
  //       profileNavigationList.addAll([
  //         ProfileNavigation('Notification'),
  //         ProfileNavigation('Change language'),
  //         ProfileNavigation('Change Password')
  //       ]);
  //     }
  //   });
  // }
}
