import 'result.dart';

class DashboardPriorityModel {
  int? status;
  String? message;
  DashboardProrityResultModel? result;

  DashboardPriorityModel({this.status, this.message, this.result});

  factory DashboardPriorityModel.fromJson(Map<String, dynamic> json) {
    return DashboardPriorityModel(
      status: json['status'] as int?,
      message: json['message'] as String?,
      result: json['result'] == null
          ? null
          : DashboardProrityResultModel.fromJson(
              json['result'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'result': result?.toJson(),
      };
}
