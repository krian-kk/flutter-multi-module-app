import '../../utils/app_utils.dart';

class CustomerNotMetPostModel {
  CustomerNotMetPostModel(
      {required this.eventId,
      required this.eventType,
      required this.caseId,
      required this.eventCode,
      required this.eventAttr,
      this.contact,
      this.createdAt,
      required this.createdBy,
      required this.eventModule,
      required this.agentName,
      required this.contractor,
      this.callID,
      this.callingID,
      required this.callerServiceID,
      required this.voiceCallEventCode,
      this.invalidNumber,
      required this.agrRef});

  CustomerNotMetPostModel.fromJson(Map<String, dynamic> json) {
    eventId = json['eventId'];
    eventType = json['eventType'];
    caseId = json['caseId'];
    eventCode = json['eventCode'];
    eventAttr = CustomerNotMetEventAttr.fromJson(json['eventAttr']);
    contact = json['contact'];
    createdAt = json['createdAt'];
    createdBy = json['createdBy'];
    eventModule = json['eventModule'];
    agentName = json['agentName'];
    contractor = json['contractor'];
    callID = json['callID'];
    callingID = json['callingID'];
    callerServiceID = json['callerServiceID'];
    voiceCallEventCode = json['voiceCallEventCode'];
    invalidNumber = json['invalidNumber'];
    agrRef = json['agrRef'];
  }
  late int eventId;
  late String eventType;
  late String caseId;
  late String eventCode;
  late CustomerNotMetEventAttr eventAttr;
  late dynamic contact;
  late String? createdAt;
  late String createdBy;
  late String eventModule;
  late String agentName;
  late String contractor;
  late String? callID;
  late String? callingID;
  late String? callerServiceID;
  late String voiceCallEventCode;
  late bool? invalidNumber;
  late String agrRef;

  Map<String, dynamic> toJson() {
    bool isOnline = true;
    AppUtils.checkNetworkConnection().then((value) {
      isOnline = value;
    });
    final Map<String, dynamic> data = <String, dynamic>{};
    data['eventId'] = eventId;
    data['eventType'] = eventType;
    data['caseId'] = caseId;
    data['eventCode'] = eventCode;
    data['eventAttr'] = eventAttr.toJson();
    if (contact != null) {
      data['contact'] = contact;
    }
    if (isOnline == false) {
      data['createdAt'] = DateTime.now().toString();
    }
    data['createdBy'] = createdBy;
    data['eventModule'] = eventModule;
    data['agentName'] = agentName;
    data['contractor'] = contractor;
    data['callID'] = callID;
    data['callingID'] = callingID;
    data['callerServiceID'] = callerServiceID;
    data['voiceCallEventCode'] = voiceCallEventCode;
    data['invalidNumber'] = invalidNumber;
    data['agrRef'] = agrRef;
    return data;
  }
}

class CustomerNotMetEventAttr {
  CustomerNotMetEventAttr({
    this.remarks,
    required this.followUpPriority,
    required this.nextActionDate,
    this.altitude = 0,
    this.accuracy = 0,
    this.altitudeAccuracy = 0,
    this.heading = 0,
    this.speed = 0,
    this.latitude = 0,
    this.longitude = 0,
    this.reginalText,
    this.translatedText,
    this.audioS3Path,
  });

  CustomerNotMetEventAttr.fromJson(Map<String, dynamic> json) {
    remarks = json['remarks'];
    followUpPriority = json['followUpPriority'];
    nextActionDate = json['nextActionDate'];
    altitude = json['altitude'];
    accuracy = json['accuracy'];
    altitudeAccuracy = json['altitudeAccuracy'];
    heading = json['heading'];
    speed = json['speed'];
    latitude = json['Latitude'];
    longitude = json['Longitude'];
    reginalText = json['reginal_text'];
    translatedText = json['translated_text'];
    audioS3Path = json['audioS3Path'];
  }
  late String? remarks;
  late String followUpPriority;
  late String nextActionDate;
  late double altitude;
  late double accuracy;
  late double altitudeAccuracy;
  late double heading;
  late double speed;
  late double latitude;
  late double longitude;
  late String? reginalText;
  late String? translatedText;
  late String? audioS3Path;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['remarks'] = remarks;
    data['followUpPriority'] = followUpPriority;
    data['nextActionDate'] = nextActionDate;
    data['altitude'] = altitude;
    data['accuracy'] = accuracy;
    data['altitudeAccuracy'] = altitudeAccuracy;
    data['heading'] = heading;
    data['speed'] = speed;
    data['Latitude'] = latitude;
    data['Longitude'] = longitude;
    if (reginalText != null && translatedText != null && audioS3Path != null) {
      data['reginal_text'] = reginalText;
      data['translated_text'] = translatedText;
      data['audioS3Path'] = audioS3Path;
    }
    return data;
  }
}
