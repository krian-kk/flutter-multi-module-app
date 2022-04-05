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
import 'package:origa/widgets/pin_code_text_field_widget.dart';

class NewMpinScreen extends StatefulWidget {
  const NewMpinScreen({Key? key, required this.saveFuction}) : super(key: key);
  final OnChange saveFuction;

  @override
  State<NewMpinScreen> createState() => _NewMpinScreenState();
}

class _NewMpinScreenState extends State<NewMpinScreen> {
  late TextEditingController contoller;
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
                    Languages.of(context)!
                        .changeYourSecureDigitPIN
                        .replaceAll('?', ''),
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
            child: CustomText(
              Languages.of(context)!.newPin,
              fontSize: FontSize.sixteen,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: PinCodeTextFieldWidget(
              appContext: context,
              controller: contoller,
              length: 4,
              mainAxisAlignment: MainAxisAlignment.center,
              animationType: AnimationType.scale,
              onChanged: (value) {
                setState(() {});
              },
              textStyle: const TextStyle(
                fontSize: FontSize.fourteen,
                color: ColorResource.color23375A,
              ),
              inputFormatters: [
                FilteringTextInputFormatter.deny(Constants.rEGEXEMOJI),
                FilteringTextInputFormatter.deny(' '),
                FilteringTextInputFormatter.digitsOnly,
              ],
              keyboardType: TextInputType.number,
              pinTheme: PinTheme(
                fieldOuterPadding: const EdgeInsets.all(8),
                activeColor: ColorResource.color7F8EA2.withOpacity(0.3),
                selectedColor: ColorResource.color23375A.withOpacity(0.3),
                inactiveColor: ColorResource.color232222.withOpacity(0.3),
                fieldHeight: 46,
                fieldWidth: 38,
                borderWidth: 1,
              ),
            ),
          ),
          const SizedBox(height: 20),
          CustomButton(
            Languages.of(context)!.save.toUpperCase(),
            fontSize: FontSize.sixteen,
            isEnabled: (contoller.text.length > 3),
            onTap: () => widget.saveFuction(contoller.text),
          ),
        ],
      ),
    );
  }
}
