class PostImageCapturedModel {
  late int eventId;
  late String eventType;
  late String caseId;
  late String? eventCode;
  late EventAttr eventAttr;
  late String createdBy;
  late String eventModule;
  late String? callID;
  late String? callingID;
  late String callerServiceID;
  late String voiceCallEventCode;
  late int? invalidNumber;
  late String agentName;
  late String agrRef;

  PostImageCapturedModel({
    this.eventId = 22,
    required this.eventType,
    required this.caseId,
    this.eventCode = "TELEVT015",
    required this.eventAttr,
    required this.createdBy,
    required this.eventModule,
    this.callID,
    this.callingID,
    this.callerServiceID = "e",
    this.voiceCallEventCode = "TELEVT011",
    this.invalidNumber,
    required this.agentName,
    required this.agrRef,
  });

  PostImageCapturedModel.fromJson(Map<String, dynamic> json) {
    eventId = json['eventId'];
    eventType = json['eventType'];
    caseId = json['caseId'];
    eventCode = json['eventCode'];
    eventAttr = (json['eventAttr'] != null
        ? EventAttr.fromJson(json['eventAttr'])
        : null)!;
    createdBy = json['createdBy'];
    eventModule = json['eventModule'];
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
    data['createdBy'] = createdBy;
    data['eventModule'] = eventModule;
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

class EventAttr {
  late String remarks;
  late List<String> imageLocation;
  late double altitude;
  late double accuracy;
  late double altitudeAccuracy;
  late double heading;
  late double speed;
  late double latitude;
  late double longitude;
  late AgentLocation? agentLocation;

  EventAttr(
      {required this.remarks,
      required this.imageLocation,
      this.altitude = 0.0,
      this.accuracy = 0.0,
      this.altitudeAccuracy = 0.0,
      this.heading = 0.0,
      this.speed = 0.0,
      this.latitude = 0.0,
      this.longitude = 0.0,
      this.agentLocation});

  EventAttr.fromJson(Map<String, dynamic> json) {
    remarks = json['remarks'];
    imageLocation = json['imageLocation'].cast<String>();
    altitude = json['altitude'];
    accuracy = json['accuracy'];
    altitudeAccuracy = json['altitudeAccuracy'];
    heading = json['heading'];
    speed = json['speed'];
    latitude = json['Latitude'];
    longitude = json['Longitude'];
    agentLocation = json['agentLocation'] != null
        ? AgentLocation.fromJson(json['agentLocation'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['remarks'] = remarks;
    data['imageLocation'] = imageLocation;
    data['altitude'] = altitude;
    data['accuracy'] = accuracy;
    data['altitudeAccuracy'] = altitudeAccuracy;
    data['heading'] = heading;
    data['speed'] = speed;
    data['Latitude'] = latitude;
    data['Longitude'] = longitude;
    if (agentLocation != null) {
      data['agentLocation'] = agentLocation!.toJson();
    }
    return data;
  }
}

class AgentLocation {
  int? latitude;
  int? longitude;
  String? missingAgentLocation;

  AgentLocation(
      {this.latitude = 0,
      this.longitude = 0,
      this.missingAgentLocation = "true"});

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
