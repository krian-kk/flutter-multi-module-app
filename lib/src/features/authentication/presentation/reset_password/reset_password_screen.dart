import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:languages/app_languages.dart';
import 'package:origa/http/api_repository.dart';
import 'package:origa/http/httpurls.dart';
import 'package:origa/models/reset_password_model/reset_password_model.dart';
import 'package:origa/src/features/authentication/bloc/sign_in_bloc.dart';
import 'package:origa/src/features/authentication/bloc/sign_in_event.dart';
import 'package:origa/src/features/authentication/bloc/sign_in_state.dart';
import 'package:origa/utils/app_utils.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/constants.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/string_resource.dart';
import 'package:origa/widgets/bottomsheet_appbar.dart';
import 'package:origa/widgets/custom_button.dart';
import 'package:origa/widgets/custom_loading_widget.dart';
import 'package:origa/widgets/custom_text.dart';
import 'package:origa/widgets/custom_textfield.dart';
import 'package:origa/widgets/pin_code_text_field_widget.dart';

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
  bool isEnableResendOtp = true;
  int sendOtpTapCount = 0;

  bool isCheck = true;
  bool isSaveNewPasswordLoad = true;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  FocusNode userIdFocusNode = FocusNode();
  FocusNode mobileNumberFocusNode = FocusNode();
  FocusNode userNameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode pinCodeFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

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
    if (timer != null) {
      timer!.cancel();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: BlocProvider.of<SignInBloc>(context),
      listener: (BuildContext context, state) {
        if (state is FillAgentInfoForResetPassword) {
          {
            setState(() {
              mobileNumberController.text =
                  state.agentDetails.mobile.toString();
              emailController.text = state.agentDetails.email.toString();
              userNameController.text = state.agentDetails.name.toString();
            });
          }
          setState(() => isCheck = true);
        }
        if (state is SendOtpSuccessState) {
          setState(() {
            isSendOTP = false;
            sendOtpTapCount++;
            isTime = true;
            secondsOTP();
          });
        }
      },
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.89,
        child: Scaffold(
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: true,
          body: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                BottomSheetAppbar(
                  title: Languages.of(context)!.resetPassword,
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
                      children: <Widget>[
                        CustomTextField(
                          Languages.of(context)!.userId,
                          userIdController,
                          keyBoardType: TextInputType.emailAddress,
                          isFill: true,
                          isBorder: true,
                          isLabel: true,
                          borderColor: ColorResource.colorFFFFFF,
                          focusNode: userIdFocusNode,
                          onChange: () {
                            setState(() {
                              mobileNumberController.clear();
                              userNameController.clear();
                              emailController.clear();
                              // isSendOTP = true;
                            });
                          },
                          onEditing: () {
                            userIdFocusNode.unfocus();
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validatorCallBack: (bool values) {},
                          validationRules: const ['required'],
                          suffixWidget: GestureDetector(
                            onTap: isCheck
                                ? () async {
                                    if (_formKey.currentState!.validate()) {
                                      setState(() => isCheck = false);
                                      userIdFocusNode.unfocus();
                                      mobileNumberController.clear();
                                      userNameController.clear();
                                      emailController.clear();
                                      BlocProvider.of<SignInBloc>(context).add(
                                          ResetPasswordClickEvent(
                                              userIdController.text));
                                    }
                                  }
                                : () {},
                            child: Container(
                              decoration: BoxDecoration(
                                color: ColorResource.color23375A,
                                borderRadius: BorderRadius.circular(85),
                                border: Border.all(
                                    color: ColorResource.colorECECEC),
                              ),
                              margin: const EdgeInsets.all(12),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 6),
                              child: isCheck
                                  ? CustomText(
                                      Languages.of(context)!.check,
                                      color: ColorResource.colorFFFFFF,
                                      lineHeight: 1,
                                      fontSize: FontSize.twelve,
                                      fontWeight: FontWeight.w700,
                                    )
                                  : const Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 10.0,
                                      ),
                                      child: SizedBox(
                                        width: 15,
                                        height: 10,
                                        child: CircularProgressIndicator(
                                          color: ColorResource.colorFFFFFF,
                                          strokeWidth: 1,
                                        ),
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
                          Languages.of(context)!.userName,
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
                            setState(() {});
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validatorCallBack: (bool values) {},
                        ),
                        const SizedBox(height: 15),
                        isSendOTP
                            ? const SizedBox()
                            : Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
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
                                    child: PinCodeTextFieldWidget(
                                      appContext: context,
                                      controller: pinCodeController,
                                      length: 6,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      animationType: AnimationType.scale,
                                      onChanged: (String value) {
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
                                        fieldWidth: 28,
                                        borderWidth: 1,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Visibility(
                                    visible: isEnableResendOtp,
                                    child: Center(
                                      child: InkWell(
                                        onTap: isTime
                                            ? () {}
                                            : () async {
                                                BlocProvider.of<SignInBloc>(
                                                        context)
                                                    .add(SendOtpToServerEvent(
                                                        userIdController.text));
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
                                                .text.isNotEmpty) &&
                                        (userIdController.text != '' &&
                                            mobileNumberController.text != '' &&
                                            userNameController.text != ''
                                        // emailController.text != ''
                                        )
                                    ? ColorResource.color23375A
                                    : ColorResource.colorBEC4CF,
                                textColor: (userIdController.text.isNotEmpty &&
                                            mobileNumberController
                                                .text.isNotEmpty &&
                                            userNameController
                                                .text.isNotEmpty) &&
                                        (userIdController.text != '' &&
                                            mobileNumberController.text != '' &&
                                            userNameController.text != ''
                                        // emailController.text != ''
                                        )
                                    ? ColorResource.colorFFFFFF
                                    : ColorResource.color23375A,
                                borderColor: (userIdController
                                                .text.isNotEmpty &&
                                            mobileNumberController
                                                .text.isNotEmpty &&
                                            userNameController
                                                .text.isNotEmpty) &&
                                        // emailController
                                        //     .text.isNotEmpty) &&
                                        (userIdController.text != '' &&
                                            mobileNumberController.text != '' &&
                                            userNameController.text != '')
                                    ? ColorResource.color23375A
                                    : ColorResource.colorBEC4CF,
                                onTap: (userIdController.text.isNotEmpty ||
                                        mobileNumberController
                                            .text.isNotEmpty ||
                                        userNameController.text.isNotEmpty
                                    // ||
                                    // emailController.text.isNotEmpty
                                    )
                                    ? () {
                                        BlocProvider.of<SignInBloc>(context)
                                            .add(SendOtpToServerEvent(
                                                userIdController.text));
                                      }
                                    : () {},
                                cardShape: 85,
                                fontSize: FontSize.sixteen,
                              )
                            : CustomButton(
                                Languages.of(context)!.submit.toUpperCase(),
                                buttonBackgroundColor:
                                    (pinCodeController.text.isNotEmpty &&
                                            pinCodeController.text.length == 6)
                                        ? ColorResource.color23375A
                                        : ColorResource.colorBEC4CF,
                                textColor: (pinCodeController.text.isNotEmpty &&
                                        pinCodeController.text.length == 6)
                                    ? ColorResource.colorFFFFFF
                                    : ColorResource.color23375A,
                                borderColor:
                                    (pinCodeController.text.isNotEmpty &&
                                            pinCodeController.text.length == 6)
                                        ? ColorResource.color23375A
                                        : ColorResource.colorBEC4CF,
                                onTap: (pinCodeController.text.isNotEmpty &&
                                        pinCodeController.text.length == 6)
                                    ? () async {
                                        if (userNameController
                                            .text.isNotEmpty) {
                                          BlocProvider.of<SignInBloc>(context)
                                              .add(VerifyOtpEvent(
                                                  userIdController.text,
                                                  pinCodeController.text));
                                        }
                                      }
                                    : () {},
                                cardShape: 85,
                                fontSize: FontSize.sixteen,
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

  static const MethodChannel platform = MethodChannel('recordAudioChannel');

  resetPasswordShowBottomSheet(String name) {
    final TextEditingController newPasswordController = TextEditingController();
    final TextEditingController confirmPasswordController =
        TextEditingController();
    final FocusNode newPasswordFocusNode = FocusNode();
    final FocusNode confirmPasswordFocusNode = FocusNode();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
            builder: (BuildContext buildContext, StateSetter setState) => Form(
                  key: formKey,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.89,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        BottomSheetAppbar(
                          title: Languages.of(context)!.resetPassword,
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
                              children: <Widget>[
                                CustomTextField(
                                  Languages.of(context)!.enterNewPassword,
                                  newPasswordController,
                                  obscureText: true,
                                  isFill: true,
                                  isBorder: true,
                                  isLabel: true,
                                  errorMaxLine: 5,
                                  borderColor: ColorResource.colorFFFFFF,
                                  validationRules: const <String>['password'],
                                  // maximumWordCount: 10,
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
                                  obscureText: true,
                                  isFill: true,
                                  isBorder: true,
                                  isLabel: true,
                                  borderColor: ColorResource.colorFFFFFF,
                                  validationRules: const <String>['required'],
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
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 50),
                                  child: CustomButton(
                                    isSaveNewPasswordLoad
                                        ? Languages.of(context)!
                                            .saveNewPassword
                                            .toUpperCase()
                                        : null,
                                    isLeading: !isSaveNewPasswordLoad,
                                    trailingWidget: CustomLoadingWidget(
                                      gradientColors: <Color>[
                                        ColorResource.colorFFFFFF,
                                        ColorResource.colorFFFFFF
                                            .withOpacity(0.7),
                                      ],
                                    ),
                                    fontSize: FontSize.sixteen,
                                    fontWeight: FontWeight.w700,
                                    padding: 15.0,
                                    cardShape: 75.0,
                                    onTap: isSaveNewPasswordLoad
                                        ? () async {
                                            if (formKey.currentState!
                                                .validate()) {
                                              if (newPasswordController.text ==
                                                  confirmPasswordController
                                                      .text) {
                                                setState(() =>
                                                    isSaveNewPasswordLoad =
                                                        false);
                                                final ResetPasswordModel
                                                    requestBodyData =
                                                    ResetPasswordModel(
                                                        otp: pinCodeController
                                                            .text,
                                                        username: name,
                                                        newPassword:
                                                            newPasswordController
                                                                .text);
                                                final Map<String, dynamic>
                                                    requestData = {
                                                  'data': jsonEncode(
                                                      requestBodyData)
                                                };
                                                String text =
                                                    await platform.invokeMethod(
                                                        'sendEncryptedData',
                                                        requestData);
                                                final Map<String, dynamic>
                                                    postResult =
                                                    await APIRepository.apiRequest(
                                                        APIRequestType.post,
                                                        HttpUrl
                                                            .resetPasswordUrl(),
                                                        requestBodydata: {
                                                      'encryptedData': text
                                                    });
                                                if (postResult[
                                                    Constants.success]) {
                                                  AppUtils.topSnackBar(
                                                      context,
                                                      Constants
                                                          .successfullyUpdated);
                                                  await Future<dynamic>.delayed(
                                                      const Duration(
                                                          seconds: 2));
                                                  Navigator.pop(context);
                                                }
                                              } else {
                                                AppUtils.showToast(
                                                  Languages.of(context)!
                                                      .pleaseSelectCorrectPassword,
                                                );
                                              }
                                              setState(() =>
                                                  isSaveNewPasswordLoad = true);
                                            }
                                          }
                                        : () {},
                                    borderColor: ColorResource.colorBEC4CF,
                                    buttonBackgroundColor:
                                        ColorResource.color23375A,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )));
  }
}
