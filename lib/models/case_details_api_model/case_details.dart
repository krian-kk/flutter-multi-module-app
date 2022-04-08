import 'agent.dart';
import 'attr.dart';
import 'audit.dart';
import 'contact.dart';
import 'customer.dart';
import 'repayment_info.dart';

class CaseDetails {
  CaseDetails({
    this.id,
    this.pos,
    this.tos,
    this.caseStage,
    this.supportAllocatedTo,
    this.allocId,
    this.agrId,
    this.isActive,
    this.collStatus,
    this.due,
    this.originalDue,
    this.odVal,
    this.cust,
    this.accNo,
    this.agrRef,
    this.collSubStatus,
    this.telSubStatus,
    this.telStatus,
    this.repoStatus,
    this.repoSubStatus,
    this.followUpDate,
    this.fieldfollowUpDate,
    this.additionalInfo,
    this.module,
    this.fatherSpouseName,
    this.bankName,
    this.batchNo,
    this.product,
    this.agency,
    this.location,
    this.pincode,
    this.emiStartDate,
    this.schemeCode,
    this.odInt,
    this.assetDetails,
    this.coLender,
    this.empBusEntity,
    this.lastPaymentDate,
    this.sourcingRmName,
    this.lastPaidAmount,
    this.riskRanking,
    this.reviewFlag,
    this.riskBucket,
    this.chassisNo,
    this.modelMake,
    this.customerId,
    this.loanDuration,
    this.loanDisbDate,
    this.emiAmt,
    this.pendingEmi,
    this.amtPenalty,
    this.loanAmt,
    this.minDueAmt,
    this.cardOs,
    this.statementDate,
    this.dueDate,
    this.cardStatus,
    this.lastBilledAmt,
    this.ref1,
    this.ref2,
    this.gurantor,
    this.customer,
    this.contact,
    this.attr,
    this.repaymentInfo,
    this.agent,
    this.audit,
    this.caseId,
    this.starredCase,
    this.lastEvent,
    this.telecallingIntensity,
    this.fieldIntensity,
    this.totalReceiptAmount,
    this.contractor,
  });

