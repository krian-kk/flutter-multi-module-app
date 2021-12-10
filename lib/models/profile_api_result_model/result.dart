import 'package:origa/models/profile_api_result_model/address.dart';

import 'audit.dart';
import 'contact.dart';

class ProfileResultModel {
  String? id;
  String? aRef;
  String? profileImgUrl;
  List<dynamic>? areaCode;
  Audit? audit;
  List<dynamic>? children;
  String? contractor;
  dynamic dateJoining;
  dynamic dateResign;
  String? defMobileNumber;
  String? name;
  String? parent;
  String? roleLevel;
  String? status;
  String? type;
  bool? userAdmin;
  int? failedLoginCounter;
  List<dynamic>? address;
  // List<Contact>? contact;
  // String? webLogin;
  // dynamic aId;
  // dynamic aclId;
  // dynamic parentId;
  // int? lastOtp;

  ProfileResultModel({
    this.id,
    this.areaCode,
    this.aRef,
    this.profileImgUrl,
    this.name,
    this.type,
    this.contractor,
    this.status,
    this.children,
    this.audit,
    // this.contact,
    // this.webLogin,
    this.dateJoining,
    this.dateResign,
    this.defMobileNumber,
    this.roleLevel,
    // this.aId,
    // this.aclId,
    this.parent,
    // this.parentId,
    // this.lastOtp,
    this.userAdmin,
    this.failedLoginCounter,
    this.address,
  });

  factory ProfileResultModel.fromJson(Map<String, dynamic> json) =>
      ProfileResultModel(
        id: json['_id'] as String?,
        areaCode: json['areaCode'] as List<dynamic>?,
        aRef: json['aRef'] as String?,
        profileImgUrl: json['profileImgUrl'] as String?,
        name: json['name'] as String?,
        type: json['type'] as String?,
        contractor: json['contractor'] as String?,
        status: json['status'] as String?,
        children: json['children'] as List<dynamic>?,
        audit: json['audit'] == null
            ? null
            : Audit.fromJson(Map<String, dynamic>.from(json['audit'])),
        // contact: (json['contact'] as List<dynamic>?)
        //     ?.map((e) => Contact.fromJson(Map<String, dynamic>.from(e)))
        //     .toList(),
        // webLogin: json['webLogin'] as String?,
        dateJoining: json['dateJoining'] as dynamic,
        dateResign: json['dateResign'] as dynamic,
        defMobileNumber: json['defMobileNumber'] as String?,
        roleLevel: json['roleLevel'] as String?,
        // aId: json['aId'] as dynamic,
        // aclId: json['aclId'] as dynamic,
        parent: json['parent'] as String?,
        // parentId: json['parentId'] as dynamic,
        // lastOtp: json['lastOtp'] as int?,
        userAdmin: json['userAdmin'] as bool?,
        failedLoginCounter: json['failedLoginCounter'] as int?,
        address: json['address'] as List<dynamic>?,
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'areaCode': areaCode,
        'aRef': aRef,
        'profileImgUrl': profileImgUrl,
        'name': name,
        'type': type,
        'contractor': contractor,
        'status': status,
        'children': children,
        'audit': audit?.toJson(),
        // 'contact': contact?.map((e) => e.toJson()).toList(),
        // 'webLogin': webLogin,
        'dateJoining': dateJoining,
        'dateResign': dateResign,
        'defMobileNumber': defMobileNumber,
        'roleLevel': roleLevel,
        // 'aId': aId,
        // 'aclId': aclId,
        'parent': parent,
        // 'parentId': parentId,
        // 'lastOtp': lastOtp,
        'userAdmin': userAdmin,
        'failedLoginCounter': failedLoginCounter,
        'address': address,
      };
}
