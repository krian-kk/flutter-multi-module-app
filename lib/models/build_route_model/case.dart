import 'address.dart';

class Case {
  String? id;
  int? due;
  String? cust;
  String? collSubStatus;
  String? followUpPriority;
  String? followUpDate;
  String? customerId;
  String? pincode;
  String? caseId;
  String? locationType;
  int? distanceMeters;
  List<Address>? address;

  Case({
    this.id,
    this.due,
    this.cust,
    this.collSubStatus,
    this.followUpPriority,
    this.followUpDate,
    this.customerId,
    this.pincode,
    this.caseId,
    this.locationType,
    this.distanceMeters,
    this.address,
  });

  factory Case.fromJson(Map<String, dynamic> json) => Case(
        id: json['_id'] as String?,
        due: json['due'] as int?,
        cust: json['cust'] as String?,
        collSubStatus: json['collSubStatus'] as String?,
        followUpPriority: json['followUpPriority'] as String?,
        followUpDate: json['followUpDate'] as String?,
        customerId: json['customerId'] as String?,
        pincode: json['pincode'] as String?,
        caseId: json['caseId'] as String?,
        locationType: json['locationType'] as String?,
        distanceMeters: json['distanceMeters'] as int?,
        address: (json['address'] as List<dynamic>?)
            ?.map((e) => Address.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'due': due,
        'cust': cust,
        'collSubStatus': collSubStatus,
        'followUpPriority': followUpPriority,
        'followUpDate': followUpDate,
        'customerId': customerId,
        'pincode': pincode,
        'caseId': caseId,
        'locationType': locationType,
        'distanceMeters': distanceMeters,
        'address': address?.map((e) => e.toJson()).toList(),
      };
}
