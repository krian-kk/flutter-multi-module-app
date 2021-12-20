import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
import 'package:origa/widgets/custom_text.dart';
import 'package:origa/widgets/custom_textfield.dart';
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
  late FocusNode passwords;
  bool _obscureText = true;
  bool _isChecked = false;
  // String? userType;

  @override
  void initState() {
    bloc = LoginBloc()..add(LoginInitialEvent(context: context));
    username = FocusNode();
    passwords = FocusNode();
    _loadUserNamePassword();
    // userId.text = 'HAR_fos1';
    // password.text = 'Agent1234';
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
      listener: (context, state) async {
        if (state is NoInternetConnectionState) {
          AppUtils.noInternetSnackbar(context);
        }

        if (state is HomeTabState) {
          Navigator.pushReplacementNamed(context, AppRoutes.homeTabScreen);
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
          bloc.isLoaded = true;
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
                          Languages.of(context)!.userId,
                          userId,
                          isFill: true,
                          isBorder: true,
                          isLabel: true,
                          keyBoardType: TextInputType.emailAddress,
                          errorborderColor: ColorResource.color23375A,
                          borderColor: ColorResource.color23375A,
                          validationRules: const ['required'],
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
                          validationRules: const ['required'],
                          focusNode: passwords,
                          onEditing: () {
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
                        AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            onEnd: () => setState(() {
                                  bloc.isAnimating = !bloc.isAnimating;
                                }),
                            width: bloc.isSubmit
                                ? MediaQuery.of(context).size.width
                                : 70,
                            height: 55,
                            child: bloc.isAnimating || bloc.isSubmit
                                ? loginButton()
                                : circularLoading(bloc.isLoaded)),
                        const SizedBox(
                          height: 17,
                        ),
                        InkWell(
                          onTap: () {
                            bloc.add(ResendOTPEvent());
                          },
                          child: const CustomText(
                            Constants.resetPassword,
                            fontSize: FontSize.sixteen,
                            fontWeight: FontWeight.w600,
                            color: ColorResource.color23375A,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        CustomButton(
                          StringResource.loginViaDifferentUser,
                          onTap: () {
                            setState(() {
                              userId.clear();
                              password.clear();
                              _isChecked = false;
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

  Future<void> _signIn() async {
    final bool isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    } else {
      if (ConnectivityResult.none == await Connectivity().checkConnectivity()) {
        bloc.add(NoInternetConnectionEvent());
      } else {
        var params = {
          "userName": userId.text,
          "agentRef": userId.text,
          "password": password.text
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
  //         APIRequestType.POST,
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
  Widget loginButton() => CustomButton(
        StringResource.signIn.toUpperCase(),
        buttonBackgroundColor: ColorResource.color23375A,
        borderColor: ColorResource.color23375A,
        onTap: () {
          _signIn();
        },
        cardShape: 85,
        fontSize: FontSize.sixteen,
        fontWeight: FontWeight.w600,
      );
  // this is custom Widget to show rounded container
  // here is state is submitting, we are showing loading indicator on container then.
  // if it completed then showing a Icon.
  Widget circularLoading(bool done) {
    final color = done ? ColorResource.color23375A : ColorResource.color23375A;
    return Container(
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
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
