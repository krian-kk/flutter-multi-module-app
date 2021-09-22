import 'package:json_annotation/json_annotation.dart';
import 'package:origa/utils/selectable.dart';

@JsonSerializable()
class Bank extends Selectable {
  String id;
  String name;
  Bank(this.id, this.name);

  @override
  // TODO: implement displayName
  String get displayName => name;
}
