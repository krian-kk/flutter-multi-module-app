import 'package:origa/utils/app_utils.dart';

class PTPPostModel {
  PTPPostModel(
      {required this.eventId,
      required this.eventType,
      required this.caseId,
      required this.eventCode,
      required this.eventAttr,
      required this.createdBy,
      this.createdAt,
      required this.agentName,
      required this.contractor,
      required this.eventModule,
      required this.contact,
      required this.agrRef,
      this.callID,
      this.callingID,
      required this.callerServiceID,
      required this.voiceCallEventCode,
      required this.invalidNumber});

  PTPPostModel.fromJson(Map<String, dynamic> json) {
    eventId = json['eventId'];
    eventType = json['eventType'];
    caseId = json['caseId'];
    eventCode = json['eventCode'];
    eventAttr = EventAttr.fromJson(json['eventAttr']);
    createdBy = json['createdBy'];
    createdAt = json['createdAt'];
    agentName = json['agentName'];
    contractor = json['contractor'];
    eventModule = json['eventModule'];
    contact = PTPContact.fromJson(json['contact']);
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
  late String createdBy;
  late String? createdAt;
  late String agentName;
  late String contractor;
  late String eventModule;
  late PTPContact contact;
  late String agrRef;
  late String? callID;
  late String? callingID;
  late String? callerServiceID;
  late String? voiceCallEventCode;
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
    data['createdBy'] = createdBy;
    if (isOnline == false) {
      data['createdAt'] = DateTime.now().toString();
    }
    data['agentName'] = agentName;
    data['contractor'] = contractor;
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
    this.reginalText,
    this.translatedText,
    this.audioS3Path,
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
    reginalText = json['reginal_text'];
    translatedText = json['translated_text'];
    audioS3Path = json['audioS3Path'];
  }
  late String date;
  late String time;
  late String remarks;
  late int ptpAmount;
  late String? reference;
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
  late String? reginalText;
  late String? translatedText;
  late String? audioS3Path;

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
    if (reginalText != null && translatedText != null && audioS3Path != null) {
      data['reginal_text'] = reginalText;
      data['translated_text'] = translatedText;
      data['audioS3Path'] = audioS3Path;
    }

    return data;
  }
}

// class AgentLocation {
//   late double latitude;
//   late double longitude;
//   late String missingAgentLocation;

//   AgentLocation(
//       {required this.latitude,
//       required this.longitude,
//       required this.missingAgentLocation});

//   AgentLocation.fromJson(Map<String, dynamic> json) {
//     latitude = json['latitude'];
//     longitude = json['longitude'];
//     missingAgentLocation = json['missingAgentLocation'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['latitude'] = latitude;
//     data['longitude'] = longitude;
//     data['missingAgentLocation'] = missingAgentLocation;
//     return data;
//   }
// }

class PTPContact {
  PTPContact(
      {required this.cType,
      required this.health,
      required this.value,
      required this.resAddressId0,
      required this.contactId0});

  PTPContact.fromJson(Map<String, dynamic> json) {
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
