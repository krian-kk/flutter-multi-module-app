import 'package:json_annotation/json_annotation.dart';
import 'package:origa/utils/selectable.dart';

@JsonSerializable()
class Branch extends Selectable {
  String id;
  String name;
  Branch(this.id, this.name);

  @override
  // TODO: implement displayName
  String get displayName => name;
}
