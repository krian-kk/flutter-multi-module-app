import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/models/profile_navigation_button_model.dart';
import 'package:origa/router.dart';
import 'package:origa/screen/map_view_bottom_sheet_screen/map_view_bottom_sheet_screen.dart';
import 'package:origa/screen/message_screen/chat_screen.dart';
import 'package:origa/screen/profile_screen.dart/bloc/profile_bloc.dart';
import 'package:origa/screen/profile_screen.dart/language_bottom_sheet_screen.dart';
import 'package:origa/screen/profile_screen.dart/notification_bottom_sheet_screen.dart';
import 'package:origa/screen/reset_password_screen/reset_password_screen.dart';
import 'package:origa/singleton.dart';
import 'package:origa/utils/app_utils.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/constants.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/utils/string_resource.dart';
import 'package:origa/widgets/custom_button.dart';
import 'package:origa/widgets/custom_loading_widget.dart';
import 'package:origa/widgets/custom_text.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late ProfileBloc bloc;
  String addressValue = '';
  Uint8List? profileImage;

  @override
  void initState() {
    bloc = ProfileBloc()..add(ProfileInitialEvent(context));
    getAddress();
    super.initState();
  }

  void getAddress() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    addressValue = (_pref.getString('addressValue') ?? '').toString();
  }

  Future pickImage(
      ImageSource source, BuildContext cameraDialogueContext) async {
    Navigator.pop(cameraDialogueContext);
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image != null) {
        final getProfileImage = File(image.path);
        setState(() {
          bloc.image = getProfileImage;
          bloc.add(PostProfileImageEvent(postValue: getProfileImage));
        });
      } else {
        AppUtils.showToast(StringResource.canceled,
            gravity: ToastGravity.CENTER);
      }
    } on PlatformException catch (e) {
      print(e.message);
    }
  }

  Future<void> showSecurePinDialogBox() async {
    TextEditingController pinCodeContoller = TextEditingController();
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
                          Languages.of(context)!.changeYourSecureDigitPIN,
                          fontSize: FontSize.sixteen,
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
                CustomText(
                  Languages.of(context)!.newPin,
                  fontSize: FontSize.sixteen,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w700,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: PinCodeTextField(
                    appContext: context,
                    controller: pinCodeContoller,
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
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    List<ProfileNavigation> profileNavigationList = [
      // ProfileNavigation(
      //     title: Languages.of(context)!.notification,
      //     notificationCount: 3,
      //     onTap: () {
      //       bloc.add(ClickNotificationEvent());
      //     }),
      ProfileNavigation(
          title: Languages.of(context)!.selectLanguage,
          onTap: () {
            bloc.add(ClickChangeLaunguageEvent());
          }),
      ProfileNavigation(
          title: Languages.of(context)!.changePassword,
          onTap: () {
            bloc.add(ClickChangePassswordEvent());
          }),
      // ProfileNavigation(
      //     title: Languages.of(context)!.changeSecurePIN,
      //     onTap: () {
      //       bloc.add(ClickChangeSecurityPinEvent());
      //     })
    ];
    return BlocListener<ProfileBloc, ProfileState>(
      bloc: bloc,
      listener: (context, state) {
        if (state is PostDataApiSuccessState) {
          AppUtils.topSnackBar(context, StringResource.profileImageChanged);
        }
        if (state is ClickNotificationState) {
          notificationShowBottomSheet(context);
        }
        if (state is ClickChangeLaunguageState) {
          languageBottomSheet();
        }
        if (state is ClickMessageState) {
          // Navigator.push(
          //     context, MaterialPageRoute(builder: (context) => ChatScreen()));
          messageShowBottomSheet(fromID: state.fromId, toID: state.toId);
        }
        if (state is ChangeProfileImageState) {
          profileImageShowBottomSheet();
        }
        if (state is NoInternetState) {
          AppUtils.noInternetSnackbar(context);
        }
        if (state is ClickChangePasswordState) {
          changePasswordBottomSheet(context);
        }
        if (state is ClickMarkAsHomeState) {
          markAsHomeShowBottomSheet(context);
        }
        if (state is LoginState) {
          Navigator.pushNamedAndRemoveUntil(
              context, AppRoutes.loginScreen, (route) => false);
        }
        if (state is ClickChangeSecurityPinState) {
          showSecurePinDialogBox();
        }
      },
      child: BlocBuilder<ProfileBloc, ProfileState>(
        bloc: bloc,
        builder: (context, state) {
          if (state is ProfileLoadingState) {
            return const CustomLoadingWidget();
          } else {
            if (bloc.profileAPIValue.result?.first.profileImgUrl != null) {
              profileImage = base64
                  .decode(bloc.profileAPIValue.result!.first.profileImgUrl!);
            }
            return bloc.isNoInternetAndServerError
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(bloc.noInternetAndServerErrorMsg!),
                        const SizedBox(
                          height: 5,
                        ),
                        IconButton(
                            onPressed: () {
                              bloc.add(ProfileInitialEvent(context));
                            },
                            icon: const Icon(Icons.refresh)),
                      ],
                    ),
                  )
                : Scaffold(
                    backgroundColor: ColorResource.colorF7F8FA,
                    body: Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 9, 20, 0),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: ColorResource.colorFFFFFF,
                                  boxShadow: [
                                    BoxShadow(
                                      color: ColorResource.color000000
                                          .withOpacity(0.2),
                                      blurRadius: 2.0,
                                      offset: const Offset(1.0, 1.0),
                                    )
                                  ],
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10.0))),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 19.0),
                                child: Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Stack(
                                          children: [
                                            GestureDetector(
                                              onTap: () => bloc.add(
                                                  ChangeProfileImageEvent()),
                                              child: bloc.image != null
                                                  ? CircleAvatar(
                                                      radius: 25,
                                                      backgroundImage:
                                                          FileImage(File(bloc
                                                              .image!.path)))
                                                  : profileImage != null
                                                      ? CircleAvatar(
                                                          radius: 25,
                                                          backgroundImage:
                                                              Image.memory(
                                                                      profileImage!)
                                                                  .image)
                                                      : Container(
                                                          child: SvgPicture.asset(
                                                              ImageResource
                                                                  .profileImagePicker),
                                                          width: 45,
                                                          height: 45,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: ColorResource
                                                                .color23375A,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        52.5),
                                                          ),
                                                        ),
                                            ),
                                            if (bloc.isProfileImageUpdating)
                                              const CircleAvatar(
                                                radius: 25,
                                                backgroundColor:
                                                    ColorResource.color23375A,
                                                child: Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: CustomLoadingWidget(
                                                    strokeWidth: 3.0,
                                                  ),
                                                ),
                                              )
                                          ],
                                        ),
                                        SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.013),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            CustomText(
                                              bloc.profileAPIValue.result?.first
                                                      .aRef
                                                      .toString() ??
                                                  '_',
                                              fontSize: FontSize.eighteen,
                                              fontStyle: FontStyle.normal,
                                              fontWeight: FontWeight.w700,
                                              color: ColorResource.color101010,
                                            ),
                                            const SizedBox(height: 11),
                                            CustomText(
                                              bloc.profileAPIValue.result?.first
                                                      .name
                                                      .toString() ??
                                                  '_',
                                              fontSize: FontSize.sixteen,
                                              fontStyle: FontStyle.normal,
                                              fontWeight: FontWeight.w400,
                                              color: ColorResource.color101010,
                                            ),
                                            CustomText(
                                              bloc.profileAPIValue.result?.first
                                                      .defMobileNumber
                                                      .toString() ??
                                                  '_',
                                              fontSize: FontSize.sixteen,
                                              fontStyle: FontStyle.normal,
                                              fontWeight: FontWeight.w700,
                                              color: ColorResource.color101010,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 30),
                                    Singleton.instance.usertype ==
                                            Constants.fieldagent
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              CustomText(
                                                Languages.of(context)!
                                                    .homeAddress
                                                    .toUpperCase(),
                                                fontSize: FontSize.fourteen,
                                                fontStyle: FontStyle.normal,
                                                fontWeight: FontWeight.w700,
                                                color:
                                                    ColorResource.color101010,
                                              ),
                                              GestureDetector(
                                                onTap: () => bloc.add(
                                                    ClickMarkAsHomeEvent()),
                                                child: SizedBox(
                                                  child: CustomText(
                                                    Languages.of(context)!
                                                        .markAsHome,
                                                    fontSize: FontSize.twelve,
                                                    isUnderLine: true,
                                                    fontStyle: FontStyle.normal,
                                                    fontWeight: FontWeight.w700,
                                                    color: ColorResource
                                                        .color101010,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        : const SizedBox(),
                                    const SizedBox(height: 5),
                                    Singleton.instance.usertype ==
                                            Constants.fieldagent
                                        ? Container(
                                            width: double.infinity,
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 5.0),
                                            decoration: const BoxDecoration(
                                                color:
                                                    ColorResource.colorF8F9FB,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0))),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 20,
                                                vertical: 16.0,
                                              ),
                                              child: CustomText(
                                                addressValue != ''
                                                    ? addressValue
                                                    : bloc
                                                            .profileAPIValue
                                                            .result
                                                            ?.first
                                                            .homeAddress ??
                                                        'Home address not available.',
                                                fontSize: FontSize.fourteen,
                                                fontWeight: FontWeight.w400,
                                                fontStyle: FontStyle.normal,
                                                color:
                                                    ColorResource.color484848,
                                              ),
                                            ),
                                          )
                                        : const SizedBox(),
                                    ListView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: profileNavigationList.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return GestureDetector(
                                            onTap: profileNavigationList[index]
                                                .onTap,
                                            child: Container(
                                              width: double.infinity,
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 5.0),
                                              decoration: const BoxDecoration(
                                                  color:
                                                      ColorResource.colorF8F9FB,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              10.0))),
                                              child: ListTile(
                                                title: SizedBox(
                                                  // width: 260,
                                                  child: CustomText(
                                                    profileNavigationList[index]
                                                        .title
                                                        .toUpperCase(),
                                                    lineHeight: 1,
                                                    fontSize: FontSize.sixteen,
                                                    fontWeight: FontWeight.w700,
                                                    fontStyle: FontStyle.normal,
                                                    color: ColorResource
                                                        .color23375A,
                                                  ),
                                                ),
                                                trailing: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    SvgPicture.asset(
                                                        ImageResource
                                                            .forwardArrow),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        }),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 22),
                            GestureDetector(
                              onTap: () => bloc.add(LoginEvent()),
                              child: Container(
                                width: 125,
                                height: 40,
                                decoration: BoxDecoration(
                                    color: ColorResource.colorFFFFFF,
                                    border: Border.all(
                                        color: ColorResource.color23375A,
                                        width: 0.5),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(75.0))),
                                child: Center(
                                  child: CustomText(
                                    Languages.of(context)!.logout.toUpperCase(),
                                    fontSize: FontSize.twelve,
                                    color: ColorResource.color23375A,
                                    fontWeight: FontWeight.w700,
                                    lineHeight: 1,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    bottomNavigationBar: Container(
                      width: double.infinity,
                      color: ColorResource.colorFFFFFF,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 11.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 200,
                              child: CustomButton(
                                Languages.of(context)!.message,
                                onTap: () => bloc.add(ClickMessageEvent(
                                  fromId: bloc.profileAPIValue.result![0].aRef,
                                  toId: bloc.profileAPIValue.result![0].parent,
                                )),
                                fontSize: FontSize.sixteen,
                                cardShape: 5,
                                isTrailing: false,
                                leadingWidget: const CircleAvatar(
                                  radius: 13,
                                  backgroundColor: ColorResource.colorFFFFFF,
                                  child: CustomText(
                                    '2',
                                    fontSize: FontSize.twelve,
                                    lineHeight: 1,
                                    color: ColorResource.colorEA6D48,
                                    fontWeight: FontWeight.w700,
                                    fontStyle: FontStyle.normal,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
          }
        },
      ),
    );
  }

  profileImageShowBottomSheet() {
    showModalBottomSheet(
        context: context,
        isDismissible: false,
        enableDrag: false,
        isScrollControlled: true,
        backgroundColor: ColorResource.colorFFFFFF,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        builder: (BuildContext context) => StatefulBuilder(
            builder: (BuildContext buildContext, StateSetter setState) =>
                SizedBox(
                  height: 270.0,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              Languages.of(context)!
                                  .addAProfilePhoto
                                  .toUpperCase(),
                              color: ColorResource.color23375A,
                              fontSize: FontSize.fourteen,
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.normal,
                            ),
                            const Spacer(),
                            GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: SvgPicture.asset(ImageResource.close))
                          ],
                        ),
                        const SizedBox(height: 60),
                        CustomButton(
                          Languages.of(context)!.captureImage.toUpperCase(),
                          cardShape: 75.0,
                          textColor: ColorResource.color23375A,
                          fontSize: FontSize.sixteen,
                          fontWeight: FontWeight.w700,
                          padding: 15.0,
                          borderColor: ColorResource.colorBEC4CF,
                          buttonBackgroundColor: ColorResource.colorBEC4CF,
                          isLeading: true,
                          onTap: () => pickImage(ImageSource.camera, context),
                          trailingWidget:
                              SvgPicture.asset(ImageResource.captureImage),
                        ),
                        const SizedBox(height: 20),
                        CustomButton(
                          Languages.of(context)!.uploadPhoto,
                          textColor: ColorResource.color23375A,
                          fontSize: FontSize.sixteen,
                          fontWeight: FontWeight.w700,
                          padding: 15.0,
                          cardShape: 75.0,
                          onTap: () => pickImage(ImageSource.gallery, context),
                          borderColor: ColorResource.colorBEC4CF,
                          buttonBackgroundColor: ColorResource.colorBEC4CF,
                          isLeading: true,
                          trailingWidget:
                              SvgPicture.asset(ImageResource.uploadPhoto),
                        ),
                      ],
                    ),
                  ),
                )));
  }

  changePasswordBottomSheet(BuildContext buildContext) {
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

  languageBottomSheet() {
    showModalBottomSheet(
        context: context,
        isDismissible: false,
        enableDrag: false,
        isScrollControlled: true,
        backgroundColor: ColorResource.colorFFFFFF,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        builder: (BuildContext context) => StatefulBuilder(
            builder: (BuildContext buildContext, StateSetter setState) =>
                LanguageBottomSheetScreen(bloc: bloc)));
  }

  messageShowBottomSheet({String? fromID, String? toID}) {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      enableDrag: false,
      isScrollControlled: true,
      backgroundColor: ColorResource.colorFFFFFF,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      builder: (BuildContext context) => StatefulBuilder(
        builder: (BuildContext buildContext, StateSetter setState) => SizedBox(
          height: MediaQuery.of(context).size.height * 0.86,
          child: ChatScreen(
              fromARefId: fromID,
              toARefId: toID,
              agentImage: profileImage != null
                  ? Image.memory(profileImage!).image
                  : null),
        ),
      ),
    );
    // MessageChatRoomScreen(bloc)
  }

  notificationShowBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isDismissible: false,
        enableDrag: false,
        isScrollControlled: true,
        backgroundColor: ColorResource.colorFFFFFF,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        builder: (BuildContext context) => StatefulBuilder(
            builder: (BuildContext buildContext, StateSetter setState) =>
                NotificationBottomSheetScreen(bloc: bloc)));
  }

  markAsHomeShowBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isDismissible: false,
        enableDrag: false,
        isScrollControlled: true,
        backgroundColor: ColorResource.colorFFFFFF,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        builder: (BuildContext context) => LayoutBuilder(
            builder: (BuildContext buildContext, BoxConstraints settate) =>
                MapViewBottomSheetScreen(
                  title: Languages.of(context)!.markAsHome,
                  onClose: (value) async {
                    SharedPreferences _pref =
                        await SharedPreferences.getInstance();
                    setState(() {
                      addressValue = value;
                      _pref.setString('addressValue', value);
                    });
                  },
                )));
  }
}
