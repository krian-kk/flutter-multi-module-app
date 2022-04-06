class MyDeposistModel {
  MyDeposistModel({this.status, this.message, this.result});

  MyDeposistModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    result =
        json['result'] != null ? DeposistResult.fromJson(json['result']) : null;
  }
  int? status;
  String? message;
  DeposistResult? result;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (result != null) {
      data['result'] = result!.toJson();
    }
    return data;
  }
}

class DeposistResult {
  DeposistResult({this.count, this.totalAmt, this.cheque, this.cash});

  DeposistResult.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    totalAmt = json['totalAmt'];
    cheque = json['cheque'] != null ? Cheque.fromJson(json['cheque']) : null;
    cash = json['cash'] != null ? Cheque.fromJson(json['cash']) : null;
  }
  int? count;
  dynamic totalAmt;
  Cheque? cheque;
  Cheque? cash;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    data['totalAmt'] = totalAmt;
    if (cheque != null) {
      data['cheque'] = cheque!.toJson();
    }
    if (cash != null) {
      data['cash'] = cash!.toJson();
    }
    return data;
  }
}

class Cheque {
  Cheque({this.count, this.cases, this.totalAmt});

  Cheque.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['cases'] != null) {
      cases = <Cases>[];
      json['cases'].forEach((dynamic v) {
        cases!.add(Cases.fromJson(v));
      });
    }
    totalAmt = json['totalAmt'];
  }
  int? count;
  List<Cases>? cases;
  dynamic totalAmt;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    if (cases != null) {
      data['cases'] = cases!.map((Cases v) => v.toJson()).toList();
    }
    data['totalAmt'] = totalAmt;
    return data;
  }
}

class Cases {
  Cases({this.sId, this.eventAttr, this.agrRef, this.caseId});

  Cases.fromJson(Map<String, dynamic> json) {
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
  EventAttr({this.amountCollected, this.date, this.mode, this.customerName});

  EventAttr.fromJson(Map<String, dynamic> json) {
    amountCollected = json['amountCollected'];
    date = json['date'];
    mode = json['mode'];
    customerName = json['customerName'];
  }
  dynamic amountCollected;
  String? date;
  String? mode;
  String? customerName;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['amountCollected'] = amountCollected;
    data['date'] = date;
    data['mode'] = mode;
    data['customerName'] = customerName;
    return data;
  }
}
