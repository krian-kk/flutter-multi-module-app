import 'result.dart';

class DashboardEventCountModel {
  DashboardEventCountModel({this.status, this.message, this.result});

  factory DashboardEventCountModel.fromJson(Map<String, dynamic> json) {
    return DashboardEventCountModel(
      status: json['status'] as int?,
      message: json['message'] as String?,
      result: (json['result'] as List<dynamic>?)
          ?.map((dynamic e) =>
              DashboardEventCountResult.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
  int? status;
  String? message;
  List<DashboardEventCountResult>? result;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'status': status,
        'message': message,
        'result':
            result?.map((DashboardEventCountResult e) => e.toJson()).toList(),
      };
}
