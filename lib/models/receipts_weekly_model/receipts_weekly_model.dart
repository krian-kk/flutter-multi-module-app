import 'result.dart';

class ReceiptsWeeklyModel {
  int? status;
  String? message;
  Result? result;

  ReceiptsWeeklyModel({this.status, this.message, this.result});

  factory ReceiptsWeeklyModel.fromJson(Map<String, dynamic> json) {
    return ReceiptsWeeklyModel(
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
