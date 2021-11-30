import 'result.dart';

class DashboardMyReceiptsModel {
  int? status;
  String? message;
  DashboardMyReceiptsResult? result;

  DashboardMyReceiptsModel({this.status, this.message, this.result});

  factory DashboardMyReceiptsModel.fromJson(Map<String, dynamic> json) {
    return DashboardMyReceiptsModel(
      status: json['status'] as int?,
      message: json['message'] as String?,
      result: json['result'] == null
          ? null
          : DashboardMyReceiptsResult.fromJson(
              json['result'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'result': result?.toJson(),
      };
}
