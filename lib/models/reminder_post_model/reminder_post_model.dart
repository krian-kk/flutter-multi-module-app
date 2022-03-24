class ReminderPostAPI {
  late int eventId;
  late String eventType;
  late String caseId;
  late String eventCode;
  late EventAttr eventAttr;
  late Contact contact;
  late String createdBy;
  late String agentName;
  late String contractor;
  late String eventModule;
  late String agrRef;
  late String? callID;
  late String? callingID;
  late String callerServiceID;
  late String voiceCallEventCode;
  late bool? invalidNumber;

  ReminderPostAPI({
    required this.eventId,
    required this.eventType,
    required this.caseId,
    required this.eventCode,
    required this.eventAttr,
    required this.contact,
    required this.createdBy,
    required this.agentName,
    required this.contractor,
    required this.eventModule,
    required this.agrRef,
    required this.callID,
    required this.callingID,
    required this.callerServiceID,
    required this.voiceCallEventCode,
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
    contractor = json['contractor'];
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
    data['contractor'] = contractor;
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
  late double latitude;
  late double longitude;
  // ignore: non_constant_identifier_names
  late String? reginal_text;
  // ignore: non_constant_identifier_names
  late String? translated_text;
  late String? audioS3Path;

  EventAttr({
    required this.reminderDate,
    required this.time,
    required this.remarks,
    this.followUpPriority = 'RETRY',
    required this.latitude,
    required this.longitude,
    // ignore: non_constant_identifier_names
    this.reginal_text,
    // ignore: non_constant_identifier_names
    this.translated_text,
    this.audioS3Path,
  });

  EventAttr.fromJson(Map<String, dynamic> json) {
    reminderDate = json['reminderDate'];
    time = json['time'];
    remarks = json['remarks'];
    followUpPriority = json['followUpPriority'];
    latitude = json['Latitude'];
    longitude = json['Longitude'];
    reginal_text = json['reginal_text'];
    translated_text = json['translated_text'];
    audioS3Path = json['audioS3Path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['reminderDate'] = reminderDate;
    data['time'] = time;
    data['remarks'] = remarks;
    data['followUpPriority'] = followUpPriority;
    data['Latitude'] = latitude;
    data['Longitude'] = longitude;
    if (reginal_text != null &&
        translated_text != null &&
        audioS3Path != null) {
      data['reginal_text'] = reginal_text;
      data['translated_text'] = translated_text;
      data['audioS3Path'] = audioS3Path;
    }
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
      required this.health,
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
