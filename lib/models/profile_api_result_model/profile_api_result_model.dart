import 'result.dart';

class ProfileApiResultModel {
  int? status;
  String? message;
  List<ProfileResultModel>? result;

  ProfileApiResultModel({this.status, this.message, this.result});

  factory ProfileApiResultModel.fromJson(Map<String, dynamic> json) {
    return ProfileApiResultModel(
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
