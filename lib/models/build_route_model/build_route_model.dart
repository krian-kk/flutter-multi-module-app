import 'result.dart';

class BuildRouteModel {
  int? status;
  String? message;
  BuildRouteResultModel? result;

  BuildRouteModel({this.status, this.message, this.result});

  factory BuildRouteModel.fromJson(Map<String, dynamic> json) {
    return BuildRouteModel(
      status: json['status'] as int?,
      message: json['message'] as String?,
      result: json['result'] == null
          ? null
          : BuildRouteResultModel.fromJson(
              json['result'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'result': result?.toJson(),
      };
}
