import 'package:hive/hive.dart';
import 'package:origa/models/case_details_api_model/result.dart';

part 'case_details_h_model.g.dart';

@HiveType(typeId: 0)
class CaseDetailsHiveModel extends HiveObject {
  @HiveField(0)
  late int status;

  @HiveField(1)
  late String message;

  @HiveField(2)
  late dynamic result;

  CaseDetailsHiveModel(
      {required this.status, required this.message, required this.result});
}
