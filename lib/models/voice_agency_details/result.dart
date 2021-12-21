class VoiceAgencyResult {
  List<dynamic>? voiceAgencyData;
  String? agentAgencyContact;

  VoiceAgencyResult({this.voiceAgencyData, this.agentAgencyContact});

  factory VoiceAgencyResult.fromJson(Map<String, dynamic> json) =>
      VoiceAgencyResult(
        voiceAgencyData: json['voiceAgencyData'] as List<dynamic>?,
        agentAgencyContact: json['agentAgencyContact'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'voiceAgencyData': voiceAgencyData,
        'agentAgencyContact': agentAgencyContact,
      };
}
