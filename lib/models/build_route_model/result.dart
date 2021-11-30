import 'case.dart';

class BuildRouteResultModel {
  List<Case>? cases;

  BuildRouteResultModel({this.cases});

  factory BuildRouteResultModel.fromJson(Map<String, dynamic> json) =>
      BuildRouteResultModel(
        cases: (json['cases'] as List<dynamic>?)
            ?.map((e) => Case.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'cases': cases?.map((e) => e.toJson()).toList(),
      };
}
