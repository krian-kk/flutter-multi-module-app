import 'package:domain_models/response_models/case/case_detail_models/agent.dart';
import 'package:domain_models/response_models/case/case_detail_models/attr.dart';
import 'package:domain_models/response_models/case/case_detail_models/audit.dart';
import 'package:domain_models/response_models/case/case_detail_models/customer.dart';
import 'package:domain_models/response_models/case/case_detail_models/other_loan_detail.dart';
import 'package:domain_models/response_models/case/case_detail_models/repayment_info.dart';

import 'contact.dart';

class CaseDetails {
  CaseDetails(
      {this.id,
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
      this.followUpPriority,
      this.fieldfollowUpPriority,
      this.additionalInfo,
      this.module,
      this.fatherSpouseName,
      this.lastPaymentMode,
      this.zone,
      this.dpd,
      this.language,
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
      this.vehicleRegNo,
      this.vehicleIdentificationNo,
      this.ref1No,
      this.ref2No,
      this.dealerName,
      this.dealerAddress,
      this.batteryID});

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
        cust: json['cust'],
        accNo: json['accNo'] as String?,
        agrRef: json['agrRef'] as String?,
        collSubStatus:
            json['collSubStatus'] != "" ? json['collSubStatus'] : null,
        telSubStatus: json['telSubStatus'],
        telStatus: json['telStatus'] as String?,
        repoStatus: json['repoStatus'] as String?,
        repoSubStatus: json['repoSubStatus'] as String?,
        followUpDate: json['followUpDate'] as dynamic,
        fieldfollowUpDate: json['fieldfollowUpDate'] as String?,
        followUpPriority: json['followUpPriority'],
        fieldfollowUpPriority: json['fieldfollowUpPriority'],
        additionalInfo: json['additionalInfo'] as dynamic,
        module: json['module'] as String?,
        fatherSpouseName: json['fatherSpouseName'] as String?,
        lastPaymentMode: json['lastPaymentMode'] as String?,
        zone: json['zone'] as String?,
        dpd: json['dpd'],
        language: json['language'] as String?,
        bankName: json['bankName'] as String?,
        batchNo: json['batchNo'] as String?,
        product: json['product'] as String?,
        agency: json['agency'] as String?,
        location: json['location'] as String?,
        pincode: json['pincode'] as String?,
        emiStartDate: json['emiStartDate'] as String?,
        schemeCode: json['schemeCode'] as String?,
        odInt: json['odInt'],
        assetDetails: json['assetDetails'] as String?,
        coLender: json['coLender'] as String?,
        empBusEntity: json['empBusEntity'] as String?,
        lastPaymentDate: json['lastPaymentDate'] as String?,
        sourcingRmName: json['sourcingRmName'] as String?,
        lastPaidAmount: json['lastPaidAmount'],
        riskRanking: json['riskRanking'] as String?,
        reviewFlag: json['reviewFlag'] as String?,
        riskBucket: json['riskBucket'] as String?,
        chassisNo: json['chassisNo'] as String?,
        modelMake: json['modelMake'] as String?,
        customerId: json['customerId'],
        loanDuration: json['loanDuration'],
        loanDisbDate: json['loanDisbDate'] as String?,
        emiAmt: json['emiAmt'],
        pendingEmi: json['pendingEMI'],
        amtPenalty: json['amtPenalty'],
        loanAmt: json['loanAmt'],
        minDueAmt: json['minDueAmt'],
        cardOs: json['cardOs'],
        statementDate: json['statementDate'] as String?,
        dueDate: json['dueDate'] as String?,
        cardStatus: json['cardStatus'] as String?,
        lastBilledAmt: json['lastBilledAmt'],
        ref1: json['ref1'],
        ref2: json['ref2'],
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
        vehicleRegNo: json['vehicleRegNo'],
        vehicleIdentificationNo: json['vehicleIdentificationNo'],
        ref1No: json['ref1No'],
        ref2No: json['ref2No'],
        dealerName: json['dealerName'],
        dealerAddress: json['dealerAddress'],
        batteryID: json['batteryID'],
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
  String? followUpPriority;
  String? fieldfollowUpPriority;
  dynamic additionalInfo;
  String? module;
  String? fatherSpouseName;
  String? lastPaymentMode;
  String? zone;
  dynamic dpd;
  String? language;
  String? bankName;
  String? batchNo;
  String? product;
  String? emiStartDate;
  String? schemeCode;
  dynamic loanDuration;
  dynamic loanAmt;
  String? pincode;
  List<dynamic>? gurantor;
  Customer? customer;
  List<Contact>? contact;
  List<Attr>? attr = [];
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
  dynamic odInt;
  String? assetDetails;
  String? coLender;
  String? empBusEntity;
  String? lastPaymentDate;
  String? sourcingRmName;
  dynamic lastPaidAmount;
  String? riskRanking;
  String? reviewFlag;
  String? riskBucket;
  String? chassisNo;
  String? modelMake;
  String? customerId;
  String? loanDisbDate;
  dynamic emiAmt;
  dynamic pendingEmi;
  dynamic amtPenalty;
  dynamic minDueAmt;
  dynamic cardOs;
  String? statementDate;
  dynamic dueDate;
  String? cardStatus;
  dynamic lastBilledAmt;
  dynamic ref1;
  dynamic ref2;
  bool? starredCase;
  String? lastEvent;
  int? telecallingIntensity;
  int? fieldIntensity;
  int? totalReceiptAmount;
  String? contractor;
  String? vehicleRegNo;
  String? vehicleIdentificationNo;
  String? ref1No;
  String? ref2No;
  String? dealerName;
  String? dealerAddress;
  String? batteryID;

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
        'followUpPriority': followUpPriority,
        'fieldfollowUpPriority': fieldfollowUpPriority,
        'additionalInfo': additionalInfo,
        'module': module,
        'fatherSpouseName': fatherSpouseName,
        'lastPaymentMode': lastPaymentMode,
        'zone': zone,
        'dpd': dpd,
        'language': language,
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
        'vehicleRegNo': vehicleRegNo,
        'vehicleIdentificationNo': vehicleIdentificationNo,
        'ref1No': ref1No,
        'ref2No': ref2No,
        'dealerName': dealerName,
        'dealerAddress': dealerAddress,
        'batteryID': batteryID,
      };
}

