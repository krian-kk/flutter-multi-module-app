import 'contact.dart';
import 'event_attr.dart';

class OtsPostModel {
  int eventId;
  String eventType;
  String caseId;
  OTSEventAttr eventAttr;
  String eventCode;
  String createdBy;
  String agentName;
  String eventModule;
  OTSContact contact;
  String? callId;
  String? callingId;
  String callerServiceId;
  String voiceCallEventCode;
  String? invalidNumber;
  String agrRef;
  String contractor;
  List<String> imageLocation;
  OtsPostModel({
    required this.eventId,
    required this.eventType,
    required this.caseId,
    required this.eventAttr,
    required this.eventCode,
    required this.createdBy,
    required this.agentName,
    required this.eventModule,
    required this.contact,
    required this.callId,
    required this.callingId,
    required this.callerServiceId,
    required this.voiceCallEventCode,
    this.invalidNumber = '0',
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

  Map<String, dynamic> toJson() => {
        'eventId': eventId,
        'eventType': eventType,
        'caseId': caseId,
        'eventAttr': eventAttr.toJson(),
        'eventCode': eventCode,
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
