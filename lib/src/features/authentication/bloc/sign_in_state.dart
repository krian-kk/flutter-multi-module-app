import 'package:origa/src/features/authentication/bloc/form_submission_status.dart';
import 'package:repository/auth_repository.dart';

class SignInState {
  SignInState({
    this.username = '',
    this.password = '',
    this.formStatus = const InitialFormStatus(),
  });

  final String username;

  bool get isValidUsername => username.length > 3;
  final String password;

  bool get isValidPassword => password.length > 6;
  final FormSubmissionStatus formStatus;

  SignInState copyWith(
      {String? username, String? password, FormSubmissionStatus? formStatus}) {
    return SignInState(
        username: username ?? this.username,
        password: password ?? this.password,
        formStatus: formStatus ?? this.formStatus);
  }
}

class FillAgentInfoForResetPassword extends SignInState {
  FillAgentInfoForResetPassword(this.agentDetails);

  ShortAgentDetails agentDetails;
}

class SetPasswordState extends SignInState {
  SetPasswordState({this.name});

  final String? name;
}

class SetPasswordSuccessState extends SignInState {}

class SuccessResetPasswordState extends SignInState {}

class SendOtpSuccessState extends SignInState {}

class RequestOtpSuccessState extends SignInState {}

class VerifyOtpSuccessState extends SignInState {}

class SuccessOtpState extends SignInState {
  SuccessOtpState({required this.pin});

  final String pin;
}

class FailureOtpState extends SignInState {}

class VerifyOtpFailureState extends SignInState {}

class ResetPasswordSuccessState extends SignInState {}
