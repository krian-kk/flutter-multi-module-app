// // import 'package:flutter/material.dart';

// // class LoginResponse extends StatefulWidget {
// //   final String data;
// //   LoginResponse(this.data, {Key? key}) : super(key: key);

// //   @override
// //   _LoginResponseState createState() => _LoginResponseState();
// // }

// // class _LoginResponseState extends State<LoginResponse> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Keycloak Response'),
// //       ),
// //       body: SingleChildScrollView(
// //         child: Container(
// //           padding: EdgeInsets.all(15),
// //           child: Text(widget.data),
// //         ),
// //         ),
// //     );
// //   }
// // }


// import 'dart:convert';
// import 'dart:io';

// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:origa/authentication/authentication_bloc.dart';
// import 'package:origa/http/api_repository.dart';
// import 'package:origa/http/httpurls.dart';
// import 'package:origa/languages/app_languages.dart';
// import 'package:origa/models/login_response.dart';
// import 'package:origa/router.dart';
// import 'package:origa/screen/login_screen/login_response.dart';
// import 'package:origa/screen/reset_password_screen/reset_password_screen.dart';
// import 'package:origa/utils/app_utils.dart';
// import 'package:origa/utils/color_resource.dart';
// import 'package:origa/utils/constants.dart';
// import 'package:origa/utils/font.dart';
// import 'package:origa/utils/image_resource.dart';
// import 'package:origa/utils/string_resource.dart';
// import 'package:origa/widgets/bottomsheet_appbar.dart';
// import 'package:origa/widgets/custom_button.dart';
// import 'package:origa/widgets/custom_text.dart';
// import 'package:origa/widgets/custom_textfield.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import 'bloc/login_bloc.dart';
// import 'package:jwt_decoder/jwt_decoder.dart';

// class LoginScreen extends StatefulWidget {
//   final AuthenticationBloc authBloc;
//   const LoginScreen(this.authBloc, {Key? key}) : super(key: key);

//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   late LoginBloc bloc;

//   late TextEditingController userName = TextEditingController();
//   late TextEditingController password = TextEditingController();

//   final _formKey = GlobalKey<FormState>();

//   late FocusNode username;
//   late FocusNode passwords;
//   bool _obscureText = true;
//   bool _isChecked = false;
//   String? userType;

//   @override
//   void initState() {
//     bloc = LoginBloc()..add(LoginInitialEvent());
//     username = FocusNode();
//     passwords = FocusNode();
//     _loadUserNamePassword();
//     super.initState();
//   }

//   // _passwordVisibleOrNot the password show status
//   void _passwordVisibleOrNot() {
//     setState(() {
//       _obscureText = !_obscureText;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<LoginBloc, LoginState>(
//       bloc: bloc,
//       listener: (context, state) {
//         if (state is NoInternetConnectionState) {
//           AppUtils.noInternetSnackbar(context);
//         }

