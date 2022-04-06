import 'result.dart';

class EventDetailsApiModel {
  EventDetailsApiModel({this.status, this.message, this.result});

  factory EventDetailsApiModel.fromJson(Map<String, dynamic> json) {
    return EventDetailsApiModel(
      status: json['status'] as int?,
      message: json['message'] as String?,
      result: (json['result'] as List<dynamic>?)
          ?.map((dynamic e) =>
              EventDetailsResultModel.fromJson(Map<String, dynamic>.from(e)))
          .toList(),
    );
  }
  int? status;
  String? message;
  List<EventDetailsResultModel>? result = <EventDetailsResultModel>[];

  Map<String, dynamic> toJson() => <String, dynamic>{
        'status': status,
        'message': message,
        'result':
            result?.map((EventDetailsResultModel e) => e.toJson()).toList(),
      };
}
