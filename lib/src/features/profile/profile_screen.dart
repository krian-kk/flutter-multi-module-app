import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:design_system/app_sizes.dart';
import 'package:design_system/colors.dart';
import 'package:design_system/fonts.dart';
import 'package:design_system/widgets/longRoundedBtnIcon_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:languages/app_languages.dart';
import 'package:origa/gen/assets.gen.dart';
import 'package:origa/http/api_repository.dart';
import 'package:origa/http/httpurls.dart';
import 'package:origa/models/profile_navigation_button_model.dart';
import 'package:origa/screen/message_screen/chat_screen.dart';
import 'package:origa/screen/mpin_screens/forgot_mpin_screen.dart';
import 'package:origa/screen/mpin_screens/new_mpin_screen.dart';
import 'package:origa/screen/reset_password_screen/reset_password_screen.dart';
import 'package:origa/src/features/profile/bloc/profile_bloc.dart';
import 'package:origa/src/features/profile/presentation/customer_language_preference/customer_language_preference.dart';
import 'package:origa/src/features/profile/presentation/language_bottom_sheet_screen/language_bottom_sheet_screen.dart';
import 'package:origa/utils/app_utils.dart';
import 'package:origa/utils/constants.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/utils/preference_helper.dart';
import 'package:origa/utils/skeleton.dart';
import 'package:origa/utils/string_resource.dart';
import 'package:origa/widgets/custom_loading_widget.dart';
import 'package:origa/widgets/custom_text.dart';
import 'package:repository/file_repository.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  late BuildContext mContext;
  Uint8List? profileImage;

  @override
  void initState() {
    mContext = context;
    BlocProvider.of<ProfileBloc>(context).add(ProfileInitialEvent());
    super.initState();
  }

  Future<bool> requestOTP(String aRef) async {
    const bool returnValue = false;
    final object = <String, dynamic>{'aRef': aRef};
    final Map<String, dynamic> requestData = {'data': jsonEncode(object)};
    final String text = '';
    // String text = await platform.invokeMethod('sendEncryptedData', requestData);
    final Map<String, dynamic> postResult = await APIRepository.apiRequest(
      APIRequestType.post,
      HttpUrl.requestOTPUrl(),
      requestBodydata: <String, dynamic>{
        'encryptedData': text,
      },
    );
    if (await postResult[Constants.success]) {
    } else {
      AppUtils.showToast('Some Issue in OTP Send, Please Try Again Later');
    }
    return returnValue;
  }

  Future<bool> createMpin(String? mPin) async {
    bool returnValue = false;
    final Map<String, dynamic> postResult = await APIRepository.apiRequest(
        APIRequestType.put, HttpUrl.createMpin,
        requestBodydata: <String, dynamic>{
          'mPin': mPin,
        });
    if (postResult[Constants.success]) {
      setState(() => returnValue = true);
    } else {
      setState(() => returnValue = false);
      // AppUtils.showErrorToast("OTP does't match");
    }
    return returnValue;
  }

  Future<bool> verifyOTP(String? aRef, String? otp) async {
    bool returnValue = false;
    final Map<String, dynamic> postResult = await APIRepository.apiRequest(
        APIRequestType.post, HttpUrl.verifyOTP(),
        requestBodydata: <String, dynamic>{
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

  Future<void> showForgorSecurePinDialogBox(String userName) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
              side:
                  BorderSide(width: 0.5, color: ColorResourceDesign.lightGray),
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            contentPadding: const EdgeInsets.all(20),
            content: ForgotMpinScreen(
              submitOtpFunction:
                  (String? otp, bool? isError, Function()? function) async {
                final bool result = await verifyOTP(userName, otp);
                if (result) {
                  Navigator.pop(context);
                  await showNewMpinDialogBox();
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

  Future<void> showNewMpinDialogBox() async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
              side:
                  BorderSide(width: 0.5, color: ColorResourceDesign.lightGray),
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            contentPadding: const EdgeInsets.all(20),
            content: NewMpinScreen(
              saveFuction: (String? mPin) async {
                // New Pin Create Api in this
                if (await createMpin(mPin)) {
                  AppUtils.showToast('Change MPin Successfully');
                  PreferenceHelper.setPreference(Constants.mPin, mPin);
                  Navigator.pop(context);
                } else {
                  AppUtils.showToast('Change Mpin has some Issue');
                }
              },
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    final List<ProfileNavigation> profileNavigationList = <ProfileNavigation>[
      ProfileNavigation(
          title: Languages.of(context)!.selectAppLanguage,
          isEnable: true,
          onTap: () {
            BlocProvider.of<ProfileBloc>(context)
                .add(InitialClickChangeLanguageEvent());
          }),
      ProfileNavigation(
          title: Languages.of(context)!.selectSpeechToTextLanguage,
          isEnable: true,
          // Singleton.instance.usertype == Constants.fieldagent
          //     ? true
          //     : false,
          onTap: () {
            BlocProvider.of<ProfileBloc>(context)
                .add(InitialCustomerLanguagePreferenceEvent());
          }),
    ];
    return BlocListener<ProfileBloc, ProfileState>(
      bloc: BlocProvider.of<ProfileBloc>(context),
      listener: (BuildContext context, ProfileState state) async {
        if (state is OpenChangeLanguagePopUpState) {
          languageBottomSheet();
        }

        if (state is ImagePopUpState) {
          openImagePickerModal();
        }

        if (state is CustomerLanguagePreferenceState) {
          customerSupportLanguageBottomSheet();
        }
        if (state is ClickMessageState) {
          messageShowBottomSheet(fromID: state.fromId, toID: state.toId);
        }

        if (state is SuccessUpdatedProfileImageState) {
          AppUtils.topSnackBar(context, StringResource.profileImageChanged);
        }
        if (state is FailureUpdateProfileImageState) {
          AppUtils.topSnackBar(
              context, StringResource.FailureprofileImageChanged);
        }

        if (state is NoInternetState) {
          AppUtils.noInternetSnackbar(context);
        }
        if (state is ClickChangePasswordState) {
          changePasswordBottomSheet(context);
        }
        if (state is LoginState) {
          while (context.canPop()) {
            context.pop();
          }
          context.pushReplacement(context.namedLocation('login'));
        }
      },
      child: BlocBuilder<ProfileBloc, ProfileState>(
          bloc: BlocProvider.of<ProfileBloc>(context),
          builder: (BuildContext context, ProfileState state) {
            if (state is AuthorizationLoadingState) {
              return const CustomLoadingWidget();
            }
            if (state is ProfileLoadingState) {
              return const SkeletonLoading();
            }
            return BlocProvider.of<ProfileBloc>(context)
                    .isNoInternetAndServerError
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CustomText(BlocProvider.of<ProfileBloc>(context)
                            .noInternetAndServerErrorMsg!),
                        const SizedBox(
                          height: 5,
                        ),
                        IconButton(
                            onPressed: () {
                              BlocProvider.of<ProfileBloc>(context)
                                  .add(ProfileInitialEvent());
                            },
                            icon: const Icon(Icons.refresh)),
                      ],
                    ),
                  )
                : Scaffold(
                    backgroundColor: ColorResourceDesign.whiteTwo,
                    body: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20.0, 9, 20, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: ColorResourceDesign.whiteColor,
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                      color: ColorResourceDesign.blackTwo
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
                                  children: <Widget>[
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Stack(
                                          children: <Widget>[
                                            GestureDetector(
                                              onTap: () => BlocProvider.of<
                                                      ProfileBloc>(context)
                                                  .add(InitialImageTapEvent()),
                                              child: BlocProvider.of<ProfileBloc>(
                                                              context)
                                                          .image !=
                                                      null
                                                  ? CircleAvatar(
                                                      radius: 25,
                                                      backgroundImage: FileImage(File(
                                                          BlocProvider.of<ProfileBloc>(
                                                                  context)
                                                              .image!
                                                              .path)))
                                                  : profileImage != null
                                                      ? CircleAvatar(
                                                          radius: 25,
                                                          backgroundImage:
                                                              Image.memory(
                                                                      profileImage!)
                                                                  .image)
                                                      : Container(
                                                          width: 45,
                                                          height: 45,
                                                          decoration:
                                                              BoxDecoration(
                                                            color:
                                                                ColorResourceDesign
                                                                    .blueColor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        52.5),
                                                          ),
                                                          child: SvgPicture.asset(
                                                              ImageResource
                                                                  .profileImagePicker)),
                                            ),
                                            if (BlocProvider.of<ProfileBloc>(
                                                    context)
                                                .isProfileImageUpdating)
                                              const CircleAvatar(
                                                radius: 25,
                                                backgroundColor:
                                                    ColorResourceDesign
                                                        .blueColor,
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
                                          children: <Widget>[
                                            CustomText(
                                              BlocProvider.of<ProfileBloc>(
                                                      context)
                                                  .profileAPIValue
                                                  .aRef
                                                  .toString(),
                                              fontSize: Sizes.p18,
                                              fontWeight: FontWeight.w700,
                                              color: ColorResourceDesign
                                                  .appTextPrimaryColor,
                                            ),
                                            const SizedBox(height: 11),
                                            CustomText(
                                              BlocProvider.of<ProfileBloc>(
                                                      context)
                                                  .profileAPIValue
                                                  .name
                                                  .toString(),
                                              fontSize: Sizes.p16,
                                              color: ColorResourceDesign
                                                  .appTextPrimaryColor,
                                            ),
                                            CustomText(
                                              BlocProvider.of<ProfileBloc>(
                                                      context)
                                                  .profileAPIValue
                                                  .defMobileNumber
                                                  .toString(),
                                              fontSize: Sizes.p16,
                                              fontWeight: FontWeight.w700,
                                              color: ColorResourceDesign
                                                  .appTextPrimaryColor,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 30),
                                    const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Spacer(),
                                      ],
                                    ),
                                    ListView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: profileNavigationList.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return profileNavigationList[index]
                                                  .isEnable
                                              ? GestureDetector(
                                                  onTap: profileNavigationList[
                                                          index]
                                                      .onTap,
                                                  child: Container(
                                                    width: double.infinity,
                                                    margin: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 5.0),
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 4),
                                                    decoration: const BoxDecoration(
                                                        color:
                                                            ColorResourceDesign
                                                                .lightWhiteGray,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10.0))),
                                                    child: ListTile(
                                                      title: SizedBox(
                                                        // width: 260,
                                                        child: CustomText(
                                                          profileNavigationList[
                                                                  index]
                                                              .title
                                                              .toUpperCase(),
                                                          lineHeight: 1.4,
                                                          fontSize: Sizes.p16,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color:
                                                              ColorResourceDesign
                                                                  .textColor,
                                                        ),
                                                      ),
                                                      trailing: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: <Widget>[
                                                          SvgPicture.asset(
                                                              ImageResource
                                                                  .forwardArrow),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : const SizedBox();
                                        }),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 22),
                            GestureDetector(
                              onTap: () => BlocProvider.of<ProfileBloc>(context)
                                  .add(LoginEvent()),
                              child: Container(
                                width: 125,
                                height: 40,
                                decoration: BoxDecoration(
                                    color: ColorResourceDesign.whiteColor,
                                    border: Border.all(
                                        color: ColorResourceDesign.blueColor,
                                        width: 0.5),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(75.0))),
                                child: Center(
                                  child: CustomText(
                                    Languages.of(context)!.logout.toUpperCase(),
                                    fontSize: Sizes.p12,
                                    color: ColorResourceDesign.textColor,
                                    fontWeight: FontWeight.w700,
                                    lineHeight: 1,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 25),
                          ],
                        ),
                      ),
                    ),
                    floatingActionButton: Visibility(
                      visible: false,
                      child: GestureDetector(
                        onTap: () {
                          webViewScreen(context,
                              urlAddress: 'https://origahelpdesk.w3spaces.com');
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(30),
                                bottomRight: Radius.circular(30),
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(5)),
                            color: ColorResourceDesign.blueColor,
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
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
                                    .titleMedium!
                                    .copyWith(
                                        color: Colors.white,
                                        fontSize: 6,
                                        backgroundColor: Colors.transparent),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
          }),
    );
  }

  webViewScreen(BuildContext context, {required String urlAddress}) {
    showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: false,
      context: context,
      backgroundColor: ColorResourceDesign.whiteColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(100),
        ),
      ),
      builder: (BuildContext context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.9,
          // child: WebViewWidget(urlAddress: urlAddress),
        );
      },
    );
  }

  changePasswordBottomSheet(BuildContext buildContext) {
    showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
      context: buildContext,
      backgroundColor: ColorResourceDesign.lightWhiteGray,
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
        backgroundColor: ColorResourceDesign.whiteColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        builder: (BuildContext context) => StatefulBuilder(
              builder: (BuildContext buildContext, StateSetter setState) =>
                  LanguageBottomSheetScreen(mcontext: mContext),
            ));
  }

  customerSupportLanguageBottomSheet() {
    showModalBottomSheet(
        context: context,
        isDismissible: false,
        enableDrag: false,
        isScrollControlled: true,
        backgroundColor: ColorResourceDesign.whiteColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        builder: (BuildContext context) => StatefulBuilder(
            builder: (BuildContext buildContext, StateSetter setState) =>
                CustomerLanguagePreference(mcontext: mContext)));
  }

  messageShowBottomSheet({String? fromID, String? toID}) {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      enableDrag: false,
      isScrollControlled: true,
      backgroundColor: ColorResourceDesign.whiteColor,
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
  }

  notificationShowBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isDismissible: false,
        enableDrag: false,
        isScrollControlled: true,
        backgroundColor: ColorResourceDesign.whiteColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        builder: (BuildContext context) => StatefulBuilder(
              builder: (BuildContext buildContext, StateSetter setState) =>
                  Container(),
              // NotificationBottomSheetScreen(
              //     bloc: BlocProvider.of<ProfileBloc>(context)),
            ));
  }

  void openImagePickerModal() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return GetPhotoView(mContext: mContext);
      },
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
        top: Radius.circular(Sizes.p20),
      )),
      backgroundColor: Colors.transparent,
    );
  }
}

