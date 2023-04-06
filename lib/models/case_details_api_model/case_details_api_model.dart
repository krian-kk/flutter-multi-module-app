import 'result.dart';

class CaseDetailsApiModel {
  CaseDetailsApiModel({this.status, this.message, this.result});

  factory CaseDetailsApiModel.fromJson(Map<String, dynamic> json) {
    return CaseDetailsApiModel(
      status: json['status'] as int?,
      message: json['message'] as String?,
      result: json['result'] == null
          ? null
          : CaseDetailsResultModel.fromJson(
              json['result'] as Map<String, dynamic>),
    );
  }

  int? status;
  String? message;
  CaseDetailsResultModel? result;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'status': status,
        'message': message,
        'result': result?.toJson(),
      };
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
