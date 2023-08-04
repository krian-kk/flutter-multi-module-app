class PublicAgentInfoModel {
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
    audit = json['audit'] != null ? Audit.fromJson(json['audit']) : null;
    fcm = json['fcm'] != null ? Fcm.fromJson(json['fcm']) : null;
    geoLocationDetails = json['geoLocationDetails'] != null
        ? GeoLocationDetails.fromJson(json['geoLocationDetails'])
        : null;
    sId = json['_id'];
    aRef = json['aRef'];
    iV = json['__v'];
    agentPhoto = json['agentPhoto'];
    if (json['attribute_assigned'] != null) {
      attributeAssigned = <dynamic>[];
    }
    if (json['children'] != null) {
      children = <dynamic>[];
    }
    if (json['contact'] != null) {
      contact = <Contact>[];
      json['contact'].forEach((v) {
        contact!.add(Contact.fromJson(v));
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
  }

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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (audit != null) {
      data['audit'] = audit!.toJson();
    }
    if (fcm != null) {
      data['fcm'] = fcm!.toJson();
    }
    if (geoLocationDetails != null) {
      data['geoLocationDetails'] = geoLocationDetails!.toJson();
    }
    data['_id'] = sId;
    data['aRef'] = aRef;
    data['__v'] = iV;
    data['agentPhoto'] = agentPhoto;
    data['areaCode'] = areaCode;
    if (attributeAssigned != null) {
      data['attribute_assigned'] =
          attributeAssigned!.map((v) => v.toJson()).toList();
    }
    if (children != null) {
      data['children'] = children!.map((v) => v.toJson()).toList();
    }
    if (contact != null) {
      data['contact'] = contact!.map((v) => v.toJson()).toList();
    }
    data['contractor'] = contractor;
    data['contractorDeactivate'] = contractorDeactivate;
    data['dateJoining'] = dateJoining;
    data['dateResign'] = dateResign;
    data['defMobileNumber'] = defMobileNumber;
    data['draDocument'] = draDocument;
    data['isInternal'] = isInternal;
    if (linkedBank != null) {
      data['linkedBank'] = linkedBank!.map((v) => v.toJson()).toList();
    }
    data['name'] = name;
    data['parent'] = parent;
    data['policeDocument'] = policeDocument;
    data['roleLevel'] = roleLevel;
    data['sentOtpCounter'] = sentOtpCounter;
    data['status'] = status;
    data['type'] = type;
    data['userAdmin'] = userAdmin;
    data['parentId'] = parentId;
    data['appVersion'] = appVersion;
    data['failedLoginCounter'] = failedLoginCounter;
    data['fcmToken'] = fcmToken;
    data['mPin'] = mPin;
    data['webLogin'] = webLogin;
    return data;
  }
}

class Audit {
  Audit({this.crBy, this.crAt, this.syncAt, this.upBy, this.upAt});

  Audit.fromJson(Map<String, dynamic> json) {
    crBy = json['crBy'];
    crAt = json['crAt'];
    syncAt = json['syncAt'];
    upBy = json['upBy'];
    upAt = json['upAt'];
  }

  String? crBy;
  String? crAt;
  String? syncAt;
  String? upBy;
  String? upAt;

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

class Fcm {
  Fcm({this.token});

  Fcm.fromJson(Map<String, dynamic> json) {
    token = json['token'];
  }

  String? token;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    return data;
  }
}

class GeoLocationDetails {
  GeoLocationDetails({this.lastUpdatedAt, this.lat, this.lng});

  GeoLocationDetails.fromJson(Map<String, dynamic> json) {
    lastUpdatedAt = json['lastUpdatedAt'];
    lat = json['lat'];
    lng = json['lng'];
  }

  String? lastUpdatedAt;
  double? lat;
  double? lng;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lastUpdatedAt'] = lastUpdatedAt;
    data['lat'] = lat;
    data['lng'] = lng;
    return data;
  }
}

class Contact {
  Contact({this.cType, this.value});

  Contact.fromJson(Map<String, dynamic> json) {
    cType = json['cType'];
    value = json['value'];
  }

  String? cType;
  String? value;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cType'] = cType;
    data['value'] = value;
    return data;
  }
}
