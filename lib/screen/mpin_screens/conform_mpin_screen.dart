import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/constants.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/widgets/custom_text.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class ConformMpinScreen extends StatefulWidget {
  final GestureTapCallback successFunction;
  final GestureTapCallback forgotPinFunction;
  final String mPin;

  const ConformMpinScreen({
    Key? key,
    required this.successFunction,
    required this.forgotPinFunction,
    required this.mPin,
  }) : super(key: key);

  @override
  State<ConformMpinScreen> createState() => _ConformMpinScreenState();
}

class _ConformMpinScreenState extends State<ConformMpinScreen> {
  late TextEditingController contoller;
  bool isError = false;
  @override
  void initState() {
    contoller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: CustomText(
                    Languages.of(context)!.enterYourSecureFourdDigitPin,
                    fontSize: FontSize.eighteen,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      child: SvgPicture.asset(ImageResource.close),
                    ))
              ]),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: PinCodeTextField(
              appContext: context,
              controller: contoller,
              length: 4,
              mainAxisAlignment: MainAxisAlignment.center,
              obscureText: false,
              animationType: AnimationType.scale,
              onChanged: (value) {
                setState(() => isError = false);
              },
              onCompleted: (value) {
                if (contoller.text == widget.mPin) {
                  Navigator.pop(context);
                  widget.successFunction();
                } else {
                  setState(() => isError = true);
                }
              },
              textStyle: const TextStyle(
                fontSize: FontSize.fourteen,
                color: ColorResource.color23375A,
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.deny(Constants.rEGEXEMOJI),
                FilteringTextInputFormatter.deny(' '),
                FilteringTextInputFormatter.digitsOnly,
              ],
              pinTheme: PinTheme(
                fieldOuterPadding: const EdgeInsets.all(8),
                activeColor: isError
                    ? Colors.red
                    : ColorResource.color7F8EA2.withOpacity(0.3),
                selectedColor: isError
                    ? Colors.red
                    : ColorResource.color23375A.withOpacity(0.3),
                inactiveColor: isError
                    ? Colors.red
                    : ColorResource.color232222.withOpacity(0.3),
                fieldHeight: 46,
                fieldWidth: 38,
                borderWidth: 1,
                errorBorderColor: Colors.red,
              ),
            ),
          ),
          const SizedBox(height: 60),
          GestureDetector(
            onTap: widget.forgotPinFunction,
            child: Container(
              padding: const EdgeInsets.all(2),
              child: CustomText(
                Languages.of(context)!.forgotPin,
                color: ColorResource.color23375A,
                fontSize: FontSize.sixteen,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w600,
              ),
            ),
          )
        ],
      ),
    );
  }
}
