import 'package:freezed_annotation/freezed_annotation.dart';

part 'example.freezed.dart';

part 'example.g.dart';

@freezed
@JsonSerializable()
class Example with _$Example {
  const factory Example({
    bool? sendSms,
    bool? cloudTelephony,
    bool? contactMasking,
    bool? showSendRepaymentInfo,
    bool? showCallTriedSmsButton,
    String? repaymentWhatsappTemplate,
    String? sendRepaymentInfoWhatsappTemplateName,
    String? googleMapsApiKey,
  }) = _Example;
}
