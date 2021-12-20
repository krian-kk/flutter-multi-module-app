class CustomerNotMetPostModel {
  late double eventId;
  late String eventType;
  late String caseId;
  late String eventCode;
  late CustomerNotMetEventAttr eventAttr;
  late dynamic contact;
  late String createdBy;
  late String eventModule;
  late String agentName;
  late String? callID;
  late String? callingID;
  late String callerServiceID;
  late String voiceCallEventCode;
  late double? invalidNumber;
  late String agrRef;

  CustomerNotMetPostModel(
      {this.eventId = 24,
      required this.eventType,
      required this.caseId,
      required this.eventCode,
      required this.eventAttr,
      this.contact,
      required this.createdBy,
      required this.eventModule,
      required this.agentName,
      this.callID,
      this.callingID,
      this.callerServiceID = 'e',
      this.voiceCallEventCode = 'TELEVT011',
      this.invalidNumber,
      required this.agrRef});

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
  late double altitude;
  late double accuracy;
  late double altitudeAccuracy;
  late double heading;
  late double speed;
  late double latitude;
  late double longitude;

  CustomerNotMetEventAttr({
    required this.remarks,
    required this.followUpPriority,
    required this.nextActionDate,
    this.altitude = 0,
    this.accuracy = 0,
    this.altitudeAccuracy = 0,
    this.heading = 0,
    this.speed = 0,
    this.latitude = 0,
    this.longitude = 0,
  });

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
    return data;
  }
}
