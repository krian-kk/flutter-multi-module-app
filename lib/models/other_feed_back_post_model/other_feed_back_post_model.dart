class OtherFeedBackPostModel {
  late int eventId;
  late String eventType;
  late String caseId;
  late String eventCode;
  late EventAttr eventAttr;
  late OtherFeedBackContact contact;
  late String createdBy;
  late String eventModule;
  late String agentName;
  late String contractor;
  late String agrRef;
  late String callID;
  late String callingID;
  late String callerServiceID;
  late String voiceCallEventCode;
  late String invalidNumber;

  OtherFeedBackPostModel({
    required this.eventId,
    required this.eventType,
    required this.caseId,
    required this.eventCode,
    required this.eventAttr,
    required this.contact,
    required this.createdBy,
    required this.eventModule,
    required this.agentName,
    required this.contractor,
    required this.agrRef,
    required this.callID,
    required this.callingID,
    required this.callerServiceID,
    required this.voiceCallEventCode,
    this.invalidNumber = '0',
  });

  OtherFeedBackPostModel.fromJson(Map<String, dynamic> json) {
    eventId = json['eventId'];
    eventType = json['eventType'];
    caseId = json['caseId'];
    eventCode = json['eventCode'];
    eventAttr = EventAttr.fromJson(json['eventAttr']);
    contact = OtherFeedBackContact.fromJson(json['contact']);
    createdBy = json['createdBy'];
    eventModule = json['eventModule'];
    agentName = json['agentName'];
    contractor = json['contractor'];
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
    data['contact'] = contact.toJson();
    data['createdBy'] = createdBy;
    data['eventModule'] = eventModule;
    data['agentName'] = agentName;
    data['contractor'] = contractor;
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
  late bool vehicleavailable;
  late String collectorfeedback;
  late String actionproposed;
  late String actionDate;
  late String remarks;
  late List<String> imageLocation;
  late String followUpPriority;
  late double altitude;
  late double accuracy;
  late double altitudeAccuracy;
  late double heading;
  late double speed;
  late double latitude;
  late double longitude;
  // late double distance;
  // late AgentLocation agentLocation;
  late List<OtherFeedBackContact>? contact;

  EventAttr({
    required this.vehicleavailable,
    required this.actionDate,
    required this.collectorfeedback,
    required this.actionproposed,
    required this.remarks,
    required this.imageLocation,
    this.followUpPriority = 'RETRY',
    required this.altitude,
    required this.accuracy,
    required this.altitudeAccuracy,
    required this.heading,
    required this.speed,
    required this.latitude,
    required this.longitude,
    // this.distance = 0,
    // required this.agentLocation,
    required this.contact,
  });

  EventAttr.fromJson(Map<String, dynamic> json) {
    vehicleavailable = json['vehicleavailable'];
    collectorfeedback = json['collectorfeedback'];
    actionproposed = json['actionproposed'];
    actionDate = json['actionDate'];
    remarks = json['remarks'];
    imageLocation = json['imageLocation'].cast<String>();
    followUpPriority = json['followUpPriority'];
    altitude = json['altitude'];
    accuracy = json['accuracy'];
    altitudeAccuracy = json['altitudeAccuracy'];
    heading = json['heading'];
    speed = json['speed'];
    latitude = json['Latitude'];
    longitude = json['Longitude'];
    // distance = json['distance'];
    // agentLocation = AgentLocation.fromJson(json['agentLocation']);
    contact = json['contact'].forEach((v) {
      contact?.add(v);
    });
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['vehicleavailable'] = vehicleavailable;
    data['collectorfeedback'] = collectorfeedback;
    data['actionproposed'] = actionproposed;
    data['actionDate'] = actionDate;
    data['remarks'] = remarks;
    data['imageLocation'] = imageLocation;
    data['followUpPriority'] = followUpPriority;
    data['altitude'] = altitude;
    data['accuracy'] = accuracy;
    data['altitudeAccuracy'] = altitudeAccuracy;
    data['heading'] = heading;
    data['speed'] = speed;
    data['Latitude'] = latitude;
    data['Longitude'] = longitude;
    // data['distance'] = distance;
    // data['agentLocation'] = agentLocation.toJson();
    data['contact'] = contact?.map((v) => v.toJson()).toList();
    return data;
  }
}

class AgentLocation {
  late double latitude;
  late double longitude;
  late String missingAgentLocation;

  AgentLocation(
      {this.latitude = 0,
      this.longitude = 0,
      this.missingAgentLocation = 'true'});

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

class OtherFeedBackContact {
  late String cType;
  late String? health;
  late String value;
  late String resAddressId0;
  late String contactId0;

  OtherFeedBackContact({
    required this.cType,
    this.health,
    required this.value,
    required this.resAddressId0,
    required this.contactId0,
  });

  OtherFeedBackContact.fromJson(Map<String, dynamic> json) {
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
