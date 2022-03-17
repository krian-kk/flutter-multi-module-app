class Speech2TextModel {
  int? status;
  String? message;
  Result? result;

  Speech2TextModel({this.status, this.message, this.result});

  Speech2TextModel.fromJson(Map<String, dynamic> json) {
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
  String? reginalText;
  String? translatedText;

  Result({this.reginalText, this.translatedText});

  Result.fromJson(Map<String, dynamic> json) {
    reginalText = json['reginal_text'];
    translatedText = json['translated_text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reginal_text'] = this.reginalText;
    data['translated_text'] = this.translatedText;
    return data;
  }
}
