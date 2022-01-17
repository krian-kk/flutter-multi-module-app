import 'attr.dart';
import 'contact.dart';
import 'repayment_info.dart';

class CaseDetails {
  String? id;
  dynamic? pos;
  dynamic due;
  String? cust;
  dynamic odVal;
  String? accNo;
  String? collSubStatus;
  String? bankName;
  String? batchNo;
  String? product;
  String? emiStartDate;
  String? schemeCode;
  String? loanDuration;
  dynamic loanAmt;
  String? pincode;
  List<Contact>? contact;
  List<List<Attr>>? attr;
  RepaymentInfo? repaymentInfo;
  String? caseId;

  CaseDetails({
    this.id,
    this.pos,
    this.due,
    this.cust,
    this.odVal,
    this.accNo,
    this.collSubStatus,
    this.bankName,
    this.batchNo,
    this.product,
    this.emiStartDate,
    this.schemeCode,
    this.loanDuration,
    this.loanAmt,
    this.pincode,
    this.contact,
    this.attr,
    this.repaymentInfo,
    this.caseId,
  });

  factory CaseDetails.fromJson(Map<String, dynamic> json) => CaseDetails(
        id: json['_id'] as String?,
        pos: json['pos'],
        due: json['due'],
        cust: json['cust'] as String?,
        odVal: json['odVal'],
        accNo: json['accNo'] as String?,
        collSubStatus: json['collSubStatus'] as String?,
        bankName: json['bankName'] as String?,
        batchNo: json['batchNo'] as String?,
        product: json['product'] as String?,
        emiStartDate: json['emiStartDate'] as String?,
        schemeCode: json['schemeCode'] as String?,
        loanDuration: json['loanDuration'] as String?,
        loanAmt: json['loanAmt'],
        pincode: json['pincode'] as String?,
        contact: (json['contact'] as List<dynamic>?)
            ?.map((e) => Contact.fromJson(e as Map<String, dynamic>))
            .toList(),
        attr: (json['attr'] as List<dynamic>?)
            ?.map((e) => (e as List<dynamic>)
                .map((e) => Attr.fromJson(e as Map<String, dynamic>))
                .toList())
            .toList(),
        repaymentInfo: json['repaymentInfo'] == null
            ? null
            : RepaymentInfo.fromJson(
                Map<String, dynamic>.from(json['repaymentInfo'])),
        caseId: json['caseId'] as String?,
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'pos': pos,
        'due': due,
        'cust': cust,
        'odVal': odVal,
        'accNo': accNo,
        'collSubStatus': collSubStatus,
        'bankName': bankName,
        'batchNo': batchNo,
        'product': product,
        'emiStartDate': emiStartDate,
        'schemeCode': schemeCode,
        'loanDuration': loanDuration,
        'loanAmt': loanAmt,
        'pincode': pincode,
        'contact': contact?.map((e) => e.toJson()).toList(),
        'attr': attr?.map((e) => e.map((e) => e.toJson()).toList()).toList(),
        'repaymentInfo': repaymentInfo?.toJson(),
        'caseId': caseId,
      };
}
