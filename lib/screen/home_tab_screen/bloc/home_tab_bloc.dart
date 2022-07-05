import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:origa/authentication/authentication_bloc.dart';
import 'package:origa/singleton.dart';

import 'home_tab_event.dart';
import 'home_tab_state.dart';

class HomeTabBloc extends Bloc<HomeTabEvent, HomeTabState> {
  HomeTabBloc({AuthenticationBloc? authBloc}) : super(HomeTabInitialState());

  int? notificationCount = 0;
  String? userType;

  @override
  Stream<HomeTabState> mapEventToState(HomeTabEvent event) async* {
    if (event is HomeTabInitialEvent) {
      yield HomeTabLoadingState();

      if (event.notificationData != null) {
        yield NavigateTabState(notificationData: event.notificationData);
      }
      userType = Singleton.instance.usertype;
      yield HomeTabLoadedState();
    }
  }
}
