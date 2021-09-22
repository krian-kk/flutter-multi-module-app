import 'package:bloc/bloc.dart';
import 'package:origa/authentication/authentication_event.dart';
import 'package:origa/authentication/authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationUnInitialized());

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is AppStarted) {
      await Future.delayed(const Duration(seconds: 2));
      yield AuthenticationAuthenticated();
    }
  }
}
