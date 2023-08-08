import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:origa/http/api_repository.dart';
import 'package:origa/http/httpurls.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/models/chat_history.dart';
import 'package:origa/models/language_model.dart';
import 'package:origa/models/notification_model.dart';
import 'package:origa/models/profile_api_result_model/profile_api_result_model.dart';
import 'package:origa/singleton.dart';
import 'package:origa/utils/app_utils.dart';
import 'package:origa/utils/base_equatable.dart';
import 'package:origa/utils/constants.dart';
import 'package:origa/utils/preference_helper.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial());

  ProfileApiModel profileAPIValue = ProfileApiModel();

  // it's manage the Refresh the page basaed on Internet connection
  bool isNoInternetAndServerError = false;
  String? noInternetAndServerErrorMsg = '';

  List<NotificationMainModel> notificationList = <NotificationMainModel>[];
  List<LanguageModel> languageList = [];
  // String? userType;
  bool isProfileImageUpdating = false;
  File? image;
  ChatHistoryModel chatHistoryData = ChatHistoryModel();
  int newMsgCount = 0;

  String? authorizationLetter;
  String? idCardFront;
  String? idCardBack;

// customer language preference data
  List<CustomerLanguagePreferenceModel> customerLanguagePreferenceList = [];

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is ProfileInitialEvent) {
      yield ProfileLoadingState();
      Singleton.instance.buildContext = event.context;

      if (ConnectivityResult.none == await Connectivity().checkConnectivity()) {
        isNoInternetAndServerError = true;
        noInternetAndServerErrorMsg =
            Languages.of(event.context)!.noInternetConnection;
        yield NoInternetState();
      } else {
        isNoInternetAndServerError = false;
        final Map<String, dynamic> getProfileData =
            await APIRepository.apiRequest(
                APIRequestType.get, HttpUrl.profileUrl,encrypt: true);

        if (getProfileData['success']) {
          final Map<String, dynamic> jsonData = getProfileData['data'];
          profileAPIValue = ProfileApiModel.fromJson(jsonData);
        } else if (getProfileData['statusCode'] == 401 ||
            getProfileData['data'] == Constants.connectionTimeout ||
            getProfileData['statusCode'] == 502) {
          isNoInternetAndServerError = true;
          noInternetAndServerErrorMsg = getProfileData['data'];
        }
      }
      await PreferenceHelper.getString(keyPair: Constants.agentRef)
          .then((value) {
        Singleton.instance.agentRef = value;
      });
      yield ProfileLoadedState();
    }
    if (event is ClickNotificationEvent) {
      yield ClickNotificationState();
    }

    if (event is ClickChangeLaunguageEvent) {
      yield ClickChangeLaunguageState();
    }

    if (event is ClickAuthorizationLetterEvent) {
      if (ConnectivityResult.none == await Connectivity().checkConnectivity()) {
        yield NoInternetState();
      } else {
        yield AuthorizationLoadingState();

        final Map<String, dynamic> getAuthorizationLetter =
            await APIRepository.apiRequest(
                APIRequestType.get, HttpUrl.authorizationLetter,encrypt: true);
        if (getAuthorizationLetter[Constants.success]) {
          final Map<String, dynamic> jsonData = getAuthorizationLetter['data'];
          authorizationLetter = jsonData['result'].toString();
          // AppUtils.showErrorToast(jsonData['result']['message']);
        }
        yield ClickAuthorizationLetterState();
      }
      yield ProfileLoadedState();
    }

    if (event is ClickIDCardEvent) {
      if (ConnectivityResult.none == await Connectivity().checkConnectivity()) {
        yield NoInternetState();
      } else {
        yield AuthorizationLoadingState();

        final Map<String, dynamic> getIdCardFront =
            await APIRepository.apiRequest(
                APIRequestType.get, HttpUrl.idCardFront,encrypt: true);
        if (getIdCardFront[Constants.success]) {
          final Map<String, dynamic> idCardFrontData = getIdCardFront['data'];
          // AppUtils.showErrorToast(idCardFrontData['result']['message']);
          idCardFront = idCardFrontData['result'].toString();
        }

        final Map<String, dynamic> getIdCardBack =
            await APIRepository.apiRequest(
                APIRequestType.get, HttpUrl.idCardBack,encrypt: true);
        if (getIdCardBack[Constants.success]) {
          final Map<String, dynamic> idCardBackData = getIdCardBack['data'];
          idCardBack = idCardBackData['result'].toString();
        }
        yield ClickIDCardState();
      }
      yield ProfileLoadedState();
    }

    if (event is SwitchCardEvent) {
      yield SwitchCardState();
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
      yield ProfileLoadingState();
      Singleton.instance.isOfflineStorageFeatureEnabled = false;
      await FirebaseFirestore.instance.terminate();
      // await _prefs.clear();
      await PreferenceHelper.setPreference(Constants.accessToken, '');
      await PreferenceHelper.setPreference(Constants.userType, '');
      await PreferenceHelper.setPreference(
          Constants.appDataLoadedFromFirebase, false);
      await PreferenceHelper.setPreference(
          Constants.appDataLoadedFromFirebaseTime, '');
      await PreferenceHelper.setPreference('addressValue', '');
      await PreferenceHelper.setPreference('areyouatOffice', true);
      yield LoginState();
    }
    if (event is ClickMarkAsHomeEvent) {
      yield ClickMarkAsHomeState();
    }

    if (event is PostProfileImageEvent) {
      isProfileImageUpdating = true;
      final Map<String, dynamic> postResult = await APIRepository.apiRequest(
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
