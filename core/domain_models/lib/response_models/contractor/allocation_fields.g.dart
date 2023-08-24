// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'allocation_fields.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Fields _$FieldsFromJson(Map<String, dynamic> json) => Fields(
      key: json['key'] as String?,
      csvName: json['csvName'] as String?,
      type: json['type'] as String?,
      required: json['required'] as bool?,
      limit: json['limit'] as int?,
      isAttribute: json['isAttribute'] as bool?,
      isActive: json['isActive'] as bool?,
      tableHeader: json['tableHeader'] as String?,
    );

Map<String, dynamic> _$FieldsToJson(Fields instance) => <String, dynamic>{
      'key': instance.key,
      'csvName': instance.csvName,
      'type': instance.type,
      'required': instance.required,
      'limit': instance.limit,
      'isAttribute': instance.isAttribute,
      'isActive': instance.isActive,
      'tableHeader': instance.tableHeader,
    };
