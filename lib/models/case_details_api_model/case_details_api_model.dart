import 'result.dart';

class CaseDetailsApiModel {
  int? status;
  String? message;
  Result? result;

  CaseDetailsApiModel({this.status, this.message, this.result});

  factory CaseDetailsApiModel.fromJson(Map<String, dynamic> json) {
    return CaseDetailsApiModel(
      status: json['status'] as int?,
      message: json['message'] as String?,
      result: json['result'] == null
          ? null
          : Result.fromJson(json['result'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'result': result?.toJson(),
      };
}
