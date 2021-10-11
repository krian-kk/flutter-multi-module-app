import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';

import 'home_tab_event.dart';
import 'home_tab_state.dart';

class HomeTabBloc extends Bloc<HomeTabEvent, HomeTabState> {
  HomeTabBloc() : super(HomeTabInitialState());

  int? notificationCount = 3;

  @override
  Stream<HomeTabState> mapEventToState(HomeTabEvent event) async* {}
}
