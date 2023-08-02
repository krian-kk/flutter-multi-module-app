class DashboardEventsCaseResults {
  DashboardEventsCaseResults({this.count, this.totalAmt, this.cases});

  factory DashboardEventsCaseResults.fromJson(Map<String, dynamic> json) =>
      DashboardEventsCaseResults(
        count:
            json['count'] != null ? json['count'] as int? : json['totalCount'],
        totalAmt: json['totalAmt'],
        cases: (json['cases'] as List<dynamic>?)
            ?.map((dynamic e) => Case.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
  int? count;
  dynamic totalAmt;
  List<Case>? cases;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'count': count,
        'totalAmt': totalAmt,
        'cases': cases?.map((Case e) => e.toJson()).toList(),
      };
}

class Case {
  Case({
    this.id,
    this.due,
    this.cust,
    this.collSubStatus,
    this.telSubStatus,
    this.agrRef,
    this.bankName,
    this.followUpDate,
    this.fieldfollowUpDate,
    this.customerId,
    this.caseId,
    this.address,
  });

  factory Case.fromJson(Map<String, dynamic> json) => Case(
        id: json['_id'] as String?,
        due: json['due'],
        cust: json['cust'] as String?,
        collSubStatus: json['collSubStatus'] as String?,
        telSubStatus: json['telSubStatus'] ?? '-',
        agrRef: json['agrRef'] ?? '-',
        bankName: json['bankName'] ?? '-',
        followUpDate: json['followUpDate'] as String? ?? '-',
        fieldfollowUpDate: json['fieldfollowUpDate'] as String? ?? '-',
        customerId: json['customerId'] as String?,
        caseId: json['caseId'] as String?,
        address: (json['contact'] as List<dynamic>?)
            ?.map((dynamic e) => Address.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
  String? id;
  dynamic due;
  String? cust;
  String? collSubStatus;
  String? telSubStatus;
  String? agrRef;
  String? bankName;
  String? followUpDate;
  String? fieldfollowUpDate;
  String? customerId;
  String? caseId;
  List<Address>? address;

  Map<String, dynamic> toJson() => <String, dynamic>{
        '_id': id,
        'due': due,
        'cust': cust,
        'collSubStatus': collSubStatus,
        'telSubStatus': telSubStatus,
        'agrRef': agrRef,
        'bankName': bankName,
        'followUpDate': followUpDate,
        'fieldfollowUpDate': fieldfollowUpDate,
        'customerId': customerId,
        'caseId': caseId,
        'address': address?.map((Address e) => e.toJson()).toList(),
      };
}

class Address {
  Address({this.cType, this.value});

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        cType: json['cType'] as String?,
        value: json['value'] as String?,
      );
  String? cType;
  String? value;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'cType': cType,
        'value': value,
      };
}
