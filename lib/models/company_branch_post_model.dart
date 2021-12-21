class CompanyBranchDepositPostModel {
  late List<String> caseIds;
  late Deposition deposition;
  // String? eventModule;
  // String? callID;
  // String? callingID;
  // String? callerServiceID;
  // String? voiceCallEventCode;
  // int? invalidNumber;
  // String? agentName;
  // String? contractor;
  // String? agrRef;

  CompanyBranchDepositPostModel({
    required this.caseIds,
    required this.deposition,
    // this.eventModule = 'Field Allocation',
    // this.callID = '0',
    // this.callingID = '0',
    // this.callerServiceID = '',
    // this.voiceCallEventCode = '',
    // this.invalidNumber = 0,
    // this.agentName = '',
    // this.contractor = '',
    // this.agrRef = '',
  });

  CompanyBranchDepositPostModel.fromJson(Map<String, dynamic> json) {
    caseIds = json['caseIds'].forEach((v) {
      caseIds.add(v);
    });
    deposition = json['deposition'];
    // callID = json['callID'];
    // callingID = json['callingID'];
    // callerServiceID = json['callerServiceID'];
    // voiceCallEventCode = json['voiceCallEventCode'];
    // invalidNumber = json['invalidNumber'];
    // agentName = json['agentName'];
    // contractor = json['contractor'];
    // agrRef = json['agrRef'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['caseIds'] = caseIds;
    data['deposition'] = deposition;

    // data['eventModule'] = eventModule;
    // data['callID'] = callID;
    // data['callingID'] = callingID;
    // data['callerServiceID'] = callerServiceID;
    // data['voiceCallEventCode'] = voiceCallEventCode;
    // data['invalidNumber'] = invalidNumber;
    // data['agentName'] = agentName;
    // data['contractor'] = contractor;
    // data['agrRef'] = agrRef;
    return data;
  }
}

// class EventAttr {
//   int? amountCollected;
//   String? date;
//   String? chequeRefNo;
//   String? remarks;
//   String? mode;
//   String? followUpPriority;
//   String? customerName;
//   List<String>? imageLocation;
//   late Deposition deposition;
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
//       {this.amountCollected = 0,
//       required this.date,
//       required this.chequeRefNo,
//       required this.remarks,
//       required this.mode,
//       this.followUpPriority = 'REVIEW',
//       required this.customerName,
//       required this.imageLocation,
//       required this.deposition,
//       this.altitude = 0,
//       this.accuracy = 0,
//       this.altitudeAccuracy = 0,
//       this.heading = 0,
//       this.speed = 0,
//       this.latitude = 0,
//       this.longitude = 0,
//       this.distance = 0,
//       this.agentLocation,
//       this.appStatus = '0',
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
//     deposition = (json['deposition'] != null
//         ? Deposition.fromJson(json['deposition'])
//         : null)!;
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
//         : null;
//     appStatus = json['appStatus'];
//     duplicate = json['duplicate'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data['amountCollected'] = amountCollected;
//     data['date'] = date;
//     data['chequeRefNo'] = chequeRefNo;
//     data['remarks'] = remarks;
//     data['mode'] = mode;
//     data['followUpPriority'] = followUpPriority;
//     data['customerName'] = customerName;
//     data['imageLocation'] = imageLocation;
//     if (deposition != null) {
//       data['deposition'] = deposition.toJson();
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

class Deposition {
  late String companyBranchName;
  late String companyBranchLocation;

  late String recptAmount;
  late String deptAmount;
  late String reference;
  List<String>? imageLocation;
  late String mode;
  late String depositDate;
  late String status;

  Deposition(
      {required this.companyBranchName,
      required this.companyBranchLocation,
      required this.recptAmount,
      required this.deptAmount,
      required this.reference,
      required this.imageLocation,
      required this.mode,
      required this.depositDate,
      required this.status});

  Deposition.fromJson(Map<String, dynamic> json) {
    companyBranchName = json['companyBranchName'];
    companyBranchLocation = json['companyBranchLocation'];
    recptAmount = json['recptAmount'];
    deptAmount = json['deptAmount'];
    reference = json['reference'];
    imageLocation = json['imageLocation'].cast<String>();
    mode = json['mode'];
    depositDate = json['depositDate'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['companyBranchName'] = companyBranchName;
    data['companyBranchLocation'] = companyBranchLocation;
    data['recptAmount'] = recptAmount;
    data['deptAmount'] = deptAmount;
    data['reference'] = reference;
    data['imageLocation'] = imageLocation;
    data['mode'] = mode;
    data['depositDate'] = depositDate;
    data['status'] = status;
    return data;
  }
}

// class AgentLocation {
//   int? latitude;
//   int? longitude;
//   String? missingAgentLocation;

//   AgentLocation(
//       {this.latitude = 0,
//       this.longitude = 0,
//       this.missingAgentLocation = 'true'});

//   AgentLocation.fromJson(Map<String, dynamic> json) {
//     latitude = json['latitude'];
//     longitude = json['longitude'];
//     missingAgentLocation = json['missingAgentLocation'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data['latitude'] = latitude;
//     data['longitude'] = longitude;
//     data['missingAgentLocation'] = missingAgentLocation;
//     return data;
//   }
// }
