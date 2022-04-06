import '../../singleton.dart';
import '../../utils/constants.dart';

class MyVisitsCaseModel {
  MyVisitsCaseModel({this.status, this.message, this.result});

  MyVisitsCaseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    result =
        json['result'] != null ? MyvistResult.fromJson(json['result']) : null;
  }
  int? status;
  String? message;
  MyvistResult? result;

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

class MyvistResult {
  MyvistResult(
      {this.count, this.totalAmt, this.met, this.notMet, this.invalid});

  MyvistResult.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    totalAmt = json['totalAmt'];
    //Here we load my visit api data and my calls api data
    met = json['met'] != null
        ? Met.fromJson(json['met'])
        : json['connected'] != null
            ? Met.fromJson(json['connected'])
            : null;
    notMet = json['notMet'] != null
        ? Met.fromJson(json['notMet'])
        : json['unreachable'] != null
            ? Met.fromJson(json['unreachable'])
            : null;
    invalid = json['invalid'] != null ? Met.fromJson(json['invalid']) : null;
  }
  int? count;
  dynamic totalAmt;
  Met? met;
  Met? notMet;
  Met? invalid;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    data['totalAmt'] = totalAmt;
    if (met != null) {
      data['met'] = met!.toJson();
    }
    if (notMet != null) {
      data['notMet'] = notMet!.toJson();
    }
    if (invalid != null) {
      data['invalid'] = invalid!.toJson();
    }
    return data;
  }
}

class Met {
  Met({this.count, this.totalAmt, this.cases});

  Met.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    totalAmt = json['totalAmt'];
    if (json['cases'] != null) {
      cases = <Cases>[];
      json['cases'].forEach((dynamic v) {
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
      data['cases'] = cases!.map((Cases v) => v.toJson()).toList();
    }
    return data;
  }
}

class Cases {
  Cases(
      {this.sId,
      this.pos,
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
    pos = json['pos'];
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
    // if (Singleton.instance.usertype == Constants.fieldagent) {
    //   if (json['collSubStatus'] != null &&
    //       json['collSubStatus'].toString().toLowerCase() == 'new') {
    //     followUpDate = DateTime.now().toString();
    //   } else {
    //     followUpDate = json['followUpDate'] ?? '-';
    //   }
    // }
    if (Singleton.instance.usertype == Constants.telecaller) {
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

    if (Singleton.instance.usertype == Constants.fieldagent) {
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
    }

    bankName = json['bankName'];
    aRef = json['aRef'];
    if (json['contact'] != null) {
      contact = <Contact>[];
      json['contact'].forEach((dynamic v) {
        contact!.add(Contact.fromJson(v));
      });
    }
    totalReceiptAmount = json['totalReceiptAmount'];
    caseId = json['caseId'];
    customerId = json['customerId'];
  }
  String? sId;
  dynamic pos;
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
    data['pos'] = pos;
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
      data['contact'] = contact!.map((Contact v) => v.toJson()).toList();
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

// class CasesNew {
//   String? sId;
//   int? pos;
//   double? due;
//   double? originalDue;
//   double? odVal;
//   String? cust;
//   String? agrRef;
//   String? collSubStatus;
//   String? fieldfollowUpPriority;
//   String? telSubStatus;
//   String? followUpDate;
//   String? fieldfollowUpDate;
//   String? bankName;
//   String? aRef;
//   List<Contact>? contact;
//   int? totalReceiptAmount;
//   String? caseId;
//   String? customerId;

// CasesNew(
//     {this.sId,
//     this.pos,
//     this.due,
//     this.originalDue,
//     this.odVal,
//     this.cust,
//     this.agrRef,
//     this.collSubStatus,
//     this.fieldfollowUpPriority,
//     this.telSubStatus,
//     this.followUpDate,
//     this.fieldfollowUpDate,
//     this.bankName,
//     this.aRef,
//     this.contact,
//     this.totalReceiptAmount,
//     this.caseId,
//     this.customerId});

// CasesNew.fromJson(Map<String, dynamic> json) {
//   sId = json['_id'];
//   pos = json['pos'];
//   due = json['due'];
//   originalDue = json['original_due'];
//   odVal = json['odVal'];
//   cust = json['cust'];
//   agrRef = json['agrRef'];
//   collSubStatus = json['collSubStatus'];
//   fieldfollowUpPriority = json['fieldfollowUpPriority'];
//   telSubStatus = json['telSubStatus'];
//   followUpDate = json['followUpDate'];
//   fieldfollowUpDate = json['fieldfollowUpDate'];
//   bankName = json['bankName'];
//   aRef = json['aRef'];
//   if (json['contact'] != null) {
//     contact = <Contact>[];
//     json['contact'].forEach((v) {
//       contact!.add(new Contact.fromJson(v));
//     });
//   }
//   totalReceiptAmount = json['totalReceiptAmount'];
//   caseId = json['caseId'];
//   customerId = json['customerId'];
// }

// Map<String, dynamic> toJson() {
//   final Map<String, dynamic> data = new Map<String, dynamic>();
//   data['_id'] = this.sId;
//   data['pos'] = this.pos;
//   data['due'] = this.due;
//   data['original_due'] = this.originalDue;
//   data['odVal'] = this.odVal;
//   data['cust'] = this.cust;
//   data['agrRef'] = this.agrRef;
//   data['collSubStatus'] = this.collSubStatus;
//   data['fieldfollowUpPriority'] = this.fieldfollowUpPriority;
//   data['telSubStatus'] = this.telSubStatus;
//   data['followUpDate'] = this.followUpDate;
//   data['fieldfollowUpDate'] = this.fieldfollowUpDate;
//   data['bankName'] = this.bankName;
//   data['aRef'] = this.aRef;
//   if (this.contact != null) {
//     data['contact'] = this.contact!.map((v) => v.toJson()).toList();
//   }
//   data['totalReceiptAmount'] = this.totalReceiptAmount;
//   data['caseId'] = this.caseId;
//   data['customerId'] = this.customerId;
//   return data;
// }
// }
