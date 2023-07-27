import 'package:origa/src/services/network_utils/network_exception.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_result.freezed.dart';

@freezed
abstract class ApiResult<T> with _$ApiResult<T> {
  const factory ApiResult.success({@Default(null) T? data}) = Success<T>;

  const factory ApiResult.failure({@Default(null) NetworkExceptions? error}) =
      Failure<T>;
}
