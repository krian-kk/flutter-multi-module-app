import '../../utils/app_utils.dart';

class DisputePostModel {
  DisputePostModel({
    required this.eventId,
    required this.eventType,
    required this.caseId,
    required this.eventCode,
    required this.eventAttr,
    required this.contact,
    this.createdAt,
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

  DisputePostModel.fromJson(Map<String, dynamic> json) {
    eventId = json['eventId'];
    eventType = json['eventType'];
    caseId = json['caseId'];
    eventCode = json['eventCode'];
    eventAttr = EventAttr.fromJson(json['eventAttr']);
    contact = Contact.fromJson(json['contact']);
    createdAt = json['createdAt'];
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
  late int eventId;
  late String eventType;
  late String caseId;
  late String eventCode;
  late EventAttr eventAttr;
  late Contact contact;
  late String? createdAt;
  late String createdBy;
  late String agentName;
  late String contractor;
  late String eventModule;
  late String agrRef;
  late String? callID;
  late String? callingID;
  late String? callerServiceID;
  late String voiceCallEventCode;
  late String? invalidNumber;

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
    data['contact'] = contact.toJson();
    if (isOnline == false) {
      data['createdAt'] = DateTime.now().toString();
    }
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
  EventAttr({
    required this.actionDate,
    this.disputereasons,
    required this.remarks,
    required this.amountDenied,
    required this.followUpPriority,
    required this.latitude,
    required this.longitude,
    required this.accuracy,
    this.reginalText,
    this.translatedText,
    this.audioS3Path,
  });

  EventAttr.fromJson(Map<String, dynamic> json) {
    actionDate = json['actionDate'];
    disputereasons = json['disputereasons'];
    remarks = json['remarks'];
    amountDenied = json['amountDenied'];
    followUpPriority = json['followUpPriority'];
    latitude = json['Latitude'];
    longitude = json['Longitude'];
    accuracy = json['accuracy'];
    reginalText = json['reginal_text'];
    translatedText = json['translated_text'];
    audioS3Path = json['audioS3Path'];
  }
  late String actionDate;
  late String? disputereasons;
  late String remarks;
  late String amountDenied;
  late String followUpPriority;
  late double latitude;
  late double longitude;
  late double accuracy;
  late String? reginalText;
  late String? translatedText;
  late String? audioS3Path;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['actionDate'] = actionDate;
    data['disputereasons'] = disputereasons;
    data['remarks'] = remarks;
    data['amountDenied'] = amountDenied;
    data['followUpPriority'] = followUpPriority;
    data['Latitude'] = latitude;
    data['Longitude'] = longitude;
    data['accuracy'] = accuracy;
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
