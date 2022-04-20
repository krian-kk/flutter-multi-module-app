class OtherFeedBackPostModel {
  OtherFeedBackPostModel({
    required this.eventId,
    required this.eventType,
    required this.caseId,
    required this.eventCode,
    required this.eventAttr,
    required this.contact,
    this.createdAt,
    required this.createdBy,
    required this.eventModule,
    required this.agentName,
    required this.contractor,
    required this.agrRef,
    required this.callID,
    required this.callingID,
    required this.callerServiceID,
    required this.voiceCallEventCode,
    this.invalidNumber,
  });

  OtherFeedBackPostModel.fromJson(Map<String, dynamic> json) {
    eventId = json['eventId'];
    eventType = json['eventType'];
    caseId = json['caseId'];
    eventCode = json['eventCode'];
    eventAttr = EventAttr.fromJson(json['eventAttr']);
    contact = OtherFeedBackContact.fromJson(json['contact']);
    createdAt = json['createdAt'];
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
  late int eventId;
  late String eventType;
  late String caseId;
  late String eventCode;
  late EventAttr eventAttr;
  late OtherFeedBackContact contact;
  late String? createdAt;
  late String createdBy;
  late String eventModule;
  late String agentName;
  late String contractor;
  late String agrRef;
  late String callID;
  late String callingID;
  late String callerServiceID;
  late String voiceCallEventCode;
  late bool? invalidNumber;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['eventId'] = eventId;
    data['eventType'] = eventType;
    data['caseId'] = caseId;
    data['eventCode'] = eventCode;
    data['eventAttr'] = eventAttr.toJson();
    data['contact'] = contact.toJson();
    data['createdAt'] = createdAt;
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
    required this.contact,
    this.reginalText,
    this.translatedText,
    this.audioS3Path,
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
    contact = json['contact'].forEach((dynamic v) {
      contact?.add(v);
    });
    reginalText = json['reginal_text'];
    translatedText = json['translated_text'];
    audioS3Path = json['audioS3Path'];
  }
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
  late List<dynamic>? contact;
  late String? reginalText;
  late String? translatedText;
  late String? audioS3Path;

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
    data['contact'] = contact?.map((dynamic v) => v.toJson()).toList();
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
//       {this.latitude = 0,
//       this.longitude = 0,
//       this.missingAgentLocation = 'true'});

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

class OtherFeedBackContact {
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
  late String cType;
  late String? health;
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
