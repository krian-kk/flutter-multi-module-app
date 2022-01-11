class AgencyDetailsModel {
  int? status;
  String? message;
  Result? result;

  AgencyDetailsModel({this.status, this.message, this.result});

  AgencyDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    result = json['result'] != null ? Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    return data;
  }
}

class Result {
  List<VoiceAgencyData>? voiceAgencyData;
  String? agentAgencyContact;

  Result({this.voiceAgencyData, this.agentAgencyContact});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['voiceAgencyData'] != null) {
      voiceAgencyData = <VoiceAgencyData>[];
      json['voiceAgencyData'].forEach((v) {
        voiceAgencyData!.add(VoiceAgencyData.fromJson(v));
      });
    }
    agentAgencyContact = json['agentAgencyContact'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.voiceAgencyData != null) {
      data['voiceAgencyData'] =
          this.voiceAgencyData!.map((v) => v.toJson()).toList();
    }
    data['agentAgencyContact'] = this.agentAgencyContact;
    return data;
  }
}

class VoiceAgencyData {
  String? sId;
  List<String>? callerIds;
  bool? currentlyUsed;
  String? agencyId;
  String? agencyName;
  String? url;
  String? contractor;
  String? smsApiKey;
  String? voiceApiKey;
  int? iV;
  String? roleLevel;
  bool? tokenVerified;
  String? version;

  VoiceAgencyData(
      {this.sId,
      this.callerIds,
      this.currentlyUsed,
      this.agencyId,
      this.agencyName,
      this.url,
      this.contractor,
      this.smsApiKey,
      this.voiceApiKey,
      this.iV,
      this.roleLevel,
      this.tokenVerified,
      this.version});

  VoiceAgencyData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    callerIds = json['callerIds'].cast<String>();
    currentlyUsed = json['currentlyUsed'];
    agencyId = json['agencyId'];
    agencyName = json['agencyName'];
    url = json['url'];
    contractor = json['contractor'];
    smsApiKey = json['smsApiKey'];
    voiceApiKey = json['voiceApiKey'];
    iV = json['__v'];
    roleLevel = json['roleLevel'];
    tokenVerified = json['tokenVerified'];
    version = json['version'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['callerIds'] = this.callerIds;
    data['currentlyUsed'] = this.currentlyUsed;
    data['agencyId'] = this.agencyId;
    data['agencyName'] = this.agencyName;
    data['url'] = this.url;
    data['contractor'] = this.contractor;
    data['smsApiKey'] = this.smsApiKey;
    data['voiceApiKey'] = this.voiceApiKey;
    data['__v'] = this.iV;
    data['roleLevel'] = this.roleLevel;
    data['tokenVerified'] = this.tokenVerified;
    data['version'] = this.version;
    return data;
  }
}
