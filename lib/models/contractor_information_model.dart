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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.result != null) {
      data['result'] = this.result!.toJson();
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
        userAdminList!.add(new UserAdminList.fromJson(v));
      });
    }
    if (json['feedbackTemplate'] != null) {
      feedbackTemplate = <FeedbackTemplate>[];
      json['feedbackTemplate'].forEach((v) {
        feedbackTemplate!.add(new FeedbackTemplate.fromJson(v));
      });
    }
    otsEnable = json['otsEnable'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['usernamePrefix'] = this.usernamePrefix;
    data['contractor'] = this.contractor;
    data['contractorName'] = this.contractorName;
    data['contactorAttr'] = this.contactorAttr;
    data['geoLocCompulsaryApp'] = this.geoLocCompulsaryApp;
    data['nodeVersion'] = this.nodeVersion;
    data['oldVersionCompatibility'] = this.oldVersionCompatibility;
    data['perDayReceiptLimit'] = this.perDayReceiptLimit;
    data['autoApprovalReceipt'] = this.autoApprovalReceipt;
    data['receiptAckSmsTemplate'] = this.receiptAckSmsTemplate;
    data['sendSms'] = this.sendSms;
    data['autoApprovalReceiptTelecalling'] =
        this.autoApprovalReceiptTelecalling;
    data['attachBankToAgrRef'] = this.attachBankToAgrRef;
    data['bankExistCheck'] = this.bankExistCheck;
    data['reportEndDate'] = this.reportEndDate;
    data['reportStartDate'] = this.reportStartDate;
    data['cloudTelephony'] = this.cloudTelephony;
    data['contactMasking'] = this.contactMasking;
    data['hideSendRepaymentInfo'] = this.hideSendRepaymentInfo;
    data['repaymentSmsTemplate'] = this.repaymentSmsTemplate;
    data['callTriedSmsTemplate'] = this.callTriedSmsTemplate;
    data['hideCallTriedSmsButton'] = this.hideCallTriedSmsButton;
    data['ptpSms'] = this.ptpSms;
    data['ptpSmsTemplate'] = this.ptpSmsTemplate;
    data['disabledTcRecommendFieldCollect'] =
        this.disabledTcRecommendFieldCollect;
    data['reportTime'] = this.reportTime;
    data['roleLevel'] = this.roleLevel;
    data['tokenVerified'] = this.tokenVerified;
    data['version'] = this.version;
    if (this.myCasesQueue != null) {
      data['myCasesQueue'] = this.myCasesQueue!.toJson();
    }
    if (this.reports != null) {
      data['reports'] = this.reports!.toJson();
    }
    data['disabledTcSurrender'] = this.disabledTcSurrender;
    data['agentLocationMandatory'] = this.agentLocationMandatory;
    data['attributeExistCheck'] = this.attributeExistCheck;
    data['caseStatusDownload'] = this.caseStatusDownload;
    if (this.userAdminList != null) {
      data['userAdminList'] =
          this.userAdminList!.map((v) => v.toJson()).toList();
    }
    if (this.feedbackTemplate != null) {
      data['feedbackTemplate'] =
          this.feedbackTemplate!.map((v) => v.toJson()).toList();
    }
    data['otsEnable'] = this.otsEnable;
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
            ? new SortOrderMyCasesUsingTelSubStatus.fromJson(
                json['sortOrderMyCasesUsingTelSubStatus'])
            : null;
    if (json['last3DayEventOrder'] != null) {
      last3DayEventOrder = <Last3DayEventOrder>[];
      json['last3DayEventOrder'].forEach((v) {
        last3DayEventOrder!.add(new Last3DayEventOrder.fromJson(v));
      });
    }
    myCasesQueueLength = json['myCasesQueueLength'];
    sortingOn = json['sortingOn'];
    orderByCol = json['orderByCol'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sortOrderMyCasesUsingTelSubStatus != null) {
      data['sortOrderMyCasesUsingTelSubStatus'] =
          this.sortOrderMyCasesUsingTelSubStatus!.toJson();
    }
    if (this.last3DayEventOrder != null) {
      data['last3DayEventOrder'] =
          this.last3DayEventOrder!.map((v) => v.toJson()).toList();
    }
    data['myCasesQueueLength'] = this.myCasesQueueLength;
    data['sortingOn'] = this.sortingOn;
    data['orderByCol'] = this.orderByCol;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['new'] = this.new_;
    data['ptp'] = this.ptp;
    data['reminder'] = this.reminder;
    data['feedback'] = this.feedback;
    data['denial'] = this.denial;
    data['dispute'] = this.dispute;
    data['receipt'] = this.receipt;
    data['Surrender'] = this.surrender;
    data['rnr'] = this.rnr;
    data['linebusy'] = this.linebusy;
    data['switchoff'] = this.switchoff;
    data['outofnetwork'] = this.outofnetwork;
    data['disconnecting'] = this.disconnecting;
    data['doesnotexist'] = this.doesnotexist;
    data['incorrectnumber'] = this.incorrectnumber;
    data['numbernotworking'] = this.numbernotworking;
    data['notoperational'] = this.notoperational;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['telSubStatus'] = this.telSubStatus;
    data['days'] = this.days;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.feedback != null) {
      data['feedback'] = this.feedback!.toJson();
    }
    if (this.resolution != null) {
      data['resolution'] = this.resolution!.toJson();
    }
    if (this.callLogReport != null) {
      data['callLogReport'] = this.callLogReport!.toJson();
    }
    if (this.agentPerformance != null) {
      data['agentPerformance'] = this.agentPerformance!.toJson();
    }
    if (this.caseStatus != null) {
      data['caseStatus'] = this.caseStatus!.toJson();
    }
    if (this.agentGeoAnalysis != null) {
      data['agentGeoAnalysis'] = this.agentGeoAnalysis!.toJson();
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
        fields!.add(new Fields.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['s3Bucket'] = this.s3Bucket;
    data['s3FolderName'] = this.s3FolderName;
    data['s3FilePath'] = this.s3FilePath;
    if (this.fields != null) {
      data['fields'] = this.fields!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['label'] = this.label;
    data['value'] = this.value;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['aRef'] = this.aRef;
    data['name'] = this.name;
    data['userAdmin'] = this.userAdmin;
    data['type'] = this.type;
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
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['type'] = this.type;
    data['hide'] = this.hide;
    data['expanded'] = this.expanded;
    data['label'] = this.label;
    data['reportColumnMerged'] = this.reportColumnMerged;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['type'] = this.type;
    data['hide'] = this.hide;
    data['value'] = this.value;
    data['label'] = this.label;
    data['required'] = this.required;
    data['disabled'] = this.disabled;
    if (this.options != null) {
      data['options'] = this.options!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    data['viewValue'] = this.viewValue;
    return data;
  }
}
