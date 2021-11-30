import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:origa/screen/dashboard/bloc/dashboard_bloc.dart';
import 'package:origa/screen/dashboard/dashboard_screen.dart';

import 'home_tab_event.dart';
import 'home_tab_state.dart';

class HomeTabBloc extends Bloc<HomeTabEvent, HomeTabState> {
  HomeTabBloc() : super(HomeTabInitialState());

  int? notificationCount = 3;

  @override
  Stream<HomeTabState> mapEventToState(HomeTabEvent event) async* {
    if (event is HomeTabInitialEvent) {
      yield HomeTabLoadingState();

      yield HomeTabLoadedState();
    }
  }
}
