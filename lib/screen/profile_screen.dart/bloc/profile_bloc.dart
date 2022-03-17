import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:origa/http/api_repository.dart';
import 'package:origa/http/httpurls.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/models/language_model.dart';
import 'package:origa/models/notification_model.dart';
import 'package:origa/models/profile_api_result_model/profile_api_result_model.dart';
import 'package:origa/singleton.dart';
import 'package:origa/utils/app_utils.dart';
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

  List<NotificationMainModel> notificationList = [];
  List<LanguageModel> languageList = [];
  String? userType;
  dynamic languageValue = PreferenceHelper.getPreference('mainLanguage');
  bool isProfileImageUpdating = false;
  File? image;
// customer language preference data
  List<CustomerLanguagePreferenceModel> customerLanguagePreferenceList = [];

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is ProfileInitialEvent) {
      yield ProfileLoadingState();

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
            APIRequestType.get, HttpUrl.profileUrl);

        if (getProfileData['success']) {
          Map<String, dynamic> jsonData = getProfileData['data'];
          profileAPIValue = ProfileApiModel.fromJson(jsonData);
        } else if (getProfileData['statusCode'] == 401 ||
            getProfileData['data'] == Constants.connectionTimeout ||
            getProfileData['statusCode'] == 502) {
          isNoInternetAndServerError = true;
          noInternetAndServerErrorMsg = getProfileData['data'];
        }
      }

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

    if (event is CustomerLaunguagePrefrerenceEvent) {
      customerLanguagePreferenceList = [
        CustomerLanguagePreferenceModel(
            language: Languages.of(event.context)!.tamilLang,
            languageCode: Constants.tamilLangCode),
        CustomerLanguagePreferenceModel(
            language: Languages.of(event.context)!.hindiLang,
            languageCode: Constants.hindiLangCode),
        CustomerLanguagePreferenceModel(
            language: Languages.of(event.context)!.kannadaLang,
            languageCode: Constants.kannadaLangCode),
        CustomerLanguagePreferenceModel(
            language: Languages.of(event.context)!.teluguLang,
            languageCode: Constants.teluguLangCode),
        CustomerLanguagePreferenceModel(
            language: Languages.of(event.context)!.malayalamLang,
            languageCode: Constants.malayalamLangCode),
        CustomerLanguagePreferenceModel(
            language: Languages.of(event.context)!.bengaliLang,
            languageCode: Constants.bengaliLangCode),
        CustomerLanguagePreferenceModel(
            language: Languages.of(event.context)!.gujaratiLang,
            languageCode: Constants.gujaratiLangCode),
        CustomerLanguagePreferenceModel(
            language: Languages.of(event.context)!.panjabiLang,
            languageCode: Constants.panjabiLangCode),
        CustomerLanguagePreferenceModel(
            language: Languages.of(event.context)!.marathiLang,
            languageCode: Constants.marathiLangCode),
        CustomerLanguagePreferenceModel(
            language: Languages.of(event.context)!.urduLang,
            languageCode: Constants.urduLangCode),
      ];

      yield CustomerLaunguagePrefrerenceState();
    }

    if (event is ClickChangePassswordEvent) {
      yield ClickChangePasswordState();
    }
    if (event is ClickChangeSecurityPinEvent) {
      yield ClickChangeSecurityPinState();
    }
    if (event is ClickMessageEvent) {
      yield ClickMessageState(
        fromId: event.fromId,
        toId: event.toId,
      );
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
      await _prefs.setString('addressValue', "");
      await _prefs.setBool('areyouatOffice', true);
      // await _prefs.setBool(Constants.rememberMe, false);
      yield LoginState();
    }
    if (event is ClickMarkAsHomeEvent) {
      yield ClickMarkAsHomeState();
    }

    if (event is PostProfileImageEvent) {
      isProfileImageUpdating = true;
      Map<String, dynamic> postResult = await APIRepository.apiRequest(
        APIRequestType.singleFileUpload,
        HttpUrl.changeProfileImage,
        imageFile: event.postValue,
      );
      if (postResult[Constants.success]) {
        isProfileImageUpdating = false;
        yield PostDataApiSuccessState();
      } else {
        isProfileImageUpdating = false;
        image = null;
        AppUtils.showErrorToast('Uploding Failed!');
      }
    }
  }
}
