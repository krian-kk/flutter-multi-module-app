class AddressInvalidPostModel {
  AddressInvalidPostModel({
    required this.eventId,
    required this.eventType,
    required this.caseId,
    required this.eventCode,
    required this.eventAttr,
    required this.contact,
    this.createdAt,
    required this.createdBy,
    required this.eventModule,
    required this.agentName,
    required this.contractor,
    this.callID,
    this.callingID,
    required this.callerServiceID,
    required this.voiceCallEventCode,
    this.invalidNumber,
    required this.agrRef,
  });
  AddressInvalidPostModel.fromJson(Map<String, dynamic> json) {
    eventId = json['eventId'];
    eventType = json['eventType'];
    caseId = json['caseId'];
    eventCode = json['eventCode'];
    eventAttr = AddressInvalidEventAttr.fromJson(json['eventAttr']);
    contact = json['contact'].forEach((dynamic v) {
      contact.add(v);
    });
    createdAt = json['createdAt'];
    createdBy = json['createdBy'];
    eventModule = json['eventModule'];
    agentName = json['agentName'];
    contractor = json['contractor'];

    callID = json['callID'];
    callingID = json['callingID'];
    callerServiceID = json['callerServiceID'];
    voiceCallEventCode = json['voiceCallEventCode'];
    invalidNumber = json['invalidNumber'];
    agrRef = json['agrRef'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['eventId'] = eventId;
    data['eventType'] = eventType;
    data['caseId'] = caseId;
    data['eventCode'] = eventCode;
    data['eventAttr'] = eventAttr.toJson();
    data['contact'] =
        contact.map((AddressInvalidContact v) => v.toJson()).toList();
    data['createdAt'] = createdAt;
    data['createdBy'] = createdBy;
    data['eventModule'] = eventModule;
    data['agentName'] = agentName;
    data['contractor'] = contractor;

    data['callID'] = callID;
    data['callingID'] = callingID;
    data['callerServiceID'] = callerServiceID;
    data['voiceCallEventCode'] = voiceCallEventCode;
    data['invalidNumber'] = invalidNumber;
    data['agrRef'] = agrRef;
    return data;
  }

  late int eventId;
  late String eventType;
  late String caseId;
  late String eventCode;
  late AddressInvalidEventAttr eventAttr;
  late List<AddressInvalidContact> contact;
  late String? createdAt;
  late String createdBy;
  late String eventModule;
  late String agentName;
  late String contractor;

  late String? callID;
  late String? callingID;
  late String callerServiceID;
  late String voiceCallEventCode;
  late bool? invalidNumber;
  late String agrRef;
}

class AddressInvalidEventAttr {
  AddressInvalidEventAttr({
    required this.remarks,
    required this.followUpPriority,
    required this.altitude,
    required this.accuracy,
    this.altitudeAccuracy = 0,
    required this.heading,
    required this.speed,
    required this.latitude,
    required this.longitude,
    this.reginalText,
    this.translatedText,
    this.audioS3Path,
  });
  AddressInvalidEventAttr.fromJson(Map<String, dynamic> json) {
    remarks = json['remarks'];
    followUpPriority = json['followUpPriority'];
    altitude = json['altitude'];
    accuracy = json['accuracy'];
    altitudeAccuracy = json['altitudeAccuracy'];
    heading = json['heading'];
    speed = json['speed'];
    latitude = json['Latitude'];
    longitude = json['Longitude'];
    reginalText = json['reginal_text'];
    translatedText = json['translated_text'];
    audioS3Path = json['audioS3Path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['remarks'] = remarks;
    data['followUpPriority'] = followUpPriority;
    data['altitude'] = altitude;
    data['accuracy'] = accuracy;
    data['altitudeAccuracy'] = altitudeAccuracy;
    data['heading'] = heading;
    data['speed'] = speed;
    data['Latitude'] = latitude;
    data['Longitude'] = longitude;
    if (reginalText != null && translatedText != null && audioS3Path != null) {
      data['reginal_text'] = reginalText;
      data['translated_text'] = translatedText;
      data['audioS3Path'] = audioS3Path;
    }
    return data;
  }

  late String remarks;
  late String followUpPriority;
  late double altitude;
  late double accuracy;
  late double altitudeAccuracy;
  late double heading;
  late double speed;
  late double latitude;
  late double longitude;
  late String? reginalText;
  late String? translatedText;
  late String? audioS3Path;
}

class AddressInvalidContact {
  AddressInvalidContact({
    required this.cType,
    required this.value,
    required this.health,
    required this.resAddressId_0,
  });

  AddressInvalidContact.fromJson(Map<String, dynamic> json) {
    cType = json['cType'];
    value = json['value'];
    health = json['health'];
    resAddressId_0 = json['resAddressId_0'];
  }

  late String cType;
  late String value;
  late String health;
  late String resAddressId_0;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cType'] = cType;
    data['value'] = value;
    data['health'] = health;
    data['resAddressId_0'] = resAddressId_0;
    return data;
  }
}
