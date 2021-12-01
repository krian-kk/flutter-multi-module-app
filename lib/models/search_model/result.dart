import 'address.dart';

class SearchResultModel {
  String? id;
  int? due;
  String? cust;
  String? accNo;
  String? dpdStr;
  String? collSubStatus;
  String? repoStatus;
  String? followUpDate;
  String? customerId;
  String? pincode;
  String? caseId;
  List<Address>? address;
  bool? starredCase;

  SearchResultModel({
    this.id,
    this.due,
    this.cust,
    this.accNo,
    this.dpdStr,
    this.collSubStatus,
    this.repoStatus,
    this.followUpDate,
    this.customerId,
    this.pincode,
    this.caseId,
    this.address,
    this.starredCase,
  });

  factory SearchResultModel.fromJson(Map<String, dynamic> json) =>
      SearchResultModel(
        id: json['_id'] as String?,
        due: json['due'] as int?,
        cust: json['cust'] as String?,
        accNo: json['accNo'] as String?,
        dpdStr: json['dpdStr'] as String?,
        collSubStatus: json['collSubStatus'] as String?,
        repoStatus: json['repoStatus'] as String?,
        followUpDate: json['followUpDate'] as String?,
        customerId: json['customerId'] as String?,
        pincode: json['pincode'] as String?,
        caseId: json['caseId'] as String?,
        address: (json['address'] as List<dynamic>?)
            ?.map((e) => Address.fromJson(e as Map<String, dynamic>))
            .toList(),
        starredCase: json['starredCase'] as bool?,
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'due': due,
        'cust': cust,
        'accNo': accNo,
        'dpdStr': dpdStr,
        'collSubStatus': collSubStatus,
        'repoStatus': repoStatus,
        'followUpDate': followUpDate,
        'customerId': customerId,
        'pincode': pincode,
        'caseId': caseId,
        'address': address?.map((e) => e.toJson()).toList(),
        'starredCase': starredCase,
      };
}
