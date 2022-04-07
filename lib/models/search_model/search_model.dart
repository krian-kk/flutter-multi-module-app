// import 'result.dart';

// class SearchModel {
//   int? status;
//   String? message;
//   List<SearchResultModel>? result;

//   SearchModel({this.status, this.message, this.result});

//   factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
//         status: json['status'] as int?,
//         message: json['message'] as String?,
//         result: (json['result'] as List<dynamic>?)
//             ?.map((e) => SearchResultModel.fromJson(e as Map<String, dynamic>))
//             .toList(),
//       );

//   Map<String, dynamic> toJson() => {
//         'status': status,
//         'message': message,
//         'result': result?.map((e) => e.toJson()).toList(),
//       };
// }
