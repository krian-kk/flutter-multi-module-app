// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) {
  return _LoginResponse.fromJson(json);
}

/// @nodoc
mixin _$LoginResponse {
  @JsonKey(name: 'access_token')
  String? get accessToken => throw _privateConstructorUsedError;
  @JsonKey(name: 'expires_in')
  int? get expiresIn => throw _privateConstructorUsedError;
  @JsonKey(name: 'refresh_expires_in')
  int? get refreshExpiresIn => throw _privateConstructorUsedError;
  @JsonKey(name: 'refresh_token')
  String? get refreshToken => throw _privateConstructorUsedError;
  @JsonKey(name: 'token_type')
  String? get tokenType => throw _privateConstructorUsedError;
  @JsonKey(name: 'not-before-policy')
  int? get notBeforePolicy => throw _privateConstructorUsedError;
  @JsonKey(name: 'session_state')
  String? get sessionState => throw _privateConstructorUsedError;
  @JsonKey(name: 'scope')
  String? get scope => throw _privateConstructorUsedError;
  @JsonKey(name: 'setPassword')
  bool? get setPassword => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LoginResponseCopyWith<LoginResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginResponseCopyWith<$Res> {
  factory $LoginResponseCopyWith(
          LoginResponse value, $Res Function(LoginResponse) then) =
      _$LoginResponseCopyWithImpl<$Res, LoginResponse>;
  @useResult
  $Res call(
      {@JsonKey(name: 'access_token') String? accessToken,
      @JsonKey(name: 'expires_in') int? expiresIn,
      @JsonKey(name: 'refresh_expires_in') int? refreshExpiresIn,
      @JsonKey(name: 'refresh_token') String? refreshToken,
      @JsonKey(name: 'token_type') String? tokenType,
      @JsonKey(name: 'not-before-policy') int? notBeforePolicy,
      @JsonKey(name: 'session_state') String? sessionState,
      @JsonKey(name: 'scope') String? scope,
      @JsonKey(name: 'setPassword') bool? setPassword});
}

/// @nodoc
class _$LoginResponseCopyWithImpl<$Res, $Val extends LoginResponse>
    implements $LoginResponseCopyWith<$Res> {
  _$LoginResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accessToken = freezed,
    Object? expiresIn = freezed,
    Object? refreshExpiresIn = freezed,
    Object? refreshToken = freezed,
    Object? tokenType = freezed,
    Object? notBeforePolicy = freezed,
    Object? sessionState = freezed,
    Object? scope = freezed,
    Object? setPassword = freezed,
  }) {
    return _then(_value.copyWith(
      accessToken: freezed == accessToken
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String?,
      expiresIn: freezed == expiresIn
          ? _value.expiresIn
          : expiresIn // ignore: cast_nullable_to_non_nullable
              as int?,
      refreshExpiresIn: freezed == refreshExpiresIn
          ? _value.refreshExpiresIn
          : refreshExpiresIn // ignore: cast_nullable_to_non_nullable
              as int?,
      refreshToken: freezed == refreshToken
          ? _value.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String?,
      tokenType: freezed == tokenType
          ? _value.tokenType
          : tokenType // ignore: cast_nullable_to_non_nullable
              as String?,
      notBeforePolicy: freezed == notBeforePolicy
          ? _value.notBeforePolicy
          : notBeforePolicy // ignore: cast_nullable_to_non_nullable
              as int?,
      sessionState: freezed == sessionState
          ? _value.sessionState
          : sessionState // ignore: cast_nullable_to_non_nullable
              as String?,
      scope: freezed == scope
          ? _value.scope
          : scope // ignore: cast_nullable_to_non_nullable
              as String?,
      setPassword: freezed == setPassword
          ? _value.setPassword
          : setPassword // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_LoginResponseCopyWith<$Res>
    implements $LoginResponseCopyWith<$Res> {
  factory _$$_LoginResponseCopyWith(
          _$_LoginResponse value, $Res Function(_$_LoginResponse) then) =
      __$$_LoginResponseCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'access_token') String? accessToken,
      @JsonKey(name: 'expires_in') int? expiresIn,
      @JsonKey(name: 'refresh_expires_in') int? refreshExpiresIn,
      @JsonKey(name: 'refresh_token') String? refreshToken,
      @JsonKey(name: 'token_type') String? tokenType,
      @JsonKey(name: 'not-before-policy') int? notBeforePolicy,
      @JsonKey(name: 'session_state') String? sessionState,
      @JsonKey(name: 'scope') String? scope,
      @JsonKey(name: 'setPassword') bool? setPassword});
}

