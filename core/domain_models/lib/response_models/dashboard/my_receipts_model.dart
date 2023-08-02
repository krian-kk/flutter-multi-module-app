class MyReceiptResult {
  MyReceiptResult(
      {this.totalCount,
      this.totalAmt,
      this.approved,
      this.rejected,
      this.newCase});

  MyReceiptResult.fromJson(Map<String, dynamic> json) {
    totalCount = json['totalCount'];
    totalAmt = json['totalAmt'];
    approved = json['approved'] != null
        ? ReceiptCases.fromJson(json['approved'])
        : null;
    rejected = json['rejected'] != null
        ? ReceiptCases.fromJson(json['rejected'])
        : null;
    newCase = json['new'] != null ? ReceiptCases.fromJson(json['new']) : null;
  }

  int? totalCount;
  dynamic totalAmt;
  ReceiptCases? approved;
  ReceiptCases? rejected;
  ReceiptCases? newCase;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalCount'] = totalCount;
    data['totalAmt'] = totalAmt;
    if (approved != null) {
      data['approved'] = approved!.toJson();
    }
    if (rejected != null) {
      data['rejected'] = rejected!.toJson();
    }
    if (newCase != null) {
      data['new'] = newCase!.toJson();
    }
    return data;
  }
}

class ReceiptCases {
  ReceiptCases({this.count, this.totalAmt, this.cases});

  ReceiptCases.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    totalAmt = json['totalAmt'];
    if (json['cases'] != null) {
      cases = <Cases>[];
      json['cases'].forEach((v) {
        cases!.add(Cases.fromJson(v));
      });
    }
  }

  int? count;
  dynamic totalAmt;
  List<Cases>? cases;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    data['totalAmt'] = totalAmt;
    if (cases != null) {
      data['cases'] = cases!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Cases {
  Cases(
      {this.sId,
      this.due,
      this.originalDue,
      this.odVal,
      this.cust,
      this.agrRef,
      this.collSubStatus,
      this.fieldfollowUpPriority,
      this.telSubStatus,
      this.followUpDate,
      this.fieldfollowUpDate,
      this.bankName,
      this.aRef,
      this.contact,
      this.totalReceiptAmount,
      this.caseId,
      this.customerId});

  Cases.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    due = json['due'];
    originalDue = json['original_due'];
    odVal = json['odVal'];
    cust = json['cust'];
    agrRef = json['agrRef'];
    collSubStatus = json['collSubStatus'];
    fieldfollowUpPriority = json['fieldfollowUpPriority'];
    telSubStatus = json['telSubStatus'];

    // followUpDate = json['followUpDate'] ?? '-';
    // Here we will check which user logged in then only set followUpDate
    if ("usertype" == "FIELDAGENT") {
      if (json['collSubStatus'] != null &&
          json['collSubStatus'].toString().toLowerCase() == 'new') {
        if (json['fieldfollowUpDate'] == null) {
          fieldfollowUpDate = DateTime.now().toString();
        } else {
          fieldfollowUpDate = json['fieldfollowUpDate'] ?? '-';
        }
      } else {
        fieldfollowUpDate = json['fieldfollowUpDate'] ?? '-';
      }
    } else {
      if (json['telSubStatus'] != null &&
          json['telSubStatus'].toString().toLowerCase() == 'new') {
        if (json['followUpDate'] == null) {
          followUpDate = DateTime.now().toString();
        } else {
          followUpDate = json['followUpDate'] ?? '-';
        }
      } else {
        followUpDate = json['followUpDate'] ?? '-';
      }
    }

    // fieldfollowUpDate = json['fieldfollowUpDate'] ?? '-';
    bankName = json['bankName'];
    aRef = json['aRef'];
    if (json['contact'] != null) {
      contact = <Contact>[];
      json['contact'].forEach((v) {
        contact!.add(Contact.fromJson(v));
      });
    }
    totalReceiptAmount = json['totalReceiptAmount'];
    caseId = json['caseId'];
    customerId = json['customerId'];
  }

  String? sId;
  dynamic due;
  dynamic originalDue;
  dynamic odVal;
  String? cust;
  String? agrRef;
  String? collSubStatus;
  String? fieldfollowUpPriority;
  String? telSubStatus;
  String? followUpDate;
  String? fieldfollowUpDate;
  String? bankName;
  String? aRef;
  List<Contact>? contact;
  dynamic totalReceiptAmount;
  String? caseId;
  String? customerId;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['due'] = due;
    data['original_due'] = originalDue;
    data['odVal'] = odVal;
    data['cust'] = cust;
    data['agrRef'] = agrRef;
    data['collSubStatus'] = collSubStatus;
    data['fieldfollowUpPriority'] = fieldfollowUpPriority;
    data['telSubStatus'] = telSubStatus;
    data['followUpDate'] = followUpDate;
    data['fieldfollowUpDate'] = fieldfollowUpDate;
    data['bankName'] = bankName;
    data['aRef'] = aRef;
    if (contact != null) {
      data['contact'] = contact!.map((v) => v.toJson()).toList();
    }
    data['totalReceiptAmount'] = totalReceiptAmount;
    data['caseId'] = caseId;
    data['customerId'] = customerId;
    return data;
  }
}

class Contact {
  Contact(
      {this.cType,
      this.health,
      this.value,
      this.resAddressId0,
      this.contactId0});

  Contact.fromJson(Map<String, dynamic> json) {
    cType = json['cType'];
    health = json['health'];
    value = json['value'];
    resAddressId0 = json['resAddressId_0'];
    contactId0 = json['contactId_0'];
  }

  String? cType;
  String? health;
  String? value;
  String? resAddressId0;
  String? contactId0;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cType'] = cType;
    data['health'] = health;
    data['value'] = value;
    data['resAddressId_0'] = resAddressId0;
    data['contactId_0'] = contactId0;
    return data;
  }
}
