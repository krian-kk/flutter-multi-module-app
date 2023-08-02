class YardingResult {
  YardingResult({this.sId, this.eventAttr, this.agrRef, this.caseId});

  YardingResult.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    eventAttr = json['eventAttr'] != null
        ? EventAttr.fromJson(json['eventAttr'])
        : null;
    agrRef = json['agrRef'];
    caseId = json['caseId'];
  }

  String? sId;
  EventAttr? eventAttr;
  String? agrRef;
  String? caseId;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    if (eventAttr != null) {
      data['eventAttr'] = eventAttr!.toJson();
    }
    data['agrRef'] = agrRef;
    data['caseId'] = caseId;
    return data;
  }
}

class EventAttr {
  EventAttr({this.registrationNo, this.customerName, this.date});

  EventAttr.fromJson(Map<String, dynamic> json) {
    registrationNo = json['registrationNo'];
    customerName = json['customerName'];
    date = json['date'];
  }

  String? registrationNo = '';
  String? customerName;
  String? date;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['registrationNo'] = registrationNo;
    data['customerName'] = customerName;
    data['date'] = date;
    return data;
  }
}
