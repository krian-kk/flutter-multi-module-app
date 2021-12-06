class BankDepositPostModel {
  int? eventId;
  String? eventType;
  String? caseId;
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

  BankDepositPostModel(
      {this.eventId = 0,
      this.eventType = 'RECEIPT',
      required this.caseId,
      this.eventCode = 'TELEVT003',
      required this.eventAttr,
      this.createdBy='',
      this.eventModule = 'Field Allocation',
      this.callID = '0',
      this.callingID = '0',
      this.callerServiceID = '',
      this.voiceCallEventCode = '',
      this.invalidNumber = 0,
      this.agentName ='',
      this.contractor ='',
      this.agrRef=''});

  BankDepositPostModel.fromJson(Map<String, dynamic> json) {
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
  int? amountCollected;
  String? date;
  String? chequeRefNo;
  String? remarks;
  String? mode;
  String? followUpPriority;
  String? customerName;
  List<String>? imageLocation;
 late Deposition deposition;
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
  String? duplicate;

  EventAttr(
      {this.amountCollected = 0,
      required this.date,
      required this.chequeRefNo,
      required this.remarks,
      required this.mode,
      this.followUpPriority = 'REVIEW',
      required this.customerName,
      required this.imageLocation,
      required this.deposition,
      this.altitude = 0,
      this.accuracy = 0,
      this.altitudeAccuracy = 0,
      this.heading = 0,
      this.speed = 0,
      this.latitude = 0,
      this.longitude = 0,
      this.distance = 0,
      this.agentLocation,
      this.appStatus ='',
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
    deposition = (json['deposition'] != null
        ? new Deposition.fromJson(json['deposition'])
        : null)!;
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
    duplicate = json['duplicate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amountCollected'] = this.amountCollected;
    data['date'] = this.date;
    data['chequeRefNo'] = this.chequeRefNo;
    data['remarks'] = this.remarks;
    data['mode'] = this.mode;
    data['followUpPriority'] = this.followUpPriority;
    data['customerName'] = this.customerName;
    data['imageLocation'] = this.imageLocation;
    if (this.deposition != null) {
      data['deposition'] = this.deposition.toJson();
    }
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
    data['duplicate'] = this.duplicate;
    return data;
  }
}

class Deposition {
  String? bankName;
  String? bankBranch;
  String? ifscCode;
  String? accNumber;
  String? recptAmount;
  String? deptAmount;
  String? reference;
  List<String>? imageLocation;
  String? mode;
  String? depositDate;
  String? status;

  Deposition(
      {required this.bankName,
      required this.bankBranch,
      required this.ifscCode,
      required this.accNumber,
      required this.recptAmount,
      required this.deptAmount,
      required this.reference,
      required this.imageLocation,
      required this.mode,
      required this.depositDate,
      required this.status});

  Deposition.fromJson(Map<String, dynamic> json) {
    bankName = json['bankName'];
    bankBranch = json['bankBranch'];
    ifscCode = json['ifscCode'];
    accNumber = json['accNumber'];
    recptAmount = json['recptAmount'];
    deptAmount = json['deptAmount'];
    reference = json['reference'];
    imageLocation = json['imageLocation'].cast<String>();
    mode = json['mode'];
    depositDate = json['depositDate'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bankName'] = this.bankName;
    data['bankBranch'] = this.bankBranch;
    data['ifscCode'] = this.ifscCode;
    data['accNumber'] = this.accNumber;
    data['recptAmount'] = this.recptAmount;
    data['deptAmount'] = this.deptAmount;
    data['reference'] = this.reference;
    data['imageLocation'] = this.imageLocation;
    data['mode'] = this.mode;
    data['depositDate'] = this.depositDate;
    data['status'] = this.status;
    return data;
  }
}

class AgentLocation {
  int? latitude;
  int? longitude;
  String? missingAgentLocation;

  AgentLocation({this.latitude = 0, this.longitude = 0, this.missingAgentLocation = 'true'});

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
