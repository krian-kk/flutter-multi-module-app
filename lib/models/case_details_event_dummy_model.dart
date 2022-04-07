// class CaseDetailsEventModel {
//   int? eventId;
//   String? eventType;
//   String? caseId;
//   String? eventCode;
//   EventAttr? eventAttr;
//   String? createdBy;
//   String? agentName;
//   String? contractor;
//   String? eventModule;
//   Contact? contact;
//   String? agrRef;
//   String? callID;
//   String? callingID;
//   String? callerServiceID;
//   String? voiceCallEventCode;
//   bool? invalidNumber;
//   List<String>? imageLocation;

//   CaseDetailsEventModel({
//     this.eventId,
//     this.eventType,
//     this.caseId,
//     this.eventCode,
//     this.eventAttr,
//     this.createdBy,
//     this.agentName,
//     this.contractor,
//     this.eventModule,
//     this.contact,
//     this.agrRef,
//     this.callID,
//     this.callingID,
//     this.callerServiceID,
//     this.voiceCallEventCode,
//     this.invalidNumber,
//     this.imageLocation,
//   });

//   CaseDetailsEventModel.fromJson(Map<String, dynamic> json) {
//     eventId = json['eventId'];
//     eventType = json['eventType'];
//     caseId = json['caseId'];
//     eventCode = json['eventCode'];
//     eventAttr = EventAttr.fromJson(json['eventAttr']);
//     createdBy = json['createdBy'];
//     agentName = json['agentName'];
//     contractor = json['contractor'];
//     eventModule = json['eventModule'];
//     contact = Contact.fromJson(json['contact']);
//     agrRef = json['agrRef'];
//     callID = json['callID'];
//     callingID = json['callingID'];
//     callerServiceID = json['callerServiceID'];
//     voiceCallEventCode = json['voiceCallEventCode'];
//     invalidNumber = json['invalidNumber'];
//     imageLocation = json['imageLocation'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['eventId'] = eventId;
//     data['eventType'] = eventType;
//     data['caseId'] = caseId;
//     data['eventCode'] = eventCode;
//     data['eventAttr'] = eventAttr?.toJson();
//     data['createdBy'] = createdBy;
//     data['agentName'] = agentName;
//     data['contractor'] = contractor;
//     data['eventModule'] = eventModule;
//     data['contact'] = contact?.toJson();
//     data['agrRef'] = agrRef;
//     data['callID'] = callID;
//     data['callingID'] = callingID;
//     data['callerServiceID'] = callerServiceID;
//     data['voiceCallEventCode'] = voiceCallEventCode;
//     data['invalidNumber'] = invalidNumber;
//     data['imageLocation'] = imageLocation;
//     return data;
//   }
// }

// class EventAttr {
//   String? date;
//   String? time;
//   String? remarks;
//   int? ptpAmount;
//   String? reference;
//   String? mode;
//   String? pTPType;
//   String? followUpPriority;
//   double? altitude;
//   double? accuracy;
//   double? altitudeAccuracy;
//   double? heading;
//   double? speed;
//   double? latitude;
//   double? longitude;
//   String? actionDate;
//   String? reasons;
//   String? amountDenied;
//   String? disputereasons;
//   String? reminderDate;
//   // Either Integer or Decimal
//   dynamic amountCollected;
//   String? chequeRefNo;
//   String? customerName;
//   List<String>? imageLocation;
//   CollectionsDeposition? deposition;
//   String? remarkOts;
//   String? amntOts;
//   String? appStatus;
//   String? nextActionDate;
//   String? modelMake;
//   String? registrationNo;
//   String? chassisNo;
//   Repo? repo;
//   bool? vehicleavailable;
//   String? collectorfeedback;
//   String? actionproposed;
//   List? contact;

//   EventAttr({
//     this.date,
//     this.time,
//     this.remarks,
//     this.ptpAmount,
//     this.reference,
//     this.mode,
//     this.pTPType,
//     this.followUpPriority,
//     this.altitude = 0,
//     this.accuracy = 0,
//     this.altitudeAccuracy,
//     this.heading = 0,
//     this.speed = 0,
//     this.latitude = 0,
//     this.longitude = 0,
//     this.actionDate,
//     this.reasons,
//     this.amountDenied,
//     this.disputereasons,
//     this.reminderDate,
//     this.amountCollected,
//     this.chequeRefNo,
//     this.customerName,
//     this.imageLocation,
//     this.deposition,
//     this.remarkOts,
//     this.amntOts,
//     this.appStatus,
//     this.nextActionDate,
//     this.modelMake,
//     this.registrationNo,
//     this.chassisNo,
//     this.repo,
//     this.vehicleavailable,
//     this.collectorfeedback,
//     this.actionproposed,
//     this.contact,
//   });

