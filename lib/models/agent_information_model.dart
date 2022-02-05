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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.result != null) {
      data['result'] = this.result!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['areaCode'] = this.areaCode;
    data['aRef'] = this.aRef;
    data['name'] = this.name;
    data['type'] = this.type;
    data['contractor'] = this.contractor;
    data['status'] = this.status;
    data['children'] = this.children;
    if (this.audit != null) {
      data['audit'] = this.audit!.toJson();
    }
    if (this.contact != null) {
      data['contact'] = this.contact!.map((v) => v.toJson()).toList();
    }
    data['webLogin'] = this.webLogin;
    data['dateJoining'] = this.dateJoining;
    data['dateResign'] = this.dateResign;
    data['defMobileNumber'] = this.defMobileNumber;
    data['roleLevel'] = this.roleLevel;
    data['aId'] = this.aId;
    data['aclId'] = this.aclId;
    data['parent'] = this.parent;
    data['parentId'] = this.parentId;
    data['lastOtp'] = this.lastOtp;
    data['userAdmin'] = this.userAdmin;
    data['failedLoginCounter'] = this.failedLoginCounter;
    if (this.fcm != null) {
      data['fcm'] = this.fcm!.toJson();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['crBy'] = this.crBy;
    data['crAt'] = this.crAt;
    data['upBy'] = this.upBy;
    data['upAt'] = this.upAt;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    data['cType'] = this.cType;
    return data;
  }
}

class Fcm {
  String? socketId;
  String? displayName;
  int? status;
  Null? avatar;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['socketId'] = this.socketId;
    data['displayName'] = this.displayName;
    data['status'] = this.status;
    data['avatar'] = this.avatar;
    data['id'] = this.id;
    data['participantType'] = this.participantType;
    return data;
  }
}
