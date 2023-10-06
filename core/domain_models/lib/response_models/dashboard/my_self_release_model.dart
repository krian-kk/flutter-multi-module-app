class MySelfReleaseResult {
  MySelfReleaseResult({
    this.totalCount,
    this.approved,
    this.rejected,
    this.newCase,
    this.selfReleaseEvent,
  });

  MySelfReleaseResult.fromJson(Map<String, dynamic> json) {
    totalCount = json['totalCount'];
    approved = json['approved'] != null
        ? ReceiptCases.fromJson(json['approved'])
        : null;
    rejected = json['rejected'] != null
        ? ReceiptCases.fromJson(json['rejected'])
        : null;
    newCase = json['new'] != null ? ReceiptCases.fromJson(json['new']) : null;
  }

  int? totalCount;
  List<SelfReleaseEvent>? selfReleaseEvent;
  ReceiptCases? approved;
  ReceiptCases? rejected;
  ReceiptCases? newCase;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalCount'] = totalCount;
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
  ReceiptCases({this.count, this.cases});

  ReceiptCases.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['cases'] != null) {
      cases = <Cases>[];
      json['cases'].forEach((v) {
        cases!.add(Cases.fromJson(v));
      });
    }
  }

  int? count;
  List<Cases>? cases;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    if (cases != null) {
      data['cases'] = cases!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SelfReleaseEvent {
  SelfReleaseEvent({
    required this.srid,
    required this.eventId,
    required this.caseId,
    required this.eventType,
    required this.eventAttr,
    required this.eventCode,
    required this.createdAt,
    required this.createdBy,
    required this.eventModule,
    required this.lastAction,
    required this.agrRef,
    required this.contractor,
    required this.agentName,
    required this.srV,
  });

  late final String srid;
  late final int eventId;
  late final String caseId;
  late final String eventType;
  late final EventAttr eventAttr;
  late final String eventCode;
  late final String createdAt;
  late final String createdBy;
  late final String eventModule;
  late final String lastAction;
  late final String agrRef;
  late final String contractor;
  late final String agentName;
  late final int srV;

  SelfReleaseEvent.fromJson(Map<String, dynamic> json) {
    srid = json['_id'];
    eventId = json['eventId'];
    caseId = json['caseId'];
    eventType = json['eventType'];
    eventAttr = EventAttr.fromJson(json['eventAttr']);
    eventCode = json['eventCode'];
    createdAt = json['createdAt'];
    createdBy = json['createdBy'];
    eventModule = json['eventModule'];
    lastAction = json['lastAction'];
    agrRef = json['agrRef'];
    contractor = json['contractor'];
    agentName = json['agentName'];
    srV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = srid;
    _data['eventId'] = eventId;
    _data['caseId'] = caseId;
    _data['eventType'] = eventType;
    _data['eventAttr'] = eventAttr.toJson();
    _data['eventCode'] = eventCode;
    _data['createdAt'] = createdAt;
    _data['createdBy'] = createdBy;
    _data['eventModule'] = eventModule;
    _data['lastAction'] = lastAction;
    _data['agrRef'] = agrRef;
    _data['contractor'] = contractor;
    _data['agentName'] = agentName;
    _data['__v'] = srV;
    return _data;
  }
}

class EventAttr {
  EventAttr({
    required this.depositionFlow,
    required this.modelMake,
    required this.chassisNo,
    required this.vehicleRegNo,
    required this.dealerName,
    required this.dealerAddress,
    required this.ref1,
    required this.ref1No,
    required this.ref2,
    required this.ref2No,
    required this.batteryID,
    required this.vehicleIdentificationNo,
    required this.remarks,
    this.amountCollected,
    required this.repo,
    required this.followUpPriority,
    required this.imageLocation,
    required this.customerName,
    required this.date,
    required this.altitude,
    required this.accuracy,
    required this.altitudeAccuracy,
    required this.heading,
    required this.speed,
    required this.Latitude,
    required this.Longitude,
    required this.distance,
    required this.agentLocation,
    required this.appStatus,
    required this.deposition,
  });

  late final bool depositionFlow;
  late final String modelMake;
  late final String chassisNo;
  late final String vehicleRegNo;
  late final String dealerName;
  late final String dealerAddress;
  late final String ref1;
  late final String ref1No;
  late final String ref2;
  late final String ref2No;
  late final String batteryID;
  late final String vehicleIdentificationNo;
  late final String remarks;
  late final Null amountCollected;
  late final Repo repo;
  late final String followUpPriority;
  late final List<String> imageLocation;
  late final String customerName;
  late final String date;
  late final double altitude;
  late final int accuracy;
  late final int altitudeAccuracy;
  late final double heading;
  late final double speed;
  late final double Latitude;
  late final double Longitude;
  late final int distance;
  late final AgentLocation agentLocation;
  late final String appStatus;
  late final Deposition deposition;

  EventAttr.fromJson(Map<String, dynamic> json) {
    depositionFlow = json['depositionFlow'];
    modelMake = json['modelMake'];
    chassisNo = json['chassisNo'];
    vehicleRegNo = json['vehicleRegNo'];
    dealerName = json['dealerName'];
    dealerAddress = json['dealerAddress'];
    ref1 = json['ref1'];
    ref1No = json['ref1No'];
    ref2 = json['ref2'];
    ref2No = json['ref2No'];
    batteryID = json['batteryID'];
    vehicleIdentificationNo = json['vehicleIdentificationNo'];
    remarks = json['remarks'];
    amountCollected = null;
    repo = Repo.fromJson(json['repo']);
    followUpPriority = json['followUpPriority'];
    imageLocation = List.castFrom<dynamic, String>(json['imageLocation']);
    customerName = json['customerName'];
    date = json['date'];
    altitude = json['altitude'];
    accuracy = json['accuracy'];
    altitudeAccuracy = json['altitudeAccuracy'];
    heading = json['heading'];
    speed = json['speed'];
    Latitude = json['Latitude'];
    Longitude = json['Longitude'];
    distance = json['distance'];
    agentLocation = AgentLocation.fromJson(json['agentLocation']);
    appStatus = json['appStatus'];
    deposition = Deposition.fromJson(json['deposition']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['depositionFlow'] = depositionFlow;
    _data['modelMake'] = modelMake;
    _data['chassisNo'] = chassisNo;
    _data['vehicleRegNo'] = vehicleRegNo;
    _data['dealerName'] = dealerName;
    _data['dealerAddress'] = dealerAddress;
    _data['ref1'] = ref1;
    _data['ref1No'] = ref1No;
    _data['ref2'] = ref2;
    _data['ref2No'] = ref2No;
    _data['batteryID'] = batteryID;
    _data['vehicleIdentificationNo'] = vehicleIdentificationNo;
    _data['remarks'] = remarks;
    _data['amountCollected'] = amountCollected;
    _data['repo'] = repo.toJson();
    _data['followUpPriority'] = followUpPriority;
    _data['imageLocation'] = imageLocation;
    _data['customerName'] = customerName;
    _data['date'] = date;
    _data['altitude'] = altitude;
    _data['accuracy'] = accuracy;
    _data['altitudeAccuracy'] = altitudeAccuracy;
    _data['heading'] = heading;
    _data['speed'] = speed;
    _data['Latitude'] = Latitude;
    _data['Longitude'] = Longitude;
    _data['distance'] = distance;
    _data['agentLocation'] = agentLocation.toJson();
    _data['appStatus'] = appStatus;
    _data['deposition'] = deposition.toJson();
    return _data;
  }
}

class Repo {
  Repo({
    required this.date,
    required this.time,
    required this.remarks,
    required this.status,
    required this.imageLocation,
  });

  late final String date;
  late final String time;
  late final String remarks;
  late final String status;
  late final List<String> imageLocation;

  Repo.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    time = json['time'];
    remarks = json['remarks'];
    status = json['status'];
    imageLocation = List.castFrom<dynamic, String>(json['imageLocation']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['date'] = date;
    _data['time'] = time;
    _data['remarks'] = remarks;
    _data['status'] = status;
    _data['imageLocation'] = imageLocation;
    return _data;
  }
}

class AgentLocation {
  AgentLocation({
    required this.latitude,
    required this.longitude,
    required this.missingAgentLocation,
  });

  late final double latitude;
  late final double longitude;
  late final bool missingAgentLocation;

  AgentLocation.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
    missingAgentLocation = json['missingAgentLocation'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['latitude'] = latitude;
    _data['longitude'] = longitude;
    _data['missingAgentLocation'] = missingAgentLocation;
    return _data;
  }
}

class Deposition {
  Deposition({
    required this.imageLocation,
  });

  late final List<dynamic> imageLocation;

  Deposition.fromJson(Map<String, dynamic> json) {
    imageLocation = List.castFrom<dynamic, dynamic>(json['imageLocation']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['imageLocation'] = imageLocation;
    return _data;
  }
}

class Cases {
  String? sId;
  Audit? audit;
  String? bankName;
  String? agrRef;
  String? cust;
  List<Contact>? contact;
  int? odVal;
  String? aRef;
  String? supportAllocatedTo;
  int? pos;
  int? tos;
  String? schemeCode;
  String? emiStartDate;
  int? loanAmt;
  int? loanDuration;
  String? loanDisbDate;
  int? emiAmt;
  int? paidEMI;
  String? pendingEMI;
  String? amtPenalty;
  String? charges;
  String? field78;
  String? odInt;
  String? customerId;
  int? landline;
  String? field23;
  String? field25;
  String? city;
  String? state;
  String? pincode;
  int? minDueAmt;
  int? cardOs;
  int? cycleDue;
  String? cardStatus;
  int? lastBilledAmt;
  RepaymentInfo? repaymentInfo;
  String? fatherSpouseName;
  String? empBusEntity;
  String? coLender;
  String? lastPaymentMode;
  String? lastPaidAmount;
  String? riskBucket;
  String? zone;
  String? sourcingRmName;
  String? field53;
  String? reviewFlag;
  String? assetDetails;
  String? vehicleRegNo;
  String? vehicleIdentificationNo;
  String? chassisNo;
  String? modelMake;
  String? batteryID;
  String? ref1;
  String? ref1No;
  String? ref2;
  String? ref2No;
  String? dealerName;
  String? dealerAddress;
  String? agency;
  String? product;
  String? location;
  int? dpd;
  String? language;
  String? blockCode1;
  String? blockCode2;
  int? last4Digits;
  String? productSourcingType;
  String? statementMonth;
  String? somBucket;
  int? somDpd;
  String? field72;
  String? field73;
  String? field74;
  String? field75;
  String? field79;
  String? field80;
  String? module;
  String? batchNo;
  String? caseStage;
  String? allocId;
  String? agrId;
  int? due;
  bool? isActive;
  String? collStatus;
  String? collSubStatus;
  String? followUpPriority;
  String? fieldfollowUpPriority;
  String? telStatus;
  String? telSubStatus;
  String? repoStatus;
  String? repoSubStatus;
  Null? followUpDate;
  String? fieldfollowUpDate;
  Customer? customer;
  int? totalReceiptAmount;
  String? contractor;
  Agent? agent;
  bool? overrideCampaign;
  bool? isAllocated;
  bool? isSourced;
  String? caseId;
  int? mob;
  int? digitalIntensity;
  int? emailIntensity;
  int? fieldIntensity;
  String? liveDate;
  int? obdIntensity;
  int? smsIntensity;
  int? telecallingIntensity;
  int? whatsappIntensity;
  String? addressLine1;
  String? addressLine2;
  String? addressLine3;
  String? addressLine4;
  int? bureauScore;
  String? lateFees;
  String? mobile1;
  String? mobile3;
  String? riskRanking;
  String? tradeDetails;
  bool? starredCase;
  String? lastEvent;
  String? caseFlagUpdatedBy;
  bool? contactStatusFlag;
  bool? engagementStatusFlag;
  bool? promiseStatusFlag;
  bool? resolutionStatusFlag;
  bool? rtpDenialStatusFlag;
  CaseStatus? caseStatus;
  String? botfieldfollowUpDate;
  Null? lastPaymentDate;
  String? accountStatus;
  String? dueDate;
  String? statementDate;
  bool? dnd;
  bool? internalAllocation;
  int? daysFromLastCycle;

  Cases(
      {this.sId,
      this.audit,
      this.bankName,
      this.agrRef,
      this.cust,
      this.contact,
      this.odVal,
      this.aRef,
      this.supportAllocatedTo,
      this.pos,
      this.tos,
      this.schemeCode,
      this.emiStartDate,
      this.loanAmt,
      this.loanDuration,
      this.loanDisbDate,
      this.emiAmt,
      this.paidEMI,
      this.pendingEMI,
      this.amtPenalty,
      this.charges,
      this.field78,
      this.odInt,
      this.customerId,
      this.landline,
      this.field23,
      this.field25,
      this.city,
      this.state,
      this.pincode,
      this.minDueAmt,
      this.cardOs,
      this.cycleDue,
      this.cardStatus,
      this.lastBilledAmt,
      this.repaymentInfo,
      this.fatherSpouseName,
      this.empBusEntity,
      this.coLender,
      this.lastPaymentMode,
      this.lastPaidAmount,
      this.riskBucket,
      this.zone,
      this.sourcingRmName,
      this.field53,
      this.reviewFlag,
      this.assetDetails,
      this.vehicleRegNo,
      this.vehicleIdentificationNo,
      this.chassisNo,
      this.modelMake,
      this.batteryID,
      this.ref1,
      this.ref1No,
      this.ref2,
      this.ref2No,
      this.dealerName,
      this.dealerAddress,
      this.agency,
      this.product,
      this.location,
      this.dpd,
      this.language,
      this.blockCode1,
      this.blockCode2,
      this.last4Digits,
      this.productSourcingType,
      this.statementMonth,
      this.somBucket,
      this.somDpd,
      this.field72,
      this.field73,
      this.field74,
      this.field75,
      this.field79,
      this.field80,
      this.module,
      this.batchNo,
      this.caseStage,
      this.allocId,
      this.agrId,
      this.due,
      this.isActive,
      this.collStatus,
      this.collSubStatus,
      this.followUpPriority,
      this.fieldfollowUpPriority,
      this.telStatus,
      this.telSubStatus,
      this.repoStatus,
      this.repoSubStatus,
      this.followUpDate,
      this.fieldfollowUpDate,
      this.customer,
      this.totalReceiptAmount,
      this.contractor,
      this.agent,
      this.overrideCampaign,
      this.isAllocated,
      this.isSourced,
      this.caseId,
      this.mob,
      this.digitalIntensity,
      this.emailIntensity,
      this.fieldIntensity,
      this.liveDate,
      this.obdIntensity,
      this.smsIntensity,
      this.telecallingIntensity,
      this.whatsappIntensity,
      this.addressLine1,
      this.addressLine2,
      this.addressLine3,
      this.addressLine4,
      this.bureauScore,
      this.lateFees,
      this.mobile1,
      this.mobile3,
      this.riskRanking,
      this.tradeDetails,
      this.starredCase,
      this.lastEvent,
      this.caseFlagUpdatedBy,
      this.contactStatusFlag,
      this.engagementStatusFlag,
      this.promiseStatusFlag,
      this.resolutionStatusFlag,
      this.rtpDenialStatusFlag,
      this.caseStatus,
      this.botfieldfollowUpDate,
      this.lastPaymentDate,
      this.accountStatus,
      this.dueDate,
      this.statementDate,
      this.dnd,
      this.internalAllocation,
      this.daysFromLastCycle});

  Cases.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    audit = json['audit'] != null ? new Audit.fromJson(json['audit']) : null;
    bankName = json['bankName'];
    agrRef = json['agrRef'];
    cust = json['cust'];
    if (json['contact'] != null) {
      contact = <Contact>[];
      json['contact'].forEach((v) {
        contact!.add(new Contact.fromJson(v));
      });
    }
    odVal = json['odVal'];
    aRef = json['aRef'];
    supportAllocatedTo = json['SupportAllocatedTo'];
    pos = json['pos'];
    tos = json['tos'];
    schemeCode = json['schemeCode'];
    emiStartDate = json['emiStartDate'];
    loanAmt = json['loanAmt'];
    loanDuration = json['loanDuration'];
    loanDisbDate = json['loanDisbDate'];
    emiAmt = json['emiAmt'];
    paidEMI = json['paidEMI'];
    pendingEMI = json['pendingEMI'];
    amtPenalty = json['amtPenalty'];
    charges = json['charges'];
    field78 = json['field_78'];
    odInt = json['odInt'];
    customerId = json['customerId'];
    landline = json['landline'];
    field23 = json['field_23'];
    field25 = json['field_25'];
    city = json['city'];
    state = json['state'];
    pincode = json['pincode'];
    minDueAmt = json['minDueAmt'];
    cardOs = json['cardOs'];
    cycleDue = json['cycleDue'];
    cardStatus = json['cardStatus'];
    lastBilledAmt = json['lastBilledAmt'];
    repaymentInfo = json['repaymentInfo'] != null
        ? new RepaymentInfo.fromJson(json['repaymentInfo'])
        : null;
    fatherSpouseName = json['fatherSpouseName'];
    empBusEntity = json['empBusEntity'];
    coLender = json['coLender'];
    lastPaymentMode = json['lastPaymentMode'];
    lastPaidAmount = json['lastPaidAmount'];
    riskBucket = json['riskBucket'];
    zone = json['zone'];
    sourcingRmName = json['sourcingRmName'];
    field53 = json['field_53'];
    reviewFlag = json['reviewFlag'];
    assetDetails = json['assetDetails'];
    vehicleRegNo = json['vehicleRegNo'];
    vehicleIdentificationNo = json['vehicleIdentificationNo'];
    chassisNo = json['chassisNo'];
    modelMake = json['modelMake'];
    batteryID = json['batteryID'];
    ref1 = json['ref1'];
    ref1No = json['ref1No'];
    ref2 = json['ref2'];
    ref2No = json['ref2No'];
    dealerName = json['dealerName'];
    dealerAddress = json['dealerAddress'];
    agency = json['agency'];
    product = json['product'];
    location = json['location'];
    dpd = json['dpd'];
    language = json['language'];
    blockCode1 = json['blockCode1'];
    blockCode2 = json['blockCode2'];
    last4Digits = json['last4Digits'];
    productSourcingType = json['productSourcingType'];
    statementMonth = json['statementMonth'];
    somBucket = json['somBucket'];
    somDpd = json['somDpd'];
    field72 = json['field_72'];
    field73 = json['field_73'];
    field74 = json['field_74'];
    field75 = json['field_75'];
    field79 = json['field_79'];
    field80 = json['field_80'];
    module = json['module'];
    batchNo = json['batchNo'];
    caseStage = json['caseStage'];
    allocId = json['allocId'];
    agrId = json['agrId'];
    due = json['due'];
    isActive = json['isActive'];
    collStatus = json['collStatus'];
    collSubStatus = json['collSubStatus'];
    followUpPriority = json['followUpPriority'];
    fieldfollowUpPriority = json['fieldfollowUpPriority'];
    telStatus = json['telStatus'];
    telSubStatus = json['telSubStatus'];
    repoStatus = json['repoStatus'];
    repoSubStatus = json['repoSubStatus'];
    followUpDate = json['followUpDate'];
    fieldfollowUpDate = json['fieldfollowUpDate'];
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
    totalReceiptAmount = json['totalReceiptAmount'];
    contractor = json['contractor'];
    agent = json['agent'] != null ? new Agent.fromJson(json['agent']) : null;
    overrideCampaign = json['overrideCampaign'];
    isAllocated = json['isAllocated'];
    isSourced = json['isSourced'];
    caseId = json['caseId'];
    mob = json['mob'];
    digitalIntensity = json['digitalIntensity'];
    emailIntensity = json['emailIntensity'];
    fieldIntensity = json['fieldIntensity'];
    liveDate = json['liveDate'];
    obdIntensity = json['obdIntensity'];
    smsIntensity = json['smsIntensity'];
    telecallingIntensity = json['telecallingIntensity'];
    whatsappIntensity = json['whatsappIntensity'];
    addressLine1 = json['addressLine1'];
    addressLine2 = json['addressLine2'];
    addressLine3 = json['addressLine3'];
    addressLine4 = json['addressLine4'];
    bureauScore = json['bureauScore'];
    lateFees = json['lateFees'];
    mobile1 = json['mobile1'];
    mobile3 = json['mobile3'];
    riskRanking = json['riskRanking'];
    tradeDetails = json['tradeDetails'];
    starredCase = json['starredCase'];
    lastEvent = json['lastEvent'];
    caseFlagUpdatedBy = json['caseFlagUpdatedBy'];
    contactStatusFlag = json['contactStatusFlag'];
    engagementStatusFlag = json['engagementStatusFlag'];
    promiseStatusFlag = json['promiseStatusFlag'];
    resolutionStatusFlag = json['resolutionStatusFlag'];
    rtpDenialStatusFlag = json['rtpDenialStatusFlag'];
    caseStatus = json['caseStatus'] != null
        ? new CaseStatus.fromJson(json['caseStatus'])
        : null;
    botfieldfollowUpDate = json['botfieldfollowUpDate'];
    lastPaymentDate = json['lastPaymentDate'];
    accountStatus = json['accountStatus'];
    dueDate = json['dueDate'];
    statementDate = json['statementDate'];
    dnd = json['dnd'];
    internalAllocation = json['internalAllocation'];
    daysFromLastCycle = json['daysFromLastCycle'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.audit != null) {
      data['audit'] = this.audit!.toJson();
    }
    data['bankName'] = this.bankName;
    data['agrRef'] = this.agrRef;
    data['cust'] = this.cust;
    if (this.contact != null) {
      data['contact'] = this.contact!.map((v) => v.toJson()).toList();
    }
    data['odVal'] = this.odVal;
    data['aRef'] = this.aRef;
    data['SupportAllocatedTo'] = this.supportAllocatedTo;
    data['pos'] = this.pos;
    data['tos'] = this.tos;
    data['schemeCode'] = this.schemeCode;
    data['emiStartDate'] = this.emiStartDate;
    data['loanAmt'] = this.loanAmt;
    data['loanDuration'] = this.loanDuration;
    data['loanDisbDate'] = this.loanDisbDate;
    data['emiAmt'] = this.emiAmt;
    data['paidEMI'] = this.paidEMI;
    data['pendingEMI'] = this.pendingEMI;
    data['amtPenalty'] = this.amtPenalty;
    data['charges'] = this.charges;
    data['field_78'] = this.field78;
    data['odInt'] = this.odInt;
    data['customerId'] = this.customerId;
    data['landline'] = this.landline;
    data['field_23'] = this.field23;
    data['field_25'] = this.field25;
    data['city'] = this.city;
    data['state'] = this.state;
    data['pincode'] = this.pincode;
    data['minDueAmt'] = this.minDueAmt;
    data['cardOs'] = this.cardOs;
    data['cycleDue'] = this.cycleDue;
    data['cardStatus'] = this.cardStatus;
    data['lastBilledAmt'] = this.lastBilledAmt;
    if (this.repaymentInfo != null) {
      data['repaymentInfo'] = this.repaymentInfo!.toJson();
    }
    data['fatherSpouseName'] = this.fatherSpouseName;
    data['empBusEntity'] = this.empBusEntity;
    data['coLender'] = this.coLender;
    data['lastPaymentMode'] = this.lastPaymentMode;
    data['lastPaidAmount'] = this.lastPaidAmount;
    data['riskBucket'] = this.riskBucket;
    data['zone'] = this.zone;
    data['sourcingRmName'] = this.sourcingRmName;
    data['field_53'] = this.field53;
    data['reviewFlag'] = this.reviewFlag;
    data['assetDetails'] = this.assetDetails;
    data['vehicleRegNo'] = this.vehicleRegNo;
    data['vehicleIdentificationNo'] = this.vehicleIdentificationNo;
    data['chassisNo'] = this.chassisNo;
    data['modelMake'] = this.modelMake;
    data['batteryID'] = this.batteryID;
    data['ref1'] = this.ref1;
    data['ref1No'] = this.ref1No;
    data['ref2'] = this.ref2;
    data['ref2No'] = this.ref2No;
    data['dealerName'] = this.dealerName;
    data['dealerAddress'] = this.dealerAddress;
    data['agency'] = this.agency;
    data['product'] = this.product;
    data['location'] = this.location;
    data['dpd'] = this.dpd;
    data['language'] = this.language;
    data['blockCode1'] = this.blockCode1;
    data['blockCode2'] = this.blockCode2;
    data['last4Digits'] = this.last4Digits;
    data['productSourcingType'] = this.productSourcingType;
    data['statementMonth'] = this.statementMonth;
    data['somBucket'] = this.somBucket;
    data['somDpd'] = this.somDpd;
    data['field_72'] = this.field72;
    data['field_73'] = this.field73;
    data['field_74'] = this.field74;
    data['field_75'] = this.field75;
    data['field_79'] = this.field79;
    data['field_80'] = this.field80;
    data['module'] = this.module;
    data['batchNo'] = this.batchNo;
    data['caseStage'] = this.caseStage;
    data['allocId'] = this.allocId;
    data['agrId'] = this.agrId;
    data['due'] = this.due;
    data['isActive'] = this.isActive;
    data['collStatus'] = this.collStatus;
    data['collSubStatus'] = this.collSubStatus;
    data['followUpPriority'] = this.followUpPriority;
    data['fieldfollowUpPriority'] = this.fieldfollowUpPriority;
    data['telStatus'] = this.telStatus;
    data['telSubStatus'] = this.telSubStatus;
    data['repoStatus'] = this.repoStatus;
    data['repoSubStatus'] = this.repoSubStatus;
    data['followUpDate'] = this.followUpDate;
    data['fieldfollowUpDate'] = this.fieldfollowUpDate;
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    data['totalReceiptAmount'] = this.totalReceiptAmount;
    data['contractor'] = this.contractor;
    if (this.agent != null) {
      data['agent'] = this.agent!.toJson();
    }
    data['overrideCampaign'] = this.overrideCampaign;
    data['isAllocated'] = this.isAllocated;
    data['isSourced'] = this.isSourced;
    data['caseId'] = this.caseId;
    data['mob'] = this.mob;
    data['digitalIntensity'] = this.digitalIntensity;
    data['emailIntensity'] = this.emailIntensity;
    data['fieldIntensity'] = this.fieldIntensity;
    data['liveDate'] = this.liveDate;
    data['obdIntensity'] = this.obdIntensity;
    data['smsIntensity'] = this.smsIntensity;
    data['telecallingIntensity'] = this.telecallingIntensity;
    data['whatsappIntensity'] = this.whatsappIntensity;
    data['addressLine1'] = this.addressLine1;
    data['addressLine2'] = this.addressLine2;
    data['addressLine3'] = this.addressLine3;
    data['addressLine4'] = this.addressLine4;
    data['bureauScore'] = this.bureauScore;
    data['lateFees'] = this.lateFees;
    data['mobile1'] = this.mobile1;
    data['mobile3'] = this.mobile3;
    data['riskRanking'] = this.riskRanking;
    data['tradeDetails'] = this.tradeDetails;
    data['starredCase'] = this.starredCase;
    data['lastEvent'] = this.lastEvent;
    data['caseFlagUpdatedBy'] = this.caseFlagUpdatedBy;
    data['contactStatusFlag'] = this.contactStatusFlag;
    data['engagementStatusFlag'] = this.engagementStatusFlag;
    data['promiseStatusFlag'] = this.promiseStatusFlag;
    data['resolutionStatusFlag'] = this.resolutionStatusFlag;
    data['rtpDenialStatusFlag'] = this.rtpDenialStatusFlag;
    if (this.caseStatus != null) {
      data['caseStatus'] = this.caseStatus!.toJson();
    }
    data['botfieldfollowUpDate'] = this.botfieldfollowUpDate;
    data['lastPaymentDate'] = this.lastPaymentDate;
    data['accountStatus'] = this.accountStatus;
    data['dueDate'] = this.dueDate;
    data['statementDate'] = this.statementDate;
    data['dnd'] = this.dnd;
    data['internalAllocation'] = this.internalAllocation;
    data['daysFromLastCycle'] = this.daysFromLastCycle;
    return data;
  }
}

class Audit {
  String? crBy;
  String? crAt;
  String? sourcingFlag;
  String? upBy;
  String? upAt;
  String? allocatedAt;
  String? allocatedBy;
  Null? sourcedAt;
  Null? sourcedBy;
  String? archivedAt;

  Audit(
      {this.crBy,
      this.crAt,
      this.sourcingFlag,
      this.upBy,
      this.upAt,
      this.allocatedAt,
      this.allocatedBy,
      this.sourcedAt,
      this.sourcedBy,
      this.archivedAt});

  Audit.fromJson(Map<String, dynamic> json) {
    crBy = json['crBy'];
    crAt = json['crAt'];
    sourcingFlag = json['sourcingFlag'];
    upBy = json['upBy'];
    upAt = json['upAt'];
    allocatedAt = json['allocatedAt'];
    allocatedBy = json['allocatedBy'];
    sourcedAt = json['sourcedAt'];
    sourcedBy = json['sourcedBy'];
    archivedAt = json['archivedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['crBy'] = this.crBy;
    data['crAt'] = this.crAt;
    data['sourcingFlag'] = this.sourcingFlag;
    data['upBy'] = this.upBy;
    data['upAt'] = this.upAt;
    data['allocatedAt'] = this.allocatedAt;
    data['allocatedBy'] = this.allocatedBy;
    data['sourcedAt'] = this.sourcedAt;
    data['sourcedBy'] = this.sourcedBy;
    data['archivedAt'] = this.archivedAt;
    return data;
  }
}

class Contact {
  String? cType;
  String? value;
  String? contactId0;
  String? health;
  String? emailId1;
  String? address1Id2;

  Contact(
      {this.cType,
      this.value,
      this.contactId0,
      this.health,
      this.emailId1,
      this.address1Id2});

  Contact.fromJson(Map<String, dynamic> json) {
    cType = json['cType'];
    value = json['value'];
    contactId0 = json['contactId_0'];
    health = json['health'];
    emailId1 = json['emailId_1'];
    address1Id2 = json['address1Id_2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cType'] = this.cType;
    data['value'] = this.value;
    data['contactId_0'] = this.contactId0;
    data['health'] = this.health;
    data['emailId_1'] = this.emailId1;
    data['address1Id_2'] = this.address1Id2;
    return data;
  }
}

class RepaymentInfo {
  String? benefeciaryAccNo;
  String? refUrl;
  String? refLender;
  String? benefeciaryAccName;
  String? repayBankName;
  String? repaymentIfscCode;

  RepaymentInfo(
      {this.benefeciaryAccNo,
      this.refUrl,
      this.refLender,
      this.benefeciaryAccName,
      this.repayBankName,
      this.repaymentIfscCode});

  RepaymentInfo.fromJson(Map<String, dynamic> json) {
    benefeciaryAccNo = json['benefeciaryAcc_No'];
    refUrl = json['ref_url'];
    refLender = json['refLender'];
    benefeciaryAccName = json['benefeciaryAcc_Name'];
    repayBankName = json['repayBankName'];
    repaymentIfscCode = json['repaymentIfscCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['benefeciaryAcc_No'] = this.benefeciaryAccNo;
    data['ref_url'] = this.refUrl;
    data['refLender'] = this.refLender;
    data['benefeciaryAcc_Name'] = this.benefeciaryAccName;
    data['repayBankName'] = this.repayBankName;
    data['repaymentIfscCode'] = this.repaymentIfscCode;
    return data;
  }
}

class Customer {
  String? customerId;
  String? accNo;
  String? name;

  Customer({this.customerId, this.accNo, this.name});

  Customer.fromJson(Map<String, dynamic> json) {
    customerId = json['customerId'];
    accNo = json['accNo'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customerId'] = this.customerId;
    data['accNo'] = this.accNo;
    data['name'] = this.name;
    return data;
  }
}

class Agent {
  String? agentRef;
  String? name;
  String? type;

  Agent({this.agentRef, this.name, this.type});

  Agent.fromJson(Map<String, dynamic> json) {
    agentRef = json['agentRef'];
    name = json['name'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['agentRef'] = this.agentRef;
    data['name'] = this.name;
    data['type'] = this.type;
    return data;
  }
}

class CaseStatus {
  int? count;
  String? value;

  CaseStatus({this.count, this.value});

  CaseStatus.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['value'] = this.value;
    return data;
  }
}
