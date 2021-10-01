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
        ProfileNavigation(title: 'Notification', count: true),
        ProfileNavigation(title: 'Change language', count: false),
        ProfileNavigation(title: 'Change Password', count: false)
      ]);
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
