class MyDeposistModel {
  int? status;
  String? message;
  DeposistResult? result;

  MyDeposistModel({this.status, this.message, this.result});

  MyDeposistModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    result = json['result'] != null
        ? new DeposistResult.fromJson(json['result'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    return data;
  }
}

class DeposistResult {
  int? count;
  dynamic? totalAmt;
  Cheque? cheque;
  Cheque? cash;

  DeposistResult({this.count, this.totalAmt, this.cheque, this.cash});

  DeposistResult.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    totalAmt = json['totalAmt'];
    cheque =
        json['cheque'] != null ? new Cheque.fromJson(json['cheque']) : null;
    cash = json['cash'] != null ? new Cheque.fromJson(json['cash']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['totalAmt'] = this.totalAmt;
    if (this.cheque != null) {
      data['cheque'] = this.cheque!.toJson();
    }
    if (this.cash != null) {
      data['cash'] = this.cash!.toJson();
    }
    return data;
  }
}

class Cheque {
  int? count;
  List<Cases>? cases;
  dynamic? totalAmt;

  Cheque({this.count, this.cases, this.totalAmt});

  Cheque.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['cases'] != null) {
      cases = <Cases>[];
      json['cases'].forEach((v) {
        cases!.add(new Cases.fromJson(v));
      });
    }
    totalAmt = json['totalAmt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    if (this.cases != null) {
      data['cases'] = this.cases!.map((v) => v.toJson()).toList();
    }
    data['totalAmt'] = this.totalAmt;
    return data;
  }
}

class Cases {
  String? sId;
  EventAttr? eventAttr;
  String? agrRef;

  Cases({this.sId, this.eventAttr, this.agrRef});

  Cases.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    eventAttr = json['eventAttr'] != null
        ? new EventAttr.fromJson(json['eventAttr'])
        : null;
    agrRef = json['agrRef'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.eventAttr != null) {
      data['eventAttr'] = this.eventAttr!.toJson();
    }
    data['agrRef'] = this.agrRef;
    return data;
  }
}

class EventAttr {
  dynamic? amountCollected;
  String? date;
  String? mode;
  String? customerName;

  EventAttr({this.amountCollected, this.date, this.mode, this.customerName});

  EventAttr.fromJson(Map<String, dynamic> json) {
    amountCollected = json['amountCollected'];
    date = json['date'];
    mode = json['mode'];
    customerName = json['customerName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amountCollected'] = this.amountCollected;
    data['date'] = this.date;
    data['mode'] = this.mode;
    data['customerName'] = this.customerName;
    return data;
  }
}
