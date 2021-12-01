import 'package:flutter/material.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/widgets/bottomsheet_appbar.dart';
import 'package:origa/widgets/custom_button.dart';
import 'package:origa/widgets/custom_text.dart';
import 'package:origa/widgets/custom_textfield.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);
  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  late TextEditingController userNameFirstController = TextEditingController();
  late TextEditingController mobileNumberController = TextEditingController();
  late TextEditingController userNameSecondController = TextEditingController();
  late TextEditingController emailController = TextEditingController();
  late TextEditingController pinCodeController = TextEditingController();
  bool isReset = false;
  bool isSubmit = false;
  bool isSendOTP = true;

  final _formKey = GlobalKey<FormState>();

  FocusNode userNameFirstFocusNode = FocusNode();
  FocusNode mobileNumberFocusNode = FocusNode();
  FocusNode userNameSecondFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode pinCodeFocusNode = FocusNode();

  @override
  void dispose() {
    userNameFirstController.clear();
    mobileNumberController.clear();
    userNameSecondController.clear();
    emailController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.89,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: true,
        body: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BottomSheetAppbar(
                title: Languages.of(context)!.resetPassword.toUpperCase(),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
              Expanded(
                  child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      CustomTextField(
                        Languages.of(context)!.userName,
                        userNameFirstController,
                        // obscureText: _obscureText,
                        isFill: true,
                        isBorder: true,
                        isLabel: true,
                        borderColor: ColorResource.colorFFFFFF,
                        // errorborderColor: ColorResource.color23375A,
                        validationRules: const ['required'],
                        focusNode: userNameFirstFocusNode,
                        onEditing: () {
                          userNameFirstFocusNode.unfocus();
                          mobileNumberFocusNode.requestFocus();
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        // onChange: (){
                        //    _formKey.currentState!.validate();
                        // },
                        validatorCallBack: (bool values) {},
                        suffixWidget: Container(
                          decoration: BoxDecoration(
                            color: ColorResource.color23375A,
                            borderRadius: BorderRadius.circular(85),
                            border: Border.all(
                                color: ColorResource.colorECECEC, width: 1.0),
                          ),
                          margin: const EdgeInsets.all(12),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 6),
                          child: CustomText(
                            Languages.of(context)!.check,
                            color: ColorResource.colorFFFFFF,
                            lineHeight: 1,
                            fontSize: FontSize.twelve,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(height: 21),
                      CustomTextField(
                        Languages.of(context)!.mobileNumber,
                        mobileNumberController,
                        // obscureText: _obscureText,
                        isFill: true,
                        isBorder: true,
                        isLabel: true,
                        borderColor: ColorResource.colorFFFFFF,
                        // errorborderColor: ColorResource.color23375A,
                        validationRules: const ['required'],
                        focusNode: mobileNumberFocusNode,
                        onEditing: () {
                          mobileNumberFocusNode.unfocus();
                          userNameSecondFocusNode.requestFocus();
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        // onChange: (){
                        //    _formKey.currentState!.validate();
                        // },
                        validatorCallBack: (bool values) {},
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        Languages.of(context)!.userName,
                        userNameSecondController,
                        // obscureText: _obscureText,
                        isFill: true,
                        isBorder: true,
                        isLabel: true,
                        borderColor: ColorResource.colorFFFFFF,
                        // errorborderColor: ColorResource.color23375A,
                        validationRules: const ['required'],
                        focusNode: userNameSecondFocusNode,
                        onEditing: () {
                          userNameSecondFocusNode.unfocus();
                          emailFocusNode.requestFocus();
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validatorCallBack: (bool values) {},
                      ),
                      const SizedBox(height: 21),
                      CustomTextField(
                        Languages.of(context)!.email,
                        emailController,
                        // obscureText: _obscureText,
                        isFill: true,
                        isBorder: true,
                        isLabel: true,
                        borderColor: ColorResource.colorFFFFFF,
                        // errorborderColor: ColorResource.color23375A,
                        validationRules: const ['required'],
                        focusNode: emailFocusNode,
                        onEditing: () {
                          emailFocusNode.unfocus();
                          _formKey.currentState!.validate();
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validatorCallBack: (bool values) {},
                      ),
                      const SizedBox(height: 20),
                      isSendOTP
                          ? const SizedBox()
                          : Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(height: 5),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25.0),
                                  child: PinCodeTextField(
                                    appContext: context,
                                    controller: pinCodeController,
                                    length: 6,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    obscureText: false,
                                    animationType: AnimationType.scale,
                                    onChanged: (value) {
                                      setState(() {});
                                    },
                                    textStyle: const TextStyle(
                                      fontSize: FontSize.fourteen,
                                      color: ColorResource.color23375A,
                                    ),
                                    keyboardType: TextInputType.number,
                                    pinTheme: PinTheme(
                                      fieldOuterPadding:
                                          const EdgeInsets.all(8),
                                      activeColor: ColorResource.color7F8EA2
                                          .withOpacity(0.3),
                                      selectedColor: ColorResource.color23375A
                                          .withOpacity(0.3),
                                      inactiveColor: ColorResource.color232222
                                          .withOpacity(0.3),
                                      fieldHeight: 46,
                                      fieldWidth: 30,
                                      borderWidth: 1,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 22),
                                Center(
                                  child: CustomText(
                                    Languages.of(context)!
                                        .resendOTP
                                        .toUpperCase(),
                                    isUnderLine: true,
                                    color: ColorResource.color23375A,
                                    fontSize: FontSize.sixteen,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 40),
                              ],
                            ),
                      isSendOTP
                          ? CustomButton(
                              Languages.of(context)!.sendOTP.toUpperCase(),
                              buttonBackgroundColor: (userNameFirstController
                                          .text.isNotEmpty ||
                                      mobileNumberController.text.isNotEmpty ||
                                      userNameSecondController
                                          .text.isNotEmpty ||
                                      emailController.text.isNotEmpty)
                                  ? ColorResource.color23375A
                                  : ColorResource.colorBEC4CF,
                              borderColor: (userNameFirstController
                                          .text.isNotEmpty ||
                                      mobileNumberController.text.isNotEmpty ||
                                      userNameSecondController
                                          .text.isNotEmpty ||
                                      emailController.text.isNotEmpty)
                                  ? ColorResource.color23375A
                                  : ColorResource.colorBEC4CF,
                              onTap: (userNameFirstController.text.isNotEmpty ||
                                      mobileNumberController.text.isNotEmpty ||
                                      userNameSecondController
                                          .text.isNotEmpty ||
                                      emailController.text.isNotEmpty)
                                  ? () {
                                      setState(() {
                                        isSendOTP = false;
                                      });
                                    }
                                  : () {},
                              cardShape: 85,
                              fontSize: FontSize.sixteen,
                              fontWeight: FontWeight.w600,
                            )
                          : CustomButton(
                              Languages.of(context)!.submit.toUpperCase(),
                              buttonBackgroundColor:
                                  (pinCodeController.text.isNotEmpty &&
                                          pinCodeController.text.length == 6)
                                      ? ColorResource.color23375A
                                      : ColorResource.colorBEC4CF,
                              borderColor: (pinCodeController.text.isNotEmpty &&
                                      pinCodeController.text.length == 6)
                                  ? ColorResource.color23375A
                                  : ColorResource.colorBEC4CF,
                              onTap: (pinCodeController.text.isNotEmpty &&
                                      pinCodeController.text.length == 6)
                                  ? () {
                                      Navigator.pop(context);
                                    }
                                  : () {},
                              cardShape: 85,
                              fontSize: FontSize.sixteen,
                              fontWeight: FontWeight.w600,
                            ),
                    ],
                  ),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
