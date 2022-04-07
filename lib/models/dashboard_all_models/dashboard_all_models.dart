import 'result.dart';

class DashboardAllModels {
  DashboardAllModels({this.status, this.message, this.result});

  factory DashboardAllModels.fromJson(Map<String, dynamic> json) {
    return DashboardAllModels(
      status: json['status'] as int?,
      message: json['message'] as String?,
      result: json['result'] == null
          ? null
          : Result.fromJson(json['result'] as Map<String, dynamic>),
    );
  }
  int? status;
  String? message;
  Result? result;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'status': status,
        'message': message,
        'result': result?.toJson(),
      };
}
