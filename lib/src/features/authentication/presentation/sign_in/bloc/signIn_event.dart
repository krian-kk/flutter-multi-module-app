abstract class SignInEvent {}

class SignInUsernameChanged extends SignInEvent {
  SignInUsernameChanged({required this.username});

  final String username;
}

class SignInPasswordChanged extends SignInEvent {
  SignInPasswordChanged({required this.password});

  final String password;
}

class SignInSubmitted extends SignInEvent {
  SignInSubmitted({this.paramValue});

  final dynamic paramValue;
}

class SignInSuccess extends SignInEvent {
  SignInSuccess();
}

class SignInError extends SignInEvent {
  SignInError({required this.message});
  final String message;
}
