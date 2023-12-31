import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../errors/network_exception.dart';

part 'result_state.freezed.dart';

@freezed
abstract class ResultState<T> with _$ResultState<T> {
  const factory ResultState.idle() = Idle<T>;

  const factory ResultState.loading() = Loading<T>;

  const factory ResultState.data({@Default(null) T? data}) = Data<T>;

  const factory ResultState.error({@Default(null) NetworkExceptions? error}) =
      Error<T>;
}
