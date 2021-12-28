class VoiceAgencyDatum {
  String? id;
  List<String>? callerIds;
  bool? currentlyUsed;
  String? agencyId;
  String? agencyName;
  String? url;
  String? contractor;
  String? smsApiKey;
  String? voiceApiKey;
  int? v;
  String? roleLevel;
  bool? tokenVerified;
  String? version;

  VoiceAgencyDatum({
    this.id,
    this.callerIds,
    this.currentlyUsed,
    this.agencyId,
    this.agencyName,
    this.url,
    this.contractor,
    this.smsApiKey,
    this.voiceApiKey,
    this.v,
    this.roleLevel,
    this.tokenVerified,
    this.version,
  });

  factory VoiceAgencyDatum.fromJson(Map<String, dynamic> json) {
    return VoiceAgencyDatum(
      id: json['_id'] as String?,
      // callerIds: json['callerIds'].cast<String>(),
      callerIds: json['callerIds'].forEach((v) => v.toString()),
      currentlyUsed: json['currentlyUsed'] as bool?,
      agencyId: json['agencyId'] as String?,
      agencyName: json['agencyName'] as String?,
      url: json['url'] as String?,
      contractor: json['contractor'] as String?,
      smsApiKey: json['smsApiKey'] as String?,
      voiceApiKey: json['voiceApiKey'] as String?,
      v: json['__v'] as int?,
      roleLevel: json['roleLevel'] as String?,
      tokenVerified: json['tokenVerified'] as bool?,
      version: json['version'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'callerIds': callerIds,
        'currentlyUsed': currentlyUsed,
        'agencyId': agencyId,
        'agencyName': agencyName,
        'url': url,
        'contractor': contractor,
        'smsApiKey': smsApiKey,
        'voiceApiKey': voiceApiKey,
        '__v': v,
        'roleLevel': roleLevel,
        'tokenVerified': tokenVerified,
        'version': version,
      };
}
