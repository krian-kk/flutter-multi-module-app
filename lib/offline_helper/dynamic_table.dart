import 'package:hive/hive.dart';

part 'dynamic_table.g.dart';

@HiveType(typeId: 0)
class OrigoDynamicTable extends HiveObject {
  @HiveField(0)
  late int status;

  @HiveField(1)
  late String message;

  @HiveField(2)
  late dynamic result;

  OrigoDynamicTable(
      {required this.status, required this.message, required this.result});
}