//         if (state is HomeTabState) {
//           Navigator.pushReplacementNamed(context, AppRoutes.homeTabScreen,
//               arguments: userType);
//         }
//       },
//       child: BlocBuilder<LoginBloc, LoginState>(
//         bloc: bloc,
//         builder: (context, state) {
//           return Scaffold(
//             backgroundColor: ColorResource.colorF8F9FB,
//             body: SingleChildScrollView(
//               child: Center(
//                 child: Padding(
//                   padding: const EdgeInsets.all(20.0),
//                   child: Form(
//                     key: _formKey,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         const SizedBox(
//                           height: 35,
//                         ),
//                         SvgPicture.asset(ImageResource.origa),
//                         const SizedBox(
//                           height: 17,
//                         ),
//                         SvgPicture.asset(ImageResource.login),
//                         const SizedBox(
//                           height: 20,
//                         ),
//                         CustomTextField(
//                           Languages.of(context)!.userName,
//                           userName,
//                           isFill: true,
//                           isBorder: true,
//                           isLabel: true,
//                           errorborderColor: ColorResource.color23375A,
//                           borderColor: ColorResource.color23375A,
//                           validationRules: ['required'],
//                           focusNode: username,
//                           onEditing: () {
//                             username.unfocus();
//                             _formKey.currentState!.validate();
//                           },
//                           autovalidateMode: AutovalidateMode.onUserInteraction,
//                           // onChange: (){
//                           //    _formKey.currentState!.validate();
//                           // },
//                           validatorCallBack: (bool values) {},
//                         ),
//                         const SizedBox(
//                           height: 23,
//                         ),
//                         CustomTextField(
//                           Languages.of(context)!.password,
//                           password,
//                           obscureText: _obscureText,
//                           isFill: true,
//                           isBorder: true,
//                           isLabel: true,
//                           borderColor: ColorResource.color23375A,
//                           errorborderColor: ColorResource.color23375A,
//                           validationRules: ['required'],
//                           focusNode: passwords,
//                           onEditing: () {
//                             print('object');
//                             passwords.unfocus();
//                             _formKey.currentState!.validate();
//                           },
//                           autovalidateMode: AutovalidateMode.onUserInteraction,
//                           // onChange: (){
//                           //    _formKey.currentState!.validate();
//                           // },
//                           validatorCallBack: (bool values) {},
//                           suffixWidget: InkWell(
//                             onTap: _passwordVisibleOrNot,
//                             child: Icon(
//                               _obscureText
//                                   ? Icons.visibility_off
//                                   : Icons.visibility,
//                               color: ColorResource.color23375A,
//                             ),
//                           ),
//                         ),
//                         Row(
//                           children: [
//                             Checkbox(
//                                 value: _isChecked,
//                                 activeColor: ColorResource.color23375A,
//                                 onChanged: (bool? newValue) {
//                                   final bool isValid =
//                                       _formKey.currentState!.validate();
//                                   if (!isValid) {
//                                     return;
//                                   } else {
//                                     _handleRemeberme(newValue!);
//                                   }
//                                 }),
//                             CustomText(
//                               Languages.of(context)!.rememberMe,
//                               color: ColorResource.color23375A,
//                             )
//                           ],
//                         ),
//                         const SizedBox(
//                           height: 20,
//                         ),
//                         CustomButton(
//                           StringResource.signIn.toUpperCase(),
//                           buttonBackgroundColor: ColorResource.color23375A,
//                           onTap: () {
//                             // _signIn();
//                             keyCloak();
//                           },
//                           cardShape: 85,
//                           fontSize: FontSize.sixteen,
//                           fontWeight: FontWeight.w600,
//                         ),
//                         const SizedBox(
//                           height: 17,
//                         ),
//                         InkWell(
//                           onTap: () {
//                             resendOTPBottomSheet(context);
//                             // AppUtils.showToast('Reset Password');
//                             // Navigator.push(context, MaterialPageRoute(builder: (context)=>DeviceInfo()));
//                           },
//                           child: const CustomText(
//                             Constants.resetPassword,
//                             fontSize: FontSize.sixteen,
//                             fontWeight: FontWeight.w600,
//                             color: ColorResource.color23375A,
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 30,
//                         ),
//                         CustomButton(
//                           StringResource.loginViaDifferentUser,
//                           onTap: () {
//                             setState(() {
//                               userName.clear();
//                               password.clear();
//                             });
//                           },
//                           borderColor: ColorResource.color23375A,
//                           cardShape: 85,
//                           fontSize: FontSize.sixteen,
//                           fontWeight: FontWeight.w600,
//                           textColor: ColorResource.color23375A,
//                           buttonBackgroundColor: ColorResource.colorffffff,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   resendOTPBottomSheet(BuildContext buildContext) {
//     showModalBottomSheet(
//       isScrollControlled: true,
//       isDismissible: false,
//       enableDrag: false,
//       context: buildContext,
//       backgroundColor: ColorResource.colorF8F9FB,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(
//           top: Radius.circular(20),
//         ),
//       ),
//       builder: (BuildContext context) {
//         return const ResetPasswordScreen();
//       },
//     );
//   }

