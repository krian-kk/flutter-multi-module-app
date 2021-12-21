import 'result.dart';

class ProfileApiModel {
  int? status;
  String? message;
  List<ProfileResultModel>? result;

  ProfileApiModel({this.status, this.message, this.result});

  factory ProfileApiModel.fromJson(Map<String, dynamic> json) {
    return ProfileApiModel(
      status: json['status'] as int?,
      message: json['message'] as String?,
      result: (json['result'] as List<dynamic>?)
          ?.map((e) => ProfileResultModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'result': result?.map((e) => e.toJson()).toList(),
      };
}
