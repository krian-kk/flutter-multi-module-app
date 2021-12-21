import 'result.dart';

class VoiceAgencyDetailsModel {
  int? status;
  String? message;
  VoiceAgencyResult? result;

  VoiceAgencyDetailsModel({this.status, this.message, this.result});

  factory VoiceAgencyDetailsModel.fromJson(Map<String, dynamic> json) {
    return VoiceAgencyDetailsModel(
      status: json['status'] as int?,
      message: json['message'] as String?,
      result: json['result'] == null
          ? null
          : VoiceAgencyResult.fromJson(json['result'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'result': result?.toJson(),
      };
}
