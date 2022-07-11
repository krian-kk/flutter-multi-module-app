import 'result.dart';

// class EventDetailsModel {
//   EventDetailsModel({this.status, this.message, this.result});

//   factory EventDetailsModel.fromJson(Map<String, dynamic> json) {
//     return EventDetailsModel(
//       status: json['status'] as int?,
//       message: json['message'] as String?,
//       result: json['result'].forEach((v) {
//         result!.add(new Result.fromJson(v));
//       })
//     );
//   }
//   int? status;
//   String? message;
//   List<Result>? result;

//   Map<String, dynamic> toJson() => <String, dynamic>{
//         'status': status,
//         'message': message,
//         'result':
//             result?.map((EvnetDetailsResultsModel e) => e.toJson()).toList(),
//       };
// }

class EventDetailsModel {
  EventDetailsModel({this.status, this.message, this.result});

  EventDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(Result.fromJson(v));
      });
    }
  }

  int? status;
  String? message;
  List<Result>? result;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    if (result != null) {
      data['result'] = result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  Result({this.month, this.eventList});

  Result.fromJson(Map<String, dynamic> json) {
    month = json['month'];
    if (json['eventList'] != null) {
      eventList = <EvnetDetailsResultsModel>[];
      json['eventList'].forEach((v) {
        eventList!.add(EvnetDetailsResultsModel.fromJson(v));
      });
    }
  }

  String? month;
  List<EvnetDetailsResultsModel>? eventList;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['month'] = month;
    if (eventList != null) {
      data['eventList'] = eventList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