class CaseDetailsResultModel {
  CaseDetailsResultModel(
      {this.caseDetails,
      this.addressDetails,
      this.callDetails,
      this.otherLoanDetails,
      this.bucketedCaseData,
      this.availableAddContacts});

  factory CaseDetailsResultModel.fromJson(Map<String, dynamic> json) =>
      CaseDetailsResultModel(
        caseDetails: json['caseDetails'] == null
            ? null
            : CaseDetails.fromJson(
                Map<String, dynamic>.from(json['caseDetails'])),
        addressDetails: json['addressDetails'] as List<dynamic>?,
        callDetails: json['callDetails'] as List<dynamic>?,
        bucketedCaseData: json['bucketedCaseData'],
        otherLoanDetails: json['otherLoanDetails'] != null
            ? (json['otherLoanDetails'] as List<dynamic>?)
                ?.map((dynamic e) =>
                    OtherLoanDetail.fromJson(Map<String, dynamic>.from(e)))
                .take(25)
                .toList()
            : <OtherLoanDetail>[],
        availableAddContacts: json['availableAddContacts'] != null
            ? (json['availableAddContacts'] as List<dynamic>?)
                ?.map((dynamic e) =>
                    AvailableAddContacts.fromJson(Map<String, dynamic>.from(e)))
                .toList()
            : <AvailableAddContacts>[],
      );
  CaseDetails? caseDetails;
  Map<String, dynamic>? bucketedCaseData;
  List<dynamic>? addressDetails;
  List<dynamic>? callDetails;
  List<OtherLoanDetail>? otherLoanDetails = <OtherLoanDetail>[];
  List<AvailableAddContacts>? availableAddContacts = <AvailableAddContacts>[];

