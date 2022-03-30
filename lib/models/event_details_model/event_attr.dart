class EventAttr {
  String? date;
  String? time;
  String? remarks;
  int? ptpAmount;
  String? mode;
  String? ptpType;
  String? followUpPriority;
  String? amntOts;
  String? customerName;
  String? amountCollected;
  String? chequeRefNo;
  String? remarkOts;
  String? modelMake;
  String? registrationNo;
  String? chassisNo;

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
    this.chequeRefNo,
    this.remarkOts,
    this.modelMake,
    this.registrationNo,
    this.chassisNo,
  });

  factory EventAttr.fromJson(Map<String, dynamic> json) => EventAttr(
        date: json['date'] as String?,
        time: json['time'] as String?,
        remarks: json['remarks'] as String?,
        ptpAmount: json['ptpAmount'] as int?,
        mode: json['mode'] as String?,
        ptpType: json['PTPType'] as String?,
        followUpPriority: json['followUpPriority'] as String?,
        amntOts: json['amntOts'] as String?,
        customerName: json['customerName'] as String?,
        amountCollected: json['amountCollected'] as String?,
        chequeRefNo: json['chequeRefNo'] as String?,
        remarkOts: json['remarkOts'] as String?,
        modelMake: json['modelMake'] as String?,
        registrationNo: json['registrationNo'] as String?,
        chassisNo: json['chassisNo'] as String?,
      );

  Map<String, dynamic> toJson() => {
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
        'chequeRefNo': chequeRefNo,
        'remarkOts': remarkOts,
        'modelMake': modelMake,
        'registrationNo': registrationNo,
        'chassisNo': chassisNo,
      };
}