class GetPhotoView extends StatelessWidget {
  const GetPhotoView({super.key, required this.mContext});

  final BuildContext mContext;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.35,
      builder: (_, controller) => Container(
          decoration: const BoxDecoration(
            color: ColorResourceDesign.whiteColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: Sizes.p20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(Languages.of(context)!.captureImage.toUpperCase(),
                        style: const TextStyle(
                          color: ColorResourceDesign.textColor,
                          fontSize: Sizes.p14,
                          fontWeight: FontResourceDesign.textFontWeightSemiBold,
                        )),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        minimumSize: Size.zero,
                        padding: EdgeInsets.zero,
                      ),
                      child: SvgPicture.asset(Assets.images.resetPasswordCross),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const SizedBox(height: 60),
                LongRoundedBtnIcon(
                  btnText: Languages.of(context)!.captureImage,
                  isBorder: false,
                  onPressed: () async {
                    Navigator.pop(context);
                    BlocProvider.of<ProfileBloc>(mContext).add(
                        InitialImageEvent(
                            imageType: ImagePickerType.camera.toString()));
                  },
                  // btnImage: SvgPicture.asset(Assets.images.captureImage),
                  btnImage: SvgPicture.asset(ImageResource.captureImage),
                  btnBackgroundColor: ColorResourceDesign.lightGray,
                  btnTextColor: ColorResourceDesign.textColor,
                  btnWidth: 340,
                ),
                gapH20,
                LongRoundedBtnIcon(
                  btnText: Languages.of(context)!.uploadPhoto,
                  isBorder: false,
                  onPressed: () async {
                    Navigator.pop(context);
                    BlocProvider.of<ProfileBloc>(mContext).add(
                        InitialImageEvent(
                            imageType: ImagePickerType.gallery.toString()));
                  },
                  btnImage: SvgPicture.asset(ImageResource.uploadPhoto),
                  // btnImage: SvgPicture.asset(Assets.images.uploadPhoto),
                  btnBackgroundColor: ColorResourceDesign.lightGray,
                  btnTextColor: ColorResourceDesign.textColor,
                  btnWidth: 340,
                ),
              ],
            ),
          )),
    );
  }
}
