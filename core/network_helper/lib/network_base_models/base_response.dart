import 'package:freezed_annotation/freezed_annotation.dart';

class BaseResponse {
  int? status;
  String? message;

  BaseResponse({this.status, this.message});

  factory BaseResponse.fromJson(Map<String, dynamic> json) {
    return BaseResponse(status: json["status"], message: json["message"]);
  }
}

@JsonSerializable(genericArgumentFactories: true)
class ListResponse<T> extends BaseResponse {
  List<T>? result;

  ListResponse({
    int? status,
    String? message,
    this.result,
  }) : super(message: message, status: status);

  factory ListResponse.fromJson(
      Map<String, dynamic> json, Function(Map<String, dynamic>) create) {
    var listData = <T>[];
    json['result'].forEach((v) {
      listData.add(create(v));
    });

    return ListResponse<T>(
        status: json["status"], message: json["message"], result: listData);
  }
}

@JsonSerializable(genericArgumentFactories: true)
class SingleResponse<T> extends BaseResponse {
  T? result;

  SingleResponse({
    int? status,
    String? message,
    this.result,
  }) : super(message: message, status: status);

  factory SingleResponse.fromJson(
      Map<String, dynamic> json, Function(Map<String, dynamic>) create) {
    return SingleResponse<T>(
        status: json["status"],
        message: json["message"],
        result: create(json["result"]));
  }
}
