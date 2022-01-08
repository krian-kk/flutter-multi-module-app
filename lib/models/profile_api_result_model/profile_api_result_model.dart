class ProfileApiModel {
  int? status;
  String? message;
  List<Result>? result;

  ProfileApiModel({this.status, this.message, this.result});

  ProfileApiModel.fromJson(Map<String, dynamic> json) {
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
  String? aRef;
  List<String>? areaCode;
  Audit? audit;
  List? children;
  List<Contact>? contact;
  String? contractor;
  String? dateJoining;
  String? dateResign;
  String? defMobileNumber;
  String? name;
  String? parent;
  String? roleLevel;
  String? status;
  String? type;
  bool? userAdmin;
  int? failedLoginCounter;
  String? homeAddress;
  String? profileImgUrl;

  Result({
    this.sId,
    this.aRef,
    this.areaCode,
    this.audit,
    this.children,
    this.contact,
    this.contractor,
    this.dateJoining,
    this.dateResign,
    this.defMobileNumber,
    this.name,
    this.parent,
    this.roleLevel,
    this.status,
    this.type,
    this.userAdmin,
    this.failedLoginCounter,
    this.homeAddress,
    this.profileImgUrl,
  });

  Result.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    aRef = json['aRef'];
    areaCode = json['areaCode'].cast<String>();
    audit = json['audit'] != null ? Audit.fromJson(json['audit']) : null;
    if (json['children'] != null) {
      children = [];
    }
    if (json['contact'] != null) {
      contact = <Contact>[];
      json['contact'].forEach((v) {
        contact!.add(Contact.fromJson(v));
      });
    }
    contractor = json['contractor'];
    dateJoining = json['dateJoining'];
    dateResign = json['dateResign'];
    defMobileNumber = json['defMobileNumber'];
    name = json['name'];
    parent = json['parent'];
    roleLevel = json['roleLevel'];
    status = json['status'];
    type = json['type'];
    userAdmin = json['userAdmin'];
    failedLoginCounter = json['failedLoginCounter'];
    homeAddress = json['homeAddress'];
    profileImgUrl = json['profileImgUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['aRef'] = aRef;
    data['areaCode'] = areaCode;
    if (audit != null) {
      data['audit'] = audit!.toJson();
    }
    if (children != null) {
      data['children'] = children!.map((v) => v.toJson()).toList();
    }
    if (contact != null) {
      data['contact'] = contact!.map((v) => v.toJson()).toList();
    }
    data['contractor'] = contractor;
    data['dateJoining'] = dateJoining;
    data['dateResign'] = dateResign;
    data['defMobileNumber'] = defMobileNumber;
    data['name'] = name;
    data['parent'] = parent;
    data['roleLevel'] = roleLevel;
    data['status'] = status;
    data['type'] = type;
    data['userAdmin'] = userAdmin;
    data['failedLoginCounter'] = failedLoginCounter;
    data['homeAddress'] = homeAddress;
    data['profileImgUrl'] = profileImgUrl;
    return data;
  }
}

class Audit {
  String? crBy;
  String? crAt;
  String? syncAt;
  String? upBy;
  String? upAt;

  Audit({this.crBy, this.crAt, this.syncAt, this.upBy, this.upAt});

  Audit.fromJson(Map<String, dynamic> json) {
    crBy = json['crBy'];
    crAt = json['crAt'];
    syncAt = json['syncAt'];
    upBy = json['upBy'];
    upAt = json['upAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['crBy'] = crBy;
    data['crAt'] = crAt;
    data['syncAt'] = syncAt;
    data['upBy'] = upBy;
    data['upAt'] = upAt;
    return data;
  }
}

class Contact {
  String? cType;
  String? value;

  Contact({this.cType, this.value});

  Contact.fromJson(Map<String, dynamic> json) {
    cType = json['cType'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cType'] = cType;
    data['value'] = value;
    return data;
  }
}
