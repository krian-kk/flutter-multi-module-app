class PTPPostModel {
  late int eventId;
  late String eventType;
  late String caseId;
  late String? eventCode;
  late EventAttr eventAttr;
  late String? createdBy;
  late String? agentName;
  late String? eventModule;
  late Contact contact;
  late String? agrRef;
  late String? contractor;
  late String callID;
  late String callingID;
  late String? callerServiceID;
  late String? voiceCallEventCode;
  late int? invalidNumber;

  PTPPostModel(
      {this.eventId = 0,
      required this.eventType,
      required this.caseId,
      this.eventCode = 'TELEVT001',
      required this.eventAttr,
      this.createdBy = '',
      this.agentName = '',
      this.eventModule = 'Field Allocation',
      required this.contact,
      this.agrRef = '',
      this.contractor = '',
      required this.callID,
      required this.callingID,
      this.callerServiceID = '',
      this.voiceCallEventCode = '',
      this.invalidNumber = 0});

  PTPPostModel.fromJson(Map<String, dynamic> json) {
    eventId = json['eventId'];
    eventType = json['eventType'];
    caseId = json['caseId'];
    eventCode = json['eventCode'];
    eventAttr = EventAttr.fromJson(json['eventAttr']);
    createdBy = json['createdBy'];
    agentName = json['agentName'];
    eventModule = json['eventModule'];
    contact = Contact.fromJson(json['contact']);
    agrRef = json['agrRef'];
    contractor = json['contractor'];
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
    data['eventCode'] = eventCode;
    if (eventAttr != null) {
      data['eventAttr'] = eventAttr.toJson();
    }
    data['createdBy'] = createdBy;
    data['agentName'] = agentName;
    data['eventModule'] = eventModule;
    if (contact != null) {
      data['contact'] = contact.toJson();
    }
    data['agrRef'] = agrRef;
    data['contractor'] = contractor;
    data['callID'] = callID;
    data['callingID'] = callingID;
    data['callerServiceID'] = callerServiceID;
    data['voiceCallEventCode'] = voiceCallEventCode;
    data['invalidNumber'] = invalidNumber;
    return data;
  }
}

class EventAttr {
  late String date;
  late String time;
  late String remarks;
  late int ptpAmount;
  late String reference;
  late String mode;
  late String? pTPType;
  late String followUpPriority;
  late int altitude;
  late int accuracy;
  late int altitudeAccuracy;
  late int heading;
  late int speed;
  late int latitude;
  late int longitude;
  late int distance;
  late AgentLocation agentLocation;

  EventAttr(
      {required this.date,
      required this.time,
      required this.remarks,
      required this.ptpAmount,
      required this.reference,
      required this.mode,
      this.pTPType = 'Money',
      required this.followUpPriority,
      this.altitude = 0,
      this.accuracy = 0,
      this.altitudeAccuracy = 0,
      this.heading = 0,
      this.speed = 0,
      this.latitude = 0,
      this.longitude = 0,
      this.distance = 0,
      required this.agentLocation});

  EventAttr.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    time = json['time'];
    remarks = json['remarks'];
    ptpAmount = json['ptpAmount'];
    reference = json['reference'];
    mode = json['mode'];
    pTPType = json['PTPType'];
    followUpPriority = json['followUpPriority'];
    altitude = json['altitude'];
    accuracy = json['accuracy'];
    altitudeAccuracy = json['altitudeAccuracy'];
    heading = json['heading'];
    speed = json['speed'];
    latitude = json['Latitude'];
    longitude = json['Longitude'];
    distance = json['distance'];
    agentLocation = AgentLocation.fromJson(json['agentLocation']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['time'] = time;
    data['remarks'] = remarks;
    data['ptpAmount'] = ptpAmount;
    data['reference'] = reference;
    data['mode'] = mode;
    data['PTPType'] = pTPType;
    data['followUpPriority'] = followUpPriority;
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
    return data;
  }
}

class AgentLocation {
  late int latitude;
  late int longitude;
  late String missingAgentLocation;

  AgentLocation(
      {required this.latitude,
      required this.longitude,
      required this.missingAgentLocation});

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

class Contact {
  late String cType;
  late String health;
  late String value;
  late String resAddressId0;
  late String contactId0;

  Contact(
      {required this.cType,
      this.health = '1',
      this.value = '0',
      this.resAddressId0 = '',
      this.contactId0 = ''});

