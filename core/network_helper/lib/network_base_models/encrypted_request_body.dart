class EncryptedRequestBody {
  String? encryptedData;

  EncryptedRequestBody({this.encryptedData});

  factory EncryptedRequestBody.fromJson(Map<String, dynamic> json) {
    return EncryptedRequestBody(encryptedData: json["encryptedData"]);
  }
  factory EncryptedRequestBody.toJson(Map<String, dynamic> json) {
    final Map<String, dynamic> data = <String, dynamic>{};

    return EncryptedRequestBody(encryptedData: json["encryptedData"]);
  }
}
