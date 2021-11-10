class CaseDetailsProirityModel {
  late int status;
  late String message;
  late List<Result> result;

  CaseDetailsProirityModel(
      {required this.status, required this.message, required this.result});

  CaseDetailsProirityModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.result != null) {
      data['result'] = this.result.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  late String sId;
  late int due;
  late String? followUpDate;
  late String customerId;
  late String pincode;
  late String caseId;
  late List<String>? address;

  Result(
      {required this.sId,
      required this.due,
      required this.followUpDate,
      required this.customerId,
      required this.pincode,
      required this.caseId,
      this.address});

  Result.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    due = json['due'];
    followUpDate = json['followUpDate'];
    customerId = json['customerId'];
    pincode = json['pincode'];
    caseId = json['caseId'];
    address = json['address'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['due'] = this.due;
    data['followUpDate'] = this.followUpDate;
    data['customerId'] = this.customerId;
    data['pincode'] = this.pincode;
    data['caseId'] = this.caseId;
    data['address'] = this.address;
    return data;
  }
}
