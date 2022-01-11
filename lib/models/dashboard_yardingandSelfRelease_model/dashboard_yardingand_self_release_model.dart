class YardingData {
  int? status;
  String? message;
  List<YardingResult>? result;

  YardingData({this.status, this.message, this.result});

  YardingData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['result'] != null) {
      result = <YardingResult>[];
      json['result'].forEach((v) {
        result!.add(YardingResult.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (result != null) {
      data['result'] = result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class YardingResult {
  String? sId;
  EventAttr? eventAttr;
  String? agrRef;

  YardingResult({this.sId, this.eventAttr, this.agrRef});

  YardingResult.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    eventAttr = json['eventAttr'] != null
        ? EventAttr.fromJson(json['eventAttr'])
        : null;
    agrRef = json['agrRef'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    if (eventAttr != null) {
      data['eventAttr'] = eventAttr!.toJson();
    }
    data['agrRef'] = agrRef;
    return data;
  }
}

class EventAttr {
  String? registrationNo;
  String? customerName;
  String? date;

  EventAttr({this.registrationNo, this.customerName, this.date});

  EventAttr.fromJson(Map<String, dynamic> json) {
    registrationNo = json['registrationNo'];
    customerName = json['customerName'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['registrationNo'] = registrationNo;
    data['customerName'] = customerName;
    data['date'] = date;
    return data;
  }
}
