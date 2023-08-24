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

class ResetPasswordClickEvent extends SignInEvent {
  ResetPasswordClickEvent(this.agentRef);

  final String agentRef;
}

class SendOtpToServerEvent extends SignInEvent {
  SendOtpToServerEvent(this.agentRef);

  final String agentRef;
}

class RequestOtpToServerEvent extends SignInEvent {
  RequestOtpToServerEvent(this.agentRef);

  final String agentRef;
}

class VerifyOtpEvent extends SignInEvent {
  VerifyOtpEvent(this.agentRef, this.pin);

  final String agentRef;
  final String pin;
}

class ResetPasswordChangeEvent extends SignInEvent {
  ResetPasswordChangeEvent(this.agentRef, this.password, this.otp);

  final String agentRef;
  final String password;
  final String otp;
}

class SetPasswordEvent extends SignInEvent {
  SetPasswordEvent(this.userName, this.password);

  final String userName;
  final String password;
}
