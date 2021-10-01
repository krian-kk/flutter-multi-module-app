import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:origa/models/profile_navigation_button_model.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial());
  List<ProfileNavigation> profileNavigationList = [];
  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is ProfileEvent) {
      yield ProfileLoadingState();
      profileNavigationList.addAll([
        ProfileNavigation(
            title: 'Notification',
            count: true,
            onTap: () {
              this.add(ClickNotificationEvent());
            }),
        ProfileNavigation(
            title: 'Change language',
            count: false,
            onTap: () {
              this.add(ClickChangeLaunguageEvent());
            }),
        ProfileNavigation(
            title: 'Change Password',
            count: false,
            onTap: () {
              this.add(ClickChnagePassswordEvent());
            })
      ]);
      yield ProfileLoadedState();
    }
    if (event is ClickNotificationEvent) {
      yield ClickNotificationState();
    } else if (event is ClickChangeLaunguageEvent) {
      yield ClickChangeLaunguageState();
    } else if (event is ClickChnagePassswordEvent) {
      yield ClickPasswordState();
    } else {
      yield ProfileLoadedState();
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
