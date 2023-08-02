import '../../../form_submission_status.dart';

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
