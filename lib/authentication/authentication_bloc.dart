import 'package:bloc/bloc.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:origa/authentication/authentication_event.dart';
import 'package:origa/authentication/authentication_state.dart';
import 'package:origa/http/api_repository.dart';
import 'package:origa/http/httpurls.dart';
import 'package:origa/models/agent_detail_error_model.dart';
import 'package:origa/models/agent_details_model.dart';
import 'package:origa/singleton.dart';
import 'package:origa/utils/app_utils.dart';
import 'package:origa/utils/constants.dart';
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
      String? getToken = _prefs.getString(Constants.accessToken) ?? "";
      String? getUserName = _prefs.getString(Constants.userName);
      if (getToken == "") {
        yield AuthenticationUnAuthenticated();
      } else {
        if (JwtDecoder.isExpired(getToken)) {
          yield AuthenticationUnAuthenticated();
        } else {
          Singleton.instance.accessToken =
              _prefs.getString(Constants.accessToken) ?? "";
          Singleton.instance.refreshToken =
              _prefs.getString(Constants.refreshToken) ?? "";
          Singleton.instance.sessionID =
              _prefs.getString(Constants.sessionId) ?? "";
          Singleton.instance.agentRef =
              _prefs.getString(Constants.agentRef) ?? "";

          Map<String, dynamic> agentDetail = await APIRepository.apiRequest(
              APIRequestType.GET, HttpUrl.agentDetailUrl + getUserName!);
          // ignore: unnecessary_type_check

          if (agentDetail['data'] is AgentDetailErrorModel) {
            //May if logged in onther deveces
            dynamic agentDetailError =
                AgentDetailErrorModel.fromJson(agentDetail['data']);
            AppUtils.showToast(agentDetailError.msg!);
            yield AuthenticationUnAuthenticated();
          } else {
            dynamic agentDetails =
                AgentDetailsModel.fromJson(agentDetail['data']);
            if (agentDetails.data![0].agentType == 'COLLECTOR') {
              await _prefs.setString(Constants.userType, Constants.fieldagent);
            } else {
              await _prefs.setString(Constants.userType, Constants.telecaller);
            }

            if (agentDetails.data![0].agentType != null) {
              await _prefs.setString(
                  Constants.agentName, agentDetails.data![0].agentName!);
              await _prefs.setString(
                  Constants.mobileNo, agentDetails.data![0].mobNo!);
              await _prefs.setString(
                  Constants.email, agentDetails.data![0].email!);
              await _prefs.setString(
                  Constants.contractor, agentDetails.data![0].contractor!);
              await _prefs.setString(
                  Constants.status, agentDetails.data![0].status!);
              await _prefs.setString(Constants.code, agentDetails.code!);
              await _prefs.setBool(
                  Constants.userAdmin, agentDetails.data![0].userAdmin!);

              yield AuthenticationAuthenticated();
            }
          }
        }
      }
      // yield AuthenticationAuthenticated();
    }
  }
}