  Map<String, dynamic> toJson() => <String, dynamic>{
        'caseDetails': caseDetails?.toJson(),
        'addressDetails': addressDetails,
        'callDetails': callDetails,
        'bucketedCaseData': bucketedCaseData,
        'otherLoanDetails':
            otherLoanDetails?.map((OtherLoanDetail e) => e.toJson()).toList(),
      };
}

class AvailableAddContacts {
  String? cType;
  String? cName;
  String? type;

  AvailableAddContacts({this.cType, this.cName, this.type});

  AvailableAddContacts.fromJson(Map<String, dynamic> json) {
    cType = json['cType'];
    cName = json['cName'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cType'] = this.cType;
    data['cName'] = this.cName;
    data['type'] = this.type;
    return data;
  }
}

class CaseDetailModels {
  Map<String, dynamic>? attributeDetails;
  Map<String, dynamic>? customerDetails;
  Map<String, dynamic>? loanDetails;
  Map<String, dynamic>? customerContactDetails;
  Map<String, dynamic>? allocationDetails;
  Map<String, dynamic>? repaymentDetails;
  Map<String, dynamic>? assetDetails;

  CaseDetailModels(
      {this.attributeDetails,
      this.customerDetails,
      this.loanDetails,
      this.customerContactDetails,
      this.allocationDetails,
      this.repaymentDetails,
      this.assetDetails});

  CaseDetailModels.fromJson(Map<String, dynamic> json) {
    attributeDetails = json['attributeDetails'];
    customerDetails = json['customerDetails'];
    loanDetails = json['loanDetails'];
    customerContactDetails = json['customerContactDetails'];
    allocationDetails = json['allocationDetails'];
    repaymentDetails = json['repaymentDetails'];
    assetDetails = json['assetDetails'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.attributeDetails != null) {
      data['attributeDetails'] = this.attributeDetails;
    }
    if (this.customerDetails != null) {
      data['customerDetails'] = this.customerDetails;
    }
    if (this.loanDetails != null) {
      data['loanDetails'] = this.loanDetails;
    }
    if (this.customerContactDetails != null) {
      data['customerContactDetails'] = this.customerContactDetails;
    }
    if (this.allocationDetails != null) {
      data['allocationDetails'] = this.allocationDetails;
    }
    if (this.repaymentDetails != null) {
      data['repaymentDetails'] = this.repaymentDetails;
    }
    if (this.assetDetails != null) {
      data['assetDetails'] = this.assetDetails;
    }
    return data;
  }
}

class CustomerDetails {
  String? cust;
  String? city;
  String? state;
  String? pincode;
  String? fatherSpouseName;
  String? empBusEntity;
  String? riskBucket;
  String? zone;
  String? sourcingRmName;
  String? reviewFlag;
  String? ref1;
  String? ref2;

  CustomerDetails(
      {this.cust,
      this.city,
      this.state,
      this.pincode,
      this.fatherSpouseName,
      this.empBusEntity,
      this.riskBucket,
      this.zone,
      this.sourcingRmName,
      this.reviewFlag,
      this.ref1,
      this.ref2});

