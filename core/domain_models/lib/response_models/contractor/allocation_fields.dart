import 'package:freezed_annotation/freezed_annotation.dart';

part 'allocation_fields.freezed.dart';

part 'allocation_fields.g.dart';

@freezed
@JsonSerializable()
class Fields with _$Fields {
  const factory Fields(
      {String? key,
      String? csvName,
      String? type,
      bool? required,
      int? limit,
      bool? isAttribute,
      bool? isActive,
      String? tableHeader}) = _Fields;
}
