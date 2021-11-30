import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:origa/utils/base_equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitialState());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    // if (event is LoginEvent) {
    //   yield LoginLoadingState();
    //   yield LoginLoadedState();
    // }

    if (event is HomeTabEvent) {
      yield HomeTabState();
    }
  }
}
