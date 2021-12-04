import 'address.dart';

class Case {
  String? id;
  int? due;
  String? cust;
  String? collSubStatus;
  String? followUpDate;
  String? customerId;
  String? caseId;
  List<Address>? address;

  Case({
    this.id,
    this.due,
    this.cust,
    this.collSubStatus,
    this.followUpDate,
    this.customerId,
    this.caseId,
    this.address,
  });

  factory Case.fromJson(Map<String, dynamic> json) => Case(
        id: json['_id'] as String?,
        due: json['due'] as int?,
        cust: json['cust'] as String?,
        collSubStatus: json['collSubStatus'] as String?,
        followUpDate: json['followUpDate'] as String? ?? "-",
        customerId: json['customerId'] as String?,
        caseId: json['caseId'] as String?,
        address: (json['address'] as List<dynamic>?)
            ?.map((e) => Address.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'due': due,
        'cust': cust,
        'collSubStatus': collSubStatus,
        'followUpDate': followUpDate,
        'customerId': customerId,
        'caseId': caseId,
        'address': address?.map((e) => e.toJson()).toList(),
      };
}
