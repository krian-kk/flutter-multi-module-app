class AreYouAtOfficeModel {
  late int eventId;
  late String eventType;
  late AreYouAtOfficeEventAttr eventAttr;
  late String eventCode;
  late String createdBy;
  late String agentName;
  late String eventModule;
  late String contractor;
  late double roleLevel;
  late String version;
  late bool tokenVerified;

  AreYouAtOfficeModel({
    required this.eventId,
    required this.eventType,
    required this.eventAttr,
    required this.eventCode,
    required this.createdBy,
    required this.agentName,
    required this.eventModule,
    required this.contractor,
    this.roleLevel = 0,
    this.version = '',
    this.tokenVerified = true,
  });

  AreYouAtOfficeModel.fromJson(Map<String, dynamic> json) {
    eventId = json['eventId'];
    eventType = json['eventType'];
    eventAttr = AreYouAtOfficeEventAttr.fromJson(json['eventAttr']);
    eventCode = json['eventCode'];
    createdBy = json['createdBy'];
    agentName = json['agentName'];
    eventModule = json['eventModule'];
    contractor = json['contractor'];
    roleLevel = json['roleLevel'];
    version = json['version'];
    tokenVerified = json['tokenVerified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['eventId'] = eventId;
    data['eventType'] = eventType;
    data['eventAttr'] = eventAttr.toJson();
    data['eventCode'] = eventCode;
    data['createdBy'] = createdBy;
    data['agentName'] = agentName;
    data['eventModule'] = eventModule;
    data['contractor'] = contractor;
    data['roleLevel'] = roleLevel;
    data['version'] = version;
    data['tokenVerified'] = tokenVerified;
    return data;
  }
}

class AreYouAtOfficeEventAttr {
  late double altitude;
  late double accuracy;
  late double altitudeAccuracy;
  late double heading;
  late double speed;
  late double latitude;
  late double longitude;

  AreYouAtOfficeEventAttr(
      {required this.altitude,
      required this.accuracy,
      this.altitudeAccuracy = 0,
      required this.heading,
      required this.speed,
      required this.latitude,
      required this.longitude});

  AreYouAtOfficeEventAttr.fromJson(Map<String, dynamic> json) {
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
