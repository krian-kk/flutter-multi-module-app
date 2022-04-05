import 'result.dart';

class CaseDetailsApiModel {
  CaseDetailsApiModel({this.status, this.message, this.result});

  factory CaseDetailsApiModel.fromJson(Map<String, dynamic> json) {
    return CaseDetailsApiModel(
      status: json['status'] as int?,
      message: json['message'] as String?,
      result: json['result'] == null
          ? null
          : CaseDetailsResultModel.fromJson(
              json['result'] as Map<String, dynamic>),
    );
  }
  int? status;
  String? message;
  CaseDetailsResultModel? result;

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'result': result?.toJson(),
      };
}