//   Future<void> _signIn() async {
//     SharedPreferences _prefs = await SharedPreferences.getInstance();
//     final bool isValid = _formKey.currentState!.validate();
//     if (!isValid) {
//       return;
//     } else {
//       if (ConnectivityResult.none == await Connectivity().checkConnectivity()) {
//         bloc.add(NoInternetConnectionEvent());
//       }
//       if (userName.text == 'fos' && password.text == '1234') {
//         setState(() {
//           userType = 'FIELDAGENT';
//           _prefs.setString('userType', 'FIELDAGENT');
//         });
//         bloc.add(HomeTabEvent());
//       } else if (userName.text == 'tc' && password.text == '1234') {
//         setState(() {
//           userType = 'TELECALLER';
//           _prefs.setString('userType', 'TELECALLER');
//         });
//         bloc.add(HomeTabEvent());
//       } else {
//         AppUtils.showToast(Languages.of(context)!.passwordNotMatch);
//       }
//       // bloc.add(HomeTabEvent());
//     }
//     _formKey.currentState!.save();
//   }
  
//   LoginResponseModel loginResponse =
//       LoginResponseModel();

//   Future<void> keyCloak() async {
//     SharedPreferences _prefs = await SharedPreferences.getInstance();
    
//       var params =
//       {
//       "userName": "YES_suvodeepcollector", 
//       "agentRef": "YES_suvodeepcollector", 
//       "password": "Agent1234"
//       };
//         print('---------before execute----------');

//           Map<String, dynamic> response = await APIRepository.apiRequest(
//           APIRequestType.POST,
//           HttpUrl.loginUrl,
//           requestBodydata: params);

//           if (response['success']) {
//             loginResponse = LoginResponseModel.fromJson(response['data']);
//             _prefs.setString('accessToken', loginResponse.data!.accessToken!);
//             _prefs.setInt('accessTokenExpireTime', loginResponse.data!.expiresIn!);
//             _prefs.setString('refreshToken', loginResponse.data!.refreshToken!);
//             _prefs.setInt('refreshTokenExpireTime', loginResponse.data!.refreshExpiresIn!);
//             _prefs.setString('keycloakId', loginResponse.data!.keycloakId!);

//           }

//         // var params =  {
//       //         "username": "YES_suvodeepcollector",
//       //         "password": "Agent1234",
//       //         "grant_type": "password",
//       //         "client_id": "admin-cli",
//       //       }; 

//           // Response response = await _dio.post(
//           //   "http://10.221.10.248:8080/auth/realms/origa-dev/protocol/openid-connect/token",
//           //   options: Options(headers: {
//           //     HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded",
//           //   }),
//           //   data: jsonEncode(params),
//           // );
//           // print(params);
          

//         // var response = await http.post(
//         //     Uri.parse(HttpUrl.login_keycloak),
//         //     headers: <String, String>{
//         //       'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
//         //     },
//         //     body: params,
//         //   );
//         //   print('---------After execute----------');
//         //   print(response.statusCode.toString());
//         //   print(response.body);

//           // Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginResponse(response.body.toString())));

//   }

//   _handleRemeberme(bool value) {
//     _isChecked = value;
//     SharedPreferences.getInstance().then(
//       (prefs) {
//         prefs.setBool("remember_me", value);
//         prefs.setString('username', userName.text);
//         prefs.setString('password', password.text);
//       },
//     );
//     setState(() {
//       _isChecked = value;
//     });
//   }

//   void _loadUserNamePassword() async {
//     try {
//       SharedPreferences _prefs = await SharedPreferences.getInstance();
//       var _username = _prefs.getString("username") ?? "";
//       var _password = _prefs.getString("password") ?? "";
//       var _remeberMe = _prefs.getBool("remember_me") ?? false;

//       if (_remeberMe) {
//         setState(() {
//           _isChecked = true;
//         });
//         userName.text = _username;
//         password.text = _password;
//       }
//     } catch (e) {
//       print(e);
//     }
//   }

//   @override
//   void dispose() {
//     // Clean up the focus node when the Form is disposed
//     userName.dispose();
//     password.dispose();
//     super.dispose();
//   }
// }
