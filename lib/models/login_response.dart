class LoginResponseModel {
  String? code;
  String? status;
  String? msg;
  String? auth;
  Data? data;
  // Casecount? casecount;
  // Casecount? flag;
  String? path;
  List<dynamic>? bank;
  List<dynamic>? region;
  List<dynamic>? area;
  List<dynamic>? contractor;
  Casecount? summary;
  Casecount? usageSummary;
  String? searchKey;
  String? searchValue;
  String? totalCaseCount;
  Casecount? totalsEventObj;

  LoginResponseModel(
      {this.code,
      this.status,
      this.msg,
      this.auth,
      this.data,
      this.path,
      this.bank,
      this.region,
      this.area,
      this.contractor,
      this.summary,
      this.usageSummary,
      this.searchKey,
      this.searchValue,
      this.totalCaseCount,
      this.totalsEventObj});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    if (json['status'] is String) {
      status = json['status'];
    }
    if (json['status'] is int) {
      status = json['status'].toString();
    }
    msg = json['msg'];
    auth = json['auth'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    // casecount = json['casecount'] != null ? Casecount.fromJson(json['casecount']) : null;
    // flag = json['flag'] != null ? Casecount.fromJson(json['flag']) : null;
    path = json['path'];
    if (json['bank'] != null) {
      bank = [];
      json['bank'].forEach((v) {
        bank?.add(json['bank']);
      });
    }
    if (json['region'] != null) {
      region = [];
      json['region'].forEach((v) {
        region?.add(json['region']);
      });
    }
    if (json['area'] != null) {
      area = [];
      json['area'].forEach((v) {
        area?.add(json['area']);
      });
    }
    if (json['contractor'] != null) {
      contractor = [];
      json['contractor'].forEach((v) {
        contractor?.add(json['contractor']);
      });
    }
    summary =
        json['summary'] != null ? Casecount.fromJson(json['summary']) : null;
    usageSummary = json['usageSummary'] != null
        ? Casecount.fromJson(json['usageSummary'])
        : null;
    searchKey = json['searchKey'];
    searchValue = json['searchValue'];
    totalCaseCount = json['totalCaseCount'];
    totalsEventObj = json['totalsEventObj'] != null
        ? Casecount.fromJson(json['totalsEventObj'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['code'] = this.code;
    data['status'] = this.status;
    data['msg'] = this.msg;
    data['auth'] = this.auth;
    if (this.data != null) {
      data['data'] = this.data?.toJson();
    }
    // if (this.casecount != null) {
    //   data['casecount'] = this.casecount?.toJson();
    // }
    // if (this.flag != null) {
    //   data['flag'] = this.flag?.toJson();
    // }
    data['path'] = this.path;
    if (this.bank != null) {
      data['bank'] = this.bank?.map((v) => v.toJson()).toList();
    }
    if (this.region != null) {
      data['region'] = this.region?.map((v) => v.toJson()).toList();
    }
    if (this.area != null) {
      data['area'] = this.area?.map((v) => v.toJson()).toList();
    }
    if (this.contractor != null) {
      data['contractor'] = this.contractor?.map((v) => v.toJson()).toList();
    }
    if (this.summary != null) {
      data['summary'] = this.summary?.toJson();
    }
    if (this.usageSummary != null) {
      data['usageSummary'] = this.usageSummary?.toJson();
    }
    data['searchKey'] = this.searchKey;
    data['searchValue'] = this.searchValue;
    data['totalCaseCount'] = this.totalCaseCount;
    if (this.totalsEventObj != null) {
      data['totalsEventObj'] = this.totalsEventObj?.toJson();
    }
    return data;
  }
}

class Data {
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
      this.keycloakId});

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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access_token'] = this.accessToken;
    data['expires_in'] = this.expiresIn;
    data['refresh_expires_in'] = this.refreshExpiresIn;
    data['refresh_token'] = this.refreshToken;
    data['token_type'] = this.tokenType;
    data['not-before-policy'] = this.notBeforePolicy;
    data['session_state'] = this.sessionState;
    data['scope'] = this.scope;
    data['resetFlag'] = this.resetFlag;
    data['keycloak_id'] = this.keycloakId;
    return data;
  }
}

class Casecount {
  // Casecount({});

  Casecount.fromJson(Map<String, dynamic> json) {}

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    return data;
  }
}
