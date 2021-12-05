class YardingPostModel {
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

  YardingPostModel(
      {this.eventId = 0,
      this.eventType = 'REPO',
      required this.caseId,
      this.eventCode = 'TELEVT016',
      required this.eventAttr,
      this.createdBy = '',
      this.eventModule = 'Field Allocation',
      this.callID = '0',
      this.callingID = '0',
      this.callerServiceID = '',
      this.voiceCallEventCode = '',
      this.invalidNumber = 0,
      this.agentName = '',
      this.contractor = '0',
      this.agrRef = ''});

  YardingPostModel.fromJson(Map<String, dynamic> json) {
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
  String? modelMake;
  String? registrationNo;
  String? chassisNo;
  late String remarks;
  late Repo repo;
  String? followUpPriority;
 late List<String> imageLocation;
 late String customerName;
 late String date;
  int? altitude;
  int? accuracy;
  int? altitudeAccuracy;
  int? heading;
  int? speed;
  int? latitude;
  int? longitude;
  int? distance;
  AgentLocation? agentLocation;
  String? appStatus;

  EventAttr(
      {this.modelMake = '',
      this.registrationNo = '',
      this.chassisNo = '',
      required this.remarks,
      required this.repo,
      this.followUpPriority = 'REVIEW',
      required this.imageLocation,
      required this.customerName,
      required this.date,
      this.altitude = 0,
      this.accuracy = 0,
      this.altitudeAccuracy = 0,
      this.heading = 0,
      this.speed = 0,
      this.latitude = 0,
      this.longitude = 0,
      this.distance = 0,
      this.agentLocation,
      this.appStatus = ''});

  EventAttr.fromJson(Map<String, dynamic> json) {
    modelMake = json['modelMake'];
    registrationNo = json['registrationNo'];
    chassisNo = json['chassisNo'];
    remarks = json['remarks'];
    repo = (json['repo'] != null ? new Repo.fromJson(json['repo']) : null)!;
    followUpPriority = json['followUpPriority'];
    imageLocation = json['imageLocation'].cast<String>();
    customerName = json['customerName'];
    date = json['date'];
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
    appStatus = json['appStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['modelMake'] = this.modelMake;
    data['registrationNo'] = this.registrationNo;
    data['chassisNo'] = this.chassisNo;
    data['remarks'] = this.remarks;
    if (this.repo != null) {
      data['repo'] = this.repo.toJson();
    }
    data['followUpPriority'] = this.followUpPriority;
    data['imageLocation'] = this.imageLocation;
    data['customerName'] = this.customerName;
    data['date'] = this.date;
    data['altitude'] = this.altitude;
    data['accuracy'] = this.accuracy;
    data['altitudeAccuracy'] = this.altitudeAccuracy;
    data['heading'] = this.heading;
    data['speed'] = this.speed;
    data['Latitude'] = this.latitude;
    data['Longitude'] = this.longitude;
    data['distance'] = this.distance;
    if (this.agentLocation != null) {
      data['agentLocation'] = this.agentLocation?.toJson();
    }
    data['appStatus'] = this.appStatus;
    return data;
  }
}

class Repo {
  late String yard;
  late String date;
  late String time;
  late String remarks;
  late List<String> imageLocation;
  String? status;

  Repo(
      {required this.yard,
      required this.date,
      required this.time,
      required this.remarks,
      required this.imageLocation,
      this.status = 'yarding'});

  Repo.fromJson(Map<String, dynamic> json) {
    yard = json['yard'];
    date = json['date'];
    time = json['time'];
    remarks = json['remarks'];
    imageLocation = json['imageLocation'].cast<String>();
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['yard'] = this.yard;
    data['date'] = this.date;
    data['time'] = this.time;
    data['remarks'] = this.remarks;
    data['imageLocation'] = this.imageLocation;
    data['status'] = this.status;
    return data;
  }
}

class AgentLocation {
  int? latitude;
  int? longitude;
  String? missingAgentLocation;

  AgentLocation({this.latitude = 0, 
  this.longitude = 0, 
  this.missingAgentLocation = 'true'});

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