  CustomerDetails.fromJson(Map<String, dynamic> json) {
    cust = json['cust'];
    city = json['city'];
    state = json['state'];
    pincode = json['pincode'];
    fatherSpouseName = json['fatherSpouseName'];
    empBusEntity = json['empBusEntity'];
    riskBucket = json['riskBucket'];
    zone = json['zone'];
    sourcingRmName = json['sourcingRmName'];
    reviewFlag = json['reviewFlag'];
    ref1 = json['ref1'];
    ref2 = json['ref2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cust'] = this.cust;
    data['city'] = this.city;
    data['state'] = this.state;
    data['pincode'] = this.pincode;
    data['fatherSpouseName'] = this.fatherSpouseName;
    data['empBusEntity'] = this.empBusEntity;
    data['riskBucket'] = this.riskBucket;
    data['zone'] = this.zone;
    data['sourcingRmName'] = this.sourcingRmName;
    data['reviewFlag'] = this.reviewFlag;
    data['ref1'] = this.ref1;
    data['ref2'] = this.ref2;
    return data;
  }
}

class LoanDetails {
  String? agrRef;
  int? odVal;
  int? pos;
  int? tos;
  String? schemeCode;
  String? emiStartDate;
  int? loanAmt;
  int? loanDuration;
  String? loanDisbDate;
  String? maturityDate;
  int? emiAmt;
  int? pendingEMI;
  int? amtPenalty;
  int? odInt;
  String? customerId;
  int? minDueAmt;
  int? cardOs;
  String? statementDate;
  String? dueDate;
  String? cardStatus;
  int? lastBilledAmt;
  String? coLender;
  String? lastPaymentDate;
  String? lastPaymentMode;
  int? lastPaidAmount;
  String? blockCode1;
  String? blockCode1Date;
  String? blockCode2;
  String? blockCode2Date;
  int? last4Digits;
  String? productSourcingType;
  String? somBucket;
  int? somDpd;
  int? paidEMI;
  int? lateFees;

  LoanDetails(
      {this.agrRef,
      this.odVal,
      this.pos,
      this.tos,
      this.schemeCode,
      this.emiStartDate,
      this.loanAmt,
      this.loanDuration,
      this.loanDisbDate,
      this.maturityDate,
      this.emiAmt,
      this.pendingEMI,
      this.amtPenalty,
      this.odInt,
      this.customerId,
      this.minDueAmt,
      this.cardOs,
      this.statementDate,
      this.dueDate,
      this.cardStatus,
      this.lastBilledAmt,
      this.coLender,
      this.lastPaymentDate,
      this.lastPaymentMode,
      this.lastPaidAmount,
      this.blockCode1,
      this.blockCode1Date,
      this.blockCode2,
      this.blockCode2Date,
      this.last4Digits,
      this.productSourcingType,
      this.somBucket,
      this.somDpd,
      this.paidEMI,
      this.lateFees});

  LoanDetails.fromJson(Map<String, dynamic> json) {
    agrRef = json['agrRef'];
    odVal = json['odVal'];
    pos = json['pos'];
    tos = json['tos'];
    schemeCode = json['schemeCode'];
    emiStartDate = json['emiStartDate'];
    loanAmt = json['loanAmt'];
    loanDuration = json['loanDuration'];
    loanDisbDate = json['loanDisbDate'];
    maturityDate = json['maturityDate'];
    emiAmt = json['emiAmt'];
    pendingEMI = json['pendingEMI'];
    amtPenalty = json['amtPenalty'];
    odInt = json['odInt'];
    customerId = json['customerId'];
    minDueAmt = json['minDueAmt'];
    cardOs = json['cardOs'];
    statementDate = json['statementDate'];
    dueDate = json['dueDate'];
    cardStatus = json['cardStatus'];
    lastBilledAmt = json['lastBilledAmt'];
    coLender = json['coLender'];
    lastPaymentDate = json['lastPaymentDate'];
    lastPaymentMode = json['lastPaymentMode'];
    lastPaidAmount = json['lastPaidAmount'];
    blockCode1 = json['blockCode1'];
    blockCode1Date = json['blockCode1Date'];
    blockCode2 = json['blockCode2'];
    blockCode2Date = json['blockCode2Date'];
    last4Digits = json['last4Digits'];
    productSourcingType = json['productSourcingType'];
    somBucket = json['somBucket'];
    somDpd = json['somDpd'];
    paidEMI = json['paidEMI'];
    lateFees = json['lateFees'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['agrRef'] = this.agrRef;
    data['odVal'] = this.odVal;
    data['pos'] = this.pos;
    data['tos'] = this.tos;
    data['schemeCode'] = this.schemeCode;
    data['emiStartDate'] = this.emiStartDate;
    data['loanAmt'] = this.loanAmt;
    data['loanDuration'] = this.loanDuration;
    data['loanDisbDate'] = this.loanDisbDate;
    data['maturityDate'] = this.maturityDate;
    data['emiAmt'] = this.emiAmt;
    data['pendingEMI'] = this.pendingEMI;
    data['amtPenalty'] = this.amtPenalty;
    data['odInt'] = this.odInt;
    data['customerId'] = this.customerId;
    data['minDueAmt'] = this.minDueAmt;
    data['cardOs'] = this.cardOs;
    data['statementDate'] = this.statementDate;
    data['dueDate'] = this.dueDate;
    data['cardStatus'] = this.cardStatus;
    data['lastBilledAmt'] = this.lastBilledAmt;
    data['coLender'] = this.coLender;
    data['lastPaymentDate'] = this.lastPaymentDate;
    data['lastPaymentMode'] = this.lastPaymentMode;
    data['lastPaidAmount'] = this.lastPaidAmount;
    data['blockCode1'] = this.blockCode1;
    data['blockCode1Date'] = this.blockCode1Date;
    data['blockCode2'] = this.blockCode2;
    data['blockCode2Date'] = this.blockCode2Date;
    data['last4Digits'] = this.last4Digits;
    data['productSourcingType'] = this.productSourcingType;
    data['somBucket'] = this.somBucket;
    data['somDpd'] = this.somDpd;
    data['paidEMI'] = this.paidEMI;
    data['lateFees'] = this.lateFees;
    return data;
  }
}

class CustomerContactDetails {
  String? mobile;
  String? email;
  String? residenceAddress;

