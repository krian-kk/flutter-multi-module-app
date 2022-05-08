class BankDepositPostModel {
  BankDepositPostModel({
    required this.ids,
    required this.deposition,
    required this.contractor,
    // required this._ids,
  });

  BankDepositPostModel.fromJson(Map<String, dynamic> json) {
    ids = json['_ids'].forEach((dynamic v) {
      ids.add(v);
    });
    deposition = json['deposition'];
    contractor = json['contractor'];
    // _ids = json['_ids'];
  }

  late List<String> ids;
  late Deposition deposition;
  late String contractor;
  // late _ids _ids;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_ids'] = ids;
    data['deposition'] = deposition;
    data['contractor'] = contractor;
    // data['_ids'] = _ids;
    return data;
  }
}

class Deposition {
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
