class EventDetailsResultModel {
  String? id;
  String? caseId;
  String? eventType;
  String remarks;
  String? date;
  String? mode;
  String? reference;
  String modelMake;
  String registrationNo;
  String chassisNo;
  String customerName;
  String otsAmt;

  EventDetailsResultModel({
    this.id,
    this.caseId,
    this.eventType,
    this.remarks = '-',
    this.date,
    this.mode,
    this.reference,
    this.modelMake = '-',
    this.registrationNo = '-',
    this.chassisNo = '-',
    this.customerName = '-',
    this.otsAmt = '-',
  });

  factory EventDetailsResultModel.fromJson(Map<String, dynamic> json) =>
      EventDetailsResultModel(
        id: json['_id'] as String?,
        caseId: json['caseId'] as String?,
        eventType: json['eventType'] as String?,
        remarks: json['eventAttr']['remarks'] ??
            json['eventAttr']['remarkOts'] ??
            '-',
        date: json['eventAttr']['date'] as String?,
        mode: json['eventAttr']['mode'] as String?,
        reference: json['eventAttr']['reference'] as String?,
        modelMake: json['eventAttr']['modelMake'] ?? '-',
        registrationNo: json['eventAttr']['registrationNo'] ?? '-',
        chassisNo: json['eventAttr']['chassisNo'] ?? '-',
        customerName: json['eventAttr']['customerName'] ?? '-',
        otsAmt: json['eventAttr']['amntOts'] ?? '-',
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'caseId': caseId,
        'eventType': eventType,
        'remarks': remarks,
        'date': date,
        'mode': mode,
        'reference': reference,
        'modelMake': modelMake,
        'registrationNo': registrationNo,
        'chassisNo': chassisNo,
        'customerName': customerName,
        'otsAmt': otsAmt,
      };
}
