class PublicAgentInfoModel {
  Audit? audit;
  Fcm? fcm;
  GeoLocationDetails? geoLocationDetails;
  String? sId;
  String? aRef;
  int? iV;
  String? agentPhoto;
  List<String>? areaCode;
  List<dynamic>? attributeAssigned;
  List<dynamic>? children;
  List<Contact>? contact;
  String? contractor;
  bool? contractorDeactivate;
  dynamic dateJoining;
  dynamic dateResign;
  String? defMobileNumber;
  String? draDocument;
  bool? isInternal;
  List<dynamic>? linkedBank;
  String? name;
  String? parent;
  String? policeDocument;
  String? roleLevel;
  int? sentOtpCounter;
  String? status;
  String? type;
  bool? userAdmin;
  String? parentId;
  String? appVersion;
  int? failedLoginCounter;
  String? fcmToken;
  dynamic mPin;
  String? webLogin;

  PublicAgentInfoModel(
      {this.audit,
        this.fcm,
        this.geoLocationDetails,
        this.sId,
        this.aRef,
        this.iV,
        this.agentPhoto,
        this.areaCode,
        this.attributeAssigned,
        this.children,
        this.contact,
        this.contractor,
        this.contractorDeactivate,
        this.dateJoining,
        this.dateResign,
        this.defMobileNumber,
        this.draDocument,
        this.isInternal,
        this.linkedBank,
        this.name,
        this.parent,
        this.policeDocument,
        this.roleLevel,
        this.sentOtpCounter,
        this.status,
        this.type,
        this.userAdmin,
        this.parentId,
        this.appVersion,
        this.failedLoginCounter,
        this.fcmToken,
        this.mPin,
        this.webLogin});

  PublicAgentInfoModel.fromJson(Map<String, dynamic> json) {
    audit = json['audit'] != null ? new Audit.fromJson(json['audit']) : null;
    fcm = json['fcm'] != null ? new Fcm.fromJson(json['fcm']) : null;
    geoLocationDetails = json['geoLocationDetails'] != null
        ? new GeoLocationDetails.fromJson(json['geoLocationDetails'])
        : null;
    sId = json['_id'];
    aRef = json['aRef'];
    iV = json['__v'];
    agentPhoto = json['agentPhoto'];
    // areaCode = json['areaCode'].cast<String>();
    if (json['attribute_assigned'] != null) {
      attributeAssigned = <dynamic>[];
      // json['attribute_assigned'].forEach((v) {
      // });
    }
    if (json['children'] != null) {
      children = <dynamic>[];
      // json['children'].forEach((v) {
      //   children!.add(new Null.fromJson(v));
      // });
    }
    if (json['contact'] != null) {
      contact = <Contact>[];
      json['contact'].forEach((v) {
        contact!.add(new Contact.fromJson(v));
      });
    }
    contractor = json['contractor'];
    contractorDeactivate = json['contractorDeactivate'];
    dateJoining = json['dateJoining'];
    dateResign = json['dateResign'];
    defMobileNumber = json['defMobileNumber'];
    draDocument = json['draDocument'];
    isInternal = json['isInternal'];
    if (json['linkedBank'] != null) {
      linkedBank = <Null>[];
      json['linkedBank'].forEach((v) {
        // linkedBank!.add(new Null.fromJson(v));
      });
    }
    name = json['name'];
    parent = json['parent'];
    policeDocument = json['policeDocument'];
    roleLevel = json['roleLevel'];
    sentOtpCounter = json['sentOtpCounter'];
    // status = json['status'];
    // type = json['type'];
    // userAdmin = json['userAdmin'];
    // parentId = json['parentId'];
    // appVersion = json['appVersion'];
    // failedLoginCounter = json['failedLoginCounter'];
    // fcmToken = json['fcmToken'];
    // mPin = json['mPin'];
    // webLogin = json['webLogin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.audit != null) {
      data['audit'] = this.audit!.toJson();
    }
    if (this.fcm != null) {
      data['fcm'] = this.fcm!.toJson();
    }
    if (this.geoLocationDetails != null) {
      data['geoLocationDetails'] = this.geoLocationDetails!.toJson();
    }
    data['_id'] = this.sId;
    data['aRef'] = this.aRef;
    data['__v'] = this.iV;
    data['agentPhoto'] = this.agentPhoto;
    data['areaCode'] = this.areaCode;
    if (this.attributeAssigned != null) {
      data['attribute_assigned'] =
          this.attributeAssigned!.map((v) => v.toJson()).toList();
    }
    if (this.children != null) {
      data['children'] = this.children!.map((v) => v.toJson()).toList();
    }
    if (this.contact != null) {
      data['contact'] = this.contact!.map((v) => v.toJson()).toList();
    }
    data['contractor'] = this.contractor;
    data['contractorDeactivate'] = this.contractorDeactivate;
    data['dateJoining'] = this.dateJoining;
    data['dateResign'] = this.dateResign;
    data['defMobileNumber'] = this.defMobileNumber;
    data['draDocument'] = this.draDocument;
    data['isInternal'] = this.isInternal;
    if (this.linkedBank != null) {
      data['linkedBank'] = this.linkedBank!.map((v) => v.toJson()).toList();
    }
    data['name'] = this.name;
    data['parent'] = this.parent;
    data['policeDocument'] = this.policeDocument;
    data['roleLevel'] = this.roleLevel;
    data['sentOtpCounter'] = this.sentOtpCounter;
    data['status'] = this.status;
    data['type'] = this.type;
    data['userAdmin'] = this.userAdmin;
    data['parentId'] = this.parentId;
    data['appVersion'] = this.appVersion;
    data['failedLoginCounter'] = this.failedLoginCounter;
    data['fcmToken'] = this.fcmToken;
    data['mPin'] = this.mPin;
    data['webLogin'] = this.webLogin;
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

class Fcm {
  String? token;

  Fcm({this.token});

  Fcm.fromJson(Map<String, dynamic> json) {
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    return data;
  }
}

class GeoLocationDetails {
  String? lastUpdatedAt;
  double? lat;
  double? lng;

  GeoLocationDetails({this.lastUpdatedAt, this.lat, this.lng});

  GeoLocationDetails.fromJson(Map<String, dynamic> json) {
    lastUpdatedAt = json['lastUpdatedAt'];
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lastUpdatedAt'] = this.lastUpdatedAt;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
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
