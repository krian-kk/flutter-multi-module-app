import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:origa/authentication/authentication_bloc.dart';
import 'package:origa/router.dart';
import 'package:origa/utils/app_utils.dart';
// import 'package:origa/screen/search_allocation_details_screen/search_allocation_details_screen.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/widgets/custom_button.dart';
import 'package:origa/widgets/custom_text.dart';

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

  @override
  void initState() {
    bloc = LoginBloc()..add(LoginInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      bloc: bloc,
      listener: (context, state) {
        // TODO: implement listener
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        bloc: bloc,
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: ColorResource.colorF7F8FA,
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
                          const SizedBox(height: 7,),
                          Image.asset(ImageResource.origa),
                          const SizedBox(height: 17,),
                          Image.asset(ImageResource.login),
                          const SizedBox(height: 17,),
                          Container(
                              // height: widget.height,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                  color: ColorResource.colorFEFFFF,
                                  border: Border.all(
                                      // width: widget.borderWidth,
                                      color: ColorResource.colorFEFFFF,
                                      // style: widget.borderStyle
                                      )),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter user name';
                                    }
                                    return null;
                                  },
                                  obscureText: false,
                                  controller: userName,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'User Name',
                                      hintStyle:
                                          TextStyle(color: ColorResource.color101010.withOpacity(0.3))),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20,),
                            Container(
                              // height: widget.height,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                  color: ColorResource.colorFEFFFF,
                                  border: Border.all(
                                      // width: widget.borderWidth,
                                      color: ColorResource.colorFEFFFF,
                                      // style: widget.borderStyle
                                      )),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                                child: TextFormField(
                                   validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter valid password';
                                    }
                                    return null;
                                  },
                                  obscureText: true,
                                  controller: password,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Password',
                                      hintStyle:
                                          TextStyle(color: ColorResource.color101010.withOpacity(0.3))),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20,),
                          CustomButton(
                            'SIGN IN',
                            onTap: () {
                              if (userName.text.isEmpty && password.text.isEmpty) {
                                AppUtils.showToast('Please fill the fields');
                              } else if (password.text != '1111'){
                                AppUtils.showToast('Please enter valid password');
                              } else {
                                Navigator.pushNamed(context, AppRoutes.homeTabScreen);
                                setState(() {
                                userName.clear();
                                password.clear();
                              });
                              }
                            //   if (_formKey.currentState!.validate()) {
                            //   ScaffoldMessenger.of(context).showSnackBar(
                            //     const SnackBar(content: Text('Processing Data')),
                            //   );
                            // }
                            },
                            cardShape: 85,
                            fontSize: FontSize.sixteen,
                            fontWeight: FontWeight.w600,
                          ),
                          const SizedBox(height: 17,),
                          GestureDetector(
                            onTap: (){
                              AppUtils.showToast('Reset Password');
                            },
                            child: CustomText(
                              'Reset password via OTP',
                              fontSize: FontSize.sixteen,
                              fontWeight: FontWeight.w600,
                              color: ColorResource.color23375A,
                            ),
                          ),
                          const SizedBox(height: 30,),
                          CustomButton(
                            'Login via diffrent user',
                            onTap: () {
                              setState(() {
                                userName.clear();
                                password.clear();
                              });
                            },
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
            ),
          );
        },
      ),
    );
  }
}


