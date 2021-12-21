import 'result.dart';

class DashboardMydeposistsModel {
  int? status;
  String? message;
  DashboardMyDeposistsResult? result;

  DashboardMydeposistsModel({this.status, this.message, this.result});

  factory DashboardMydeposistsModel.fromJson(Map<String, dynamic> json) {
    return DashboardMydeposistsModel(
      status: json['status'] as int?,
      message: json['message'] as String?,
      result: json['result'] == null
          ? null
          : DashboardMyDeposistsResult.fromJson(
              json['result'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'result': result?.toJson(),
      };
}
