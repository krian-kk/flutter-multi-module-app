class EventDetailsResultsModel {
  EventDetailsResultsModel({
    this.id,
    this.caseId,
    this.eventType,
    this.eventAttr,
    this.createdAt,
    this.createdBy,
    this.eventModule,
    this.agrRef,
    this.contractor,
    this.eventCode,
    this.monthName,
  });

  factory EventDetailsResultsModel.fromJson(Map<String, dynamic> json) =>
      EventDetailsResultsModel(
          id: json['_id'] as String?,
          caseId: json['caseId'] as String?,
          eventType: json['eventType'] as String?,
          eventAttr: json['eventAttr'] == null
              ? null
              : EventAttr.fromJson(json['eventAttr'] as Map<String, dynamic>),
          createdAt: json['createdAt'] as String?,
          createdBy: json['createdBy'] as String?,
          eventModule: json['eventModule'],
          agrRef: json['agrRef'],
          contractor: json['contractor'],
          eventCode: json['eventCode'],
          //todo month parser
          monthName: json['createdAt']);
  String? id;
  String? caseId;
  String? eventType;
  EventAttr? eventAttr;
  String? createdAt;
  String? createdBy;
  String? eventModule;
  String? agrRef;
  String? contractor;
  String? eventCode;
  String? monthName;

  Map<String, dynamic> toJson() => <String, dynamic>{
    '_id': id,
    'caseId': caseId,
    'eventType': eventType,
    'eventAttr': eventAttr?.toJson(),
    'createdAt': createdAt,
    'createdBy': createdBy,
    'eventModule': eventModule,
    'agrRef': agrRef,
    'contractor': contractor,
    'eventCode': eventCode,
  };
}

class EventAttr {
  EventAttr(
      {this.date,
        this.time,
        this.remarks,
        this.ptpAmount,
        this.mode,
        this.ptpType,
        this.followUpPriority,
        this.amntOts,
        this.customerName,
        this.amountCollected,
        this.reminderDate,
        this.chequeRefNo,
        this.nextActionDate,
        this.actionDate,
        this.remarkOts,
        this.modelMake,
        this.registrationNo,
        this.chassisNo,
        this.appStatus,
        this.reginalText,
        this.translatedText,
        this.audioS3Path,
        this.disputereasons,
        this.reasons,
        this.imageLocation,
        this.vehicleRegNo,
        this.vehicleIdentificationNo,
        this.ref1,
        this.ref2,
        this.ref1No,
        this.ref2No,
        this.dealerName,
        this.dealerAddress,
        this.batteryID});

  factory EventAttr.fromJson(Map<String, dynamic> json) => EventAttr(
    date: json['date'] as String?,
    time: json['time'] as dynamic,
    remarks: json['remarks'] as String?,
    ptpAmount: json['ptpAmount'],
    mode: json['mode'] as String?,
    ptpType: json['PTPType'] as String?,
    followUpPriority: json['followUpPriority'],
    amntOts: json['amntOts'],
    customerName: json['customerName'],
    amountCollected: json['amountCollected'],
    reminderDate: json['reminderDate'],
    chequeRefNo: json['chequeRefNo'],
    nextActionDate: json['nextActionDate'],
    actionDate: json['actionDate'],
    remarkOts: json['remarkOts'] as String?,
    modelMake: json['modelMake'] as String?,
    registrationNo: json['registrationNo'] as String?,
    chassisNo: json['chassisNo'] as String?,
    appStatus: json['appStatus'],
    reginalText: json['reginal_text'] as String?,
    translatedText: json['translated_text'] as String?,
    audioS3Path: json['audioS3Path'] as String?,
    disputereasons: json['disputereasons'] as String?,
    reasons: json['reasons'] as String?,
    imageLocation: json['imageLocation'] != null
        ? json['imageLocation'].cast<String>()
        : [],
    vehicleRegNo: json['vehicleRegNo'],
    vehicleIdentificationNo: json['vehicleIdentificationNo'],
    ref1: json['ref1'],
    ref2: json['ref2'],
    ref1No: json['ref1No'],
    ref2No: json['ref2No'],
    dealerName: json['dealerName'],
    dealerAddress: json['dealerAddress'],
    batteryID: json['batteryID'],
  );
  String? date;
  dynamic time;
  String? remarks;
  dynamic ptpAmount;
  String? mode;
  String? ptpType;
  String? followUpPriority;
  String? amntOts;
  dynamic customerName;
  dynamic amountCollected;
  String? reminderDate;
  String? chequeRefNo;
  String? nextActionDate;
  String? actionDate;
  String? remarkOts;
  String? modelMake;
  String? registrationNo;
  String? chassisNo;
  String? appStatus;
  List<String>? imageLocation;
  String? reginalText;
  String? translatedText;
  String? audioS3Path;
  String? disputereasons;
  String? reasons;

  String? vehicleRegNo;
  String? vehicleIdentificationNo;
  String? ref1;
  String? ref2;
  String? ref1No;
  String? ref2No;
  String? dealerName;
  String? dealerAddress;
  String? batteryID;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'date': date,
    'time': time,
    'remarks': remarks,
    'ptpAmount': ptpAmount,
    'mode': mode,
    'PTPType': ptpType,
    'followUpPriority': followUpPriority,
    'amntOts': amntOts,
    'customerName': customerName,
    'amountCollected': amountCollected,
    'reminderDate': reminderDate,
    'chequeRefNo': chequeRefNo,
    'nextActionDate': nextActionDate,
    'actionDate': actionDate,
    'remarkOts': remarkOts,
    'modelMake': modelMake,
    'registrationNo': registrationNo,
    'chassisNo': chassisNo,
    'appStatus': appStatus,
    'reginal_text': reginalText,
    'translated_text': translatedText,
    'audioS3Path': audioS3Path,
    'disputereasons': disputereasons,
    'reasons': reasons,
    'imageLocation': imageLocation,
    'vehicleRegNo': vehicleRegNo,
    'vehicleIdentificationNo': vehicleIdentificationNo,
    'ref1': ref1,
    'ref2': ref2,
    'ref1No': ref1No,
    'ref2No': ref2No,
    'dealerName': dealerName,
    'dealerAddress': dealerAddress,
    'batteryID': batteryID,
  };
}
