import 'package:json_annotation/json_annotation.dart';
import 'package:origa/http/response/base_response.dart';

part 'generic_response.g.dart';

@JsonSerializable()
class GenericResponse extends BaseResponse {
  // ignore: avoid_positional_boolean_parameters
  GenericResponse(int status, String message, String error)
      : super(
          status,
          message,
          error,
        );

  factory GenericResponse.fromJson(Map<String, dynamic> json) =>
      _$GenericResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GenericResponseToJson(this);
}
