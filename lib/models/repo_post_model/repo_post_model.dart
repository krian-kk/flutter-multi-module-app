import '../../utils/app_utils.dart';

class RepoPostModel {
  RepoPostModel({
    required this.eventId,
    required this.eventType,
    required this.caseId,
    required this.eventCode,
    required this.eventAttr,
    required this.contact,
    this.createdAt,
    required this.createdBy,
    required this.agentName,
    required this.contractor,
    required this.eventModule,
    this.callID,
    this.callingID,
    this.callerServiceID,
    required this.voiceCallEventCode,
    this.invalidNumber,
    required this.agrRef,
  });

  RepoPostModel.fromJson(Map<String, dynamic> json) {
    eventId = json['eventId'];
    eventType = json['eventType'];
    caseId = json['caseId'];
    eventCode = json['eventCode'];
    eventAttr = EventAttr.fromJson(json['eventAttr']);
    contact = RepoContact.fromJson(json['contact']);
    createdAt = json['createdAt'];
    createdBy = json['createdBy'];
    agentName = json['agentName'];
    contractor = json['contractor'];
    eventModule = json['eventModule'];
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
  late EventAttr eventAttr;
  late RepoContact contact;
  late String? createdAt;
  late String createdBy;
  late String agentName;
  late String contractor;
  late String eventModule;
  late String? callID;
  late String? callingID;
  late String? callerServiceID;
  late String voiceCallEventCode;
  late String? invalidNumber;
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
    data['contact'] = contact.toJson();
    // data['createdAt'] = createdAt;
    if (isOnline == false) {
      data['createdAt'] = DateTime.now().toString();
    }
    data['createdBy'] = createdBy;
    data['agentName'] = agentName;
    data['contractor'] = contractor;
    data['eventModule'] = eventModule;
    data['callID'] = callID;
    data['callingID'] = callingID;
    data['callerServiceID'] = callerServiceID;
    data['voiceCallEventCode'] = voiceCallEventCode;
    data['invalidNumber'] = invalidNumber;
    data['agrRef'] = agrRef;
    return data;
  }
}

class EventAttr {
  EventAttr(
      {required this.modelMake,
      required this.chassisNo,
      required this.remarks,
      required this.repo,
      required this.date,
      required this.followUpPriority,
      required this.imageLocation,
      required this.customerName,
      this.altitude,
      required this.accuracy,
      this.altitudeAccuracy = 0.0,
      this.heading,
      this.speed,
      required this.latitude,
      required this.longitude,
      this.reginalText,
      this.translatedText,
      this.audioS3Path,
      this.vehicleRegNo,
      this.vehicleIdentificationNo,
      this.ref1,
      this.ref2,
      this.ref2No,
      this.ref1No,
      this.batteryID,
      this.dealerAddress,
      this.dealerName});

  EventAttr.fromJson(Map<String, dynamic> json) {
    modelMake = json['modelMake'];
    chassisNo = json['chassisNo'];
    remarks = json['remarks'];
    repo = Repo.fromJson(json['repo']);
    date = json['date'];
    followUpPriority = json['followUpPriority'];
    imageLocation = json['imageLocation'].cast<String>();
    customerName = json['customerName'];
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

    vehicleRegNo = json['vehicleRegNo'];
    vehicleIdentificationNo = json['vehicleIdentificationNo'];
    ref1 = json['ref1'];
    ref2 = json['ref2'];
    ref1No = json['ref1No'];
    ref2No = json['ref2No'];
    dealerName = json['dealerName'];
    dealerAddress = json['dealerAddress'];
    batteryID = json['batteryID'];
  }

  late String modelMake;
  late String chassisNo;
  late String remarks;
  late Repo repo;
  late String date;
  late String followUpPriority;
  late List<String> imageLocation;
  late String customerName;
  late double? altitude;
  late double accuracy;
  late double? altitudeAccuracy;
  late double? heading;
  late double? speed;
  late double latitude;
  late double longitude;
  late String? reginalText;
  late String? translatedText;
  late String? audioS3Path;

  late String? vehicleRegNo;
  late String? vehicleIdentificationNo;
  late String? ref1;
  late String? ref2;
  late String? ref1No;
  late String? ref2No;
  late String? dealerName;
  late String? dealerAddress;
  late String? batteryID;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['modelMake'] = modelMake;
    data['chassisNo'] = chassisNo;
    data['remarks'] = remarks;
    data['repo'] = repo.toJson();
    data['date'] = date;
    data['followUpPriority'] = followUpPriority;
    data['imageLocation'] = imageLocation;
    data['customerName'] = customerName;
    data['altitude'] = altitude;
    data['accuracy'] = accuracy;
    data['altitudeAccuracy'] = altitudeAccuracy;
    data['heading'] = heading;
    data['speed'] = speed;
    data['Latitude'] = latitude;
    data['Longitude'] = longitude;

    if (vehicleRegNo?.isNotEmpty == true) {
      data['vehicleRegNo'] = vehicleRegNo;
    }
    if (vehicleIdentificationNo?.isNotEmpty == true) {
      data['vehicleIdentificationNo'] = vehicleIdentificationNo;
    }
    if (ref1?.isNotEmpty == true) {
      data['ref1'] = ref1;
    }
    if (ref2?.isNotEmpty == true) {
      data['ref2'] = ref2;
    }
    if (ref1No?.isNotEmpty == true) {
      data['ref1No'] = ref1No;
    }
    if (ref1No?.isNotEmpty == true) {
      data['ref2No'] = ref2No;
    }
    if (ref1No?.isNotEmpty == true) {
      data['dealerName'] = dealerName;
    }
    if (ref1No?.isNotEmpty == true) {
      data['dealerAddress'] = dealerAddress;
    }
    if (ref1No?.isNotEmpty == true) {
      data['batteryID'] = batteryID;
    }
    if (reginalText != null && translatedText != null && audioS3Path != null) {
      data['reginal_text'] = reginalText;
      data['translated_text'] = translatedText;
      data['audioS3Path'] = audioS3Path;
    }
    return data;
  }
}

class Repo {
  Repo({this.status = 'pending'});

  Repo.fromJson(Map<String, dynamic> json) {
    status = json['status'];
  }

  late String status;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    return data;
  }
}

class RepoContact {
  RepoContact({
    required this.cType,
    required this.health,
    required this.value,
    // this.resAddressId0 = '',
    // this.contactId0 = ''
  });

  RepoContact.fromJson(Map<String, dynamic> json) {
    cType = json['cType'];
    health = json['health'];
    if (value.isNotEmpty) {
      value = json['value'];
    }
    // resAddressId0 = json['resAddressId_0'];
    // contactId0 = json['contactId_0'];
  }

  late String cType;
  late String health;
  late String value;

  // late String resAddressId0;
  // late String contactId0;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cType'] = cType;
    data['health'] = health;
    if (value.isNotEmpty) {
      data['value'] = value;
    }
    // data['resAddressId_0'] = resAddressId0;
    // data['contactId_0'] = contactId0;
    return data;
  }
}
