class CompanyBranchDepositPostModel {
  CompanyBranchDepositPostModel({
    required this.caseIds,
    required this.deposition,
    required this.contractor,
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
    contractor = json['contractor'];
    // callID = json['callID'];
    // callingID = json['callingID'];
    // callerServiceID = json['callerServiceID'];
    // voiceCallEventCode = json['voiceCallEventCode'];
    // invalidNumber = json['invalidNumber'];
    // agentName = json['agentName'];
    // contractor = json['contractor'];
    // agrRef = json['agrRef'];
  }

  late List<String> caseIds;
  late Deposition deposition;
  late String contractor;
  // String? eventModule;
  // String? callID;
  // String? callingID;
  // String? callerServiceID;
  // String? voiceCallEventCode;
  // int? invalidNumber;
  // String? agentName;
  // String? contractor;
  // String? agrRef;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['caseIds'] = caseIds;
    data['deposition'] = deposition;
    data['contractor'] = contractor;

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

class Deposition {
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
  late String companyBranchName;
  late String companyBranchLocation;
  late String recptAmount;
  late String deptAmount;
  late String reference;
  List<String>? imageLocation;
  late String mode;
  late String depositDate;
  late String status;

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
