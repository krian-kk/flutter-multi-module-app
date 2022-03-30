import 'event_attr.dart';

class EvnetDetailsResultsModel {
  String? id;
  String? caseId;
  String? eventType;
  EventAttr? eventAttr;

  EvnetDetailsResultsModel({
    this.id,
    this.caseId,
    this.eventType,
    this.eventAttr,
  });

  factory EvnetDetailsResultsModel.fromJson(Map<String, dynamic> json) =>
      EvnetDetailsResultsModel(
        id: json['_id'] as String?,
        caseId: json['caseId'] as String?,
        eventType: json['eventType'] as String?,
        eventAttr: json['eventAttr'] == null
            ? null
            : EventAttr.fromJson(json['eventAttr'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'caseId': caseId,
        'eventType': eventType,
        'eventAttr': eventAttr?.toJson(),
      };
}
