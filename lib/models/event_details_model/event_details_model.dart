import 'result.dart';

class EventDetailsModel {
  int? status;
  String? message;
  List<EvnetDetailsResultsModel>? result;

  EventDetailsModel({this.status, this.message, this.result});

  factory EventDetailsModel.fromJson(Map<String, dynamic> json) {
    return EventDetailsModel(
      status: json['status'] as int?,
      message: json['message'] as String?,
      result: (json['result'] as List<dynamic>?)
          ?.map((e) =>
              EvnetDetailsResultsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'result': result?.map((e) => e.toJson()).toList(),
      };
}
