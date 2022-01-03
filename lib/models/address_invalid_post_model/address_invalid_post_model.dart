class AddressInvalidPostModel {
  late int eventId;
  late String eventType;
  late String caseId;
  late String eventCode;
  late AddressInvalidEventAttr eventAttr;
  late List<AddressInvalidContact> contact;
  late String createdBy;
  late String eventModule;
  late String agentName;

  late String? callID;
  late String? callingID;
  late String callerServiceID;
  late String voiceCallEventCode;
  late int? invalidNumber;
  late String agrRef;

  AddressInvalidPostModel({
    required this.eventId,
    required this.eventType,
    required this.caseId,
    required this.eventCode,
    required this.eventAttr,
    required this.contact,
    required this.createdBy,
    required this.eventModule,
    required this.agentName,
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
    contact = json['contact'].forEach((v) {
      contact.add(v);
    });
    createdBy = json['createdBy'];
    eventModule = json['eventModule'];
    agentName = json['agentName'];

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
    data['contact'] = contact.map((v) => v.toJson()).toList();
    data['createdBy'] = createdBy;
    data['eventModule'] = eventModule;
    data['agentName'] = agentName;

    data['callID'] = callID;
    data['callingID'] = callingID;
    data['callerServiceID'] = callerServiceID;
    data['voiceCallEventCode'] = voiceCallEventCode;
    data['invalidNumber'] = invalidNumber;
    data['agrRef'] = agrRef;
    return data;
  }
}

class AddressInvalidEventAttr {
  late String remarks;
  late String followUpPriority;
  late double altitude;
  late double accuracy;
  late double altitudeAccuracy;
  late double heading;
  late double speed;
  late double latitude;
  late double longitude;

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
    return data;
  }
}

class AddressInvalidContact {
  late String cType;
  late String value;
  late String health;
  late String resAddressId_0;

  AddressInvalidContact(
      {required this.cType,
      required this.value,
      required this.health,
      required this.resAddressId_0});

  AddressInvalidContact.fromJson(Map<String, dynamic> json) {
    cType = json['cType'];
    value = json['value'];
    health = json['health'];
    resAddressId_0 = json['resAddressId_0'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cType'] = cType;
    data['value'] = value;
    data['health'] = health;
    data['resAddressId_0'] = resAddressId_0;
    return data;
  }
}