  factory CaseDetails.fromJson(Map<String, dynamic> json) => CaseDetails(
        id: json['_id'] as String?,
        pos: json['pos'],
        tos: json['tos'],
        caseStage: json['caseStage'] as String?,
        supportAllocatedTo: json['SupportAllocatedTo'] as String?,
        allocId: json['allocId'] as String?,
        agrId: json['agrId'] as String?,
        isActive: json['isActive'] as bool?,
        collStatus: json['collStatus'] as String?,
        due: json['due'],
        originalDue: json['original_due'],
        odVal: json['odVal'],
        cust: json['cust'] as String?,
        accNo: json['accNo'] as String?,
        agrRef: json['agrRef'] as String?,
        collSubStatus: json['collSubStatus'] as String?,
        telSubStatus: json['telSubStatus'] as String?,
        telStatus: json['telStatus'] as String?,
        repoStatus: json['repoStatus'] as String?,
        repoSubStatus: json['repoSubStatus'] as String?,
        followUpDate: json['followUpDate'] as dynamic,
        fieldfollowUpDate: json['fieldfollowUpDate'] as String?,
        additionalInfo: json['additionalInfo'] as dynamic,
        module: json['module'] as String?,
        fatherSpouseName: json['fatherSpouseName'] as String?,
        bankName: json['bankName'] as String?,
        batchNo: json['batchNo'] as String?,
        product: json['product'] as String?,
        agency: json['agency'] as String?,
        location: json['location'] as String?,
        pincode: json['pincode'] as String?,
        emiStartDate: json['emiStartDate'] as String?,
        schemeCode: json['schemeCode'] as String?,
        odInt: json['odInt'] as String?,
        assetDetails: json['assetDetails'] as String?,
        coLender: json['coLender'] as String?,
        empBusEntity: json['empBusEntity'] as String?,
        lastPaymentDate: json['lastPaymentDate'] as String?,
        sourcingRmName: json['sourcingRmName'] as String?,
        lastPaidAmount: json['lastPaidAmount'] as String?,
        riskRanking: json['riskRanking'] as String?,
        reviewFlag: json['reviewFlag'] as String?,
        riskBucket: json['riskBucket'] as String?,
        chassisNo: json['chassisNo'] as String?,
        modelMake: json['modelMake'] as String?,
        customerId: json['customerId'] as String?,
        loanDuration: json['loanDuration'] as String?,
        loanDisbDate: json['loanDisbDate'] as String?,
        emiAmt: json['emiAmt'] as String?,
        pendingEmi: json['pendingEMI'] as String?,
        amtPenalty: json['amtPenalty'] as String?,
        loanAmt: json['loanAmt'],
        minDueAmt: json['minDueAmt'] as String?,
        cardOs: json['cardOs'] as String?,
        statementDate: json['statementDate'] as String?,
        dueDate: json['dueDate'] as String?,
        cardStatus: json['cardStatus'] as String?,
        lastBilledAmt: json['lastBilledAmt'] as String?,
        ref1: json['ref1'] as String?,
        ref2: json['ref2'] as String?,
        gurantor: json['gurantor'] as List<dynamic>?,
        customer: json['customer'] == null
            ? null
            : Customer.fromJson(json['customer'] as Map<String, dynamic>),
        contact: (json['contact'] as List<dynamic>?)
            ?.map((dynamic e) => Contact.fromJson(e as Map<String, dynamic>))
            .toList(),
        attr: (json['attr'] as List<dynamic>?)
            ?.map((dynamic e) => Attr.fromJson(e as Map<String, dynamic>))
            .toList(),
        repaymentInfo: json['repaymentInfo'] == null
            ? null
            : RepaymentInfo.fromJson(
                Map<String, dynamic>.from(json['repaymentInfo'])),
        agent: json['agent'] == null
            ? null
            : Agent.fromJson(json['agent'] as Map<String, dynamic>),
        audit: json['audit'] == null
            ? null
            : Audit.fromJson(json['audit'] as Map<String, dynamic>),
        caseId: json['caseId'] as String?,
        starredCase: json['starredCase'] as bool?,
        lastEvent: json['lastEvent'] as String?,
        telecallingIntensity: json['telecallingIntensity'] as int?,
        fieldIntensity: json['fieldIntensity'] as int?,
        totalReceiptAmount: json['totalReceiptAmount'] as int?,
        contractor: json['contractor'] as String?,
      );
  String? id;
  dynamic pos;
  dynamic due;
  String? cust;
  dynamic odVal;
  String? accNo;
  String? collSubStatus;
  String? telSubStatus;
  String? telStatus;
  String? repoStatus;
  String? repoSubStatus;
  dynamic followUpDate;
  String? fieldfollowUpDate;
  dynamic additionalInfo;
  String? module;
  String? fatherSpouseName;
  String? bankName;
  String? batchNo;
  String? product;
  String? emiStartDate;
  String? schemeCode;
  String? loanDuration;
  dynamic loanAmt;
  String? pincode;
  List<dynamic>? gurantor;
  Customer? customer;
  List<Contact>? contact;
  List<Attr>? attr;
  RepaymentInfo? repaymentInfo;
  Agent? agent;
  Audit? audit;
  String? caseId;
  String? agrRef;
  dynamic tos;
  String? caseStage;
  String? supportAllocatedTo;
  String? allocId;
  String? agrId;
  bool? isActive;
  String? collStatus;
  dynamic originalDue;
  String? agency;
  String? location;
  String? odInt;
  String? assetDetails;
  String? coLender;
  String? empBusEntity;
  String? lastPaymentDate;
  String? sourcingRmName;
  String? lastPaidAmount;
  String? riskRanking;
  String? reviewFlag;
  String? riskBucket;
  String? chassisNo;
  String? modelMake;
  String? customerId;
  String? loanDisbDate;
  String? emiAmt;
  String? pendingEmi;
  String? amtPenalty;
  String? minDueAmt;
  String? cardOs;
  String? statementDate;
  String? dueDate;
  String? cardStatus;
  String? lastBilledAmt;
  String? ref1;
  String? ref2;
  bool? starredCase;
  String? lastEvent;
  int? telecallingIntensity;
  int? fieldIntensity;
  int? totalReceiptAmount;
  String? contractor;

  Map<String, dynamic> toJson() => <String, dynamic>{
        '_id': id,
        'pos': pos,
        'tos': tos,
        'caseStage': caseStage,
        'SupportAllocatedTo': supportAllocatedTo,
        'allocId': allocId,
        'agrId': agrId,
        'isActive': isActive,
        'collStatus': collStatus,
        'due': due,
        'original_due': originalDue,
        'odVal': odVal,
        'cust': cust,
        'accNo': accNo,
        'agrRef': agrRef,
        'collSubStatus': collSubStatus,
        'telSubStatus': telSubStatus,
        'telStatus': telStatus,
        'repoStatus': repoStatus,
        'repoSubStatus': repoSubStatus,
        'followUpDate': followUpDate,
        'fieldfollowUpDate': fieldfollowUpDate,
        'additionalInfo': additionalInfo,
        'module': module,
        'fatherSpouseName': fatherSpouseName,
        'bankName': bankName,
        'batchNo': batchNo,
        'product': product,
        'agency': agency,
        'location': location,
        'pincode': pincode,
        'emiStartDate': emiStartDate,
        'schemeCode': schemeCode,
        'odInt': odInt,
        'assetDetails': assetDetails,
        'coLender': coLender,
        'empBusEntity': empBusEntity,
        'lastPaymentDate': lastPaymentDate,
        'sourcingRmName': sourcingRmName,
        'lastPaidAmount': lastPaidAmount,
        'riskRanking': riskRanking,
        'reviewFlag': reviewFlag,
        'riskBucket': riskBucket,
        'chassisNo': chassisNo,
        'modelMake': modelMake,
        'customerId': customerId,
        'loanDuration': loanDuration,
        'loanDisbDate': loanDisbDate,
        'emiAmt': emiAmt,
        'pendingEMI': pendingEmi,
        'amtPenalty': amtPenalty,
        'loanAmt': loanAmt,
        'minDueAmt': minDueAmt,
        'cardOs': cardOs,
        'statementDate': statementDate,
        'dueDate': dueDate,
        'cardStatus': cardStatus,
        'lastBilledAmt': lastBilledAmt,
        'ref1': ref1,
        'ref2': ref2,
        'gurantor': gurantor,
        'customer': customer?.toJson(),
        'contact': contact?.map((e) => e.toJson()).toList(),
        'attr': attr?.map((e) => e.toJson()).toList().toList(),
        'repaymentInfo': repaymentInfo?.toJson(),
        'agent': agent?.toJson(),
        'audit': audit?.toJson(),
        'caseId': caseId,
        'starredCase': starredCase,
        'lastEvent': lastEvent,
        'telecallingIntensity': telecallingIntensity,
        'fieldIntensity': fieldIntensity,
        'totalReceiptAmount': totalReceiptAmount,
        'contractor': contractor,
      };
}


