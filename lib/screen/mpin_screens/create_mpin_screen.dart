import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/constants.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/widgets/custom_button.dart';
import 'package:origa/widgets/custom_text.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class CreateMpinScreen extends StatefulWidget {
  final GestureTapCallback saveFunction;
  const CreateMpinScreen({Key? key, required this.saveFunction})
      : super(key: key);

  @override
  State<CreateMpinScreen> createState() => _CreateMpinScreenState();
}

class _CreateMpinScreenState extends State<CreateMpinScreen> {
  late TextEditingController contoller;

  bool isError = false;
  @override
  void initState() {
    contoller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: CustomText(
                  Languages.of(context)!
                      .secureYourAccountByCreatingAFourDigitPin,
                  fontSize: FontSize.eighteen,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w700,
                ),
              ),
              InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    // bloc.isSubmit = true;
                    // bloc.isLoading = false;
                  },
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    child: SvgPicture.asset(ImageResource.close),
                  ))
            ]),
        const SizedBox(height: 10),
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
              activeColor: !isError
                  ? ColorResource.color7F8EA2.withOpacity(0.3)
                  : Colors.red,
              selectedColor: !isError
                  ? ColorResource.color23375A.withOpacity(0.3)
                  : Colors.red,
              inactiveColor: !isError
                  ? ColorResource.color232222.withOpacity(0.3)
                  : Colors.red,
              fieldHeight: 46,
              fieldWidth: 38,
              borderWidth: 1,
            ),
          ),
        ),
        const SizedBox(height: 40),
        CustomButton(
          Languages.of(context)!.save,
          fontSize: FontSize.sixteen,
          isEnabled: (contoller.text.length > 3),
          onTap: widget.saveFunction,
        ),
      ],
    );
  }
}
