import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:origa/authentication/authentication_bloc.dart';
import 'package:origa/singleton.dart';

import 'home_tab_event.dart';
import 'home_tab_state.dart';

class HomeTabBloc extends Bloc<HomeTabEvent, HomeTabState> {
  HomeTabBloc({AuthenticationBloc? authBloc}) : super(HomeTabInitialState()) {
    on<HomeTabEvent>(_onEvent);
  }

  int? notificationCount = 0;
  String? userType;

  Future<void> _onEvent(HomeTabEvent event, Emitter<HomeTabState> emit) async {
    if (event is HomeTabInitialEvent) {
      emit(HomeTabLoadingState());

      if (event.notificationData != null) {
        emit(NavigateTabState(notificationData: event.notificationData));
      }
      userType = Singleton.instance.usertype;
      emit(HomeTabLoadedState());
    }
  }
}
