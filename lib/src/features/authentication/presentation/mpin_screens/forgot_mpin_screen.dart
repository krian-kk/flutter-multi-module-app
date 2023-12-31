import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:languages/app_languages.dart';
import 'package:origa/listener/item_selected_listener.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/constants.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/widgets/custom_button.dart';
import 'package:origa/widgets/custom_text.dart';
import 'package:origa/widgets/pin_code_text_field_widget.dart';

class ForgotMpinScreen extends StatefulWidget {
  const ForgotMpinScreen({
    Key? key,
    required this.submitOtpFunction,
    required this.userName,
    required this.resendOtpFunction,
  }) : super(key: key);
  final OnChangeBoolFuction submitOtpFunction;
  final GestureTapCallback resendOtpFunction;
  final String userName;

  @override
  State<ForgotMpinScreen> createState() => _ForgotMpinScreenState();
}

class _ForgotMpinScreenState extends State<ForgotMpinScreen> {
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
                    Languages.of(context)!.forgotPin.replaceAll('?', ''),
                    fontSize: FontSize.eighteen,
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
              '${Languages.of(context)!.otpSentRegisterMobile}\n${Languages.of(context)!.enterOTP}',
              fontSize: FontSize.sixteen,
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: PinCodeTextFieldWidget(
              appContext: context,
              controller: controller,
              length: 6,
              mainAxisAlignment: MainAxisAlignment.center,
              animationType: AnimationType.scale,
              onChanged: (String value) {
                setState(() => isError = false);
              },
              onCompleted: (String value) {
                // if (!(contoller.text == "1111")) {
                //   setState(() => isError = true);
                // }
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
                fieldWidth: 20,
                borderWidth: 1,
              ),
            ),
          ),
          const SizedBox(height: 10),
          CustomButton(
            Languages.of(context)!.submitOTP.toUpperCase(),
            fontSize: FontSize.sixteen,
            isEnabled: (controller.text.length > 5),
            onTap: () {
              widget.submitOtpFunction(
                  controller.text, isError, changeIsError());
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
