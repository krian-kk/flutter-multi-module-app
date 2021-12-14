import 'package:bloc/bloc.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:origa/authentication/authentication_event.dart';
import 'package:origa/authentication/authentication_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationUnInitialized());

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is AppStarted) {
      await Future.delayed(const Duration(seconds: 2));
      
       SharedPreferences _prefs = await SharedPreferences.getInstance();
        String? getToken = _prefs.getString('accessToken') ?? "";
        if (getToken == "") {
             yield AuthenticationUnAuthenticated();
        } else {
          if (JwtDecoder.isExpired(getToken)) {
             yield AuthenticationUnAuthenticated();
          } else {
             yield AuthenticationAuthenticated();
          }
        }
      // yield AuthenticationAuthenticated();
    }
  }
}
