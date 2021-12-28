import 'result.dart';

class VoiceAgencyDetailModel {
  int? status;
  String? message;
  Result? result;

  VoiceAgencyDetailModel({this.status, this.message, this.result});

  factory VoiceAgencyDetailModel.fromJson(Map<String, dynamic> json) {
    return VoiceAgencyDetailModel(
      status: json['status'] as int?,
      message: json['message'] as String?,
      result: json['result'] == null
          ? null
          : Result.fromJson(json['result'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'result': result?.toJson(),
      };
}
