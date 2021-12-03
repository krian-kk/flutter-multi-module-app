import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:origa/authentication/authentication_bloc.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/router.dart';
import 'package:origa/screen/reset_password_screen/reset_password_screen.dart';
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
                        InkWell(
                          onTap: () {
                            resendOTPBottomSheet(context);
                            // AppUtils.showToast('Reset Password');
                            // Navigator.push(context, MaterialPageRoute(builder: (context)=>DeviceInfo()));
                          },
                          child: const CustomText(
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
        return const ResetPasswordScreen();
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
