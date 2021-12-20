import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:origa/http/api_repository.dart';
import 'package:origa/http/httpurls.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/models/reset_password_model/reset_password_model.dart';
import 'package:origa/utils/app_utils.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/constants.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/string_resource.dart';
import 'package:origa/widgets/bottomsheet_appbar.dart';
import 'package:origa/widgets/custom_button.dart';
import 'package:origa/widgets/custom_text.dart';
import 'package:origa/widgets/custom_textfield.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);
  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  late Timer? timer = Timer(const Duration(), () {});
  int secondsRemaining = Constants.otpWaitingTime;
  late TextEditingController userIdController = TextEditingController();
  late TextEditingController mobileNumberController = TextEditingController();
  late TextEditingController userNameController = TextEditingController();
  late TextEditingController emailController = TextEditingController();
  late TextEditingController pinCodeController = TextEditingController();
  bool isReset = false;
  bool isSubmit = false;
  bool isSendOTP = true;
  bool isTime = false;

  final _formKey = GlobalKey<FormState>();

  FocusNode userIdFocusNode = FocusNode();
  FocusNode mobileNumberFocusNode = FocusNode();
  FocusNode userNameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode pinCodeFocusNode = FocusNode();

  void secondsOTP() {
    setState(() {
      isTime = true;
    });
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (secondsRemaining != 0) {
        setState(() {
          secondsRemaining--;
        });
      } else {
        setState(() {
          isTime = false;
          secondsRemaining = Constants.otpWaitingTime;
          cancelTimer();
        });
      }
    });
  }

  cancelTimer() {
    if (timer != null) timer!.cancel();
  }

  @override
  void dispose() {
    userIdController.clear();
    mobileNumberController.clear();
    userNameController.clear();
    emailController.clear();
    cancelTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: SizedBox(
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
                  onTap: () {
                    cancelTimer();
                    Navigator.pop(context);
                  },
                ),
                Expanded(
                    child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        CustomTextField(
                          Languages.of(context)!.userId,
                          userIdController,
                          keyBoardType: TextInputType.emailAddress,
                          isFill: true,
                          isBorder: true,
                          isLabel: true,
                          borderColor: ColorResource.colorFFFFFF,
                          focusNode: userIdFocusNode,
                          onEditing: () {
                            userIdFocusNode.unfocus();
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validatorCallBack: (bool values) {},
                          suffixWidget: GestureDetector(
                            onTap: () async {
                              SharedPreferences _prefs =
                                  await SharedPreferences.getInstance();
                              if (userIdController.text ==
                                  _prefs.getString('userName')) {
                                setState(() {
                                  mobileNumberController.text =
                                      _prefs.getString('userName') ?? '';
                                  userNameController.text =
                                      _prefs.getString('accessToken') ?? '';
                                  emailController.text =
                                      _prefs.getString('accessToken') ?? '';
                                });
                              } else {
                                AppUtils.showToast(
                                    Constants.pleaseEnterCorrectUserName);
                              }
                            },
                            child: GestureDetector(
                              onTap: () async {
                                userIdFocusNode.unfocus();
                                Map<String, dynamic> getProfileData =
                                    await APIRepository.apiRequest(
                                        APIRequestType.GET,
                                        HttpUrl.resetPasswordCheckUrl(
                                            userIdController.text));
                                setState(() {
                                  mobileNumberController.text =
                                      getProfileData['data']['data'][0]
                                          ['mobileNumber'];
                                  userNameController.text =
                                      getProfileData['data']['data'][0]
                                          ['Agent_name'];
                                  emailController.text = getProfileData['data']
                                      ['data'][0]['email'];
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: ColorResource.color23375A,
                                  borderRadius: BorderRadius.circular(85),
                                  border: Border.all(
                                      color: ColorResource.colorECECEC,
                                      width: 1.0),
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
                          ),
                        ),
                        const SizedBox(height: 21),
                        CustomTextField(
                          Languages.of(context)!.mobileNumber,
                          mobileNumberController,
                          isFill: true,
                          isBorder: true,
                          isLabel: true,
                          isReadOnly: true,
                          borderColor: ColorResource.colorFFFFFF,
                          maximumWordCount: 10,
                          focusNode: mobileNumberFocusNode,
                          onEditing: () {
                            mobileNumberFocusNode.unfocus();
                            userNameFocusNode.requestFocus();
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validatorCallBack: (bool values) {},
                        ),
                        const SizedBox(height: 20),
                        CustomTextField(
                          Languages.of(context)!.userId,
                          userNameController,
                          isFill: true,
                          isBorder: true,
                          isLabel: true,
                          isReadOnly: true,
                          borderColor: ColorResource.colorFFFFFF,
                          focusNode: userNameFocusNode,
                          onEditing: () {
                            userNameFocusNode.unfocus();
                            emailFocusNode.requestFocus();
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validatorCallBack: (bool values) {},
                        ),
                        const SizedBox(height: 21),
                        CustomTextField(
                          Languages.of(context)!.email,
                          emailController,
                          isFill: true,
                          isReadOnly: true,
                          isBorder: true,
                          isLabel: true,
                          borderColor: ColorResource.colorFFFFFF,
                          keyBoardType: TextInputType.emailAddress,
                          focusNode: emailFocusNode,
                          onChange: () {
                            setState(() {});
                          },
                          onEditing: () {
                            emailFocusNode.unfocus();
                            setState(() {});
                            _formKey.currentState!.validate();
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validatorCallBack: (bool values) {},
                        ),
                        const SizedBox(height: 15),
                        isSendOTP
                            ? const SizedBox()
                            : Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const SizedBox(height: 5),
                                  if (isTime)
                                    CustomText(
                                      StringResource.remainingSeconds(
                                        secondsRemaining,
                                      ),
                                    ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 25.0),
                                    child: PinCodeTextField(
                                      appContext: context,
                                      controller: pinCodeController,
                                      length: 6,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                  const SizedBox(height: 12),
                                  Center(
                                    child: InkWell(
                                      onTap: isTime
                                          ? () {}
                                          : () async {
                                              Map<String, dynamic> postResult =
                                                  await APIRepository
                                                      .apiRequest(
                                                APIRequestType.POST,
                                                HttpUrl.resendOTPUrl(),
                                                requestBodydata: {},
                                              );
                                              if (postResult[
                                                  Constants.success]) {
                                                secondsOTP();
                                              }
                                            },
                                      child: CustomText(
                                        Languages.of(context)!
                                            .resendOTP
                                            .toUpperCase(),
                                        isUnderLine: true,
                                        color: isTime
                                            ? ColorResource.color23375A
                                                .withOpacity(0.5)
                                            : ColorResource.color23375A,
                                        fontSize: FontSize.sixteen,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 30),
                                ],
                              ),
                        isSendOTP
                            ? CustomButton(
                                Languages.of(context)!.sendOTP.toUpperCase(),
                                buttonBackgroundColor: (userIdController
                                                .text.isNotEmpty &&
                                            mobileNumberController
                                                .text.isNotEmpty &&
                                            userNameController
                                                .text.isNotEmpty &&
                                            emailController.text.isNotEmpty) &&
                                        (userIdController.text != '' &&
                                            mobileNumberController.text != '' &&
                                            userNameController.text != '' &&
                                            emailController.text != '')
                                    ? ColorResource.color23375A
                                    : ColorResource.colorBEC4CF,
                                borderColor:
                                    (userIdController.text.isNotEmpty &&
                                                mobileNumberController
                                                    .text.isNotEmpty &&
                                                userNameController
                                                    .text.isNotEmpty &&
                                                emailController
                                                    .text.isNotEmpty) &&
                                            (userIdController.text != '' &&
                                                mobileNumberController.text !=
                                                    '' &&
                                                userNameController.text != '' &&
                                                emailController.text != '')
                                        ? ColorResource.color23375A
                                        : ColorResource.colorBEC4CF,
                                onTap: (userIdController.text.isNotEmpty ||
                                        mobileNumberController
                                            .text.isNotEmpty ||
                                        userNameController.text.isNotEmpty ||
                                        emailController.text.isNotEmpty)
                                    ? () async {
                                        Map<String, dynamic> postResult =
                                            await APIRepository.apiRequest(
                                          APIRequestType.POST,
                                          HttpUrl.requestOTPUrl(),
                                          requestBodydata: {},
                                        );
                                        if (await postResult[
                                            Constants.success]) {
                                          setState(() {
                                            isSendOTP = false;
                                            isTime = true;
                                            secondsOTP();
                                          });
                                        } else {}
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
                                borderColor:
                                    (pinCodeController.text.isNotEmpty &&
                                            pinCodeController.text.length == 6)
                                        ? ColorResource.color23375A
                                        : ColorResource.colorBEC4CF,
                                onTap: (pinCodeController.text.isNotEmpty &&
                                        pinCodeController.text.length == 6)
                                    ? () {
                                        cancelTimer();
                                        resetPasswordShowBottomSheet();
                                      }
                                    : () {},
                                cardShape: 85,
                                fontSize: FontSize.sixteen,
                                fontWeight: FontWeight.w600,
                              ),
                        const SizedBox(height: 20),
                        CustomButton(
                          Languages.of(context)!.clear.toUpperCase(),
                          onTap: () {
                            userIdController.clear();
                            mobileNumberController.clear();
                            userNameController.clear();
                            emailController.clear();
                          },
                          borderColor: ColorResource.color23375A,
                          cardShape: 85,
                          fontSize: FontSize.sixteen,
                          fontWeight: FontWeight.w600,
                          textColor: ColorResource.color23375A,
                          buttonBackgroundColor: ColorResource.colorffffff,
                        ),
                      ],
                    ),
                  ),
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  resetPasswordShowBottomSheet() {
    TextEditingController newPasswordController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();
    FocusNode newPasswordFocusNode = FocusNode();
    FocusNode confirmPasswordFocusNode = FocusNode();
    final formKey = GlobalKey<FormState>();

    showModalBottomSheet(
        context: context,
        isDismissible: false,
        enableDrag: false,
        isScrollControlled: true,
        backgroundColor: ColorResource.colorF8F9FB,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        builder: (BuildContext context) => StatefulBuilder(
            builder: (BuildContext buildContext, StateSetter setState) =>
                WillPopScope(
                  onWillPop: () async => false,
                  child: Form(
                    key: formKey,
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.89,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          BottomSheetAppbar(
                            title: Languages.of(context)!
                                .resetPassword
                                .toUpperCase(),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CustomTextField(
                                    Languages.of(context)!.enterNewPassword,
                                    newPasswordController,
                                    isFill: true,
                                    isBorder: true,
                                    isLabel: true,
                                    borderColor: ColorResource.colorFFFFFF,
                                    validationRules: const ['required'],
                                    maximumWordCount: 10,
                                    focusNode: newPasswordFocusNode,
                                    onEditing: () {
                                      mobileNumberFocusNode.unfocus();
                                      userNameFocusNode.requestFocus();
                                    },
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validatorCallBack: (bool values) {},
                                  ),
                                  const SizedBox(height: 20),
                                  CustomTextField(
                                    Languages.of(context)!
                                        .enterConfirmNewPassword,
                                    confirmPasswordController,
                                    isFill: true,
                                    isBorder: true,
                                    isLabel: true,
                                    borderColor: ColorResource.colorFFFFFF,
                                    validationRules: const ['required'],
                                    maximumWordCount: 10,
                                    focusNode: confirmPasswordFocusNode,
                                    onEditing: () {
                                      mobileNumberFocusNode.unfocus();
                                      userNameFocusNode.requestFocus();
                                    },
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validatorCallBack: (bool values) {},
                                  ),
                                  const SizedBox(height: 20),
                                  const Spacer(),
                                  CustomButton(
                                    Languages.of(context)!
                                        .saveNewPassword
                                        .toUpperCase(),
                                    textColor: ColorResource.colorFFFFFF,
                                    fontSize: FontSize.sixteen,
                                    fontWeight: FontWeight.w700,
                                    padding: 15.0,
                                    cardShape: 75.0,
                                    onTap: () async {
                                      formKey.currentState!.validate();
                                      if (newPasswordController.text ==
                                          confirmPasswordController.text) {
                                        var requestBodyData =
                                            ResetPasswordModel(
                                                otp: pinCodeController.text,
                                                username:
                                                    userNameController.text,
                                                newPassword:
                                                    newPasswordController.text);
                                        Map<String, dynamic> postResult =
                                            await APIRepository.apiRequest(
                                                APIRequestType.POST,
                                                HttpUrl.resendPasswordUrl(),
                                                requestBodydata: jsonEncode(
                                                    requestBodyData.toJson()));
                                        if (postResult[Constants.success]) {
                                          AppUtils.topSnackBar(context,
                                              Constants.successfullySubmitted);
                                          Navigator.pop(context);
                                        }
                                      } else {
                                        AppUtils.showToast(
                                            'Please Enter Correct Password');
                                      }
                                    },
                                    borderColor: ColorResource.colorBEC4CF,
                                    buttonBackgroundColor:
                                        ColorResource.color23375A,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )));
  }
}
