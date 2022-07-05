class NotEligiblePostEvent {
  NotEligiblePostEvent({
    this.eventId,
    this.eventType,
    this.caseId,
    this.eventAttr,
    this.eventCode,
    this.createdBy,
    this.agentName,
    this.eventModule,
    this.callID,
    this.callingID,
    this.callerServiceID,
    this.voiceCallEventCode,
    this.invalidNumber,
    this.agrRef,
    this.contractor,
    required this.contact,
  });

  NotEligiblePostEvent.fromJson(Map<String, dynamic> json) {
    eventId = json['eventId'];
    eventType = json['eventType'];
    caseId = json['caseId'];
    eventAttr = json['eventAttr'] != null
        ? EventAttr.fromJson(json['eventAttr'])
        : null;
    eventCode = json['eventCode'];
    createdBy = json['createdBy'];
    agentName = json['agentName'];
    eventModule = json['eventModule'];
    callID = json['callID'];
    callingID = json['callingID'];
    callerServiceID = json['callerServiceID'];
    voiceCallEventCode = json['voiceCallEventCode'];
    invalidNumber = json['invalidNumber'];
    agrRef = json['agrRef'];
    contractor = json['contractor'];
    contact = Contact.fromJson(json['contact']);
  }
  int? eventId;
  String? eventType;
  String? caseId;
  EventAttr? eventAttr;
  String? eventCode;
  String? createdBy;
  String? agentName;
  String? eventModule;
  String? callID;
  String? callingID;
  String? callerServiceID;
  String? voiceCallEventCode;
  String? invalidNumber;
  String? agrRef;
  String? contractor;
  late Contact contact;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['eventId'] = eventId;
    data['eventType'] = eventType;
    data['caseId'] = caseId;
    if (eventAttr != null) {
      data['eventAttr'] = eventAttr!.toJson();
    }
    data['eventCode'] = eventCode;
    data['createdBy'] = createdBy;
    data['agentName'] = agentName;
    data['eventModule'] = eventModule;
    data['callID'] = callID;
    data['callingID'] = callingID;
    data['callerServiceID'] = callerServiceID;
    data['voiceCallEventCode'] = voiceCallEventCode;
    data['invalidNumber'] = invalidNumber;
    data['agrRef'] = agrRef;
    data['contractor'] = contractor;
    data['contact'] = contact.toJson();
    return data;
  }
}

class EventAttr {
  EventAttr.fromJson(Map<String, dynamic> json) {
    reasonForNotInterested = json['reasonForNotInterested'];
    remarks = json['remarks'];
    reginalText = json['reginal_text'];
    translatedText = json['translated_text'];
    audioS3Path = json['audioS3Path'];
  }
  EventAttr({
    this.reasonForNotInterested,
    this.remarks,
    this.reginalText,
    this.translatedText,
    this.audioS3Path,
  });

  String? reasonForNotInterested;
  String? remarks;
  late String? reginalText;
  late String? translatedText;
  late String? audioS3Path;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reasonForNotInterested'] = reasonForNotInterested;
    data['remarks'] = remarks;
    if (reginalText != null && translatedText != null && audioS3Path != null) {
      data['reginal_text'] = reginalText;
      data['translated_text'] = translatedText;
      data['audioS3Path'] = audioS3Path;
    }
    return data;
  }
}

class Contact {
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
  late String cType;
  late String health;
  late String value;
  late String resAddressId0;
  late String contactId0;

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
