import 'package:origa/utils/date_formate_utils.dart';

import 'event_attr.dart';

class EvnetDetailsResultsModel {
  EvnetDetailsResultsModel({
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
          eventModule: json['eventModule'],
          agrRef: json['agrRef'],
          contractor: json['contractor'],
          eventCode: json['eventCode'],
          monthName: DateFormateUtils.getDate2Month(json['createdAt']));
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
