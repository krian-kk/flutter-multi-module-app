// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_LoginResponse _$$_LoginResponseFromJson(Map<String, dynamic> json) =>
    _$_LoginResponse(
      accessToken: json['access_token'] as String?,
      expiresIn: json['expires_in'] as int?,
      refreshExpiresIn: json['refresh_expires_in'] as int?,
      refreshToken: json['refresh_token'] as String?,
      tokenType: json['token_type'] as String?,
      notBeforePolicy: json['not-before-policy'] as int?,
      sessionState: json['session_state'] as String?,
      scope: json['scope'] as String?,
      setPassword: json['setPassword'] as bool?,
    );

Map<String, dynamic> _$$_LoginResponseToJson(_$_LoginResponse instance) =>
    <String, dynamic>{
      'access_token': instance.accessToken,
      'expires_in': instance.expiresIn,
      'refresh_expires_in': instance.refreshExpiresIn,
      'refresh_token': instance.refreshToken,
      'token_type': instance.tokenType,
      'not-before-policy': instance.notBeforePolicy,
      'session_state': instance.sessionState,
      'scope': instance.scope,
      'setPassword': instance.setPassword,
    };
