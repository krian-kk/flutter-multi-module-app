// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'example.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Example _$ExampleFromJson(Map<String, dynamic> json) => Example(
      sendSms: json['sendSms'] as bool?,
      cloudTelephony: json['cloudTelephony'] as bool?,
      contactMasking: json['contactMasking'] as bool?,
      showSendRepaymentInfo: json['showSendRepaymentInfo'] as bool?,
      showCallTriedSmsButton: json['showCallTriedSmsButton'] as bool?,
      repaymentWhatsappTemplate: json['repaymentWhatsappTemplate'] as String?,
      sendRepaymentInfoWhatsappTemplateName:
          json['sendRepaymentInfoWhatsappTemplateName'] as String?,
      googleMapsApiKey: json['googleMapsApiKey'] as String?,
    );

Map<String, dynamic> _$ExampleToJson(Example instance) => <String, dynamic>{
      'sendSms': instance.sendSms,
      'cloudTelephony': instance.cloudTelephony,
      'contactMasking': instance.contactMasking,
      'showSendRepaymentInfo': instance.showSendRepaymentInfo,
      'showCallTriedSmsButton': instance.showCallTriedSmsButton,
      'repaymentWhatsappTemplate': instance.repaymentWhatsappTemplate,
      'sendRepaymentInfoWhatsappTemplateName':
          instance.sendRepaymentInfoWhatsappTemplateName,
      'googleMapsApiKey': instance.googleMapsApiKey,
    };
