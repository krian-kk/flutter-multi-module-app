class RepoPostModel {
  late int eventId;
  late String eventType;
  late String caseId;
  late String eventCode;
  late EventAttr eventAttr;
  late String createdBy;
  late String agentName;
  late String eventModule;
  late String contractor;
  late String callID;
  late String callingID;
  late String callerServiceID;
  late String voiceCallEventCode;
  late int invalidNumber;
  late String agrRef;

  RepoPostModel(
      {this.eventId = 0,
      required this.eventType,
      required this.caseId,
      required this.eventCode,
      required this.eventAttr,
      this.createdBy = '',
      this.agentName = '',
      this.eventModule = 'Field Allocation',
      this.contractor = '',
      this.callID = '0',
      this.callingID = '0',
      this.callerServiceID = '',
      this.voiceCallEventCode = '',
      this.invalidNumber = 0,
      this.agrRef = ''});

  RepoPostModel.fromJson(Map<String, dynamic> json) {
    eventId = json['eventId'];
    eventType = json['eventType'];
    caseId = json['caseId'];
    eventCode = json['eventCode'];
    eventAttr = EventAttr.fromJson(json['eventAttr']);
    createdBy = json['createdBy'];
    agentName = json['agentName'];
    eventModule = json['eventModule'];
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
    if (eventAttr != null) {
      data['eventAttr'] = eventAttr.toJson();
    }
    data['createdBy'] = createdBy;
    data['agentName'] = agentName;
    data['eventModule'] = eventModule;
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

class EventAttr {
  late String modelMake;
  late String registrationNo;
  late String chassisNo;
  late String remarks;
  late Repo repo;
  late String date;
  late String followUpPriority;
  late List<String> imageLocation;
  late String customerName;
  late int altitude;
  late int accuracy;
  late int altitudeAccuracy;
  late int heading;
  late int speed;
  late int latitude;
  late int longitude;
  late int distance;
  late AgentLocation agentLocation;
  late String appStatus;

  EventAttr(
      {required this.modelMake,
      required this.registrationNo,
      required this.chassisNo,
      required this.remarks,
      required this.repo,
      required this.date,
      this.followUpPriority = 'REVIEW',
      required this.imageLocation,
      this.customerName = '',
      this.altitude = 0,
      this.accuracy = 0,
      this.altitudeAccuracy = 0,
      this.heading = 0,
      this.speed = 0,
      this.latitude = 0,
      this.longitude = 0,
      this.distance = 0,
      required this.agentLocation,
      this.appStatus = ''});

  EventAttr.fromJson(Map<String, dynamic> json) {
    modelMake = json['modelMake'];
    registrationNo = json['registrationNo'];
    chassisNo = json['chassisNo'];
    remarks = json['remarks'];
    repo = Repo.fromJson(json['repo']);
    date = json['date'];
    followUpPriority = json['followUpPriority'];
    imageLocation = json['imageLocation'].cast<String>();
    customerName = json['customerName'];
    altitude = json['altitude'];
    accuracy = json['accuracy'];
    altitudeAccuracy = json['altitudeAccuracy'];
    heading = json['heading'];
    speed = json['speed'];
    latitude = json['Latitude'];
    longitude = json['Longitude'];
    distance = json['distance'];
    agentLocation = AgentLocation.fromJson(json['agentLocation']);
    appStatus = json['appStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['modelMake'] = modelMake;
    data['registrationNo'] = registrationNo;
    data['chassisNo'] = chassisNo;
    data['remarks'] = remarks;
    data['repo'] = repo.toJson();
    data['date'] = date;
    data['followUpPriority'] = followUpPriority;
    data['imageLocation'] = imageLocation;
    data['customerName'] = customerName;
    data['altitude'] = altitude;
    data['accuracy'] = accuracy;
    data['altitudeAccuracy'] = altitudeAccuracy;
    data['heading'] = heading;
    data['speed'] = speed;
    data['Latitude'] = latitude;
    data['Longitude'] = longitude;
    data['distance'] = distance;
    data['agentLocation'] = agentLocation.toJson();
    data['appStatus'] = appStatus;
    return data;
  }
}

class Repo {
  late String status;

  Repo({this.status = ''});

  Repo.fromJson(Map<String, dynamic> json) {
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    return data;
  }
}

class AgentLocation {
  late int latitude;
  late int longitude;
  late String missingAgentLocation;

  AgentLocation(
      {this.latitude = 0,
      this.longitude = 0,
      this.missingAgentLocation = 'true'});

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
