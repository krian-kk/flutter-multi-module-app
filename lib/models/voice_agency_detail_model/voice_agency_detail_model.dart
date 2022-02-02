class AgencyDetailsModel {
  int? status;
  String? message;
  AgencyResult? result;

  AgencyDetailsModel({this.status, this.message, this.result});

  AgencyDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    result =
        json['result'] != null ? AgencyResult.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (result != null) {
      data['result'] = result!.toJson();
    }
    return data;
  }
}

class AgencyResult {
  List<VoiceAgencyData>? voiceAgencyData;
  String? agentAgencyContact;

  AgencyResult({this.voiceAgencyData, this.agentAgencyContact});

  AgencyResult.fromJson(Map<String, dynamic> json) {
    if (json['voiceAgencyData'] != null) {
      voiceAgencyData = <VoiceAgencyData>[];
      json['voiceAgencyData'].forEach((v) {
        voiceAgencyData!.add(VoiceAgencyData.fromJson(v));
      });
    }
    agentAgencyContact = json['agentAgencyContact'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (voiceAgencyData != null) {
      data['voiceAgencyData'] =
          voiceAgencyData!.map((v) => v.toJson()).toList();
    }
    data['agentAgencyContact'] = agentAgencyContact;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['callerIds'] = callerIds;
    data['currentlyUsed'] = currentlyUsed;
    data['agencyId'] = agencyId;
    data['agencyName'] = agencyName;
    data['url'] = url;
    data['contractor'] = contractor;
    data['smsApiKey'] = smsApiKey;
    data['voiceApiKey'] = voiceApiKey;
    data['__v'] = iV;
    data['roleLevel'] = roleLevel;
    data['tokenVerified'] = tokenVerified;
    data['version'] = version;
    return data;
  }
}
