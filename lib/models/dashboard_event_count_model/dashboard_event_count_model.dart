import 'result.dart';

class DashboardEventCountModel {
  int? status;
  String? message;
  List<DashboardEventCountResult>? result;

  DashboardEventCountModel({this.status, this.message, this.result});

  factory DashboardEventCountModel.fromJson(Map<String, dynamic> json) {
    return DashboardEventCountModel(
      status: json['status'] as int?,
      message: json['message'] as String?,
      result: (json['result'] as List<dynamic>?)
          ?.map((e) =>
              DashboardEventCountResult.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'result': result?.map((e) => e.toJson()).toList(),
      };
}
