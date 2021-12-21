class BankDepositPostModel {
  late List<String> caseIds;
  late Deposition deposition;

  BankDepositPostModel({
    required this.caseIds,
    required this.deposition,
  });

  BankDepositPostModel.fromJson(Map<String, dynamic> json) {
    caseIds = json['caseIds'].forEach((v) {
      caseIds.add(v);
    });
    deposition = json['deposition'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['caseIds'] = caseIds;
    data['deposition'] = deposition;
    return data;
  }
}

class Deposition {
  late String bankName;
  late String bankBranch;
  late String ifscCode;
  late String accNumber;
  late String recptAmount;
  late String deptAmount;
  late String reference;
  List<String>? imageLocation;
  late String mode;
  late String depositDate;
  late String status;

  Deposition({
    required this.bankName,
    required this.bankBranch,
    required this.ifscCode,
    required this.accNumber,
    required this.recptAmount,
    required this.deptAmount,
    required this.reference,
    required this.imageLocation,
    required this.mode,
    required this.depositDate,
    required this.status,
  });

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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bankName'] = bankName;
    data['bankBranch'] = bankBranch;
    data['ifscCode'] = ifscCode;
    data['accNumber'] = accNumber;
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

class AgentLocation {
  int? latitude;
  int? longitude;
  String? missingAgentLocation;

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
