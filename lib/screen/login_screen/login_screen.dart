import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:origa/authentication/authentication_bloc.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/router.dart';
import 'package:origa/utils/app_utils.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/widgets/bottomsheet_appbar.dart';
import 'package:origa/widgets/custom_button.dart';
import 'package:origa/widgets/custom_text.dart';
import 'package:origa/widgets/custom_textfield.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bloc/login_bloc.dart';

class LoginScreen extends StatefulWidget {
  final AuthenticationBloc authBloc;
  const LoginScreen(this.authBloc, {Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late LoginBloc bloc;

  late TextEditingController userName = TextEditingController();
  late TextEditingController password = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  late FocusNode username;
  late FocusNode passwords;
  bool _obscureText = true;
  bool _isChecked = false;
  String? loginType;

  @override
  void initState() {
    bloc = LoginBloc()..add(LoginInitialEvent());
    username = FocusNode();
    passwords = FocusNode();
    _loadUserNamePassword();
    super.initState();
  }

  // _passwordVisibleOrNot the password show status
  void _passwordVisibleOrNot() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      bloc: bloc,
      listener: (context, state) {
        if (state is HomeTabState) {
          Navigator.pushReplacementNamed(context, AppRoutes.homeTabScreen,
              arguments: loginType);
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        bloc: bloc,
        builder: (context, state) {
          return Scaffold(
            backgroundColor: ColorResource.colorF8F9FB,
            body: SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 35,
                        ),
                        SvgPicture.asset(ImageResource.origa),
                        const SizedBox(
                          height: 17,
                        ),
                        SvgPicture.asset(ImageResource.login),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextField(
                          Languages.of(context)!.userName,
                          userName,
                          isFill: true,
                          isBorder: true,
                          isLabel: true,
                          errorborderColor: ColorResource.color23375A,
                          borderColor: ColorResource.color23375A,
                          validationRules: ['required'],
                          focusNode: username,
                          onEditing: () {
                            username.unfocus();
                            _formKey.currentState!.validate();
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          // onChange: (){
                          //    _formKey.currentState!.validate();
                          // },
                          validatorCallBack: (bool values) {},
                        ),
                        const SizedBox(
                          height: 23,
                        ),
                        CustomTextField(
                          Languages.of(context)!.password,
                          password,
                          obscureText: _obscureText,
                          isFill: true,
                          isBorder: true,
                          isLabel: true,
                          borderColor: ColorResource.color23375A,
                          errorborderColor: ColorResource.color23375A,
                          validationRules: ['required'],
                          focusNode: passwords,
                          onEditing: () {
                            print('object');
                            passwords.unfocus();
                            _formKey.currentState!.validate();
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          // onChange: (){
                          //    _formKey.currentState!.validate();
                          // },
                          validatorCallBack: (bool values) {},
                          suffixWidget: InkWell(
                            onTap: _passwordVisibleOrNot,
                            child: Icon(
                              _obscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: ColorResource.color23375A,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Checkbox(
                                value: _isChecked,
                                activeColor: ColorResource.color23375A,
                                onChanged: (bool? newValue) {
                                  final bool isValid =
                                      _formKey.currentState!.validate();
                                  if (!isValid) {
                                    return;
                                  } else {
                                    _handleRemeberme(newValue!);
                                  }
                                }),
                            CustomText(
                              Languages.of(context)!.rememberMe,
                              color: ColorResource.color23375A,
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomButton(
                          'SIGN IN',
                          buttonBackgroundColor: ColorResource.color23375A,
                          onTap: () {
                            _signIn();
                          },
                          cardShape: 85,
                          fontSize: FontSize.sixteen,
                          fontWeight: FontWeight.w600,
                        ),
                        const SizedBox(
                          height: 17,
                        ),
                        GestureDetector(
                          onTap: () {
                            resendOTPBottomSheet(context);
                            // AppUtils.showToast('Reset Password');
                            // Navigator.push(context, MaterialPageRoute(builder: (context)=>DeviceInfo()));
                          },
                          child: CustomText(
                            'Reset password via OTP',
                            fontSize: FontSize.sixteen,
                            fontWeight: FontWeight.w600,
                            color: ColorResource.color23375A,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        CustomButton(
                          'Login via diffrent user',
                          onTap: () {
                            setState(() {
                              userName.clear();
                              password.clear();
                            });
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
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  resendOTPBottomSheet(BuildContext buildContext) {
    showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
      context: buildContext,
      backgroundColor: ColorResource.colorF8F9FB,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (BuildContext context) {
        return ResetPasswordScreen();
      },
    );
  }

  void _signIn() {
    final bool isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    } else {
      if (userName.text == 'fos' && password.text == '1234') {
        setState(() {
          loginType = 'fos';
        });
        bloc.add(HomeTabEvent());
      } else if (userName.text == 'tc' && password.text == '1234') {
        setState(() {
          loginType = 'tc';
        });
        bloc.add(HomeTabEvent());
      } else {
        AppUtils.showToast(Languages.of(context)!.passwordNotMatch);
      }
      // bloc.add(HomeTabEvent());
    }
    _formKey.currentState!.save();
  }

  _handleRemeberme(bool value) {
    _isChecked = value;
    SharedPreferences.getInstance().then(
      (prefs) {
        prefs.setBool("remember_me", value);
        prefs.setString('username', userName.text);
        prefs.setString('password', password.text);
      },
    );
    setState(() {
      _isChecked = value;
    });
  }

  void _loadUserNamePassword() async {
    try {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      var _username = _prefs.getString("username") ?? "";
      var _password = _prefs.getString("password") ?? "";
      var _remeberMe = _prefs.getBool("remember_me") ?? false;

      if (_remeberMe) {
        setState(() {
          _isChecked = true;
        });
        userName.text = _username;
        password.text = _password;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed
    userName.dispose();
    password.dispose();
    super.dispose();
  }
}

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
                          child: const CustomText(
                            'Check',
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
                                    'Resend OTP?'.toUpperCase(),
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
                              'SEND OTP'.toUpperCase(),
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
                              'SUBMIT'.toUpperCase(),
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
