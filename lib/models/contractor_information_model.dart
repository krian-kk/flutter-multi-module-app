class ContractorAllInformationModel {
  int? status;
  String? message;
  ContractorResult? result;

  ContractorAllInformationModel({this.status, this.message, this.result});

  ContractorAllInformationModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    result = json['result'] != null
        ? ContractorResult.fromJson(json['result'])
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

class ContractorResult {
  String? sId;
  String? usernamePrefix;
  String? contractor;
  String? contractorName;
  String? contactorAttr;
  bool? geoLocCompulsaryApp;
  double? nodeVersion;
  int? oldVersionCompatibility;
  int? perDayReceiptLimit;
  bool? autoApprovalReceipt;
  String? receiptAckSmsTemplate;
  bool? sendSms;
  bool? autoApprovalReceiptTelecalling;
  bool? attachBankToAgrRef;
  bool? bankExistCheck;
  String? reportEndDate;
  String? reportStartDate;
  bool? cloudTelephony;
  bool? contactMasking;
  bool? hideSendRepaymentInfo;
  String? repaymentSmsTemplate;
  String? callTriedSmsTemplate;
  bool? hideCallTriedSmsButton;
  bool? ptpSms;
  String? ptpSmsTemplate;
  bool? disabledTcRecommendFieldCollect;
  String? reportTime;
  String? roleLevel;
  bool? tokenVerified;
  String? version;
  MyCasesQueue? myCasesQueue;
  Reports? reports;
  bool? disabledTcSurrender;
  bool? agentLocationMandatory;
  bool? attributeExistCheck;
  bool? caseStatusDownload;
  List<UserAdminList>? userAdminList;
  List<FeedbackTemplate>? feedbackTemplate;
  bool? otsEnable;

  ContractorResult(
      {this.sId,
      this.usernamePrefix,
      this.contractor,
      this.contractorName,
      this.contactorAttr,
      this.geoLocCompulsaryApp,
      this.nodeVersion,
      this.oldVersionCompatibility,
      this.perDayReceiptLimit,
      this.autoApprovalReceipt,
      this.receiptAckSmsTemplate,
      this.sendSms,
      this.autoApprovalReceiptTelecalling,
      this.attachBankToAgrRef,
      this.bankExistCheck,
      this.reportEndDate,
      this.reportStartDate,
      this.cloudTelephony,
      this.contactMasking,
      this.hideSendRepaymentInfo,
      this.repaymentSmsTemplate,
      this.callTriedSmsTemplate,
      this.hideCallTriedSmsButton,
      this.ptpSms,
      this.ptpSmsTemplate,
      this.disabledTcRecommendFieldCollect,
      this.reportTime,
      this.roleLevel,
      this.tokenVerified,
      this.version,
      this.myCasesQueue,
      this.reports,
      this.disabledTcSurrender,
      this.agentLocationMandatory,
      this.attributeExistCheck,
      this.caseStatusDownload,
      this.userAdminList,
      this.feedbackTemplate,
      this.otsEnable});

  ContractorResult.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    usernamePrefix = json['usernamePrefix'];
    contractor = json['contractor'];
    contractorName = json['contractorName'];
    contactorAttr = json['contactorAttr'];
    geoLocCompulsaryApp = json['geoLocCompulsaryApp'];
    nodeVersion = json['nodeVersion'];
    oldVersionCompatibility = json['oldVersionCompatibility'];
    perDayReceiptLimit = json['perDayReceiptLimit'];
    autoApprovalReceipt = json['autoApprovalReceipt'];
    receiptAckSmsTemplate = json['receiptAckSmsTemplate'];
    sendSms = json['sendSms'];
    autoApprovalReceiptTelecalling = json['autoApprovalReceiptTelecalling'];
    attachBankToAgrRef = json['attachBankToAgrRef'];
    bankExistCheck = json['bankExistCheck'];
    reportEndDate = json['reportEndDate'];
    reportStartDate = json['reportStartDate'];
    cloudTelephony = json['cloudTelephony'];
    contactMasking = json['contactMasking'];
    hideSendRepaymentInfo = json['hideSendRepaymentInfo'];
    repaymentSmsTemplate = json['repaymentSmsTemplate'];
    callTriedSmsTemplate = json['callTriedSmsTemplate'];
    hideCallTriedSmsButton = json['hideCallTriedSmsButton'];
    ptpSms = json['ptpSms'];
    ptpSmsTemplate = json['ptpSmsTemplate'];
    disabledTcRecommendFieldCollect = json['disabledTcRecommendFieldCollect'];
    reportTime = json['reportTime'];
    roleLevel = json['roleLevel'];
    tokenVerified = json['tokenVerified'];
    version = json['version'];
    myCasesQueue = json['myCasesQueue'] != null
        ? MyCasesQueue.fromJson(json['myCasesQueue'])
        : null;
    reports =
        json['reports'] != null ? Reports.fromJson(json['reports']) : null;
    disabledTcSurrender = json['disabledTcSurrender'];
    agentLocationMandatory = json['agentLocationMandatory'];
    attributeExistCheck = json['attributeExistCheck'];
    caseStatusDownload = json['caseStatusDownload'];
    if (json['userAdminList'] != null) {
      userAdminList = <UserAdminList>[];
      json['userAdminList'].forEach((v) {
        userAdminList!.add(UserAdminList.fromJson(v));
      });
    }
    if (json['feedbackTemplate'] != null) {
      feedbackTemplate = <FeedbackTemplate>[];
      json['feedbackTemplate'].forEach((v) {
        feedbackTemplate!.add(FeedbackTemplate.fromJson(v));
      });
    }
    otsEnable = json['otsEnable'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['usernamePrefix'] = usernamePrefix;
    data['contractor'] = contractor;
    data['contractorName'] = contractorName;
    data['contactorAttr'] = contactorAttr;
    data['geoLocCompulsaryApp'] = geoLocCompulsaryApp;
    data['nodeVersion'] = nodeVersion;
    data['oldVersionCompatibility'] = oldVersionCompatibility;
    data['perDayReceiptLimit'] = perDayReceiptLimit;
    data['autoApprovalReceipt'] = autoApprovalReceipt;
    data['receiptAckSmsTemplate'] = receiptAckSmsTemplate;
    data['sendSms'] = sendSms;
    data['autoApprovalReceiptTelecalling'] = autoApprovalReceiptTelecalling;
    data['attachBankToAgrRef'] = attachBankToAgrRef;
    data['bankExistCheck'] = bankExistCheck;
    data['reportEndDate'] = reportEndDate;
    data['reportStartDate'] = reportStartDate;
    data['cloudTelephony'] = cloudTelephony;
    data['contactMasking'] = contactMasking;
    data['hideSendRepaymentInfo'] = hideSendRepaymentInfo;
    data['repaymentSmsTemplate'] = repaymentSmsTemplate;
    data['callTriedSmsTemplate'] = callTriedSmsTemplate;
    data['hideCallTriedSmsButton'] = hideCallTriedSmsButton;
    data['ptpSms'] = ptpSms;
    data['ptpSmsTemplate'] = ptpSmsTemplate;
    data['disabledTcRecommendFieldCollect'] = disabledTcRecommendFieldCollect;
    data['reportTime'] = reportTime;
    data['roleLevel'] = roleLevel;
    data['tokenVerified'] = tokenVerified;
    data['version'] = version;
    if (myCasesQueue != null) {
      data['myCasesQueue'] = myCasesQueue!.toJson();
    }
    if (reports != null) {
      data['reports'] = reports!.toJson();
    }
    data['disabledTcSurrender'] = disabledTcSurrender;
    data['agentLocationMandatory'] = agentLocationMandatory;
    data['attributeExistCheck'] = attributeExistCheck;
    data['caseStatusDownload'] = caseStatusDownload;
    if (userAdminList != null) {
      data['userAdminList'] = userAdminList!.map((v) => v.toJson()).toList();
    }
    if (feedbackTemplate != null) {
      data['feedbackTemplate'] =
          feedbackTemplate!.map((v) => v.toJson()).toList();
    }
    data['otsEnable'] = otsEnable;
    return data;
  }
}

class MyCasesQueue {
  SortOrderMyCasesUsingTelSubStatus? sortOrderMyCasesUsingTelSubStatus;
  List<Last3DayEventOrder>? last3DayEventOrder;
  int? myCasesQueueLength;
  String? sortingOn;
  String? orderByCol;

  MyCasesQueue(
      {this.sortOrderMyCasesUsingTelSubStatus,
      this.last3DayEventOrder,
      this.myCasesQueueLength,
      this.sortingOn,
      this.orderByCol});

  MyCasesQueue.fromJson(Map<String, dynamic> json) {
    sortOrderMyCasesUsingTelSubStatus =
        json['sortOrderMyCasesUsingTelSubStatus'] != null
            ? SortOrderMyCasesUsingTelSubStatus.fromJson(
                json['sortOrderMyCasesUsingTelSubStatus'])
            : null;
    if (json['last3DayEventOrder'] != null) {
      last3DayEventOrder = <Last3DayEventOrder>[];
      json['last3DayEventOrder'].forEach((v) {
        last3DayEventOrder!.add(Last3DayEventOrder.fromJson(v));
      });
    }
    myCasesQueueLength = json['myCasesQueueLength'];
    sortingOn = json['sortingOn'];
    orderByCol = json['orderByCol'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (sortOrderMyCasesUsingTelSubStatus != null) {
      data['sortOrderMyCasesUsingTelSubStatus'] =
          sortOrderMyCasesUsingTelSubStatus!.toJson();
    }
    if (last3DayEventOrder != null) {
      data['last3DayEventOrder'] =
          last3DayEventOrder!.map((v) => v.toJson()).toList();
    }
    data['myCasesQueueLength'] = myCasesQueueLength;
    data['sortingOn'] = sortingOn;
    data['orderByCol'] = orderByCol;
    return data;
  }
}

class SortOrderMyCasesUsingTelSubStatus {
  int? new_;
  int? ptp;
  int? reminder;
  int? feedback;
  int? denial;
  int? dispute;
  int? receipt;
  int? surrender;
  int? rnr;
  int? linebusy;
  int? switchoff;
  int? outofnetwork;
  int? disconnecting;
  int? doesnotexist;
  int? incorrectnumber;
  int? numbernotworking;
  int? notoperational;

  SortOrderMyCasesUsingTelSubStatus(
      {this.new_,
      this.ptp,
      this.reminder,
      this.feedback,
      this.denial,
      this.dispute,
      this.receipt,
      this.surrender,
      this.rnr,
      this.linebusy,
      this.switchoff,
      this.outofnetwork,
      this.disconnecting,
      this.doesnotexist,
      this.incorrectnumber,
      this.numbernotworking,
      this.notoperational});

  SortOrderMyCasesUsingTelSubStatus.fromJson(Map<String, dynamic> json) {
    new_ = json['new'];
    ptp = json['ptp'];
    reminder = json['reminder'];
    feedback = json['feedback'];
    denial = json['denial'];
    dispute = json['dispute'];
    receipt = json['receipt'];
    surrender = json['Surrender'];
    rnr = json['rnr'];
    linebusy = json['linebusy'];
    switchoff = json['switchoff'];
    outofnetwork = json['outofnetwork'];
    disconnecting = json['disconnecting'];
    doesnotexist = json['doesnotexist'];
    incorrectnumber = json['incorrectnumber'];
    numbernotworking = json['numbernotworking'];
    notoperational = json['notoperational'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['new'] = new_;
    data['ptp'] = ptp;
    data['reminder'] = reminder;
    data['feedback'] = feedback;
    data['denial'] = denial;
    data['dispute'] = dispute;
    data['receipt'] = receipt;
    data['Surrender'] = surrender;
    data['rnr'] = rnr;
    data['linebusy'] = linebusy;
    data['switchoff'] = switchoff;
    data['outofnetwork'] = outofnetwork;
    data['disconnecting'] = disconnecting;
    data['doesnotexist'] = doesnotexist;
    data['incorrectnumber'] = incorrectnumber;
    data['numbernotworking'] = numbernotworking;
    data['notoperational'] = notoperational;
    return data;
  }
}

class Last3DayEventOrder {
  String? telSubStatus;
  int? days;

  Last3DayEventOrder({this.telSubStatus, this.days});

  Last3DayEventOrder.fromJson(Map<String, dynamic> json) {
    telSubStatus = json['telSubStatus'];
    days = json['days'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['telSubStatus'] = telSubStatus;
    data['days'] = days;
    return data;
  }
}

class Reports {
  Feedback? feedback;
  Feedback? resolution;
  Feedback? callLogReport;
  Feedback? agentPerformance;
  Feedback? caseStatus;
  Feedback? agentGeoAnalysis;

  Reports(
      {this.feedback,
      this.resolution,
      this.callLogReport,
      this.agentPerformance,
      this.caseStatus,
      this.agentGeoAnalysis});

  Reports.fromJson(Map<String, dynamic> json) {
    feedback =
        json['feedback'] != null ? Feedback.fromJson(json['feedback']) : null;
    resolution = json['resolution'] != null
        ? Feedback.fromJson(json['resolution'])
        : null;
    callLogReport = json['callLogReport'] != null
        ? Feedback.fromJson(json['callLogReport'])
        : null;
    agentPerformance = json['agentPerformance'] != null
        ? Feedback.fromJson(json['agentPerformance'])
        : null;
    caseStatus = json['caseStatus'] != null
        ? Feedback.fromJson(json['caseStatus'])
        : null;
    agentGeoAnalysis = json['agentGeoAnalysis'] != null
        ? Feedback.fromJson(json['agentGeoAnalysis'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (feedback != null) {
      data['feedback'] = feedback!.toJson();
    }
    if (resolution != null) {
      data['resolution'] = resolution!.toJson();
    }
    if (callLogReport != null) {
      data['callLogReport'] = callLogReport!.toJson();
    }
    if (agentPerformance != null) {
      data['agentPerformance'] = agentPerformance!.toJson();
    }
    if (caseStatus != null) {
      data['caseStatus'] = caseStatus!.toJson();
    }
    if (agentGeoAnalysis != null) {
      data['agentGeoAnalysis'] = agentGeoAnalysis!.toJson();
    }
    return data;
  }
}

class Feedback {
  String? s3Bucket;
  String? s3FolderName;
  String? s3FilePath;
  List<Fields>? fields;

  Feedback({this.s3Bucket, this.s3FolderName, this.s3FilePath, this.fields});

  Feedback.fromJson(Map<String, dynamic> json) {
    s3Bucket = json['s3Bucket'];
    s3FolderName = json['s3FolderName'];
    s3FilePath = json['s3FilePath'];
    if (json['fields'] != null) {
      fields = <Fields>[];
      json['fields'].forEach((v) {
        fields!.add(Fields.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['s3Bucket'] = s3Bucket;
    data['s3FolderName'] = s3FolderName;
    data['s3FilePath'] = s3FilePath;
    if (fields != null) {
      data['fields'] = fields!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Fields {
  String? label;
  String? value;

  Fields({this.label, this.value});

  Fields.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['label'] = label;
    data['value'] = value;
    return data;
  }
}

class UserAdminList {
  String? aRef;
  String? name;
  bool? userAdmin;
  String? type;

  UserAdminList({this.aRef, this.name, this.userAdmin, this.type});

  UserAdminList.fromJson(Map<String, dynamic> json) {
    aRef = json['aRef'];
    name = json['name'];
    userAdmin = json['userAdmin'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['aRef'] = aRef;
    data['name'] = name;
    data['userAdmin'] = userAdmin;
    data['type'] = type;
    return data;
  }
}

class FeedbackTemplate {
  String? name;
  String? type;
  bool? hide;
  bool? expanded;
  String? label;
  bool? reportColumnMerged;
  List<Data>? data;

  FeedbackTemplate(
      {this.name,
      this.type,
      this.hide,
      this.expanded,
      this.label,
      this.reportColumnMerged,
      this.data});

  FeedbackTemplate.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    type = json['type'];
    hide = json['hide'];
    expanded = json['expanded'];
    label = json['label'];
    reportColumnMerged = json['reportColumnMerged'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['type'] = type;
    data['hide'] = hide;
    data['expanded'] = expanded;
    data['label'] = label;
    data['reportColumnMerged'] = reportColumnMerged;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? name;
  String? type;
  bool? hide;
  bool? value;
  String? label;
  bool? required;
  bool? disabled;
  List<Options>? options;

  Data(
      {this.name,
      this.type,
      this.hide,
      this.value,
      this.label,
      this.required,
      this.disabled,
      this.options});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    type = json['type'];
    hide = json['hide'];
    value = json['value'];
    label = json['label'];
    required = json['required'];
    disabled = json['disabled'];
    if (json['options'] != null) {
      options = <Options>[];
      json['options'].forEach((v) {
        options!.add(Options.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['type'] = type;
    data['hide'] = hide;
    data['value'] = value;
    data['label'] = label;
    data['required'] = required;
    data['disabled'] = disabled;
    if (options != null) {
      data['options'] = options!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Options {
  String? value;
  String? viewValue;

  Options({this.value, this.viewValue});

  Options.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    viewValue = json['viewValue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value'] = value;
    data['viewValue'] = viewValue;
    return data;
  }
}
