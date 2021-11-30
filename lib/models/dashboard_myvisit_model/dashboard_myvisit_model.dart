import 'result.dart';

class DashboardMyvisitModel {
  int? status;
  String? message;
  DashboardMyVistisResult? result;

  DashboardMyvisitModel({this.status, this.message, this.result});

  factory DashboardMyvisitModel.fromJson(Map<String, dynamic> json) {
    return DashboardMyvisitModel(
      status: json['status'] as int?,
      message: json['message'] as String?,
      result: json['result'] == null
          ? null
          : DashboardMyVistisResult.fromJson(
              json['result'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'result': result?.toJson(),
      };
}
