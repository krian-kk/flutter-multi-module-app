import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/utils/app_utils.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/widgets/custom_button.dart';
import 'package:origa/widgets/custom_cancel_button.dart';
import 'package:origa/widgets/custom_text.dart';
import 'package:origa/widgets/custom_textfield.dart';

class AccountPasswordMpinScreen extends StatefulWidget {
  final GestureTapCallback submitBtnFunction;
  final String password;
  final String userName;
  final GestureTapCallback forgotPasswordFunction;
  const AccountPasswordMpinScreen({
    Key? key,
    required this.submitBtnFunction,
    required this.password,
    required this.userName,
    required this.forgotPasswordFunction,
  }) : super(key: key);

  @override
  State<AccountPasswordMpinScreen> createState() =>
      _AccountPasswordMpinScreenState();
}

class _AccountPasswordMpinScreenState extends State<AccountPasswordMpinScreen> {
  late TextEditingController contoller;
  late FocusNode focusNode;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    contoller = TextEditingController();
    focusNode = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: SizedBox(
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
              alignment: Alignment.center,
              child: CustomText(
                'Enter your account password to edit 4-digit PIN for ${widget.userName}’s account.',
                fontSize: FontSize.sixteen,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 15),
            CustomTextField(
              Languages.of(context)!.accountPassword,
              contoller,
              isFill: true,
              isBorder: true,
              isLabel: true,
              keyBoardType: TextInputType.emailAddress,
              errorborderColor: ColorResource.color23375A,
              borderColor: ColorResource.color23375A,
              validationRules: const ['required'],
              focusNode: focusNode,
              // onEditing: () {
              //   username.unfocus();
              //   _formKey.currentState!.validate();
              // },
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validatorCallBack: (bool values) {},
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                onTap: () => widget.forgotPasswordFunction(),
                child: CustomText(
                  Languages.of(context)!.forgotPin.toUpperCase(),
                  fontSize: FontSize.sixteen,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(child: CustomCancelButton.cancelButton(context)),
                SizedBox(
                  width: 163,
                  child: CustomButton(
                    Languages.of(context)!.submit.toUpperCase(),
                    fontSize: FontSize.sixteen,
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        if (contoller.text == widget.password) {
                          widget.submitBtnFunction();
                        } else {
                          AppUtils.showToast(Languages.of(context)!
                              .pleaseSelectCorrectPassword);
                        }
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
