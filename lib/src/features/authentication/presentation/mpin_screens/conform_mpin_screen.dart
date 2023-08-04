import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/utils/app_utils.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/constants.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/widgets/custom_text.dart';
import 'package:origa/widgets/pin_code_text_field_widget.dart';

class ConformMpinScreen extends StatefulWidget {
  const ConformMpinScreen(
      {Key? key,
      required this.successFunction,
      required this.forgotPinFunction,
      required this.mPin,
      this.popFunction,
      this.canPopWidget = false})
      : super(key: key);
  final GestureTapCallback successFunction;
  final GestureTapCallback forgotPinFunction;
  final GestureTapCallback? popFunction;
  final String mPin;
  final bool canPopWidget;

  @override
  State<ConformMpinScreen> createState() => _ConformMpinScreenState();
}

class _ConformMpinScreenState extends State<ConformMpinScreen> {
  late TextEditingController controller;
  bool isError = false;

  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: CustomText(
                    Languages.of(context)!.enterYourSecureFourdDigitPin,
                    fontSize: FontSize.eighteen,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                if (widget.canPopWidget)
                  InkWell(
                      onTap: () {
                        widget.popFunction!();
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        child: SvgPicture.asset(ImageResource.close),
                      ))
              ]),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: PinCodeTextFieldWidget(
              appContext: context,
              controller: controller,
              length: 4,
              obscureText: true,
              mainAxisAlignment: MainAxisAlignment.center,
              animationType: AnimationType.scale,
              onChanged: (String value) {
                setState(() => isError = false);
              },
              onCompleted: (String value) {
                if (controller.text == widget.mPin) {
                  Navigator.pop(context);
                  widget.successFunction();
                } else {
                  setState(() => isError = true);
                  AppUtils.showErrorToast(Languages.of(context)!.correctMPin);
                }
              },
              textStyle: const TextStyle(
                fontSize: FontSize.fourteen,
                color: ColorResource.color23375A,
              ),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
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
          const SizedBox(height: 40),
          GestureDetector(
            onTap: widget.forgotPinFunction,
            child: Container(
              padding: const EdgeInsets.all(2),
              child: CustomText(
                Languages.of(context)!.forgotPin,
                color: ColorResource.color23375A,
                fontSize: FontSize.sixteen,
                fontWeight: FontWeight.w600,
              ),
            ),
          )
        ],
      ),
    );
  }
}
