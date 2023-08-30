import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:domain_models/response_models/profile/profile_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:network_helper/errors/network_exception.dart';
import 'package:network_helper/network_base_models/api_result.dart';
import 'package:network_helper/network_base_models/base_response.dart';
import 'package:origa/models/language_model.dart';
import 'package:origa/utils/base_equatable.dart';
import 'package:origa/utils/constants.dart';
import 'package:preference_helper/preference_constants.dart';
import 'package:repository/file_repository.dart';
import 'package:repository/profile_repository.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({required this.repository, required this.fileRepository})
      : super(ProfileInitial()) {
    on<ProfileEvent>(_onEvent);
  }

  ProfileResponse profileAPIValue = ProfileResponse();

  bool isNoInternetAndServerError = false;
  String? noInternetAndServerErrorMsg = '';

  // List<NotificationMainModel> notificationList = <NotificationMainModel>[];
  List<LanguageModel> languageList = [];

  // String? userType;
  bool isProfileImageUpdating = false;
  File? image;
  late String path;

  // ChatHistoryModel chatHistoryData = ChatHistoryModel();
  int newMsgCount = 0;

  String? authorizationLetter;
  String? idCardFront;
  String? idCardBack;

// customer language preference data
  List<CustomerLanguagePreferenceModel> customerLanguagePreferenceList = [];

  ProfileRepository repository;
  FileRepository fileRepository;

  int? ratioIndex;
  String? setLangCode;

  int? ratioIndexS2T;
  String? setLangCodeS2T;

  Future<void> _onEvent(ProfileEvent event, Emitter<ProfileState> emit) async {
    if (event is ProfileInitialEvent) {
      emit(ProfileLoadingState());
      // // Singleton.instance.buildContext = event.context;

      if (ConnectivityResult.none == await Connectivity().checkConnectivity()) {
        isNoInternetAndServerError = true;
        noInternetAndServerErrorMsg = "NoInternetConnection";
        emit(NoInternetState());
      } else {
        isNoInternetAndServerError = false;
        final ApiResult<ProfileResponse> data =
            await repository.getProfileData();
        await data.when(
            success: (ProfileResponse? data) async {
              profileAPIValue = data!;
              emit(ProfileLoadedState());
            },
            failure: (NetworkExceptions? error) async {});
      }
    }

    if (event is InitialImageTapEvent) {
      emit(ImagePopUpState());
    }

    if (event is InitialImageEvent) {
      isProfileImageUpdating = true;
      path = await fileRepository.selectImageFromMobile(event.imageType);

      final ApiResult<BaseResponse> data = await repository
          .uploadImageToServer(fileRepository.getFileFromPath(path));
      await data.when(success: (BaseResponse? data) async {
        isProfileImageUpdating = false;
        image = fileRepository.getFileFromPath(path);
        emit(SuccessUpdatedProfileImageState());
      }, failure: (NetworkExceptions? error) async {
        isProfileImageUpdating = false;

        // AppUtils.showErrorToast('Uploading Failed!');
        emit(FailureUpdateProfileImageState());
      });
    }

    if (event is InitialClickChangeLanguageEvent) {
      ratioIndex = await repository
          .getLanguageCodeRatioIndex(PreferenceConstants.mainLanguage);
      setLangCode = await repository
          .getLanguageCode(PreferenceConstants.mainLanguageCode);
      emit(OpenChangeLanguagePopUpState());
    }

    if (event is ClickChangeLanguageEvent) {
      await repository.setLanguageCode(PreferenceConstants.mainLanguage,
          PreferenceConstants.mainLanguageCode, ratioIndex!, setLangCode!);
      emit(ClickChangeLanguageState());
    }

    if (event is InitialCustomerLanguagePreferenceEvent) {
      ratioIndexS2T = await repository
          .getLanguageCodeRatioIndex(PreferenceConstants.s2tLangSelectedIndex);
      setLangCodeS2T =
          await repository.getLanguageCode(PreferenceConstants.s2tLangcode);

      customerLanguagePreferenceList = [
        CustomerLanguagePreferenceModel(
            language: "tamilLang", languageCode: Constants.tamilLangCode),
        CustomerLanguagePreferenceModel(
            language: "hindiLang", languageCode: Constants.hindiLangCode),
        CustomerLanguagePreferenceModel(
            language: "kannadaLang", languageCode: Constants.kannadaLangCode),
        CustomerLanguagePreferenceModel(
            language: "teluguLang", languageCode: Constants.teluguLangCode),
        CustomerLanguagePreferenceModel(
            language: "malayalamLang",
            languageCode: Constants.malayalamLangCode),
        CustomerLanguagePreferenceModel(
            language: "bengaliLang", languageCode: Constants.bengaliLangCode),
        CustomerLanguagePreferenceModel(
            language: "gujaratiLang", languageCode: Constants.gujaratiLangCode),
        CustomerLanguagePreferenceModel(
            language: "punjabiLang", languageCode: Constants.panjabiLangCode),
        CustomerLanguagePreferenceModel(
            language: "marathiLang", languageCode: Constants.marathiLangCode),
        CustomerLanguagePreferenceModel(
            language: "urduLang", languageCode: Constants.urduLangCode),
      ];

      emit(CustomerLanguagePreferenceState());
    }

    if (event is CustomerLanguagePreferenceEvent) {
      await repository.setLanguageCode(PreferenceConstants.s2tLangSelectedIndex,
          PreferenceConstants.s2tLangcode, ratioIndexS2T!, setLangCodeS2T!);
      emit(ClickChangeLanguageState());
    }

    //
    // if (event is ClickChangePassswordEvent) {
    //   yield ClickChangePasswordState();
    // }
    //

    // if (event is ClickChangeSecurityPinEvent) {
    //   yield ClickChangeSecurityPinState();
    // }
    // if (event is ChangePasswordEvent) {
    //   yield ClickChangePasswordState();
    // }
    // if (event is LoginEvent) {
    //   yield ProfileLoadingState();
    //   Singleton.instance.isOfflineStorageFeatureEnabled = false;
    //   await FirebaseFirestore.instance.terminate();
    //   // await _prefs.clear();
    //   await PreferenceHelper.setPreference(Constants.accessToken, '');
    //   await PreferenceHelper.setPreference(Constants.userType, '');
    //   await PreferenceHelper.setPreference(
    //       Constants.appDataLoadedFromFirebase, false);
    //   await PreferenceHelper.setPreference(
    //       Constants.appDataLoadedFromFirebaseTime, '');
    //   await PreferenceHelper.setPreference('addressValue', '');
    //   await PreferenceHelper.setPreference('areyouatOffice', true);
    //   yield LoginState();
    // }
    // if (event is ClickMarkAsHomeEvent) {
    //   yield ClickMarkAsHomeState();
    // }
    //
  }
}
