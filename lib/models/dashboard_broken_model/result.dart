import 'address.dart';

class DashboardBrokenPTPResult {
  DashboardBrokenPTPResult({
    this.id,
    this.due,
    this.starredCase,
    this.cust,
    this.collSubStatus,
    this.followUpPriority,
    this.customerId,
    this.pincode,
    this.caseId,
    this.fieldfollowUpDate,
    this.sortId,
    this.address,
  });

  factory DashboardBrokenPTPResult.fromJson(Map<String, dynamic> json) =>
      DashboardBrokenPTPResult(
        id: json['_id'] as String?,
        due: json['due'] as int?,
        starredCase: json['starredCase'] as bool?,
        cust: json['cust'] as String?,
        collSubStatus: json['collSubStatus'] as String?,
        followUpPriority: json['followUpPriority'] as String?,
        customerId: json['customerId'] as String?,
        pincode: json['pincode'] as String?,
        caseId: json['caseId'] as String?,
        fieldfollowUpDate: json['fieldfollowUpDate'] as String?,
        sortId: json['sortId'] as int?,
        address: (json['address'] as List<dynamic>?)
            ?.map((e) => Address.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
  String? id;
  int? due;
  bool? starredCase;
  String? cust;
  String? collSubStatus;
  String? followUpPriority;
  String? customerId;
  String? pincode;
  String? caseId;
  String? fieldfollowUpDate;
  int? sortId;
  List<Address>? address;

  Map<String, dynamic> toJson() => {
        '_id': id,
        'due': due,
        'starredCase': starredCase,
        'cust': cust,
        'collSubStatus': collSubStatus,
        'followUpPriority': followUpPriority,
        'customerId': customerId,
        'pincode': pincode,
        'caseId': caseId,
        'fieldfollowUpDate': fieldfollowUpDate,
        'sortId': sortId,
        'address': address?.map((e) => e.toJson()).toList(),
      };
}
