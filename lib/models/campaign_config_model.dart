class CampaignConfigModel {
  CampaignConfigModel({this.status, this.message, this.result});

  CampaignConfigModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    result =
        json['result'] != null ? CampaignResult.fromJson(json['result']) : null;
  }

  int? status;
  String? message;
  CampaignResult? result;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    if (result != null) {
      data['result'] = result!.toJson();
    }
    return data;
  }
}

class CampaignResult {
  CampaignResult(
      {this.sId,
      this.contractor,
      this.iV,
      this.senderId,
      this.smsApiKey,
      this.whatsappApiKey,
      this.emailauthid,
      this.emailpassword});

  CampaignResult.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    contractor = json['contractor'];
    iV = json['__v'];
    senderId = json['senderId'];
    smsApiKey = json['smsApiKey'];
    whatsappApiKey = json['whatsappApiKey'];
    emailauthid = json['emailauthid'];
    emailpassword = json['emailpassword'];
  }

  String? sId;
  String? contractor;
  int? iV;
  String? senderId;
  String? smsApiKey;
  String? whatsappApiKey;
  String? emailauthid;
  String? emailpassword;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = sId;
    data['contractor'] = contractor;
    data['__v'] = iV;
    data['senderId'] = senderId;
    data['smsApiKey'] = smsApiKey;
    data['whatsappApiKey'] = whatsappApiKey;
    data['emailauthid'] = emailauthid;
    data['emailpassword'] = emailpassword;
    return data;
  }
}
