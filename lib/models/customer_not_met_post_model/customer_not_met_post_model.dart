class CustomerNotMetPostModel {
  late int eventId;
  late String eventType;
  late String caseId;
  late String eventCode;
  late CustomerNotMetEventAttr eventAttr;
  late dynamic contact;
  late String createdBy;
  late String eventModule;
  late String agentName;
  late String contractor;
  late String callID;
  late String callingID;
  late String callerServiceID;
  late String voiceCallEventCode;
  late int invalidNumber;
  late String agrRef;

  CustomerNotMetPostModel(
      {this.eventId = 0,
      required this.eventType,
      required this.caseId,
      required this.eventCode,
      required this.eventAttr,
      this.contact,
      this.createdBy = '0',
      this.eventModule = 'Field Allocation',
      this.agentName = '0',
      this.contractor = '0',
      this.callID = '0',
      this.callingID = '0',
      this.callerServiceID = '',
      this.voiceCallEventCode = '',
      this.invalidNumber = 0,
      this.agrRef = '0'});

  CustomerNotMetPostModel.fromJson(Map<String, dynamic> json) {
    eventId = json['eventId'];
    eventType = json['eventType'];
    caseId = json['caseId'];
    eventCode = json['eventCode'];
    eventAttr = CustomerNotMetEventAttr.fromJson(json['eventAttr']);
    contact = json['contact'];
    createdBy = json['createdBy'];
    eventModule = json['eventModule'];
    agentName = json['agentName'];
    contractor = json['contractor'];
    callID = json['callID'];
    callingID = json['callingID'];
    callerServiceID = json['callerServiceID'];
    voiceCallEventCode = json['voiceCallEventCode'];
    invalidNumber = json['invalidNumber'];
    agrRef = json['agrRef'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['eventId'] = eventId;
    data['eventType'] = eventType;
    data['caseId'] = caseId;
    data['eventCode'] = eventCode;
    data['eventAttr'] = eventAttr.toJson();
    if (contact != null) {
      data['contact'] = contact;
    }
    data['createdBy'] = createdBy;
    data['eventModule'] = eventModule;
    data['agentName'] = agentName;
    data['contractor'] = contractor;
    data['callID'] = callID;
    data['callingID'] = callingID;
    data['callerServiceID'] = callerServiceID;
    data['voiceCallEventCode'] = voiceCallEventCode;
    data['invalidNumber'] = invalidNumber;
    data['agrRef'] = agrRef;
    return data;
  }
}

class CustomerNotMetEventAttr {
  late String remarks;
  late String followUpPriority;
  late String nextActionDate;
  late int altitude;
  late int accuracy;
  late int altitudeAccuracy;
  late int heading;
  late int speed;
  late int latitude;
  late int longitude;
  late int distance;
  late CustomerNotMetAgentLocation agentLocation;

  CustomerNotMetEventAttr(
      {required this.remarks,
      required this.followUpPriority,
      required this.nextActionDate,
      this.altitude = 0,
      this.accuracy = 0,
      this.altitudeAccuracy = 0,
      this.heading = 0,
      this.speed = 0,
      this.latitude = 0,
      this.longitude = 0,
      this.distance = 0,
      required this.agentLocation});

  CustomerNotMetEventAttr.fromJson(Map<String, dynamic> json) {
    remarks = json['remarks'];
    followUpPriority = json['followUpPriority'];
    nextActionDate = json['nextActionDate'];
    altitude = json['altitude'];
    accuracy = json['accuracy'];
    altitudeAccuracy = json['altitudeAccuracy'];
    heading = json['heading'];
    speed = json['speed'];
    latitude = json['Latitude'];
    longitude = json['Longitude'];
    distance = json['distance'];
    agentLocation = CustomerNotMetAgentLocation.fromJson(json['agentLocation']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['remarks'] = remarks;
    data['followUpPriority'] = followUpPriority;
    data['nextActionDate'] = nextActionDate;
    data['altitude'] = altitude;
    data['accuracy'] = accuracy;
    data['altitudeAccuracy'] = altitudeAccuracy;
    data['heading'] = heading;
    data['speed'] = speed;
    data['Latitude'] = latitude;
    data['Longitude'] = longitude;
    data['distance'] = distance;
    data['agentLocation'] = agentLocation.toJson();
    return data;
  }
}

class CustomerNotMetAgentLocation {
  late int latitude;
  late int longitude;
  late String missingAgentLocation;

  CustomerNotMetAgentLocation(
      {this.latitude = 0,
      this.longitude = 0,
      this.missingAgentLocation = 'true'});

  CustomerNotMetAgentLocation.fromJson(Map<String, dynamic> json) {
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
