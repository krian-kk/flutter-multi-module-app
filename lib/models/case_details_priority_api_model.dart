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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['result'] = result.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['due'] = due;
    data['followUpDate'] = followUpDate;
    data['customerId'] = customerId;
    data['pincode'] = pincode;
    data['caseId'] = caseId;
    data['address'] = address;
    return data;
  }
}