//   EventAttr.fromJson(Map<String, dynamic> json) {
//     date = json['date'];
//     time = json['time'];
//     remarks = json['remarks'];
//     ptpAmount = json['ptpAmount'];
//     reference = json['reference'];
//     mode = json['mode'];
//     pTPType = json['PTPType'];
//     followUpPriority = json['followUpPriority'];
//     altitude = json['altitude'];
//     accuracy = json['accuracy'];
//     altitudeAccuracy = json['altitudeAccuracy'];
//     heading = json['heading'];
//     speed = json['speed'];
//     latitude = json['Latitude'];
//     longitude = json['Longitude'];
//     actionDate = json['actionDate'];
//     reasons = json['reasons'];
//     amountDenied = json['amountDenied'];
//     disputereasons = json['disputereasons'];
//     reminderDate = json['reminderDate'];
//     amountCollected = json['amountCollected'];
//     chequeRefNo = json['chequeRefNo'];
//     customerName = json['customerName'];
//     imageLocation = json['imageLocation'].cast<String>();
//     deposition = json['deposition'];
//     remarkOts = json['remarkOts'];
//     amntOts = json['amntOts'];
//     appStatus = json['appStatus'];
//     nextActionDate = json['nextActionDate'];
//     modelMake = json['modelMake'];
//     registrationNo = json['registrationNo'];
//     chassisNo = json['chassisNo'];
//     repo = Repo.fromJson(json['repo']);
//     vehicleavailable = json['vehicleavailable'];
//     collectorfeedback = json['collectorfeedback'];
//     actionproposed = json['actionproposed'];
//     contact = json['contact'].forEach((v) {
//       contact?.add(v);
//     });
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['date'] = date;
//     data['time'] = time;
//     data['remarks'] = remarks;
//     data['ptpAmount'] = ptpAmount;
//     data['reference'] = reference;
//     data['mode'] = mode;
//     data['PTPType'] = pTPType;
//     data['followUpPriority'] = followUpPriority;
//     data['altitude'] = altitude;
//     data['accuracy'] = accuracy;
//     data['altitudeAccuracy'] = altitudeAccuracy;
//     data['heading'] = heading;
//     data['speed'] = speed;
//     data['Latitude'] = latitude;
//     data['Longitude'] = longitude;
//     data['actionDate'] = actionDate;
//     data['reasons'] = reasons;
//     data['amountDenied'] = amountDenied;
//     data['disputereasons'] = disputereasons;
//     data['reminderDate'] = reminderDate;
//     data['amountCollected'] = amountCollected;
//     data['chequeRefNo'] = chequeRefNo;
//     data['customerName'] = customerName;
//     data['imageLocation'] = imageLocation;
//     data['deposition'] = deposition;
//     data['remarkOts'] = remarkOts;
//     data['amntOts'] = amntOts;
//     data['appStatus'] = appStatus;
//     data['nextActionDate'] = nextActionDate;
//     data['modelMake'] = modelMake;
//     data['registrationNo'] = registrationNo;
//     data['chassisNo'] = chassisNo;
//     data['repo'] = repo?.toJson();
//     data['vehicleavailable'] = vehicleavailable;
//     data['collectorfeedback'] = collectorfeedback;
//     data['actionproposed'] = actionproposed;
//     data['contact'] = contact?.map((v) => v.toJson()).toList();
//     return data;
//   }
// }

// class AgentLocation {
//   double? latitude;
//   double? longitude;
//   String? missingAgentLocation;

//   AgentLocation({
//     this.latitude,
//     this.longitude,
//     this.missingAgentLocation,
//   });

//   AgentLocation.fromJson(Map<String, dynamic> json) {
//     latitude = json['latitude'];
//     longitude = json['longitude'];
//     missingAgentLocation = json['missingAgentLocation'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['latitude'] = latitude;
//     data['longitude'] = longitude;
//     data['missingAgentLocation'] = missingAgentLocation;
//     return data;
//   }
// }

// class Contact {
//   String? cType;
//   String? health;
//   String? value;
//   String? resAddressId0;
//   String? contactId0;

//   Contact({
//     this.cType,
//     this.health,
//     this.value,
//     this.resAddressId0,
//     this.contactId0,
//   });

//   Contact.fromJson(Map<String, dynamic> json) {
//     cType = json['cType'];
//     health = json['health'];
//     value = json['value'];
//     resAddressId0 = json['resAddressId_0'];
//     contactId0 = json['contactId_0'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['cType'] = cType;
//     data['health'] = health;
//     data['value'] = value;
//     data['resAddressId_0'] = resAddressId0;
//     data['contactId_0'] = contactId0;
//     return data;
//   }
// }

// class CollectionsDeposition {
//   String? status;

//   CollectionsDeposition({
//     this.status,
//   });

//   CollectionsDeposition.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['status'] = status;

//     return data;
//   }
// }

// class Repo {
//   String? status;

//   Repo({this.status});

//   Repo.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['status'] = status;
//     return data;
//   }
// }
