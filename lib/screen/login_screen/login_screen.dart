import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:origa/authentication/authentication_bloc.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/router.dart';
import 'package:origa/screen/reset_password_screen/reset_password_screen.dart';
import 'package:origa/utils/app_utils.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/constants.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/utils/string_resource.dart';
import 'package:origa/widgets/custom_button.dart';
import 'package:origa/widgets/custom_loading_widget.dart';
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

  late TextEditingController userId = TextEditingController();
  late TextEditingController password = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  late FocusNode username;
  FocusNode passwords = FocusNode();
  bool _obscureText = true;
  bool _isChecked = false;

  // String? userType;

  @override
  void initState() {
    bloc = LoginBloc()..add(LoginInitialEvent(context: context));
    username = FocusNode();
    passwords = FocusNode();
    _loadUserNamePassword();
    Firebase.initializeApp();
    super.initState();
  }

  // _passwordVisibleOrNot the password show status
  void _passwordVisibleOrNot() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Future<void> showSecurePinDialogBox() async {
    TextEditingController securePinCodeContoller = TextEditingController();
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
              side: BorderSide(width: 0.5, color: ColorResource.colorDADADA),
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            contentPadding: const EdgeInsets.all(20),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 250,
                        child: CustomText(
                          Languages.of(context)!
                              .secureYourAccountByCreatingAFourDigitPin,
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
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: PinCodeTextField(
                    appContext: context,
                    controller: securePinCodeContoller,
                    length: 4,
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
                      fieldOuterPadding: const EdgeInsets.all(8),
                      activeColor: ColorResource.color7F8EA2.withOpacity(0.3),
                      selectedColor: ColorResource.color23375A.withOpacity(0.3),
                      inactiveColor: ColorResource.color232222.withOpacity(0.3),
                      fieldHeight: 46,
                      fieldWidth: 40,
                      borderWidth: 1,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                CustomButton(
                  Languages.of(context)!.save,
                  fontSize: FontSize.sixteen,
                  onTap: () {
                    showComformSecurePinDialogBox(securePinCodeContoller.text);
                    // Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        });
  }

  Future<void> showComformSecurePinDialogBox(String newPin) async {
    TextEditingController securePinCodeContoller = TextEditingController();
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
              side: BorderSide(width: 0.5, color: ColorResource.colorDADADA),
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            contentPadding: const EdgeInsets.all(20),
            content: SizedBox(
              width: 400,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 250,
                          child: CustomText(
                            Languages.of(context)!.enterYourSecureFourdDigitPin,
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
                  const SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: PinCodeTextField(
                      appContext: context,
                      controller: securePinCodeContoller,
                      length: 4,
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
                        fieldOuterPadding: const EdgeInsets.all(8),
                        activeColor: ColorResource.color7F8EA2.withOpacity(0.3),
                        selectedColor:
                            ColorResource.color23375A.withOpacity(0.3),
                        inactiveColor:
                            ColorResource.color232222.withOpacity(0.3),
                        fieldHeight: 46,
                        fieldWidth: 40,
                        borderWidth: 1,
                      ),
                    ),
                  ),
                  const SizedBox(height: 60),
                  GestureDetector(
                    onTap: () {
                      showForgorSecurePinDialogBox();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      child: CustomText(
                        Languages.of(context)!.forgotPin,
                        color: ColorResource.color23375A,
                        fontSize: FontSize.sixteen,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  Future<void> showForgorSecurePinDialogBox() async {
    TextEditingController forgotSecurePinCodeContoller =
        TextEditingController();
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
              side: BorderSide(width: 0.5, color: ColorResource.colorDADADA),
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            contentPadding: const EdgeInsets.all(20),
            content: SizedBox(
              width: 400,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 250,
                          child: CustomText(
                            Languages.of(context)!
                                .forgotPin
                                .replaceAll('?', ''),
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
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                      width: 250,
                      child: CustomText(
                        'Enter your account password to edit 4-digit PIN for Jack’s account.',
                        fontSize: FontSize.sixteen,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: PinCodeTextField(
                      appContext: context,
                      controller: forgotSecurePinCodeContoller,
                      length: 4,
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
                        fieldOuterPadding: const EdgeInsets.all(8),
                        activeColor: ColorResource.color7F8EA2.withOpacity(0.3),
                        selectedColor:
                            ColorResource.color23375A.withOpacity(0.3),
                        inactiveColor:
                            ColorResource.color232222.withOpacity(0.3),
                        fieldHeight: 46,
                        fieldWidth: 42,
                        borderWidth: 1,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  CustomButton(
                    Languages.of(context)!.sendOTP.toUpperCase(),
                    fontSize: FontSize.sixteen,
                    onTap: () {
                      // Navigator.pop(context);
                    },
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      child: CustomText(
                        Languages.of(context)!.resendOTP,
                        color: ColorResource.color23375A,
                        fontSize: FontSize.sixteen,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w600,
                        isUnderLine: true,
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          return FutureBuilder(
              future: FirebaseMessaging.instance.getToken(),
              builder: (context, snapshot) {
                if (snapshot.data != null) {
                  return BlocListener<LoginBloc, LoginState>(
                    bloc: bloc,
                    listener: (context, state) async {
                      if (state is NoInternetConnectionState) {
                        AppUtils.noInternetSnackbar(context);
                      }
                      if (state is HomeTabState) {
                        // showSecurePinDialogBox();
                        Navigator.pushReplacementNamed(
                            context, AppRoutes.homeTabScreen);
                      }
                      if (state is ResendOTPState) {
                        resendOTPBottomSheet(context);
                      }
                      if (state is SignInLoadingState) {
                        bloc.isSubmit = false;
                        bloc.isLoading = true;
                      }
                      if (state is SignInLoadedState) {
                        bloc.isSubmit = true;
                        bloc.isLoading = false;
                      }
                      if (state is SignInCompletedState) {
                        bloc.isSubmit = false;
                        bloc.isLoaded = true;
                      }
                    },
                    child: BlocBuilder<LoginBloc, LoginState>(
                      bloc: bloc,
                      builder: (context, state) {
                        return Scaffold(
                          backgroundColor: ColorResource.colorF8F9FB,
                          body: KeyboardActions(
                            config: KeyboardActionsConfig(
                              keyboardActionsPlatform:
                                  KeyboardActionsPlatform.IOS,
                              actions: [
                                KeyboardActionsItem(
                                  focusNode: passwords,
                                  displayArrows: false,
                                ),
                              ],
                            ),
                            child: SingleChildScrollView(
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Form(
                                    key: _formKey,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 60,
                                        ),
                                        // SvgPicture.asset(ImageResource.origa),
                                        Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 35),
                                            child: Image.asset(
                                                ImageResource.origa)),
                                        const SizedBox(
                                          height: 17,
                                        ),
                                        SvgPicture.asset(ImageResource.login),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        CustomTextField(
                                          Languages.of(context)!.userId,
                                          userId,
                                          isFill: true,
                                          isBorder: true,
                                          isLabel: true,
                                          keyBoardType:
                                              TextInputType.emailAddress,
                                          errorborderColor:
                                              ColorResource.color23375A,
                                          borderColor:
                                              ColorResource.color23375A,
                                          validationRules: const ['required'],
                                          focusNode: username,
                                          onEditing: () {
                                            username.unfocus();
                                            _formKey.currentState!.validate();
                                          },
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
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
                                          borderColor:
                                              ColorResource.color23375A,
                                          errorborderColor:
                                              ColorResource.color23375A,
                                          keyBoardType: TextInputType.text,
                                          validationRules: const ['required'],
                                          focusNode: passwords,
                                          onEditing: () {
                                            passwords.unfocus();
                                            _formKey.currentState!.validate();
                                          },
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
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
                                                activeColor:
                                                    ColorResource.color23375A,
                                                onChanged: (bool? newValue) {
                                                  final bool isValid = _formKey
                                                      .currentState!
                                                      .validate();
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
                                        AnimatedContainer(
                                            duration: const Duration(
                                                milliseconds: 300),
                                            onEnd: () => setState(() {
                                                  bloc.isAnimating =
                                                      !bloc.isAnimating;
                                                }),
                                            width: bloc.isSubmit
                                                ? MediaQuery.of(context)
                                                    .size
                                                    .width
                                                : 90,
                                            height: 55,
                                            child: bloc.isAnimating ||
                                                    bloc.isSubmit
                                                ? loginButton(
                                                    fcmToken: snapshot.data
                                                        .toString())
                                                : circularLoading(
                                                    bloc.isLoaded)),
                                        const SizedBox(
                                          height: 17,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            bloc.add(ResendOTPEvent());
                                          },
                                          child: CustomText(
                                            Languages.of(context)!
                                                .resetPassword,
                                            fontSize: FontSize.sixteen,
                                            fontWeight: FontWeight.w600,
                                            color: ColorResource.color23375A,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        CustomButton(
                                          Languages.of(context)!
                                              .loginViaDifferentUser,
                                          onTap: bloc.isSubmit
                                              ? () {
                                                  setState(() {
                                                    userId.clear();
                                                    password.clear();
                                                    _isChecked = false;
                                                    // signin submit button activities
                                                  });
                                                }
                                              : () {
                                                  AppUtils.showToast(
                                                      "Please wait..");
                                                },
                                          borderColor:
                                              ColorResource.color23375A,
                                          cardShape: 90,
                                          fontSize: FontSize.sixteen,
                                          fontWeight: FontWeight.w600,
                                          textColor: ColorResource.color23375A,
                                          buttonBackgroundColor:
                                              ColorResource.colorffffff,
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
                } else {
                  return Container(
                    color: Colors.white,
                    alignment: Alignment.center,
                    child: const CustomLoadingWidget(),
                  );
                }
              });
        });
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

  Future<void> _signIn({String? fcmToken}) async {
    final bool isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    } else {
      if (ConnectivityResult.none == await Connectivity().checkConnectivity()) {
        bloc.add(NoInternetConnectionEvent());
      } else {
        var params = {
          'userName': userId.text,
          'agentRef': userId.text,
          'password': password.text,
          'fcmToken': fcmToken
        };
        bloc.add(SignInEvent(paramValue: params, userId: userId.text));
      }
    }
    _formKey.currentState!.save();
  }

  // Future<void> getAgentDetails() async {
  //   try {
  //     http.Response response = await http.get(
  //         Uri.parse(
  //             'https://uat-collect.origa.ai/node/field-allocation/agents/HAR_fos1'),
  //         headers: {
  //           "access-token":
  //               "eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJVOVo5S0VDMXRqb3o4azE4ZGR6UkZqeTFxOHlRbmJSa1dRUlMwSU9tc3ljIn0.eyJleHAiOjE2Mzk2Njc5NDQsImlhdCI6MTYzOTY2NjE0NCwianRpIjoiNWU4M2RhMmItMDkwOS00YjNjLTgxMGMtZjc1YzNhZmYyZDY1IiwiaXNzIjoiaHR0cDovLzEwLjIyMS4xMC4yNDg6ODA4MC9hdXRoL3JlYWxtcy9vcmlnYS11YXQiLCJzdWIiOiI1NGI3YjExYy1iMGE0LTQ0NjMtYjEyZS02NTQ1MTY5NGQyYmQiLCJ0eXAiOiJCZWFyZXIiLCJhenAiOiJhZG1pbi1jbGkiLCJzZXNzaW9uX3N0YXRlIjoiOTZjYmRhOTQtZWViOC00OGVlLTgwYmItNTkwN2MzY2Q0NzdmIiwiYWNyIjoiMSIsInNjb3BlIjoiZW1haWwgcHJvZmlsZSIsImVtYWlsX3ZlcmlmaWVkIjpmYWxzZSwibmFtZSI6IkZPUzEiLCJwcmVmZXJyZWRfdXNlcm5hbWUiOiJoYXJfZm9zMSIsImdpdmVuX25hbWUiOiJGT1MxIn0.GAzi2BUUyuFs5Tkd8rtxzTpS5oAXJYiJaYbGtyKb0dcEIfpMLTSAlBu3h61R07kMt5GZN884BEis3UtGA739O0QIrN-OM519qrcBGW48Dk0_a6jNMRTMH82_L3XbIneDZ9d6DveFFG1QJIGaZ-34AhbNawrZJhIX7_gfVPVJ2CQP-4Yykv5Oe5XRB8AOew4spIQ25RMZl3a9YtpN3hFATJSwfg8ndd7H9C6VyGPCZdLSzoAnpSJOekC02R7OkxqFg2fqyz25B-4uA_Mu_oVlVIAoljaqC1jlk9o_NCkqJ0GOgrCwGx2lHWdP3tyDNCkrRkkQRQYv_xEctwqq6MNScQ",
  //           "refresh-token":
  //               "eyJhbGciOiJIUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICIyNDUxZGRkNS00MGE3LTQ3N2UtOWM1OS0xOTBkNDcxMWM3NzkifQ.eyJleHAiOjE2Mzk3NTI1NDQsImlhdCI6MTYzOTY2NjE0NCwianRpIjoiNzc1M2I0N2QtYmU3Zi00MTdkLWJiY2YtZDQ3MzMyNWM0NzQ0IiwiaXNzIjoiaHR0cDovLzEwLjIyMS4xMC4yNDg6ODA4MC9hdXRoL3JlYWxtcy9vcmlnYS11YXQiLCJhdWQiOiJodHRwOi8vMTAuMjIxLjEwLjI0ODo4MDgwL2F1dGgvcmVhbG1zL29yaWdhLXVhdCIsInN1YiI6IjU0YjdiMTFjLWIwYTQtNDQ2My1iMTJlLTY1NDUxNjk0ZDJiZCIsInR5cCI6IlJlZnJlc2giLCJhenAiOiJhZG1pbi1jbGkiLCJzZXNzaW9uX3N0YXRlIjoiOTZjYmRhOTQtZWViOC00OGVlLTgwYmItNTkwN2MzY2Q0NzdmIiwic2NvcGUiOiJlbWFpbCBwcm9maWxlIn0.8eAy-szmnpvnFI5C5izv17t3RGkDPh66D4jPLX-GTfI",
  //           "Authorization":
  //               "Bearer eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJVOVo5S0VDMXRqb3o4azE4ZGR6UkZqeTFxOHlRbmJSa1dRUlMwSU9tc3ljIn0.eyJleHAiOjE2Mzk2Njc5NDQsImlhdCI6MTYzOTY2NjE0NCwianRpIjoiNWU4M2RhMmItMDkwOS00YjNjLTgxMGMtZjc1YzNhZmYyZDY1IiwiaXNzIjoiaHR0cDovLzEwLjIyMS4xMC4yNDg6ODA4MC9hdXRoL3JlYWxtcy9vcmlnYS11YXQiLCJzdWIiOiI1NGI3YjExYy1iMGE0LTQ0NjMtYjEyZS02NTQ1MTY5NGQyYmQiLCJ0eXAiOiJCZWFyZXIiLCJhenAiOiJhZG1pbi1jbGkiLCJzZXNzaW9uX3N0YXRlIjoiOTZjYmRhOTQtZWViOC00OGVlLTgwYmItNTkwN2MzY2Q0NzdmIiwiYWNyIjoiMSIsInNjb3BlIjoiZW1haWwgcHJvZmlsZSIsImVtYWlsX3ZlcmlmaWVkIjpmYWxzZSwibmFtZSI6IkZPUzEiLCJwcmVmZXJyZWRfdXNlcm5hbWUiOiJoYXJfZm9zMSIsImdpdmVuX25hbWUiOiJGT1MxIn0.GAzi2BUUyuFs5Tkd8rtxzTpS5oAXJYiJaYbGtyKb0dcEIfpMLTSAlBu3h61R07kMt5GZN884BEis3UtGA739O0QIrN-OM519qrcBGW48Dk0_a6jNMRTMH82_L3XbIneDZ9d6DveFFG1QJIGaZ-34AhbNawrZJhIX7_gfVPVJ2CQP-4Yykv5Oe5XRB8AOew4spIQ25RMZl3a9YtpN3hFATJSwfg8ndd7H9C6VyGPCZdLSzoAnpSJOekC02R7OkxqFg2fqyz25B-4uA_Mu_oVlVIAoljaqC1jlk9o_NCkqJ0GOgrCwGx2lHWdP3tyDNCkrRkkQRQYv_xEctwqq6MNScQ",
  //           "session-id": "96cbda94-eeb8-48ee-80bb-5907c3cd477f",
  //           "aRef": "HAR_fos1",
  //         });
  //     if (response.statusCode == 200) {
  //       print(jsonDecode(response.body));
  //     } else {
  //       print(response.reasonPhrase);
  //     }
  //   } on Exception catch (exception) {
  //     print(exception.toString());
  //   } catch (error) {
  //     print(error.toString());
  //   }
  // }

  // LoginResponseModel loginResponse =
  //     LoginResponseModel();

  // Future<void> keyCloak() async {
  //   SharedPreferences _prefs = await SharedPreferences.getInstance();

  //     var params =
  //     {
  //     "userId": userId.text,
  //     "agentRef": userId.text,
  //     "password": password.text
  //     };
  //       print('---------before execute----------');

  //         Map<String, dynamic> response = await APIRepository.apiRequest(
  //         APIRequestType.post,
  //         HttpUrl.loginUrl,
  //         requestBodydata: params);

  //         if (response['success']) {
  //           loginResponse = LoginResponseModel.fromJson(response['data']);
  //           _prefs.setString('accessToken', loginResponse.data!.accessToken!);
  //           _prefs.setInt('accessTokenExpireTime', loginResponse.data!.expiresIn!);
  //           _prefs.setString('refreshToken', loginResponse.data!.refreshToken!);
  //           _prefs.setInt('refreshTokenExpireTime', loginResponse.data!.refreshExpiresIn!);
  //           _prefs.setString('keycloakId', loginResponse.data!.keycloakId!);

  //         }

  //       // var params =  {
  //     //         "username": "YES_suvodeepcollector",
  //     //         "password": "Agent1234",
  //     //         "grant_type": "password",
  //     //         "client_id": "admin-cli",
  //     //       };

  //         // Response response = await _dio.post(
  //         //   "http://10.221.10.248:8080/auth/realms/origa-dev/protocol/openid-connect/token",
  //         //   options: Options(headers: {
  //         //     HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded",
  //         //   }),
  //         //   data: jsonEncode(params),
  //         // );
  //         // print(params);

  //       // var response = await http.post(
  //       //     Uri.parse(HttpUrl.login_keycloak),
  //       //     headers: <String, String>{
  //       //       'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
  //       //     },
  //       //     body: params,
  //       //   );
  //       //   print('---------After execute----------');
  //       //   print(response.statusCode.toString());
  //       //   print(response.body);

  //         // Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginResponse(response.body.toString())));

  // }

  // If isSubmit = true : show Normal submit button
  Widget loginButton({String? fcmToken}) => GestureDetector(
        onTap: () {
          _signIn(fcmToken: fcmToken);
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(90.0),
            // boxShadow: const [
            //   BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.12), spreadRadius: 2),
            //   BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.24), spreadRadius: 2),
            // ],
            gradient: const LinearGradient(
              colors: [
                ColorResource.colorFFC23B,
                ColorResource.colorEA8A38,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Center(
            child: CustomText(
              StringResource.signIn.toUpperCase(),
              color: ColorResource.color23375A,
              fontSize: FontSize.sixteen,
              fontWeight: FontWeight.w600,
              lineHeight: 1,
            ),
          ),
        ),
      );
  //     CustomButton(
  //       StringResource.signIn.toUpperCase(),
  //       buttonBackgroundColor: ColorResource.colorEA8A38,
  //       borderColor: ColorResource.colorEA8A38,
  //       onTap: () {
  //         _signIn(fcmToken: fcmToken);
  //       },
  //       cardShape: 85,
  //       fontSize: FontSize.sixteen,
  //       fontWeight: FontWeight.w600,
  //   textColor: ColorResource.color23375A,
  //     );

  // this is custom Widget to show rounded container
  // here is state is submitting, we are showing loading indicator on container then.
  // if it completed then showing a Icon.
  Widget circularLoading(bool done) {
    // final color = done ? ColorResource.colorFFC23B : ColorResource.colorFFC23B;
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        // color: color,
        gradient: LinearGradient(
          colors: [
            ColorResource.colorFFC23B,
            ColorResource.colorEA8A38,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      height: 50,
      child: Center(
        child: done
            ? const SizedBox(
                height: 30,
                width: 30,
                child: Icon(Icons.done,
                    size: 30, color: ColorResource.colorffffff))
            : const SizedBox(
                height: 30,
                width: 30,
                child: CircularProgressIndicator(
                  color: ColorResource.colorffffff,
                  strokeWidth: 3,
                ),
              ),
      ),
    );
  }

  _handleRemeberme(bool value) {
    _isChecked = value;
    SharedPreferences.getInstance().then(
      (prefs) {
        prefs.setBool(Constants.rememberMe, value);
        prefs.setString(Constants.rememberUserId, userId.text);
        prefs.setString(Constants.rememberPassword, password.text);
      },
    );
    setState(() {
      _isChecked = value;
    });
  }

  void _loadUserNamePassword() async {
    try {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      var _username = _prefs.getString(Constants.rememberUserId) ?? "";
      var _password = _prefs.getString(Constants.rememberPassword) ?? "";
      var _remeberMe = _prefs.getBool(Constants.rememberMe) ?? false;

      if (_remeberMe) {
        setState(() {
          _isChecked = true;
        });
        userId.text = _username;
        password.text = _password;
      } else {
        setState(() {
          _isChecked = false;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed
    userId.dispose();
    password.dispose();
    super.dispose();
  }
}
