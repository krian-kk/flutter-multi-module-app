import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import 'package:package_info_plus/package_info_plus.dart';

import '../../singleton.dart';
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

  //
  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   debugPrint('AppLifecycleState--> ${state.name}');
  //   super.didChangeAppLifecycleState(state);
  // }

  @override
  void initState() {
    // WidgetsBinding.instance.addObserver(this);
    bloc = LoginBloc()..add(LoginInitialEvent(context: context));
    if (kDebugMode) {
      userId.text = 'SBIC_suvodeepcollector';
      password.text = 'Agent1234';
    }
    username = FocusNode();
    passwords = FocusNode();
    _loadUserNamePassword();
    loadData();
    // encryptRequest({"contractor":"C0005"});
    super.initState();
  }

  // PasswordVisibleOrNot the password show status
  void _passwordVisibleOrNot() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  static const MethodChannel platform = MethodChannel('recordAudioChannel');

  Future<void> _getEncryptedData(String data) async {
    // final Map<String, dynamic> requestData = {'data': data};
    // String text = await platform.invokeMethod('getEncryptedData', requestData);
    // debugPrint(text);
    encryptRequest({"contractor":"C0005"});
    // final Map<String, dynamic> requestData = {'data': data};
    // String text = await platform.invokeMethod('getEncryptedData', requestData);
    // debugPrint(text);
  }

  Future<void> encryptRequest(dynamic requestBodydata) async {
    final Map<String, dynamic> requestData = {'data': jsonEncode(requestBodydata)};
    String text = await platform.invokeMethod('sendEncryptedData', requestData);
    debugPrint(text);
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
                  await PreferenceHelper.setPreference(Constants.mPin, mPin!);
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
                  await PreferenceHelper.setPreference(Constants.mPin, mPin!);
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
                        // FirebaseDatabase.instance.setPersistenceEnabled(true);
                        // FirebaseDatabase.instance.setPersistenceCacheSizeBytes(
                        //     Settings.CACHE_SIZE_UNLIMITED);
                        // final DatabaseReference scoresRef = FirebaseDatabase
                        //     .instance
                        //     .ref(Singleton.instance.firebaseDatabaseName);
                        // await scoresRef.keepSynced(true);
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

                      if (state is TriggerHomeTabState) {
                        bloc.add(TriggeredHomeTabEvent(userId.text));
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
                                            child: SvgPicture.asset(
                                                ImageResource.collectLogo)),
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
                                        // const SizedBox(height: 10),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          floatingActionButton: Visibility(
                            visible: false,
                            // visible: WidgetsBinding
                            //             .instance.window.viewInsets.bottom >
                            //         0.0
                            //     ? false
                            //     : true,
                            child: GestureDetector(
                              onTap: () {
                                webViewScreen(context,
                                    urlAddress:
                                        'https://origahelpdesk.w3spaces.com');
                              },
                              child: Container(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.white),
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(100),
                                        ),
                                      ),
                                      padding: const EdgeInsets.all(2),
                                      child: const Icon(
                                        Icons.question_mark_rounded,
                                        size: 14.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      Languages.of(context)!.help,
                                      textScaleFactor: 3,
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1!
                                          .copyWith(
                                              color: Colors.white,
                                              fontSize: 6,
                                              backgroundColor:
                                                  Colors.transparent),
                                    )
                                  ],
                                ),
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(30),
                                      bottomRight: Radius.circular(30),
                                      topLeft: Radius.circular(30),
                                      topRight: Radius.circular(5)),
                                  color: ColorResource.color23375A,
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
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

  webViewScreen(BuildContext context, {required String urlAddress}) {
    showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: false,
      context: context,
      backgroundColor: ColorResource.colorFFFFFF,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(100),
        ),
      ),
      builder: (BuildContext context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.9,
          child: WebViewWidget(urlAddress: urlAddress),
        );
      },
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

  Future<void> _signIn({String? fcmToken}) async {
    final bool isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    } else {
      if (ConnectivityResult.none == await Connectivity().checkConnectivity()) {
        bloc.add(NoInternetConnectionEvent());
      } else {
        final PackageInfo packageInfo = await PackageInfo.fromPlatform();
        final params = {
          'userName': userId.text,
          'agentRef': userId.text,
          'password': password.text,
          'fcmToken': fcmToken,
          'appVersion': packageInfo.version
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
    PreferenceHelper.setPreference(Constants.rememberMe, value);
    PreferenceHelper.setPreference(Constants.rememberUserId, userId.text);
    PreferenceHelper.setPreference(Constants.rememberPassword, password.text);
    setState(() {
      _isChecked = value;
    });
  }

  _loadUserNamePassword() async {
    try {
      bool _remeberMe = false;
      String? _username;
      String? _password;
      await PreferenceHelper.getString(keyPair: Constants.rememberPassword)
          .then((value) {
        _password = value;
      });
      await PreferenceHelper.getString(keyPair: Constants.rememberUserId)
          .then((value) {
        _username = value;
      });
      await PreferenceHelper.getBool(keyPair: Constants.rememberMe)
          .then((value) {
        _remeberMe = value;
      });

      if (_remeberMe) {
        setState(() {
          _isChecked = true;
        });
        userId.text = _username!;
        password.text = _password!;
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

  void loadData() async {
    await _getEncryptedData('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');
  }
}
