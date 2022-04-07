import 'contact.dart';

class ReceiptWeeklyCase {
  ReceiptWeeklyCase({
    this.id,
    this.due,
    this.originalDue,
    this.odVal,
    this.cust,
    this.agrRef,
    this.collSubStatus,
    this.telSubStatus,
    this.followUpDate,
    this.fieldfollowUpDate,
    this.bankName,
    this.customerId,
    this.contact,
    this.caseId,
  });

  factory ReceiptWeeklyCase.fromJson(Map<String, dynamic> json) =>
      ReceiptWeeklyCase(
        id: json['_id'] as String?,
        due: json['due'] as int?,
        originalDue: json['original_due'] as int?,
        odVal: json['odVal'] as int?,
        cust: json['cust'] as String?,
        agrRef: json['agrRef'] as String?,
        collSubStatus: json['collSubStatus'] as String?,
        telSubStatus: json['telSubStatus'] as String?,
        followUpDate: json['followUpDate'] as dynamic,
        fieldfollowUpDate: json['fieldfollowUpDate'] as dynamic,
        bankName: json['bankName'] as String?,
        customerId: json['customerId'] as String?,
        contact: (json['contact'] as List<dynamic>?)
            ?.map((dynamic e) => Contact.fromJson(e as Map<String, dynamic>))
            .toList(),
        caseId: json['caseId'] as String?,
      );
  String? id;
  int? due;
  int? originalDue;
  int? odVal;
  String? cust;
  String? agrRef;
  String? collSubStatus;
  String? telSubStatus;
  dynamic followUpDate;
  dynamic fieldfollowUpDate;
  String? bankName;
  String? customerId;
  List<Contact>? contact;
  String? caseId;

  Map<String, dynamic> toJson() => <String, dynamic>{
        '_id': id,
        'due': due,
        'original_due': originalDue,
        'odVal': odVal,
        'cust': cust,
        'agrRef': agrRef,
        'collSubStatus': collSubStatus,
        'telSubStatus': telSubStatus,
        'followUpDate': followUpDate,
        'fieldfollowUpDate': fieldfollowUpDate,
        'bankName': bankName,
        'customerId': customerId,
        'contact': contact?.map((Contact e) => e.toJson()).toList(),
        'caseId': caseId,
      };
}
