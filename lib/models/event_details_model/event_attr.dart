class EventAttr {
  EventAttr({
    this.date,
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
  });

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
  String? reginalText;
  String? translatedText;
  String? audioS3Path;

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
      };
}
