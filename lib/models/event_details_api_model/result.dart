class EventDetailsResultModel {
  String? id;
  String? caseId;
  String? eventType;
  String? remarks;
  String? date;
  String? mode;
  String? reference;

  EventDetailsResultModel({
    this.id,
    this.caseId,
    this.eventType,
    this.remarks,
    this.date,
    this.mode,
    this.reference,
  });

  factory EventDetailsResultModel.fromJson(Map<String, dynamic> json) =>
      EventDetailsResultModel(
        id: json['_id'] as String?,
        caseId: json['caseId'] as String?,
        eventType: json['eventType'] as String?,
        remarks: json['eventAttr']['remarks'] as String?,
        date: json['date'] as String?,
        mode: json['mode'] as String?,
        reference: json['reference'] as String?,
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'caseId': caseId,
        'eventType': eventType,
        'remarks': remarks,
        'date': date,
        'mode': mode,
        'reference': reference,
      };
}
