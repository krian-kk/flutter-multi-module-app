class LoginResponseModel {
  LoginResponseModel(
      {this.status,
      this.msg,
      this.data});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['status'] is int) {
      status = json['status'].toString();
    }
    msg = json['message'];
    data = json['result'] != null ? Data.fromJson(json['result']) : null;
  }

  String? status;
  String? msg;
  Data? data;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['msg'] = msg;
    if (this.data != null) {
      data['data'] = this.data?.toJson();
    }
    return data;
  }
}

class Data {
  Data(
      {this.accessToken,
      this.expiresIn,
      this.refreshExpiresIn,
      this.refreshToken,
      this.tokenType,
      this.notBeforePolicy,
      this.sessionState,
      this.scope,
      this.resetFlag,
      this.keycloakId,
      this.setPassword});

  Data.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    expiresIn = json['expires_in'];
    refreshExpiresIn = json['refresh_expires_in'];
    refreshToken = json['refresh_token'];
    tokenType = json['token_type'];
    notBeforePolicy = json['not-before-policy'];
    sessionState = json['session_state'];
    scope = json['scope'];
    resetFlag = json['resetFlag'];
    keycloakId = json['keycloak_id'];
    setPassword = json['setPassword'];
  }
  String? accessToken;
  int? expiresIn;
  int? refreshExpiresIn;
  String? refreshToken;
  String? tokenType;
  int? notBeforePolicy;
  String? sessionState;
  String? scope;
  bool? resetFlag;
  String? keycloakId;
  bool? setPassword;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['access_token'] = accessToken;
    data['expires_in'] = expiresIn;
    data['refresh_expires_in'] = refreshExpiresIn;
    data['refresh_token'] = refreshToken;
    data['token_type'] = tokenType;
    data['not-before-policy'] = notBeforePolicy;
    data['session_state'] = sessionState;
    data['scope'] = scope;
    data['resetFlag'] = resetFlag;
    data['keycloak_id'] = keycloakId;
    data['setPassword'] = setPassword;
    return data;
  }
}

class Casecount {
  Casecount.fromJson(Map<String, dynamic> json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    return data;
  }
}