  Contact.fromJson(Map<String, dynamic> json) {
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

// class PTPPostModel {
//   late int eventId;
//   late String eventType;
//   late String caseId;
//   late EventAttr eventAttr;
//   late String eventCode;
//   String? createdBy;
//   String? agentName;
//   String? eventModule;
//   late String createdAt;
//   late String lastAction;
//   String? contractor;
//   String? agrRef;

//   PTPPostModel(
//       {this.eventId = 0,
//       required this.eventType,
//       required this.caseId,
//       required this.eventAttr,
//       this.eventCode = 'TELEVT003',
//       this.createdBy = '',
//       this.agentName = '',
//       this.eventModule = 'Field Allocation',
//       required this.createdAt,
//       required this.lastAction,
//       this.contractor = '',
//       this.agrRef = ''});

//   PTPPostModel.fromJson(Map<String, dynamic> json) {
//     eventId = json['eventId'];
//     eventType = json['eventType'];
//     caseId = json['caseId'];
//     eventAttr = EventAttr.fromJson(json['eventAttr']);
//     eventCode = json['eventCode'];
//     createdBy = json['createdBy'];
//     agentName = json['agentName'];
//     eventModule = json['eventModule'];
//     createdAt = json['createdAt'];
//     lastAction = json['lastAction'];
//     contractor = json['contractor'];
//     agrRef = json['agrRef'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['eventId'] = eventId;
//     data['eventType'] = eventType;
//     data['caseId'] = caseId;
//     data['eventAttr'] = eventAttr.toJson();
//     data['eventCode'] = eventCode;
//     data['createdBy'] = createdBy;
//     data['agentName'] = agentName;
//     data['eventModule'] = eventModule;
//     data['createdAt'] = createdAt;
//     data['lastAction'] = lastAction;
//     data['contractor'] = contractor;
//     data['agrRef'] = agrRef;
//     return data;
//   }
// }

// class EventAttr {
//   late int amountCollected;
//   late String date;
//   late String chequeRefNo;
//   late String remarks;
//   late String mode;
//   late String followUpPriority;
//   late String customerName;
//   late List? imageLocation;
//   Deposition? deposition;
//   int? altitude;
//   int? accuracy;
//   int? altitudeAccuracy;
//   int? heading;
//   int? speed;
//   int? latitude;
//   int? longitude;
//   int? distance;
//   AgentLocation? agentLocation;
//   String? appStatus;
//   String? duplicate;

//   EventAttr(
//       {required this.amountCollected,
//       required this.date,
//       this.chequeRefNo = '',
//       required this.remarks,
//       required this.mode,
//       this.followUpPriority = '',
//       this.customerName = '',
//       this.imageLocation,
//       this.deposition,
//       this.altitude = 0,
//       this.accuracy = 0,
//       this.altitudeAccuracy = 0,
//       this.heading = 0,
//       this.speed = 0,
//       this.latitude = 0,
//       this.longitude = 0,
//       this.distance = 0,
//       this.agentLocation,
//       this.appStatus = '',
//       this.duplicate = 'true'});

//   EventAttr.fromJson(Map<String, dynamic> json) {
//     amountCollected = json['amountCollected'];
//     date = json['date'];
//     chequeRefNo = json['chequeRefNo'];
//     remarks = json['remarks'];
//     mode = json['mode'];
//     followUpPriority = json['followUpPriority'];
//     customerName = json['customerName'];
//     imageLocation = json['imageLocation'].cast<String>();
//     deposition = json['deposition'] != null
//         ? Deposition.fromJson(json['deposition'])
//         : null;
//     altitude = json['altitude'];
//     accuracy = json['accuracy'];
//     altitudeAccuracy = json['altitudeAccuracy'];
//     heading = json['heading'];
//     speed = json['speed'];
//     latitude = json['Latitude'];
//     longitude = json['Longitude'];
//     distance = json['distance'];
//     agentLocation = json['agentLocation'] != null
//         ? AgentLocation.fromJson(json['agentLocation'])
//         : AgentLocation(
//             latitude: 0, longitude: 0, missingAgentLocation: 'true');
//     appStatus = json['appStatus'];
//     duplicate = json['duplicate'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['amountCollected'] = amountCollected;
//     data['date'] = date;
//     data['chequeRefNo'] = chequeRefNo;
//     data['remarks'] = remarks;
//     data['mode'] = mode;
//     data['followUpPriority'] = followUpPriority;
//     data['customerName'] = customerName;
//     data['imageLocation'] = imageLocation;
//     if (deposition != null) {
//       data['deposition'] = deposition?.toJson();
//     }
//     data['altitude'] = altitude;
//     data['accuracy'] = accuracy;
//     data['altitudeAccuracy'] = altitudeAccuracy;
//     data['heading'] = heading;
//     data['speed'] = speed;
//     data['Latitude'] = latitude;
//     data['Longitude'] = longitude;
//     data['distance'] = distance;
//     if (agentLocation != null) {
//       data['agentLocation'] = agentLocation?.toJson();
//     }
//     data['appStatus'] = appStatus;
//     data['duplicate'] = duplicate;
//     return data;
//   }
// }

// class Deposition {
//   String? status;

//   Deposition({this.status});

//   Deposition.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['status'] = status;
//     return data;
//   }
// }

// class AgentLocation {
//   late int latitude;
//   late int longitude;
//   late String missingAgentLocation;

//   AgentLocation(
//       {required this.latitude,
//       required this.longitude,
//       required this.missingAgentLocation});

//   AgentLocation.fromJson(Map<String, dynamic> json) {
//     latitude = json['latitude'];
//     longitude = json['longitude'];
//     missingAgentLocation = json['missingAgentLocation'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['latitude'] = latitude;
//     data['longitude'] = longitude;
//     data['missingAgentLocation'] = missingAgentLocation;
//     return data;
//   }
// }
