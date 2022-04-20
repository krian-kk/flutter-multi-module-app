import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:origa/authentication/authentication_bloc.dart';
import 'package:origa/http/api_repository.dart';
import 'package:origa/http/httpurls.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/router.dart';
import 'package:origa/screen/mpin_screens/account_password_mpin_screen.dart';
import 'package:origa/screen/mpin_screens/conform_mpin_screen.dart';
import 'package:origa/screen/mpin_screens/create_mpin_screen.dart';
import 'package:origa/screen/mpin_screens/forgot_mpin_screen.dart';
import 'package:origa/screen/mpin_screens/new_mpin_screen.dart';
import 'package:origa/screen/reset_password_screen/reset_password_screen.dart';
import 'package:origa/utils/app_utils.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/constants.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/utils/preference_helper.dart';
import 'package:origa/utils/string_resource.dart';
import 'package:origa/widgets/custom_button.dart';
import 'package:origa/widgets/custom_loading_widget.dart';
import 'package:origa/widgets/custom_text.dart';
import 'package:origa/widgets/custom_textfield.dart';
import 'package:origa/widgets/web_view_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bloc/login_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen(this.authBloc, {Key? key, this.notificationData})
      : super(key: key);
  final AuthenticationBloc authBloc;
  final dynamic notificationData;

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

  @override
  void initState() {
    bloc = LoginBloc()..add(LoginInitialEvent(context: context));
    if (kDebugMode) {
      userId.text = 'CDE_46';
      password.text = 'Origa123';
      // userId.text = 'YES_fos';
      // password.text = 'Agent1234';
    }
    // userId.text = 'CDE_46';
    // password.text = 'Origa123';
    username = FocusNode();
    passwords = FocusNode();
    _loadUserNamePassword();
    super.initState();
  }

  // PasswordVisibleOrNot the password show status
  void _passwordVisibleOrNot() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Future<bool> requestOTP(String aRef) async {
    bool returnValue = false;
    final Map<String, dynamic> postResult = await APIRepository.apiRequest(
      APIRequestType.post,
      HttpUrl.requestOTPUrl(),
      requestBodydata: {
        'aRef': aRef,
      },
    );
    if (await postResult[Constants.success]) {
      setState(() => returnValue = true);
    } else {
      AppUtils.showToast('Some Issue in OTP Send, Please Try Again Later');
    }
    return returnValue;
  }

  Future<bool> verifyOTP(String? aRef, String? otp) async {
    bool returnValue = false;
    final Map<String, dynamic> postResult = await APIRepository.apiRequest(
        APIRequestType.post, HttpUrl.verifyOTP(),
        requestBodydata: {
          'aRef': aRef,
          'otp': otp,
        });
    if (postResult[Constants.success]) {
      setState(() => returnValue = true);
    } else {
      setState(() => returnValue = false);
      // AppUtils.showErrorToast("OTP does't match");
    }
    return returnValue;
  }

  webViewScreen(BuildContext context, {required String urlAddress}) {
    showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
      context: context,
      backgroundColor: ColorResource.colorFFFFFF,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.9,
            child: WebViewWidget(urlAddress: urlAddress),
          ),
        );
      },
    );
  }

  Future<bool> createMpin(String? mPin) async {
    bool returnValue = false;
    final Map<String, dynamic> postResult = await APIRepository.apiRequest(
        APIRequestType.put, HttpUrl.createMpin,
        requestBodydata: {
          'mPin': mPin,
        });
    if (postResult[Constants.success]) {
      setState(() => returnValue = true);
    } else {
      setState(() => returnValue = false);
    }
    return returnValue;
  }

  Future<void> showCreateMPinDialogBox() async {
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
            content: CreateMpinScreen(
              saveFunction: (mPin) async {
                // Create Secure Mpin APi
                if (await createMpin(mPin)) {
                  final SharedPreferences _prefs =
                      await SharedPreferences.getInstance();
                  await _prefs.setString(Constants.accessToken, mPin!);
                  Navigator.pop(context);
                  bloc.add(TriggeredHomeTabEvent(userId.text));
                } else {
                  AppUtils.showToast('Change mPin has some Issue');
                }
              },
            ),
          );
        });
  }

  Future<void> showComformSecurePinDialogBox(
      String mPin, String userName) async {
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
            content: ConformMpinScreen(
              successFunction: () async {
                // SharedPreferences _prefs =
                //     await SharedPreferences.getInstance();
                // await _prefs.setString(Constants.mPin, mPin);
                PreferenceHelper.setPreference(Constants.mPin, mPin);
                bloc.add(TriggeredHomeTabEvent(userId.text));
              },
              forgotPinFunction: () async {
                if (await requestOTP(userName)) {
                  await showForgorSecurePinDialogBox(userName);
                }
              },
              popFunction: () {},
              mPin: mPin,
            ),
          );
        });
  }

  Future<void> showForgorSecurePinDialogBox(String userName) async {
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
            content: ForgotMpinScreen(
              submitOtpFunction: (otp, isError, function) async {
                final bool result = await verifyOTP(userName, otp);
                if (result) {
                  Navigator.pop(context);
                  await showAccountPasswordMpinDialogBox(userName);
                } else {
                  function;
                }
              },
              resendOtpFunction: () => requestOTP(userName),
              userName: userName,
            ),
          );
        });
  }

  Future<void> showAccountPasswordMpinDialogBox(String userName) async {
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
            content: AccountPasswordMpinScreen(
              submitBtnFunction: () {
                Navigator.pop(context);
                showCreatePinDialogBox();
              },
              forgotPasswordFunction: () => resendOTPBottomSheet(context),
              password: password.text,
              userName: userName,
            ),
          );
        });
  }

  Future<void> showCreatePinDialogBox() async {
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
            content: NewMpinScreen(
              saveFuction: (mPin) async {
                // New Pin Create Api in this
                if (await createMpin(mPin)) {
                  final SharedPreferences _prefs =
                      await SharedPreferences.getInstance();
                  await _prefs.setString(Constants.mPin, mPin!);
                  Navigator.pop(context);
                  Navigator.pop(context);
                  bloc.add(TriggeredHomeTabEvent(userId.text));
                } else {
                  AppUtils.showToast('Change mPin has some Issue');
                }
              },
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
                      if (state is EnterSecurePinState) {
                        setState(() {
                          bloc.isSubmit = true;
                          bloc.isLoading = false;
                          bloc.isLoaded = false;
                        });
                        if (state.securePin == null) {
                          await showCreateMPinDialogBox();
                        } else {
                          await showComformSecurePinDialogBox(
                            state.securePin.toString(),
                            state.userName.toString(),
                          );
                        }
                      }
                      if (state is HomeTabState) {
                        await Navigator.pushReplacementNamed(
                            context, AppRoutes.homeTabScreen,
                            arguments: widget.notificationData);
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
                            enable: (Platform.isIOS),
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
                                      children: [
                                        const SizedBox(height: 40),
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
                                        const SizedBox(height: 30),
                                        if (userId.text != '' ||
                                            password.text != '')
                                          CustomButton(
                                            Languages.of(context)!
                                                .loginViaDifferentUser,
                                            onTap: bloc.isSubmit
                                                ? () {
                                                    if (userId.text != '' ||
                                                        password.text != '') {
                                                      setState(() {
                                                        userId.clear();
                                                        password.clear();
                                                        _isChecked = false;
                                                        // Signin submit button activities
                                                      });
                                                      AppUtils.showToast(Languages
                                                              .of(context)!
                                                          .logiginDeifferentSucessMessage);
                                                    } else {
                                                      AppUtils.showToast(Languages
                                                              .of(context)!
                                                          .logiginDeifferentFailMessage);
                                                    }
                                                  }
                                                : () {
                                                    AppUtils.showToast(
                                                      Languages.of(context)!
                                                          .pleaseWait,
                                                    );
                                                  },
                                            borderColor:
                                                ColorResource.color23375A,
                                            cardShape: 90,
                                            fontSize: FontSize.sixteen,
                                            textColor:
                                                ColorResource.color23375A,
                                            buttonBackgroundColor:
                                                ColorResource.colorffffff,
                                          ),
                                        const SizedBox(height: 10),
                                        // CustomButton(
                                        //   Languages.of(context)!.help,
                                        //   onTap: () => webViewScreen(
                                        //     context,
                                        //     urlAddress:
                                        //         'https://www.google.com/?client=safari',
                                        //   ),
                                        //   borderColor:
                                        //       ColorResource.color23375A,
                                        //   cardShape: 90,
                                        //   fontSize: FontSize.sixteen,
                                        //   fontWeight: FontWeight.w600,
                                        //   textColor: ColorResource.color23375A,
                                        //   buttonBackgroundColor:
                                        //       ColorResource.colorffffff,
                                        // ),
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
        final params = {
          'userName': userId.text,
          'agentRef': userId.text,
          'password': password.text,
          'fcmToken': fcmToken
        };
        bloc.add(
          SignInEvent(
              paramValue: params, userId: userId.text, context: context),
        );
      }
    }
    _formKey.currentState!.save();
  }

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

  // this is custom Widget to show rounded container
  // here is state is submitting, we are showing loading indicator on container then.
  // if it completed then showing a Icon.
  Widget circularLoading(bool done) {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
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

  _loadUserNamePassword() async {
    try {
      final SharedPreferences _prefs = await SharedPreferences.getInstance();
      final _username = _prefs.getString(Constants.rememberUserId) ?? '';
      final _password = _prefs.getString(Constants.rememberPassword) ?? '';
      final _remeberMe = _prefs.getBool(Constants.rememberMe) ?? false;

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
      debugPrint(e.toString());
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
