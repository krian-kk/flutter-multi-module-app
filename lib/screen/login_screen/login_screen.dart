import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:origa/authentication/authentication_bloc.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/router.dart';
import 'package:origa/utils/app_utils.dart';
// import 'package:origa/screen/search_allocation_details_screen/search_allocation_details_screen.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/widgets/custom_button.dart';
import 'package:origa/widgets/custom_text.dart';
import 'package:origa/widgets/custom_textfield.dart';

import 'bloc/login_bloc.dart';

class LoginScreen extends StatefulWidget {
  AuthenticationBloc authBloc;
  LoginScreen(this.authBloc, {Key? key}) : super(key: key);

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

  @override
  void initState() {
    bloc = LoginBloc()..add(LoginInitialEvent());
    username = FocusNode();
    passwords = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      bloc: bloc,
      listener: (context, state) {
       if (state is HomeTabState) {
         Navigator.pushReplacementNamed(context, AppRoutes.homeTabScreen);
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
                        Image.asset(ImageResource.origa),
                        const SizedBox(
                          height: 17,
                        ),
                        Image.asset(ImageResource.login),
                        const SizedBox(
                          height: 17,
                        ),
                        CustomTextField(
                                  Languages.of(context)!.userName,
                                  userName,
                                  isFill: true,
                                  isBorder: true,
                                  errorborderColor: ColorResource.colorF8F9FB,
                                  borderColor: ColorResource.colorF8F9FB,
                                  validationRules: ['required'],
                                  focusNode: username,
                                  onEditing: () {
                                    username.unfocus();
                                    _formKey.currentState!.validate();
                                  },
                                  validatorCallBack: (bool values) {},
                                ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextField(
                                  Languages.of(context)!.password,
                                  password,
                                  obscureText: true,
                                  isFill: true,
                                  isBorder: true,
                                  borderColor: ColorResource.colorF8F9FB,
                                  errorborderColor: ColorResource.colorF8F9FB,
                                   validationRules: ['required'],
                                   focusNode: passwords,
                                   onEditing: () {
                                    passwords.unfocus();
                                    _formKey.currentState!.validate();
                                  },
                                  validatorCallBack: (bool values) {},
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
                            AppUtils.showToast('Reset Password');
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

  void _signIn() {
    final bool isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    } else {
      if (userName.text == 'origa' && password.text == '1234') {
        bloc.add(HomeTabEvent());
      } else {
        AppUtils.showToast("Password doesn't match");
      }
      // bloc.add(HomeTabEvent());
    }
    _formKey.currentState!.save();
  }
}
