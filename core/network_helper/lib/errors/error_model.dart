class ErrorModel {
  int? status;
  String? message;
  dynamic result;

  ErrorModel({this.status, this.message, this.result});

  factory ErrorModel.fromJson(Map<String, dynamic> json) {
    return ErrorModel(
        status: json["status"],
        message: json["message"],
        result: json['result']);
  }
}
