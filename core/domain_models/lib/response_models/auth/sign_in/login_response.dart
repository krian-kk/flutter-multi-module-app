import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_response.freezed.dart';

part 'login_response.g.dart';

@freezed
class LoginResponse with _$LoginResponse {
  const factory LoginResponse({
    @JsonKey(name: 'access_token') String? accessToken,
    @JsonKey(name: 'expires_in') int? expiresIn,
    @JsonKey(name: 'refresh_expires_in') int? refreshExpiresIn,
    @JsonKey(name: 'refresh_token') String? refreshToken,
    @JsonKey(name: 'token_type') String? tokenType,
    @JsonKey(name: 'not-before-policy') int? notBeforePolicy,
    @JsonKey(name: 'session_state') String? sessionState,
    @JsonKey(name: 'scope') String? scope,
    @JsonKey(name: 'setPassword') bool? setPassword
  }) = _LoginResponse;

  factory LoginResponse.fromJson(Map<String, Object?> json) =>
      _$LoginResponseFromJson(json);
}