/// @nodoc
class __$$_LoginResponseCopyWithImpl<$Res>
    extends _$LoginResponseCopyWithImpl<$Res, _$_LoginResponse>
    implements _$$_LoginResponseCopyWith<$Res> {
  __$$_LoginResponseCopyWithImpl(
      _$_LoginResponse _value, $Res Function(_$_LoginResponse) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accessToken = freezed,
    Object? expiresIn = freezed,
    Object? refreshExpiresIn = freezed,
    Object? refreshToken = freezed,
    Object? tokenType = freezed,
    Object? notBeforePolicy = freezed,
    Object? sessionState = freezed,
    Object? scope = freezed,
    Object? setPassword = freezed,
  }) {
    return _then(_$_LoginResponse(
      accessToken: freezed == accessToken
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String?,
      expiresIn: freezed == expiresIn
          ? _value.expiresIn
          : expiresIn // ignore: cast_nullable_to_non_nullable
              as int?,
      refreshExpiresIn: freezed == refreshExpiresIn
          ? _value.refreshExpiresIn
          : refreshExpiresIn // ignore: cast_nullable_to_non_nullable
              as int?,
      refreshToken: freezed == refreshToken
          ? _value.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String?,
      tokenType: freezed == tokenType
          ? _value.tokenType
          : tokenType // ignore: cast_nullable_to_non_nullable
              as String?,
      notBeforePolicy: freezed == notBeforePolicy
          ? _value.notBeforePolicy
          : notBeforePolicy // ignore: cast_nullable_to_non_nullable
              as int?,
      sessionState: freezed == sessionState
          ? _value.sessionState
          : sessionState // ignore: cast_nullable_to_non_nullable
              as String?,
      scope: freezed == scope
          ? _value.scope
          : scope // ignore: cast_nullable_to_non_nullable
              as String?,
      setPassword: freezed == setPassword
          ? _value.setPassword
          : setPassword // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_LoginResponse implements _LoginResponse {
  const _$_LoginResponse(
      {@JsonKey(name: 'access_token') this.accessToken,
      @JsonKey(name: 'expires_in') this.expiresIn,
      @JsonKey(name: 'refresh_expires_in') this.refreshExpiresIn,
      @JsonKey(name: 'refresh_token') this.refreshToken,
      @JsonKey(name: 'token_type') this.tokenType,
      @JsonKey(name: 'not-before-policy') this.notBeforePolicy,
      @JsonKey(name: 'session_state') this.sessionState,
      @JsonKey(name: 'scope') this.scope,
      @JsonKey(name: 'setPassword') this.setPassword});

  factory _$_LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$$_LoginResponseFromJson(json);

  @override
  @JsonKey(name: 'access_token')
  final String? accessToken;
  @override
  @JsonKey(name: 'expires_in')
  final int? expiresIn;
  @override
  @JsonKey(name: 'refresh_expires_in')
  final int? refreshExpiresIn;
  @override
  @JsonKey(name: 'refresh_token')
  final String? refreshToken;
  @override
  @JsonKey(name: 'token_type')
  final String? tokenType;
  @override
  @JsonKey(name: 'not-before-policy')
  final int? notBeforePolicy;
  @override
  @JsonKey(name: 'session_state')
  final String? sessionState;
  @override
  @JsonKey(name: 'scope')
  final String? scope;
  @override
  @JsonKey(name: 'setPassword')
  final bool? setPassword;

  @override
  String toString() {
    return 'LoginResponse(accessToken: $accessToken, expiresIn: $expiresIn, refreshExpiresIn: $refreshExpiresIn, refreshToken: $refreshToken, tokenType: $tokenType, notBeforePolicy: $notBeforePolicy, sessionState: $sessionState, scope: $scope, setPassword: $setPassword)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_LoginResponse &&
            (identical(other.accessToken, accessToken) ||
                other.accessToken == accessToken) &&
            (identical(other.expiresIn, expiresIn) ||
                other.expiresIn == expiresIn) &&
            (identical(other.refreshExpiresIn, refreshExpiresIn) ||
                other.refreshExpiresIn == refreshExpiresIn) &&
            (identical(other.refreshToken, refreshToken) ||
                other.refreshToken == refreshToken) &&
            (identical(other.tokenType, tokenType) ||
                other.tokenType == tokenType) &&
            (identical(other.notBeforePolicy, notBeforePolicy) ||
                other.notBeforePolicy == notBeforePolicy) &&
            (identical(other.sessionState, sessionState) ||
                other.sessionState == sessionState) &&
            (identical(other.scope, scope) || other.scope == scope) &&
            (identical(other.setPassword, setPassword) ||
                other.setPassword == setPassword));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      accessToken,
      expiresIn,
      refreshExpiresIn,
      refreshToken,
      tokenType,
      notBeforePolicy,
      sessionState,
      scope,
      setPassword);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_LoginResponseCopyWith<_$_LoginResponse> get copyWith =>
      __$$_LoginResponseCopyWithImpl<_$_LoginResponse>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_LoginResponseToJson(
      this,
    );
  }
}

abstract class _LoginResponse implements LoginResponse {
  const factory _LoginResponse(
          {@JsonKey(name: 'access_token') final String? accessToken,
          @JsonKey(name: 'expires_in') final int? expiresIn,
          @JsonKey(name: 'refresh_expires_in') final int? refreshExpiresIn,
          @JsonKey(name: 'refresh_token') final String? refreshToken,
          @JsonKey(name: 'token_type') final String? tokenType,
          @JsonKey(name: 'not-before-policy') final int? notBeforePolicy,
          @JsonKey(name: 'session_state') final String? sessionState,
          @JsonKey(name: 'scope') final String? scope,
          @JsonKey(name: 'setPassword') final bool? setPassword}) =
      _$_LoginResponse;

  factory _LoginResponse.fromJson(Map<String, dynamic> json) =
      _$_LoginResponse.fromJson;

  @override
  @JsonKey(name: 'access_token')
  String? get accessToken;
  @override
  @JsonKey(name: 'expires_in')
  int? get expiresIn;
  @override
  @JsonKey(name: 'refresh_expires_in')
  int? get refreshExpiresIn;
  @override
  @JsonKey(name: 'refresh_token')
  String? get refreshToken;
  @override
  @JsonKey(name: 'token_type')
  String? get tokenType;
  @override
  @JsonKey(name: 'not-before-policy')
  int? get notBeforePolicy;
  @override
  @JsonKey(name: 'session_state')
  String? get sessionState;
  @override
  @JsonKey(name: 'scope')
  String? get scope;
  @override
  @JsonKey(name: 'setPassword')
  bool? get setPassword;
  @override
  @JsonKey(ignore: true)
  _$$_LoginResponseCopyWith<_$_LoginResponse> get copyWith =>
      throw _privateConstructorUsedError;
}
