import 'result.dart';

class EventDetailsModel {
  EventDetailsModel({this.status, this.message, this.result});

  factory EventDetailsModel.fromJson(Map<String, dynamic> json) {
    return EventDetailsModel(
      status: json['status'] as int?,
      message: json['message'] as String?,
      result: (json['result'] as List<dynamic>?)
          ?.map((dynamic e) =>
              EvnetDetailsResultsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
  int? status;
  String? message;
  List<EvnetDetailsResultsModel>? result;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'status': status,
        'message': message,
        'result':
            result?.map((EvnetDetailsResultsModel e) => e.toJson()).toList(),
      };
}
