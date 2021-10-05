import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:origa/models/language_model.dart';
import 'package:origa/models/notification_model.dart';
import 'package:origa/models/profile_navigation_button_model.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial());
  List<ProfileNavigation> profileNavigationList = [];
  List<NotificationMainModel> notificationList = [];
  List<LanguageModel> languageList = [];
  int languageValue = 0;

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is ProfileInitialEvent) {
      yield ProfileLoadingState();
      profileNavigationList.addAll([
        ProfileNavigation(
            title: 'Notification',
            count: true,
            onTap: () {
              this.add(ClickNotificationEvent());
            }),
        ProfileNavigation(
            title: 'Select Launguage',
            count: false,
            onTap: () {
              this.add(ClickChangeLaunguageEvent());
            }),
        ProfileNavigation(
            title: 'Change Password',
            count: false,
            onTap: () {
              this.add(ClickChangePassswordEvent());
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
