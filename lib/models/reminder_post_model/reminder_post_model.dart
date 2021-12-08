class ReminderPostAPI {
  late int eventId;
  late String eventType;
  late String caseId;
  late String eventCode;
  late EventAttr eventAttr;
  late Contact contact;
  late String createdBy;
  late String agentName;
  late String eventModule;
  late String contractor;
  late String agrRef;
  late String callID;
  late String callingID;
  late String callerServiceID;
  late String voiceCallEventCode;
  late int invalidNumber;

  ReminderPostAPI(
      {this.eventId = 0,
      required this.eventType,
      required this.caseId,
      required this.eventCode,
      required this.eventAttr,
      required this.contact,
      this.createdBy = '',
      this.agentName = '',
      this.eventModule = 'Field Allocation',
      this.contractor = '0',
      this.agrRef = '0',
      required this.callID,
      required this.callingID,
      this.callerServiceID = '',
      this.voiceCallEventCode = '',
      this.invalidNumber = 0});

  ReminderPostAPI.fromJson(Map<String, dynamic> json) {
    eventId = json['eventId'];
    eventType = json['eventType'];
    caseId = json['caseId'];
    eventCode = json['eventCode'];
    eventAttr = EventAttr.fromJson(json['eventAttr']);
    contact = Contact.fromJson(json['contact']);
    createdBy = json['createdBy'];
    agentName = json['agentName'];
    eventModule = json['eventModule'];
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
    data['agentName'] = agentName;
    data['eventModule'] = eventModule;
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
  late String reminderDate;
  late String time;
  late String remarks;
  late String followUpPriority;
  late int altitude;
  late int accuracy;
  late int altitudeAccuracy;
  late int heading;
  late int speed;
  late int latitude;
  late int longitude;
  late int distance;
  late AgentLocation agentLocation;

  EventAttr(
      {required this.reminderDate,
      required this.time,
      required this.remarks,
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
    reminderDate = json['reminderDate'];
    time = json['time'];
    remarks = json['remarks'];
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
    data['reminderDate'] = reminderDate;
    data['time'] = time;
    data['remarks'] = remarks;
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
  late int latitude;
  late int longitude;
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

class Contact {
  late String cType;
  late String health;
  late String value;
  late String resAddressId0;
  late String contactId0;

  Contact(
      {required this.cType,
      this.health = '1',
      required this.value,
      this.resAddressId0 = '',
      this.contactId0 = ''});

  Contact.fromJson(Map<String, dynamic> json) {
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
