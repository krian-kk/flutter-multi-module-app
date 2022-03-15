import '../singleton.dart';
import '../utils/constants.dart';

class MyReceiptsCaseModel {
  int? status;
  String? message;
  MyReceiptResult? result;

  MyReceiptsCaseModel({this.status, this.message, this.result});

  MyReceiptsCaseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    result = json['result'] != null
        ? MyReceiptResult.fromJson(json['result'])
        : null;
  }

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

class MyReceiptResult {
  int? totalCount;
  dynamic totalAmt;
  ReceiptCases? approved;
  ReceiptCases? rejected;
  ReceiptCases? newCase;

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
  int? count;
  dynamic totalAmt;
  List<Cases>? cases;

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
  String? cType;
  String? health;
  String? value;
  String? resAddressId0;
  String? contactId0;

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

// class MyReceiptsCaseModel {
//   int? status;
//   String? message;
//   MyReceiptResult? result;

//   MyReceiptsCaseModel({this.status, this.message, this.result});

//   MyReceiptsCaseModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     result = json['result'] != null
//         ? MyReceiptResult.fromJson(json['result'])
//         : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = status;
//     data['message'] = message;
//     if (result != null) {
//       data['result'] = result!.toJson();
//     }
//     return data;
//   }
// }

// class MyReceiptResult {
//   int? totalCount;
//   dynamic totalAmt;
//   List<ReceiptEvent>? receiptEvent;
//   List<Cases>? cases;
//   ReceiptList? approved;
//   ReceiptList? rejected;
//   ReceiptList? newCase;

//   MyReceiptResult(
//       {this.totalCount,
//       this.totalAmt,
//       this.receiptEvent,
//       this.cases,
//       this.approved,
//       this.rejected,
//       this.newCase});

//   MyReceiptResult.fromJson(Map<String, dynamic> json) {
//     totalCount = json['totalCount'];
//     totalAmt = json['totalAmt'];
//     if (json['receiptEvent'] != null) {
//       receiptEvent = <ReceiptEvent>[];
//       json['receiptEvent'].forEach((v) {
//         receiptEvent!.add(ReceiptEvent.fromJson(v));
//       });
//     }
//     if (json['cases'] != null) {
//       cases = <Cases>[];
//       json['cases'].forEach((v) {
//         cases!.add(Cases.fromJson(v));
//       });
//     }
//     approved = json['approved'] != null
//         ? ReceiptList.fromJson(json['approved'])
//         : null;
//     rejected = json['rejected'] != null
//         ? ReceiptList.fromJson(json['rejected'])
//         : null;
//     newCase =
//         json['newCase'] != null ? ReceiptList.fromJson(json['newCase']) : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['totalCount'] = totalCount;
//     data['totalAmt'] = totalAmt;
//     if (receiptEvent != null) {
//       data['receiptEvent'] = receiptEvent!.map((v) => v.toJson()).toList();
//     }
//     if (cases != null) {
//       data['cases'] = cases!.map((v) => v.toJson()).toList();
//     }
//     if (approved != null) {
//       data['approved'] = approved!.toJson();
//     }
//     if (rejected != null) {
//       data['rejected'] = rejected!.toJson();
//     }
//     if (newCase != null) {
//       data['newCase'] = newCase!.toJson();
//     }
//     return data;
//   }
// }

// class ReceiptEvent {
//   String? sId;
//   String? caseId;
//   EventAttr? eventAttr;

//   ReceiptEvent({this.sId, this.caseId, this.eventAttr});

//   ReceiptEvent.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     caseId = json['caseId'];
//     eventAttr = json['eventAttr'] != null
//         ? EventAttr.fromJson(json['eventAttr'])
//         : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['_id'] = sId;
//     data['caseId'] = caseId;
//     if (eventAttr != null) {
//       data['eventAttr'] = eventAttr!.toJson();
//     }
//     return data;
//   }
// }

// class EventAttr {
//   String? amountCollected;
//   String? appStatus;

//   EventAttr({this.amountCollected, this.appStatus});

//   EventAttr.fromJson(Map<String, dynamic> json) {
//     amountCollected = json['amountCollected'];
//     appStatus = json['appStatus'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['amountCollected'] = amountCollected;
//     data['appStatus'] = appStatus;
//     return data;
//   }
// }

// class Cases {
//   String? sId;
//   dynamic due;
//   dynamic originalDue;
//   dynamic odVal;
//   String? cust;
//   String? agrRef;
//   String? collSubStatus;
//   String? telSubStatus;
//   String? followUpDate;
//   String? fieldfollowUpDate;
//   String? bankName;
//   List<Contact>? contact;
//   String? caseId;
//   String? customerId;

//   Cases(
//       {this.sId,
//       this.due,
//       this.originalDue,
//       this.odVal,
//       this.cust,
//       this.agrRef,
//       this.collSubStatus,
//       this.telSubStatus,
//       this.followUpDate,
//       this.fieldfollowUpDate,
//       this.bankName,
//       this.contact,
//       this.caseId,
//       this.customerId});

//   Cases.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     due = json['due'];
//     originalDue = json['original_due'];
//     odVal = json['odVal'];
//     cust = json['cust'];
//     agrRef = json['agrRef'];
//     collSubStatus = json['collSubStatus'];
//     telSubStatus = json['telSubStatus'];
//     followUpDate = json['followUpDate'];
//     fieldfollowUpDate = json['fieldfollowUpDate'];
//     bankName = json['bankName'];
//     if (json['contact'] != null) {
//       contact = <Contact>[];
//       json['contact'].forEach((v) {
//         contact!.add(Contact.fromJson(v));
//       });
//     }
//     caseId = json['caseId'];
//     customerId = json['customerId'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['_id'] = sId;
//     data['due'] = due;
//     data['original_due'] = originalDue;
//     data['odVal'] = odVal;
//     data['cust'] = cust;
//     data['agrRef'] = agrRef;
//     data['collSubStatus'] = collSubStatus;
//     data['telSubStatus'] = telSubStatus;
//     data['followUpDate'] = followUpDate;
//     data['fieldfollowUpDate'] = fieldfollowUpDate;
//     data['bankName'] = bankName;
//     if (contact != null) {
//       data['contact'] = contact!.map((v) => v.toJson()).toList();
//     }
//     data['caseId'] = caseId;
//     data['customerId'] = customerId;
//     return data;
//   }
// }

// class Contact {
//   String? cType;
//   String? health;
//   String? value;
//   String? resAddressId0;
//   String? contactId0;
//   String? sId;

//   Contact(
//       {this.cType,
//       this.health,
//       this.value,
//       this.resAddressId0,
//       this.contactId0,
//       this.sId});

//   Contact.fromJson(Map<String, dynamic> json) {
//     cType = json['cType'];
//     health = json['health'];
//     value = json['value'];
//     resAddressId0 = json['resAddressId_0'];
//     contactId0 = json['contactId_0'];
//     sId = json['_id'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['cType'] = cType;
//     data['health'] = health;
//     data['value'] = value;
//     data['resAddressId_0'] = resAddressId0;
//     data['contactId_0'] = contactId0;
//     data['_id'] = sId;
//     return data;
//   }
// }

// class ReceiptList {
//   int? count;
//   dynamic totalAmt;
//   List<Cases>? cases;

//   ReceiptList({this.count, this.totalAmt, this.cases});

//   ReceiptList.fromJson(Map<String, dynamic> json) {
//     count = json['count'];
//     totalAmt = json['totalAmt'];
//     if (json['cases'] != null) {
//       cases = <Cases>[];
//       json['cases'].forEach((v) {
//         cases!.add(Cases.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['count'] = count;
//     data['totalAmt'] = totalAmt;
//     if (cases != null) {
//       data['cases'] = cases!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// // class Cases {
// // 	String? sId;
// // 	double? due;
// // 	double? originalDue;
// // 	double? odVal;
// // 	String? cust;
// // 	String? agrRef;
// // 	String? collSubStatus;
// // 	String? telSubStatus;
// // 	Null? followUpDate;
// // 	String? fieldfollowUpDate;
// // 	String? bankName;
// // 	List<Contact>? contact;
// // 	String? caseId;

// // 	Cases({this.sId, this.due, this.originalDue, this.odVal, this.cust, this.agrRef, this.collSubStatus, this.telSubStatus, this.followUpDate, this.fieldfollowUpDate, this.bankName, this.contact, this.caseId});

// // 	Cases.fromJson(Map<String, dynamic> json) {
// // 		sId = json['_id'];
// // 		due = json['due'];
// // 		originalDue = json['original_due'];
// // 		odVal = json['odVal'];
// // 		cust = json['cust'];
// // 		agrRef = json['agrRef'];
// // 		collSubStatus = json['collSubStatus'];
// // 		telSubStatus = json['telSubStatus'];
// // 		followUpDate = json['followUpDate'];
// // 		fieldfollowUpDate = json['fieldfollowUpDate'];
// // 		bankName = json['bankName'];
// // 		if (json['contact'] != null) {
// // 			contact = <Contact>[];
// // 			json['contact'].forEach((v) { contact!.add(new Contact.fromJson(v)); });
// // 		}
// // 		caseId = json['caseId'];
// // 	}

// // 	Map<String, dynamic> toJson() {
// // 		final Map<String, dynamic> data = new Map<String, dynamic>();
// // 		data['_id'] = this.sId;
// // 		data['due'] = this.due;
// // 		data['original_due'] = this.originalDue;
// // 		data['odVal'] = this.odVal;
// // 		data['cust'] = this.cust;
// // 		data['agrRef'] = this.agrRef;
// // 		data['collSubStatus'] = this.collSubStatus;
// // 		data['telSubStatus'] = this.telSubStatus;
// // 		data['followUpDate'] = this.followUpDate;
// // 		data['fieldfollowUpDate'] = this.fieldfollowUpDate;
// // 		data['bankName'] = this.bankName;
// // 		if (this.contact != null) {
// //       data['contact'] = this.contact!.map((v) => v.toJson()).toList();
// //     }
// // 		data['caseId'] = this.caseId;
// // 		return data;
// // 	}
// // }

// // class Contact {
// // 	String? cType;
// // 	String? health;
// // 	String? value;

// // 	Contact({this.cType, this.health, this.value});

// // 	Contact.fromJson(Map<String, dynamic> json) {
// // 		cType = json['cType'];
// // 		health = json['health'];
// // 		value = json['value'];
// // 	}

// // 	Map<String, dynamic> toJson() {
// // 		final Map<String, dynamic> data = new Map<String, dynamic>();
// // 		data['cType'] = this.cType;
// // 		data['health'] = this.health;
// // 		data['value'] = this.value;
// // 		return data;
// // 	}
// // }

// // class Result {
// // 	int? totalCount;
// // 	int? totalAmt;
// // 	List<ReceiptEvent>? receiptEvent;
// // 	List<Cases>? cases;
// // 	Approved? approved;
// // 	Approved? rejected;
// // 	Approved? new;

// // 	Result({this.totalCount, this.totalAmt, this.receiptEvent, this.cases, this.approved, this.rejected, this.new});

// // 	Result.fromJson(Map<String, dynamic> json) {
// // 		totalCount = json['totalCount'];
// // 		totalAmt = json['totalAmt'];
// // 		if (json['receiptEvent'] != null) {
// // 			receiptEvent = <ReceiptEvent>[];
// // 			json['receiptEvent'].forEach((v) { receiptEvent!.add(new ReceiptEvent.fromJson(v)); });
// // 		}
// // 		if (json['cases'] != null) {
// // 			cases = <Cases>[];
// // 			json['cases'].forEach((v) { cases!.add(new Cases.fromJson(v)); });
// // 		}
// // 		approved = json['approved'] != null ? new Approved.fromJson(json['approved']) : null;
// // 		rejected = json['rejected'] != null ? new Approved.fromJson(json['rejected']) : null;
// // 		new = json['new'] != null ? new Approved.fromJson(json['new']) : null;
// // 	}

// // 	Map<String, dynamic> toJson() {
// // 		final Map<String, dynamic> data = new Map<String, dynamic>();
// // 		data['totalCount'] = this.totalCount;
// // 		data['totalAmt'] = this.totalAmt;
// // 		if (this.receiptEvent != null) {
// //       data['receiptEvent'] = this.receiptEvent!.map((v) => v.toJson()).toList();
// //     }
// // 		if (this.cases != null) {
// //       data['cases'] = this.cases!.map((v) => v.toJson()).toList();
// //     }
// // 		if (this.approved != null) {
// //       data['approved'] = this.approved!.toJson();
// //     }
// // 		if (this.rejected != null) {
// //       data['rejected'] = this.rejected!.toJson();
// //     }
// // 		if (this.new != null) {
// //       data['new'] = this.new!.toJson();
// //     }
// // 		return data;
// // 	}
// // }