  CustomerContactDetails({this.mobile, this.email, this.residenceAddress});

  CustomerContactDetails.fromJson(Map<String, dynamic> json) {
    mobile = json['mobile'];
    email = json['email'];
    residenceAddress = json['residence address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    data['residence address'] = this.residenceAddress;
    return data;
  }
}

class AllocationDetails {
  String? aRef;
  String? supportAllocatedTo;

  AllocationDetails({this.aRef, this.supportAllocatedTo});

  AllocationDetails.fromJson(Map<String, dynamic> json) {
    aRef = json['aRef'];
    supportAllocatedTo = json['SupportAllocatedTo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['aRef'] = this.aRef;
    data['SupportAllocatedTo'] = this.supportAllocatedTo;
    return data;
  }
}

class RepaymentDetails {
  String? benefeciaryAccNo;
  String? benefeciaryAccName;
  String? repayBankName;
  String? refUrl;
  String? repaymentIfscCode;
  String? refLender;

  RepaymentDetails(
      {this.benefeciaryAccNo,
      this.benefeciaryAccName,
      this.repayBankName,
      this.refUrl,
      this.repaymentIfscCode,
      this.refLender});

  RepaymentDetails.fromJson(Map<String, dynamic> json) {
    benefeciaryAccNo = json['benefeciaryAcc_No'];
    benefeciaryAccName = json['benefeciaryAcc_Name'];
    repayBankName = json['repayBankName'];
    refUrl = json['ref_url'];
    repaymentIfscCode = json['repaymentIfscCode'];
    refLender = json['refLender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['benefeciaryAcc_No'] = this.benefeciaryAccNo;
    data['benefeciaryAcc_Name'] = this.benefeciaryAccName;
    data['repayBankName'] = this.repayBankName;
    data['ref_url'] = this.refUrl;
    data['repaymentIfscCode'] = this.repaymentIfscCode;
    data['refLender'] = this.refLender;
    return data;
  }
}

class AssetDetails {
  String? assetDetails;
  String? chassisNo;
  String? modelMake;

  AssetDetails({this.assetDetails, this.chassisNo, this.modelMake});

  AssetDetails.fromJson(Map<String, dynamic> json) {
    assetDetails = json['assetDetails'];
    chassisNo = json['chassisNo'];
    modelMake = json['modelMake'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['assetDetails'] = this.assetDetails;
    data['chassisNo'] = this.chassisNo;
    data['modelMake'] = this.modelMake;
    return data;
  }
}
