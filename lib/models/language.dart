import 'package:json_annotation/json_annotation.dart';
import 'package:origa/utils/selectable.dart';

@JsonSerializable()
class Language extends Selectable {
  String name;
  String languageCode;
  String locationCode;

  Language(this.name, this.languageCode, this.locationCode);

  @override
  // TODO: implement displayName
  String get displayName => name;
}
