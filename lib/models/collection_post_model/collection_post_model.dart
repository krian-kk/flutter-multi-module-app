class CollectionPostModel {
  late int eventId;
  late String eventType;
  late String caseId;
  late EventAttr eventAttr;
  late String eventCode;
  late String createdBy;
  late String agentName;
  late String eventModule;
  late CollectionsContact contact;
  late String agrRef;
  late String? callID;
  late String? callingID;
  late String callerServiceID;
  late String voiceCallEventCode;
  late double? invalidNumber;

  CollectionPostModel({
    required this.eventId,
    required this.eventType,
    required this.caseId,
    required this.eventAttr,
    required this.eventCode,
    required this.createdBy,
    required this.agentName,
    required this.eventModule,
    required this.contact,
    required this.agrRef,
    this.callID,
    this.callingID,
    required this.callerServiceID,
    required this.voiceCallEventCode,
    this.invalidNumber,
  });

  CollectionPostModel.fromJson(Map<String, dynamic> json) {
    eventId = json['eventId'];
    eventType = json['eventType'];
    caseId = json['caseId'];
    eventAttr = EventAttr.fromJson(json['eventAttr']);
    eventCode = json['eventCode'];
    createdBy = json['createdBy'];
    agentName = json['agentName'];
    eventModule = json['eventModule'];
    contact = CollectionsContact.fromJson(json['contact']);
    agrRef = json['agrRef'];
    callID = json['callID'];
    callingID = json['callingID'];
    callerServiceID = json['callerServiceID'];
    voiceCallEventCode = json['voiceCallEventCode'];
    invalidNumber = json['invalidNumber'];
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
    data['contact'] = contact.toJson();
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
  late int amountCollected;
  late String date;
  late String chequeRefNo;
  late String remarks;
  late String mode;
  late String followUpPriority;
  late String customerName;
  late List<String> imageLocation;
  late double? altitude;
  late double accuracy;
  late double? altitudeAccuracy;
  late double? heading;
  late double? speed;
  late double latitude;
  late double longitude;

  EventAttr({
    required this.amountCollected,
    required this.date,
    required this.chequeRefNo,
    required this.remarks,
    required this.mode,
    this.followUpPriority = '',
    this.customerName = '',
    required this.imageLocation,
    this.altitude,
    this.accuracy = 0,
    this.altitudeAccuracy,
    this.heading,
    this.speed,
    this.latitude = 0,
    this.longitude = 0,
  });

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
    return data;
  }
}

class CollectionsContact {
  late String cType;
  late String health;
  late String value;
  late String resAddressId0;
  late String contactId0;

  CollectionsContact(
      {required this.cType,
      required this.health,
      required this.value,
      this.resAddressId0 = '',
      this.contactId0 = ''});

  CollectionsContact.fromJson(Map<String, dynamic> json) {
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

class CollectionsDeposition {
  late String status;

  CollectionsDeposition({
    this.status = 'pending',
  });

  CollectionsDeposition.fromJson(Map<String, dynamic> json) {
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;

    return data;
  }
}
