// import 'result.dart';

// class DashboardUntouchedCasesModel {
//   int? status;
//   String? message;
//   DashboardUntouchedResultModel? result;

//   DashboardUntouchedCasesModel({this.status, this.message, this.result});

//   factory DashboardUntouchedCasesModel.fromJson(Map<String, dynamic> json) {
//     return DashboardUntouchedCasesModel(
//       status: json['status'] as int?,
//       message: json['message'] as String?,
//       result: json['result'] == null
//           ? null
//           : DashboardUntouchedResultModel.fromJson(
//               json['result'] as Map<String, dynamic>),
//     );
//   }

//   Map<String, dynamic> toJson() => {
//         'status': status,
//         'message': message,
//         'result': result?.toJson(),
//       };
// }
