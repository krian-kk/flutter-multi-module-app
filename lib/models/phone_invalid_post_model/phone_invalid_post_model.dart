class PhoneInvalidPostModel {
  late int eventId;
  late String eventType;
  late String caseId;
  late String eventCode;
  late PhoneInvalidEventAttr eventAttr;
  late String eventModule;
  late PhoneInvalidContact contact;
  late String createdBy;
  late String? callID;
  late String? callingID;
  late String callerServiceID;
  late String voiceCallEventCode;
  late int? invalidNumber;
  late String agentName;
  late String agrRef;

  PhoneInvalidPostModel({
    this.eventId = 0,
    required this.eventType,
    required this.caseId,
    required this.eventCode,
    required this.eventAttr,
    required this.eventModule,
    required this.contact,
    this.createdBy = '',
    this.callID,
    this.callingID,
    this.callerServiceID = 'Kaleyra_123',
    this.voiceCallEventCode = 'TELEVT011',
    this.invalidNumber,
    required this.agentName,
    required this.agrRef,
  });

  PhoneInvalidPostModel.fromJson(Map<String, dynamic> json) {
    eventId = json['eventId'];
    eventType = json['eventType'];
    caseId = json['caseId'];
    eventCode = json['eventCode'];
    eventAttr = PhoneInvalidEventAttr.fromJson(json['eventAttr']);
    eventModule = json['eventModule'];
    contact = PhoneInvalidContact.fromJson(json['contact']);
    createdBy = json['createdBy'];
    callID = json['callID'];
    callingID = json['callingID'];
    callerServiceID = json['callerServiceID'];
    voiceCallEventCode = json['voiceCallEventCode'];
    invalidNumber = json['invalidNumber'];
    agentName = json['agentName'];
    agrRef = json['agrRef'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['eventId'] = eventId;
    data['eventType'] = eventType;
    data['caseId'] = caseId;
    data['eventCode'] = eventCode;
    data['eventAttr'] = eventAttr.toJson();
    data['eventModule'] = eventModule;
    data['contact'] = contact.toJson();
    data['createdBy'] = createdBy;
    data['callID'] = callID;
    data['callingID'] = callingID;
    data['callerServiceID'] = callerServiceID;
    data['voiceCallEventCode'] = voiceCallEventCode;
    data['invalidNumber'] = invalidNumber;
    data['agentName'] = agentName;
    data['agrRef'] = agrRef;
    return data;
  }
}

class PhoneInvalidEventAttr {
  late String remarks;
  late String followUpPriority;
  late String nextActionDate;

  PhoneInvalidEventAttr(
      {required this.remarks,
      this.followUpPriority = 'AWAITING CONTACT',
      required this.nextActionDate});

  PhoneInvalidEventAttr.fromJson(Map<String, dynamic> json) {
    remarks = json['remarks'];
    followUpPriority = json['followUpPriority'];
    nextActionDate = json['nextActionDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['remarks'] = remarks;
    data['followUpPriority'] = followUpPriority;
    data['nextActionDate'] = nextActionDate;
    return data;
  }
}

class PhoneInvalidContact {
  late String cType;
  late String value;
  late String contactId0;
  late String health;

  PhoneInvalidContact(
      {required this.cType,
      required this.value,
      this.contactId0 = '',
      this.health = ''});

  PhoneInvalidContact.fromJson(Map<String, dynamic> json) {
    cType = json['cType'];
    value = json['value'];
    contactId0 = json['contactId_0'];
    health = json['health'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cType'] = cType;
    data['value'] = value;
    data['contactId_0'] = contactId0;
    data['health'] = health;
    return data;
  }
}
