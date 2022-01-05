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
        result!.add(new Result.fromJson(v));
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

  Result(
      {this.sId,
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
      this.failedLoginCounter});

  Result.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    aRef = json['aRef'];
    areaCode = json['areaCode'].cast<String>();
    audit = json['audit'] != null ? new Audit.fromJson(json['audit']) : null;
    if (json['children'] != null) {
      children = [];
    }
    if (json['contact'] != null) {
      contact = <Contact>[];
      json['contact'].forEach((v) {
        contact!.add(new Contact.fromJson(v));
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['aRef'] = this.aRef;
    data['areaCode'] = this.areaCode;
    if (this.audit != null) {
      data['audit'] = this.audit!.toJson();
    }
    if (this.children != null) {
      data['children'] = this.children!.map((v) => v.toJson()).toList();
    }
    if (this.contact != null) {
      data['contact'] = this.contact!.map((v) => v.toJson()).toList();
    }
    data['contractor'] = this.contractor;
    data['dateJoining'] = this.dateJoining;
    data['dateResign'] = this.dateResign;
    data['defMobileNumber'] = this.defMobileNumber;
    data['name'] = this.name;
    data['parent'] = this.parent;
    data['roleLevel'] = this.roleLevel;
    data['status'] = this.status;
    data['type'] = this.type;
    data['userAdmin'] = this.userAdmin;
    data['failedLoginCounter'] = this.failedLoginCounter;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['crBy'] = this.crBy;
    data['crAt'] = this.crAt;
    data['syncAt'] = this.syncAt;
    data['upBy'] = this.upBy;
    data['upAt'] = this.upAt;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cType'] = this.cType;
    data['value'] = this.value;
    return data;
  }
}
