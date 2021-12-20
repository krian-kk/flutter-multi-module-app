class RepoPostModel {
  late double eventId;
  late String eventType;
  late String caseId;
  late String eventCode;
  late EventAttr eventAttr;
  late List<RepoContact> contact;
  late String createdBy;
  late String agentName;
  late String eventModule;
  late String? callID;
  late String? callingID;
  late String callerServiceID;
  late String voiceCallEventCode;
  late double? invalidNumber;
  late String agrRef;

  RepoPostModel({
    this.eventId = 0,
    required this.eventType,
    required this.caseId,
    required this.eventCode,
    required this.eventAttr,
    required this.contact,
    required this.createdBy,
    required this.agentName,
    required this.eventModule,
    this.callID,
    this.callingID,
    required this.callerServiceID,
    this.voiceCallEventCode = 'TELEVT011',
    this.invalidNumber,
    required this.agrRef,
  });

  RepoPostModel.fromJson(Map<String, dynamic> json) {
    eventId = json['eventId'];
    eventType = json['eventType'];
    caseId = json['caseId'];
    eventCode = json['eventCode'];
    eventAttr = EventAttr.fromJson(json['eventAttr']);
    contact = json['contact'].forEach((v) {
      contact.add(v);
    });
    createdBy = json['createdBy'];
    agentName = json['agentName'];
    eventModule = json['eventModule'];
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
    data['contact'] = contact.map((v) => v.toJson()).toList();
    data['createdBy'] = createdBy;
    data['agentName'] = agentName;
    data['eventModule'] = eventModule;
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
  late double? altitude;
  late double accuracy;
  late double? altitudeAccuracy;
  late double? heading;
  late double? speed;
  late double latitude;
  late double longitude;

  EventAttr({
    required this.modelMake,
    required this.registrationNo,
    required this.chassisNo,
    required this.remarks,
    required this.repo,
    required this.date,
    this.followUpPriority = 'REVIEW',
    required this.imageLocation,
    required this.customerName,
    this.altitude,
    this.accuracy = 0,
    this.altitudeAccuracy,
    this.heading,
    this.speed,
    this.latitude = 0,
    this.longitude = 0,
  });

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

class RepoContact {
  late String cType;
  late String health;
  late String value;
  late String resAddressId0;
  late String contactId0;

  RepoContact(
      {required this.cType,
      this.health = '1',
      required this.value,
      this.resAddressId0 = '',
      this.contactId0 = ''});

  RepoContact.fromJson(Map<String, dynamic> json) {
    cType = json['cType'];
    health = json['health'];
    value = json['value'];
    resAddressId0 = json['resAddressId_0'];
    contactId0 = json['contactId_0'];
  }

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
