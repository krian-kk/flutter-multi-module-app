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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (result != null) {
      data['result'] = result!.toJson();
    }
    return data;
  }
}

class Result {
  String? reginalText;
  String? translatedText;
  String? audioS3Path;

  Result({
    this.reginalText,
    this.translatedText,
    this.audioS3Path,
  });

  Result.fromJson(Map<String, dynamic> json) {
    reginalText = json['reginal_text'];
    translatedText = json['translated_text'];
    audioS3Path = json['audioS3Path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['reginal_text'] = reginalText;
    data['translated_text'] = translatedText;
    data['audioS3Path'] = audioS3Path;
    return data;
  }
}
