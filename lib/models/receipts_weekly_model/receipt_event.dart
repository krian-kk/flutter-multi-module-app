import 'event_attr.dart';

class ReceiptEvent {
  String? id;
  String? caseId;
  EventAttr? eventAttr;

  ReceiptEvent({this.id, this.caseId, this.eventAttr});

  factory ReceiptEvent.fromJson(Map<String, dynamic> json) => ReceiptEvent(
        id: json['_id'] as String?,
        caseId: json['caseId'] as String?,
        eventAttr: json['eventAttr'] == null
            ? null
            : EventAttr.fromJson(json['eventAttr'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'caseId': caseId,
        'eventAttr': eventAttr?.toJson(),
      };
}
