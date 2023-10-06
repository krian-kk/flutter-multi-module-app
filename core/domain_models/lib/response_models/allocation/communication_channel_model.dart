class CommunicationChannelModel {
  CommunicationChannelModel.fromJson(Map<String, dynamic> json) {
    voiceApiKeyAvailable = json['voiceApiKeyAvailable'];
  }

  bool? voiceApiKeyAvailable;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['voiceApiKeyAvailable'] = voiceApiKeyAvailable;
    return data;
  }
}
