import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:origa/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_tab_event.dart';
import 'home_tab_state.dart';

class HomeTabBloc extends Bloc<HomeTabEvent, HomeTabState> {
  HomeTabBloc() : super(HomeTabInitialState());

  int? notificationCount = 0;
  String? userType;

  @override
  Stream<HomeTabState> mapEventToState(HomeTabEvent event) async* {
    if (event is HomeTabInitialEvent) {
      yield HomeTabLoadingState();

      SharedPreferences _prefs = await SharedPreferences.getInstance();
      userType = _prefs.getString(Constants.userType);

      yield HomeTabLoadedState();
    }
  }
}
