class CommunicationChannelModel {
  CommunicationChannelModel({this.status, this.message, this.result});

  CommunicationChannelModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    result =
        json['result'] != null ? ChannelResults.fromJson(json['result']) : null;
  }

  int? status;
  String? message;
  ChannelResults? result;

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

class ChannelResults {
  ChannelResults.fromJson(Map<String, dynamic> json) {
    voiceApiKeyAvailable = json['voiceApiKeyAvailable'];
  }

  bool? voiceApiKeyAvailable;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['voiceApiKeyAvailable'] = voiceApiKeyAvailable;
    return data;
  }
}
