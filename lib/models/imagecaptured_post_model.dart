class PostImageCapturedModel {
  int? eventId;
  String? eventType;
  late String caseId;
  String? eventCode;
  late EventAttr eventAttr;
  String? createdBy;
  String? eventModule;
  String? callID;
  String? callingID;
  String? callerServiceID;
  String? voiceCallEventCode;
  int? invalidNumber;
  String? agentName;
  String? contractor;
  String? agrRef;

  PostImageCapturedModel(
      {this.eventId = 0,
      this.eventType = "IMAGE CAPTURED",
      required this.caseId,
      this.eventCode = "TELEVT015",
      required this.eventAttr,
      this.createdBy = '',
      this.eventModule = 'Field Allocation',
      this.callID = "0",
      this.callingID = "0",
      this.callerServiceID = "",
      this.voiceCallEventCode = "",
      this.invalidNumber = 0,
      this.agentName = "",
      this.contractor = "",
      this.agrRef = ""});

  PostImageCapturedModel.fromJson(Map<String, dynamic> json) {
    eventId = json['eventId'];
    eventType = json['eventType'];
    caseId = json['caseId'];
    eventCode = json['eventCode'];
    eventAttr = (json['eventAttr'] != null
        ? new EventAttr.fromJson(json['eventAttr'])
        : null)!;
    createdBy = json['createdBy'];
    eventModule = json['eventModule'];
    callID = json['callID'];
    callingID = json['callingID'];
    callerServiceID = json['callerServiceID'];
    voiceCallEventCode = json['voiceCallEventCode'];
    invalidNumber = json['invalidNumber'];
    agentName = json['agentName'];
    contractor = json['contractor'];
    agrRef = json['agrRef'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['eventId'] = this.eventId;
    data['eventType'] = this.eventType;
    data['caseId'] = this.caseId;
    data['eventCode'] = this.eventCode;
    if (this.eventAttr != null) {
      data['eventAttr'] = this.eventAttr.toJson();
    }
    data['createdBy'] = this.createdBy;
    data['eventModule'] = this.eventModule;
    data['callID'] = this.callID;
    data['callingID'] = this.callingID;
    data['callerServiceID'] = this.callerServiceID;
    data['voiceCallEventCode'] = this.voiceCallEventCode;
    data['invalidNumber'] = this.invalidNumber;
    data['agentName'] = this.agentName;
    data['contractor'] = this.contractor;
    data['agrRef'] = this.agrRef;
    return data;
  }
}

class EventAttr {
  late String remarks;
  late List<String> imageLocation;
  int? altitude;
  int? accuracy;
  int? altitudeAccuracy;
  int? heading;
  int? speed;
  int? latitude;
  int? longitude;
  int? distance;
  AgentLocation? agentLocation;

  EventAttr(
      {required this.remarks,
      required this.imageLocation,
      this.altitude = 0,
      this.accuracy = 0,
      this.altitudeAccuracy = 0,
      this.heading = 0,
      this.speed = 0,
      this.latitude = 0,
      this.longitude = 0,
      this.distance = 0,
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
    distance = json['distance'];
    agentLocation = json['agentLocation'] != null
        ? new AgentLocation.fromJson(json['agentLocation'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['remarks'] = this.remarks;
    data['imageLocation'] = this.imageLocation;
    data['altitude'] = this.altitude;
    data['accuracy'] = this.accuracy;
    data['altitudeAccuracy'] = this.altitudeAccuracy;
    data['heading'] = this.heading;
    data['speed'] = this.speed;
    data['Latitude'] = this.latitude;
    data['Longitude'] = this.longitude;
    data['distance'] = this.distance;
    if (this.agentLocation != null) {
      data['agentLocation'] = this.agentLocation!.toJson();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['missingAgentLocation'] = this.missingAgentLocation;
    return data;
  }
}