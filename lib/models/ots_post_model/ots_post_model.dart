import 'contact.dart';
import 'event_attr.dart';

class OtsPostModel {
  OtsPostModel({
    required this.eventId,
    required this.eventType,
    required this.caseId,
    required this.eventAttr,
    required this.eventCode,
    this.createdAt,
    required this.createdBy,
    required this.agentName,
    required this.eventModule,
    required this.contact,
    required this.callId,
    required this.callingId,
    required this.callerServiceId,
    required this.voiceCallEventCode,
    this.invalidNumber,
    required this.agrRef,
    required this.contractor,
    required this.imageLocation,
  });

  factory OtsPostModel.fromJson(Map<String, dynamic> json) => OtsPostModel(
        eventId: json['eventId'] as int,
        eventType: json['eventType'] as String,
        caseId: json['caseId'] as String,
        eventAttr:
            OTSEventAttr.fromJson(json['eventAttr'] as Map<String, dynamic>),
        eventCode: json['eventCode'] as String,
        createdAt: json['createdAt'] as String?,
        createdBy: json['createdBy'] as String,
        agentName: json['agentName'] as String,
        eventModule: json['eventModule'] as String,
        contact: OTSContact.fromJson(json['contact'] as Map<String, dynamic>),
        callId: json['callID'] as dynamic,
        callingId: json['callingID'] as dynamic,
        callerServiceId: json['callerServiceID'] as String,
        voiceCallEventCode: json['voiceCallEventCode'] as String,
        invalidNumber: json['invalidNumber'] as dynamic,
        agrRef: json['agrRef'] as String,
        contractor: json['contractor'] as String,
        imageLocation: json['imageLocation'],
      );
  int eventId;
  String eventType;
  String caseId;
  OTSEventAttr eventAttr;
  String eventCode;
  String? createdAt;
  String createdBy;
  String agentName;
  String eventModule;
  OTSContact contact;
  String? callId;
  String? callingId;
  String callerServiceId;
  String voiceCallEventCode;
  bool? invalidNumber;
  String agrRef;
  String contractor;
  List<String> imageLocation;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'eventId': eventId,
        'eventType': eventType,
        'caseId': caseId,
        'eventAttr': eventAttr.toJson(),
        'eventCode': eventCode,
        'createdAt': createdAt,
        'createdBy': createdBy,
        'agentName': agentName,
        'eventModule': eventModule,
        'contact': contact.toJson(),
        'callID': callId,
        'callingID': callingId,
        'callerServiceID': callerServiceId,
        'voiceCallEventCode': voiceCallEventCode,
        'invalidNumber': invalidNumber,
        'agrRef': agrRef,
        'contractor': contractor,
        'imageLocation': imageLocation,
      };
}
