// import 'result.dart';

// class GetCallCustomerStatusModel {
//   int? status;
//   String? message;
//   List<Result>? result;

//   GetCallCustomerStatusModel({this.status, this.message, this.result});

//   factory GetCallCustomerStatusModel.fromJson(Map<String, dynamic> json) {
//     return GetCallCustomerStatusModel(
//       status: json['status'] as int?,
//       message: json['message'] as String?,
//       result: (json['result'] as List<dynamic>?)
//           ?.map((e) => Result.fromJson(e as Map<String, dynamic>))
//           .toList(),
//     );
//   }

//   Map<String, dynamic> toJson() => {
//         'status': status,
//         'message': message,
//         'result': result?.map((e) => e.toJson()).toList(),
//       };
// }
