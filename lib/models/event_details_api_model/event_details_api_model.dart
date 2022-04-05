import 'result.dart';

class EventDetailsApiModel {
  EventDetailsApiModel({this.status, this.message, this.result});

  factory EventDetailsApiModel.fromJson(Map<String, dynamic> json) {
    return EventDetailsApiModel(
      status: json['status'] as int?,
      message: json['message'] as String?,
      result: (json['result'] as List<dynamic>?)
          ?.map((e) =>
              EventDetailsResultModel.fromJson(Map<String, dynamic>.from(e)))
          .toList(),
    );
  }
  int? status;
  String? message;
  List<EventDetailsResultModel>? result = [];

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'result': result?.map((e) => e.toJson()).toList(),
      };
}
