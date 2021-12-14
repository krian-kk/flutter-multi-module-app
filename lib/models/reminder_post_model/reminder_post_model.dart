class ReminderPostAPI {
  late double eventId;
  late String eventType;
  late String caseId;
  late String eventCode;
  late EventAttr eventAttr;
  late Contact contact;
  late String createdBy;
  late String agentName;
  late String eventModule;
  late String agrRef;
  late String? callID;
  late String? callingID;
  late String callerServiceID;
  late String voiceCallEventCode;
  late double? invalidNumber;

  ReminderPostAPI({
    this.eventId = 19,
    required this.eventType,
    required this.caseId,
    required this.eventCode,
    required this.eventAttr,
    required this.contact,
    this.createdBy = '',
    this.agentName = 'SUVODEEP TELECALLER changed 3',
    this.eventModule = 'Field Allocation',
    this.agrRef = 'YES_SD00001',
    this.callID,
    this.callingID,
    this.callerServiceID = 'Kaleyra_123',
    this.voiceCallEventCode = 'TELEVT011',
    this.invalidNumber,
  });

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
  late double altitude;
  late double accuracy;
  late double altitudeAccuracy;
  late double heading;
  late double speed;
  late double latitude;
  late double longitude;

  EventAttr({
    required this.reminderDate,
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
  });

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
