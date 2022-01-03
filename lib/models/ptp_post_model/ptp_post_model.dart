class PTPPostModel {
  late int eventId;
  late String eventType;
  late String caseId;
  late String eventCode;
  late EventAttr eventAttr;
  late String createdBy;
  late String agentName;
  late String eventModule;
  late PTPContact contact;
  late String agrRef;
  late String? callID;
  late String? callingID;
  late String? callerServiceID;
  late String? voiceCallEventCode;
  late double? invalidNumber;

  PTPPostModel(
      {required this.eventId,
      required this.eventType,
      required this.caseId,
      required this.eventCode,
      required this.eventAttr,
      required this.createdBy,
      required this.agentName,
      required this.eventModule,
      required this.contact,
      required this.agrRef,
      this.callID,
      this.callingID,
      this.callerServiceID,
      required this.voiceCallEventCode,
      this.invalidNumber});

  PTPPostModel.fromJson(Map<String, dynamic> json) {
    eventId = json['eventId'];
    eventType = json['eventType'];
    caseId = json['caseId'];
    eventCode = json['eventCode'];
    eventAttr = EventAttr.fromJson(json['eventAttr']);
    createdBy = json['createdBy'];
    agentName = json['agentName'];
    eventModule = json['eventModule'];
    contact = PTPContact.fromJson(json['contact']);
    agrRef = json['agrRef'];
    callID = json['callID'];
    callingID = json['callingID'];
    callerServiceID = json['callerServiceID'];
    voiceCallEventCode = json['voiceCallEventCode'];
    invalidNumber = json['invalidNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['eventId'] = eventId;
    data['eventType'] = eventType;
    data['caseId'] = caseId;
    data['eventCode'] = eventCode;
    data['eventAttr'] = eventAttr.toJson();
    data['createdBy'] = createdBy;
    data['agentName'] = agentName;
    data['eventModule'] = eventModule;
    data['contact'] = contact.toJson();
    data['agrRef'] = agrRef;

    data['callID'] = callID;
    data['callingID'] = callingID;
    data['callerServiceID'] = callerServiceID;
    data['voiceCallEventCode'] = voiceCallEventCode;
    data['invalidNumber'] = invalidNumber;
    return data;
  }
}

class EventAttr {
  late String date;
  late String time;
  late String remarks;
  late int ptpAmount;
  late String reference;
  late String mode;
  late String? pTPType;
  late String followUpPriority;
  late double altitude;
  late double accuracy;
  late double? altitudeAccuracy;
  late double heading;
  late double speed;
  late double latitude;
  late double longitude;

  EventAttr({
    required this.date,
    required this.time,
    required this.remarks,
    required this.ptpAmount,
    required this.reference,
    required this.mode,
    required this.pTPType,
    required this.followUpPriority,
    this.altitude = 0,
    this.accuracy = 0,
    this.altitudeAccuracy,
    this.heading = 0,
    this.speed = 0,
    this.latitude = 0,
    this.longitude = 0,
  });

  EventAttr.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    time = json['time'];
    remarks = json['remarks'];
    ptpAmount = json['ptpAmount'];
    reference = json['reference'];
    mode = json['mode'];
    pTPType = json['PTPType'];
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
    data['date'] = date;
    data['time'] = time;
    data['remarks'] = remarks;
    data['ptpAmount'] = ptpAmount;
    data['reference'] = reference;
    data['mode'] = mode;
    data['PTPType'] = pTPType;
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

class AgentLocation {
  late double latitude;
  late double longitude;
  late String missingAgentLocation;

  AgentLocation(
      {required this.latitude,
      required this.longitude,
      required this.missingAgentLocation});

  AgentLocation.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
    missingAgentLocation = json['missingAgentLocation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['missingAgentLocation'] = missingAgentLocation;
    return data;
  }
}

class PTPContact {
  late String cType;
  late String health;
  late String value;
  late String resAddressId0;
  late String contactId0;

  PTPContact(
      {required this.cType,
      required this.health,
      required this.value,
      this.resAddressId0 = '',
      this.contactId0 = ''});

  PTPContact.fromJson(Map<String, dynamic> json) {
    cType = json['cType'];
    health = json['health'];
    value = json['value'];
    resAddressId0 = json['resAddressId_0'];
    contactId0 = json['contactId_0'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cType'] = cType;
    data['health'] = health;
    data['value'] = value;
    data['resAddressId_0'] = resAddressId0;
    data['contactId_0'] = contactId0;
    return data;
  }
}
