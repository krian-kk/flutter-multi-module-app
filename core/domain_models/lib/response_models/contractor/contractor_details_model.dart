import 'package:domain_models/response_models/contractor/allocation_templates.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class ContractorResponse {
  ContractorResponse(
      {this.sendSms,
      this.cloudTelephony,
      this.contactMasking,
      this.showSendRepaymentInfo,
      this.showCallTriedSmsButton,
      this.repaymentWhatsappTemplate,
      this.sendRepaymentInfoWhatsappTemplateName,
      this.googleMapsApiKey,
      // this.allocationTemplateConfig
      });

  // ContractorResponse.fromJson(Map<String, dynamic> json) {
  //   sendSms = json['sendSms'];
  //   cloudTelephony = json['cloudTelephony'];
  //   contactMasking = json['contactMasking'];
  //   showSendRepaymentInfo = json['showSendRepaymentInfo'];
  //   showCallTriedSmsButton = json['showCallTriedSmsButton'];
  //   repaymentWhatsappTemplate = json['repaymentWhatsappTemplate'];
  //   sendRepaymentInfoWhatsappTemplateName =
  //       json['sendRepaymentInfoWhatsappTemplateName'];
  //   googleMapsApiKey = json['googleMapsApiKey'];
  //   allocationTemplateConfig =
  //       AllocationTemplateConfig.fromJson(json["allocationTemplateConfig"]);
  // }

  bool? sendSms; 
  bool? cloudTelephony; 
  bool? contactMasking; 
  bool? showSendRepaymentInfo; 
  bool? showCallTriedSmsButton; 
  String? repaymentWhatsappTemplate; 
  String? sendRepaymentInfoWhatsappTemplateName; 
  String? googleMapsApiKey; 
  // AllocationTemplateConfig? allocationTemplateConfig;

// Map<String, dynamic> toJson() {
//   final Map<String, dynamic> data = <String, dynamic>{};
//   data['sendSms'] = sendSms;
//   data['cloudTelephony'] = cloudTelephony;
//   data['contactMasking'] = contactMasking;
//   data['showSendRepaymentInfo'] = showSendRepaymentInfo;
//   data['showCallTriedSmsButton'] = showCallTriedSmsButton;
//   data['repaymentWhatsappTemplate'] = repaymentWhatsappTemplate;
//   data['sendRepaymentInfoWhatsappTemplateName'] =
//       sendRepaymentInfoWhatsappTemplateName;
//   data['googleMapsApiKey'] = googleMapsApiKey;
//   return data;
// }
}
