import 'event_attr.dart';

class EvnetDetailsResultsModel {
  EvnetDetailsResultsModel({
    this.id,
    this.caseId,
    this.eventType,
    this.eventAttr,
    this.createdAt,
    this.createdBy,
  });

  factory EvnetDetailsResultsModel.fromJson(Map<String, dynamic> json) =>
      EvnetDetailsResultsModel(
        id: json['_id'] as String?,
        caseId: json['caseId'] as String?,
        eventType: json['eventType'] as String?,
        eventAttr: json['eventAttr'] == null
            ? null
            : EventAttr.fromJson(json['eventAttr'] as Map<String, dynamic>),
        createdAt: json['createdAt'] as String?,
        createdBy: json['createdBy'] as String?,
      );
  String? id;
  String? caseId;
  String? eventType;
  EventAttr? eventAttr;
  String? createdAt;
  String? createdBy;

  Map<String, dynamic> toJson() => {
        '_id': id,
        'caseId': caseId,
        'eventType': eventType,
        'eventAttr': eventAttr?.toJson(),
        'createdAt': createdAt,
        'createdBy': createdBy,
      };
}
