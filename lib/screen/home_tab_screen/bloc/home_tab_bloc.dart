import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';

import 'home_tab_event.dart';
import 'home_tab_state.dart';

class HomeTabBloc extends Bloc<HomeTabEvent, HomeTabState> {
  HomeTabBloc() : super(HomeTabInitialState());

  @override
  Stream<HomeTabState> mapEventToState(HomeTabEvent event) async* {}
}
