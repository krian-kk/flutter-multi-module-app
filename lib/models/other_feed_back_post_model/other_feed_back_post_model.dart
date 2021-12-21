class OtherFeedBackPostModel {
  late double eventId;
  late String eventType;
  late String caseId;
  late String eventCode;
  late EventAttr eventAttr;
  late List<OtherFeedBackContact> contact;
  late String createdBy;
  late String eventModule;
  late String agentName;
  late String contractor;
  late String agrRef;
  late String callID;
  late String callingID;
  late String callerServiceID;
  late String voiceCallEventCode;
  late double invalidNumber;

  OtherFeedBackPostModel(
      {this.eventId = 0,
      required this.eventType,
      required this.caseId,
      required this.eventCode,
      required this.eventAttr,
      required this.contact,
      this.createdBy = '',
      this.eventModule = 'Field Allocation',
      this.agentName = '',
      this.contractor = '',
      this.agrRef = '0',
      this.callID = '0',
      this.callingID = '0',
      this.callerServiceID = '',
      this.voiceCallEventCode = '',
      this.invalidNumber = 0});

  OtherFeedBackPostModel.fromJson(Map<String, dynamic> json) {
    eventId = json['eventId'];
    eventType = json['eventType'];
    caseId = json['caseId'];
    eventCode = json['eventCode'];
    eventAttr = EventAttr.fromJson(json['eventAttr']);
    contact = json['contact'].forEach((v) {
      contact.add(v);
    });
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
    data['contact'] = contact.map((v) => v.toJson()).toList();
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
  late double distance;
  late AgentLocation agentLocation;

  EventAttr(
      {required this.actionDate,
      this.remarks = '',
      required this.imageLocation,
      this.followUpPriority = 'RETRY',
      this.altitude = 0,
      this.accuracy = 0,
      this.altitudeAccuracy = 0,
      this.heading = 0,
      this.speed = 0,
      this.latitude = 0,
      this.longitude = 0,
      this.distance = 0,
      required this.agentLocation});

  EventAttr.fromJson(Map<String, dynamic> json) {
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
    distance = json['distance'];
    agentLocation = AgentLocation.fromJson(json['agentLocation']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
    data['distance'] = distance;
    data['agentLocation'] = agentLocation.toJson();
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
  late String health;
  late String value;
  late String resAddressId0;
  late String contactId0;

  OtherFeedBackContact(
      {this.cType = 'residence address',
      this.health = '1',
      this.value = '0',
      this.resAddressId0 = '',
      this.contactId0 = ''});

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