// import 'attr.dart';
// import 'contact.dart';
// import 'repayment_info.dart';

// class CaseDetails {
//   String? id;
//   dynamic pos;
//   dynamic due;
//   String? cust;
//   dynamic odVal;
//   String? accNo;
//   String? collSubStatus;
//   String? telSubStatus;
//   String? bankName;
//   String? batchNo;
//   String? product;
//   String? emiStartDate;
//   String? schemeCode;
//   String? loanDuration;
//   dynamic loanAmt;
//   String? pincode;
//   List<Contact>? contact;
//   List<Attr>? attr;
//   RepaymentInfo? repaymentInfo;
//   String? caseId;
//   String? agrRef;

//   CaseDetails({
//     this.id,
//     this.pos,
//     this.due,
//     this.cust,
//     this.odVal,
//     this.accNo,
//     this.collSubStatus,
//     this.telSubStatus,
//     this.bankName,
//     this.batchNo,
//     this.product,
//     this.emiStartDate,
//     this.schemeCode,
//     this.loanDuration,
//     this.loanAmt,
//     this.pincode,
//     this.contact,
//     this.attr,
//     this.repaymentInfo,
//     this.caseId,
//     this.agrRef,
//   });

//   factory CaseDetails.fromJson(Map<String, dynamic> json) => CaseDetails(
//         id: json['_id'] as String?,
//         pos: json['pos'],
//         due: json['due'],
//         cust: json['cust'] as String?,
//         odVal: json['odVal'],
//         accNo: json['accNo'] as String?,
//         collSubStatus: json['collSubStatus'] as String?,
//         telSubStatus: json['telSubStatus'] as String?,
//         bankName: json['bankName'] as String?,
//         batchNo: json['batchNo'] as String?,
//         product: json['product'] as String?,
//         emiStartDate: json['emiStartDate'] as String?,
//         schemeCode: json['schemeCode'] as String?,
//         loanDuration: json['loanDuration'] as String?,
//         loanAmt: json['loanAmt'],
//         pincode: json['pincode'] as String?,
//         contact: (json['contact'] as List<dynamic>?)
//             ?.map((e) => Contact.fromJson(e as Map<String, dynamic>))
//             .toList(),
//         attr: (json['attr'] as List<dynamic>?)
//             ?.map((e) => Attr.fromJson(e as Map<String, dynamic>))
//             .toList(),
//         repaymentInfo: json['repaymentInfo'] == null
//             ? null
//             : RepaymentInfo.fromJson(
//                 Map<String, dynamic>.from(json['repaymentInfo'])),
//         caseId: json['caseId'] as String?,
//         agrRef: json['agrRef'] as String?,
//       );

//   Map<String, dynamic> toJson() => {
//         '_id': id,
//         'pos': pos,
//         'due': due,
//         'cust': cust,
//         'odVal': odVal,
//         'accNo': accNo,
//         'collSubStatus': collSubStatus,
//         'telSubStatus': telSubStatus,
//         'bankName': bankName,
//         'batchNo': batchNo,
//         'product': product,
//         'emiStartDate': emiStartDate,
//         'schemeCode': schemeCode,
//         'loanDuration': loanDuration,
//         'loanAmt': loanAmt,
//         'pincode': pincode,
//         'contact': contact?.map((e) => e.toJson()).toList(),
//         'attr': attr?.map((e) => e.toJson()).toList().toList(),
//         'repaymentInfo': repaymentInfo?.toJson(),
//         'caseId': caseId,
//         'agrRef': agrRef,
//       };
// }
