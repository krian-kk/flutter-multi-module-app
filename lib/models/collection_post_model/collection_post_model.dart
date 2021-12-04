class CollectionPostModel {
  late int eventId;
  late String eventType;
  late String caseId;
  late EventAttr eventAttr;
  late String eventCode;
  late String createdBy;
  late String agentName;
  late String eventModule;
  late String createdAt;
  late String lastAction;
  late String contractor;
  late String agrRef;

  CollectionPostModel(
      {this.eventId = 0,
      required this.eventType,
      required this.caseId,
      required this.eventAttr,
      this.eventCode = 'TELEVT003',
      this.createdBy = '',
      this.agentName = '',
      this.eventModule = 'Field Allocation',
      required this.createdAt,
      required this.lastAction,
      this.contractor = '',
      this.agrRef = ''});

  CollectionPostModel.fromJson(Map<String, dynamic> json) {
    eventId = json['eventId'];
    eventType = json['eventType'];
    caseId = json['caseId'];
    eventAttr = EventAttr.fromJson(json['eventAttr']);
    eventCode = json['eventCode'];
    createdBy = json['createdBy'];
    agentName = json['agentName'];
    eventModule = json['eventModule'];
    createdAt = json['createdAt'];
    lastAction = json['lastAction'];
    contractor = json['contractor'];
    agrRef = json['agrRef'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['eventId'] = eventId;
    data['eventType'] = eventType;
    data['caseId'] = caseId;
    data['eventAttr'] = eventAttr.toJson();
    data['eventCode'] = eventCode;
    data['createdBy'] = createdBy;
    data['agentName'] = agentName;
    data['eventModule'] = eventModule;
    data['createdAt'] = createdAt;
    data['lastAction'] = lastAction;
    data['contractor'] = contractor;
    data['agrRef'] = agrRef;
    return data;
  }
}

class EventAttr {
  late int amountCollected;
  late String date;
  late String chequeRefNo;
  late String remarks;
  late String mode;
  late String followUpPriority;
  late String customerName;
  late List<String> imageLocation;
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
  late String duplicate;

  EventAttr(
      {this.amountCollected = 0,
      required this.date,
      this.chequeRefNo = '',
      required this.remarks,
      required this.mode,
      this.followUpPriority = '',
      this.customerName = '',
      required this.imageLocation,
      this.altitude = 0,
      this.accuracy = 0,
      this.altitudeAccuracy = 0,
      this.heading = 0,
      this.speed = 0,
      this.latitude = 0,
      this.longitude = 0,
      this.distance = 0,
      required this.agentLocation,
      this.appStatus = '',
      this.duplicate = 'true'});

  EventAttr.fromJson(Map<String, dynamic> json) {
    amountCollected = json['amountCollected'];
    date = json['date'];
    chequeRefNo = json['chequeRefNo'];
    remarks = json['remarks'];
    mode = json['mode'];
    followUpPriority = json['followUpPriority'];
    customerName = json['customerName'];
    imageLocation = json['imageLocation'].cast<String>();
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
    duplicate = json['duplicate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['amountCollected'] = amountCollected;
    data['date'] = date;
    data['chequeRefNo'] = chequeRefNo;
    data['remarks'] = remarks;
    data['mode'] = mode;
    data['followUpPriority'] = followUpPriority;
    data['customerName'] = customerName;
    data['imageLocation'] = imageLocation;
    data['altitude'] = altitude;
    data['accuracy'] = accuracy;
    data['altitudeAccuracy'] = altitudeAccuracy;
    data['heading'] = heading;
    data['speed'] = speed;
    data['Latitude'] = latitude;
    data['Longitude'] = longitude;
    data['distance'] = distance;
    if (agentLocation != null) {
      data['agentLocation'] = agentLocation.toJson();
    }
    data['appStatus'] = appStatus;
    data['duplicate'] = duplicate;
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
