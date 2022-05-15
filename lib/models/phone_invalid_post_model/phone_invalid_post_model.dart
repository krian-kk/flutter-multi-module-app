import '../../utils/app_utils.dart';

class PhoneInvalidPostModel {
  PhoneInvalidPostModel({
    required this.eventId,
    required this.eventType,
    required this.caseId,
    required this.eventCode,
    required this.eventAttr,
    required this.eventModule,
    required this.contact,
    this.createdAt,
    required this.createdBy,
    this.callID,
    this.callingID,
    required this.callerServiceID,
    required this.voiceCallEventCode,
    this.invalidNumber,
    required this.agentName,
    required this.contractor,
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
    createdAt = json['createdAt'];
    createdBy = json['createdBy'];
    callID = json['callID'];
    callingID = json['callingID'];
    callerServiceID = json['callerServiceID'];
    voiceCallEventCode = json['voiceCallEventCode'];
    invalidNumber = json['invalidNumber'];
    agentName = json['agentName'];
    contractor = json['contractor'];
    agrRef = json['agrRef'];
  }
  late int eventId;
  late String eventType;
  late String caseId;
  late String eventCode;
  late PhoneInvalidEventAttr eventAttr;
  late String eventModule;
  late PhoneInvalidContact contact;
  late String? createdAt;
  late String createdBy;
  late String? callID;
  late String? callingID;
  late String? callerServiceID;
  late String voiceCallEventCode;
  late String? invalidNumber;
  late String agentName;
  late String contractor;
  late String agrRef;

  Map<String, dynamic> toJson() {
    bool isOnline = true;
    AppUtils.checkNetworkConnection().then((value) {
      isOnline = value;
    });
    final Map<String, dynamic> data = <String, dynamic>{};
    data['eventId'] = eventId;
    data['eventType'] = eventType;
    data['caseId'] = caseId;
    data['eventCode'] = eventCode;
    data['eventAttr'] = eventAttr.toJson();
    data['eventModule'] = eventModule;
    data['contact'] = contact.toJson();
    if (isOnline == false) {
      data['createdAt'] = DateTime.now().toString();
    }
    data['createdBy'] = createdBy;
    data['callID'] = callID;
    data['callingID'] = callingID;
    data['callerServiceID'] = callerServiceID;
    data['voiceCallEventCode'] = voiceCallEventCode;
    data['invalidNumber'] = invalidNumber;
    data['agentName'] = agentName;
    data['contractor'] = contractor;
    data['agrRef'] = agrRef;
    return data;
  }
}

class PhoneInvalidEventAttr {
  PhoneInvalidEventAttr({
    required this.remarks,
    required this.followUpPriority,
    // required this.nextActionDate,
    this.reginalText,
    this.translatedText,
    this.audioS3Path,
  });

  PhoneInvalidEventAttr.fromJson(Map<String, dynamic> json) {
    remarks = json['remarks'];
    followUpPriority = json['followUpPriority'];
    // nextActionDate = json['nextActionDate'];
    reginalText = json['reginal_text'];
    translatedText = json['translated_text'];
    audioS3Path = json['audioS3Path'];
  }
  late String? remarks;
  late String followUpPriority;
  // late String nextActionDate;
  late String? reginalText;
  late String? translatedText;
  late String? audioS3Path;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['remarks'] = remarks;
    data['followUpPriority'] = followUpPriority;
    // data['nextActionDate'] = nextActionDate;
    if (reginalText != null && translatedText != null && audioS3Path != null) {
      data['reginal_text'] = reginalText;
      data['translated_text'] = translatedText;
      data['audioS3Path'] = audioS3Path;
    }
    return data;
  }
}

class PhoneInvalidContact {
  PhoneInvalidContact({
    required this.cType,
    required this.value,
    this.contactId0 = '',
    required this.health,
  });

  PhoneInvalidContact.fromJson(Map<String, dynamic> json) {
    cType = json['cType'];
    value = json['value'];
    contactId0 = json['contactId_0'];
    health = json['health'];
  }
  late String cType;
  late String value;
  late String contactId0;
  late String health;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cType'] = cType;
    data['value'] = value;
    data['contactId_0'] = contactId0;
    data['health'] = health;
    return data;
  }
}
