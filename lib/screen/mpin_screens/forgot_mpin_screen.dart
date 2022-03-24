import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/listener/item_selected_listener.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/constants.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/widgets/custom_button.dart';
import 'package:origa/widgets/custom_text.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class ForgotMpinScreen extends StatefulWidget {
  final OnChangeBoolFuction submitOtpFunction;
  final GestureTapCallback resendOtpFunction;
  final String userName;
  const ForgotMpinScreen({
    Key? key,
    required this.submitOtpFunction,
    required this.userName,
    required this.resendOtpFunction,
  }) : super(key: key);

  @override
  State<ForgotMpinScreen> createState() => _ForgotMpinScreenState();
}

class _ForgotMpinScreenState extends State<ForgotMpinScreen> {
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: CustomText(
                    Languages.of(context)!.forgotPin.replaceAll('?', ''),
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
          Align(
            alignment: Alignment.centerLeft,
            child: CustomText(
              Languages.of(context)!.enterOTP,
              fontSize: FontSize.sixteen,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 20),
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
                // if (!(contoller.text == "1111")) {
                //   setState(() => isError = true);
                // }
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
                fieldWidth: 37,
                borderWidth: 1,
              ),
            ),
          ),
          const SizedBox(height: 10),
          CustomButton(
            Languages.of(context)!.submitOTP.toUpperCase(),
            fontSize: FontSize.sixteen,
            isEnabled: (contoller.text.length > 3),
            onTap: () {
              widget.submitOtpFunction(
                  contoller.text, isError, changeIsError());
              // showNewMpinDialogBox();
              // Navigator.pop(context);
            },
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: widget.resendOtpFunction,
            child: Container(
              padding: const EdgeInsets.all(2),
              child: CustomText(
                Languages.of(context)!.resendOTP,
                color: ColorResource.color23375A,
                fontSize: FontSize.sixteen,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w600,
                isUnderLine: true,
              ),
            ),
          )
        ],
      ),
    );
  }

  changeIsError() {
    setState(() => isError = true);
  }
}
