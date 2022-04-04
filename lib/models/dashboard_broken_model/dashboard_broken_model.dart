// import 'result.dart';

// class DashboardBrokenModel {
//   int? status;
//   String? message;
//   List<DashboardBrokenPTPResult>? result;

//   DashboardBrokenModel({this.status, this.message, this.result});

//   factory DashboardBrokenModel.fromJson(Map<String, dynamic> json) {
//     return DashboardBrokenModel(
//       status: json['status'] as int?,
//       message: json['message'] as String?,
//       result: (json['result'] as List<dynamic>?)
//           ?.map((e) =>
//               DashboardBrokenPTPResult.fromJson(e as Map<String, dynamic>))
//           .toList(),
//     );
//   }

//   Map<String, dynamic> toJson() => {
//         'status': status,
//         'message': message,
//         'result': result?.map((e) => e.toJson()).toList(),
//       };
// }
