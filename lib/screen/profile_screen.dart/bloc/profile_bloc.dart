import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/models/language_model.dart';
import 'package:origa/models/notification_model.dart';
import 'package:origa/models/profile_navigation_button_model.dart';
import 'package:origa/utils/preference_helper.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial());
  List<ProfileNavigation> profileNavigationList = [];
  List<NotificationMainModel> notificationList = [];
  List<LanguageModel> languageList = [];
  dynamic languageValue = PreferenceHelper.getPreference('mainLanguage');

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is ProfileInitialEvent) {
      yield ProfileLoadingState();

      profileNavigationList.addAll([
        ProfileNavigation(
            title: Languages.of(event.context)!.notification,
            count: true,
            onTap: () {
              add(ClickNotificationEvent());
            }),
        ProfileNavigation(
            title: Languages.of(event.context)!.selectLanguage,
            count: false,
            onTap: () {
              add(ClickChangeLaunguageEvent());
            }),
        ProfileNavigation(
            title: Languages.of(event.context)!.changePassword,
            count: false,
            onTap: () {
              add(ClickChangePassswordEvent());
            })
      ]);
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
    if (event is ChangeProfileImageEvent) {
      yield ChangeProfileImageState();
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
