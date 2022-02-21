class AgentInformation {
  int? status;
  String? message;
  List<Result>? result;

  AgentInformation({this.status, this.message, this.result});

  AgentInformation.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (result != null) {
      data['result'] = result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  String? sId;
  List<String>? areaCode;
  String? aRef;
  String? name;
  String? type;
  String? contractor;
  String? status;
  List<String>? children;
  Audit? audit;
  List<Contact>? contact;
  String? webLogin;
  dynamic dateJoining;
  dynamic dateResign;
  String? defMobileNumber;
  String? roleLevel;
  dynamic aId;
  dynamic aclId;
  String? parent;
  dynamic parentId;
  int? lastOtp;
  bool? userAdmin;
  int? failedLoginCounter;
  Fcm? fcm;

  Result(
      {this.sId,
      this.areaCode,
      this.aRef,
      this.name,
      this.type,
      this.contractor,
      this.status,
      this.children,
      this.audit,
      this.contact,
      this.webLogin,
      this.dateJoining,
      this.dateResign,
      this.defMobileNumber,
      this.roleLevel,
      this.aId,
      this.aclId,
      this.parent,
      this.parentId,
      this.lastOtp,
      this.userAdmin,
      this.failedLoginCounter,
      this.fcm});

  Result.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    areaCode = json['areaCode'].cast<String>();
    aRef = json['aRef'];
    name = json['name'];
    type = json['type'];
    contractor = json['contractor'];
    status = json['status'];
    children = json['children'].cast<String>();
    audit = json['audit'] != null ? Audit.fromJson(json['audit']) : null;
    if (json['contact'] != null) {
      contact = <Contact>[];
      json['contact'].forEach((v) {
        contact!.add(Contact.fromJson(v));
      });
    }
    webLogin = json['webLogin'];
    dateJoining = json['dateJoining'];
    dateResign = json['dateResign'];
    defMobileNumber = json['defMobileNumber'];
    roleLevel = json['roleLevel'];
    aId = json['aId'];
    aclId = json['aclId'];
    parent = json['parent'];
    parentId = json['parentId'];
    lastOtp = json['lastOtp'];
    userAdmin = json['userAdmin'];
    failedLoginCounter = json['failedLoginCounter'];
    fcm = json['fcm'] != null ? Fcm.fromJson(json['fcm']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['areaCode'] = areaCode;
    data['aRef'] = aRef;
    data['name'] = name;
    data['type'] = type;
    data['contractor'] = contractor;
    data['status'] = status;
    data['children'] = children;
    if (audit != null) {
      data['audit'] = audit!.toJson();
    }
    if (contact != null) {
      data['contact'] = contact!.map((v) => v.toJson()).toList();
    }
    data['webLogin'] = webLogin;
    data['dateJoining'] = dateJoining;
    data['dateResign'] = dateResign;
    data['defMobileNumber'] = defMobileNumber;
    data['roleLevel'] = roleLevel;
    data['aId'] = aId;
    data['aclId'] = aclId;
    data['parent'] = parent;
    data['parentId'] = parentId;
    data['lastOtp'] = lastOtp;
    data['userAdmin'] = userAdmin;
    data['failedLoginCounter'] = failedLoginCounter;
    if (fcm != null) {
      data['fcm'] = fcm!.toJson();
    }
    return data;
  }
}

class Audit {
  String? crBy;
  String? crAt;
  String? upBy;
  String? upAt;

  Audit({this.crBy, this.crAt, this.upBy, this.upAt});

  Audit.fromJson(Map<String, dynamic> json) {
    crBy = json['crBy'];
    crAt = json['crAt'];
    upBy = json['upBy'];
    upAt = json['upAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['crBy'] = crBy;
    data['crAt'] = crAt;
    data['upBy'] = upBy;
    data['upAt'] = upAt;
    return data;
  }
}

class Contact {
  String? value;
  String? cType;

  Contact({this.value, this.cType});

  Contact.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    cType = json['cType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value'] = value;
    data['cType'] = cType;
    return data;
  }
}

class Fcm {
  String? socketId;
  String? displayName;
  int? status;
  dynamic avatar;
  String? id;
  int? participantType;

  Fcm(
      {this.socketId,
      this.displayName,
      this.status,
      this.avatar,
      this.id,
      this.participantType});

  Fcm.fromJson(Map<String, dynamic> json) {
    socketId = json['socketId'];
    displayName = json['displayName'];
    status = json['status'];
    avatar = json['avatar'];
    id = json['id'];
    participantType = json['participantType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['socketId'] = socketId;
    data['displayName'] = displayName;
    data['status'] = status;
    data['avatar'] = avatar;
    data['id'] = id;
    data['participantType'] = participantType;
    return data;
  }
}
