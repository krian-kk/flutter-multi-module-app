// class NewEventDetailList {
//   int? status;
//   String? message;
//   List<Result>? result;

//   NewEventDetailList({this.status, this.message, this.result});

//   NewEventDetailList.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     if (json['result'] != null) {
//       result = <Result>[];
//       json['result'].forEach((v) {
//         result!.add(new Result.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     data['message'] = this.message;
//     if (this.result != null) {
//       data['result'] = this.result!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class Result {
//   String? month;
//   List<EventList>? eventList;

//   Result({this.month, this.eventList});

//   Result.fromJson(Map<String, dynamic> json) {
//     month = json['month'];
//     if (json['eventList'] != null) {
//       eventList = <EventList>[];
//       json['eventList'].forEach((v) {
//         eventList!.add(EventList.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['month'] = this.month;
//     if (this.eventList != null) {
//       data['eventList'] = this.eventList!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
