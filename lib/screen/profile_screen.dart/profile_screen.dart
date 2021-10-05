// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/screen/profile_screen.dart/bloc/profile_bloc.dart';
import 'package:origa/screen/profile_screen.dart/language_bottom_sheet_screen.dart';
import 'package:origa/screen/profile_screen.dart/notification_bottom_sheet_screen.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/utils/string_resource.dart';
import 'package:origa/widgets/custom_button.dart';
import 'package:origa/widgets/custom_text.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late ProfileBloc bloc;
  File? image;
  @override
  void initState() {
    bloc = ProfileBloc()..add(ProfileInitialEvent());
    super.initState();
  }

  Future pickImage(
      ImageSource source, BuildContext cameraDialogueContext) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final imageTemporary = File(image.path);
      print(imageTemporary);
      setState(() => this.image = imageTemporary);
    } on PlatformException catch (e) {
      print(e.message);
    }
    Navigator.pop(cameraDialogueContext);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      bloc: bloc,
      listener: (context, state) {
        if (state is ClickNotificationState) {
          notificationShowBottomSheet(context);
        }
        if (state is ClickChangeLaunguageState) {
          launguageBottomSheet();
        }
        if (state is ClickMessageState) {
          messageShowBottomSheet();
        }
        if (state is ChangeProfileImageState) {
          profileImageShowBottomSheet();
        }
      },
      child: BlocBuilder<ProfileBloc, ProfileState>(
        bloc: bloc,
        builder: (context, state) {
          if (state is ProfileLoadedState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Scaffold(
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
                        decoration: new BoxDecoration(
                            color: ColorResource.colorFFFFFF,
                            boxShadow: [
                              BoxShadow(
                                color:
                                    ColorResource.color000000.withOpacity(0.2),
                                blurRadius: 2.0,
                                offset: Offset(
                                    1.0, 1.0), // shadow direction: bottom right
                              )
                            ],
                            borderRadius:
                                new BorderRadius.all(Radius.circular(10.0))),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 19.0),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () =>
                                        bloc.add(ChangeProfileImageEvent()),
                                    child: image == null
                                        ? CircleAvatar(
                                            radius: 25,
                                            backgroundImage: AssetImage(
                                                ImageResource.profile))
                                        : CircleAvatar(
                                            radius: 25,
                                            backgroundImage:
                                                FileImage(File(image!.path))),
                                  ),
                                  SizedBox(width: 13),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                        'USER ID  1004',
                                        fontSize: FontSize.eighteen,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w700,
                                        color: ColorResource.color101010,
                                      ),
                                      SizedBox(height: 11),
                                      CustomText(
                                        'Debashish Patnaik',
                                        fontSize: FontSize.sixteen,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w400,
                                        color: ColorResource.color101010,
                                      ),
                                      CustomText(
                                        '7002792169',
                                        fontSize: FontSize.sixteen,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w700,
                                        color: ColorResource.color101010,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(height: 30),
                              Row(
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
                                    color: ColorResource.color101010,
                                  ),
                                  CustomText(
                                    Languages.of(context)!.markAsHome,
                                    fontSize: FontSize.twelve,
                                    isUnderLine: true,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w700,
                                    color: ColorResource.color101010,
                                  ),
                                ],
                              ),
                              SizedBox(height: 5),
                              Container(
                                width: double.infinity,
                                margin: EdgeInsets.symmetric(vertical: 5.0),
                                decoration: new BoxDecoration(
                                    color: ColorResource.colorF8F9FB,
                                    borderRadius: new BorderRadius.all(
                                        Radius.circular(10.0))),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 16, 15, 4),
                                  child: CustomText(
                                    '2/345, 6th Main Road Gomathipuram, Madurai - 625032',
                                    fontSize: FontSize.fourteen,
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                    color: ColorResource.color484848,
                                  ),
                                ),
                              ),
                              ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: bloc.profileNavigationList.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Container(
                                      width: double.infinity,
                                      margin:
                                          EdgeInsets.symmetric(vertical: 5.0),
                                      decoration: new BoxDecoration(
                                          color: ColorResource.colorF8F9FB,
                                          borderRadius: new BorderRadius.all(
                                              Radius.circular(10.0))),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 21, vertical: 14),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            GestureDetector(
                                              onTap: bloc
                                                  .profileNavigationList[index]
                                                  .onTap,
                                              // () {
                                              //   switch (bloc
                                              //       .profileNavigationList[
                                              //           index]
                                              //       .title) {
                                              //     case 'Notification':
                                              //       notificationShowBottomSheet(
                                              //           context);
                                              //       break;
                                              //     case 'Select Launguage':
                                              //       launguageBottomSheet();
                                              //       break;
                                              //     case 'Change Password':
                                              //       break;
                                              //   }
                                              // },
                                              child: Row(
                                                children: [
                                                  CustomText(
                                                    bloc
                                                        .profileNavigationList[
                                                            index]
                                                        .title
                                                        .toUpperCase(),
                                                    lineHeight: 1,
                                                    fontSize: FontSize.sixteen,
                                                    fontWeight: FontWeight.w700,
                                                    fontStyle: FontStyle.normal,
                                                    color: ColorResource
                                                        .color23375A,
                                                  ),
                                                  SizedBox(width: 5),
                                                  Visibility(
                                                    visible: bloc
                                                        .profileNavigationList[
                                                            index]
                                                        .count,
                                                    child: CircleAvatar(
                                                      backgroundColor:
                                                          ColorResource
                                                              .color23375A,
                                                      radius: 13,
                                                      child: Center(
                                                        child: CustomText('2',
                                                            lineHeight: 1,
                                                            fontSize:
                                                                FontSize.twelve,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color: ColorResource
                                                                .colorFFFFFF),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Image.asset(
                                                ImageResource.forwardArrow)
                                          ],
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
                        // onTap: () =>
                        //     Navigator.popUntil(context, (route) => false),
                        child: Container(
                          width: 125,
                          height: 40,
                          decoration: new BoxDecoration(
                              color: ColorResource.colorFFFFFF,
                              border: Border.all(
                                  color: ColorResource.color23375A, width: 0.5),
                              borderRadius:
                                  new BorderRadius.all(Radius.circular(75.0))),
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
                  padding: EdgeInsets.symmetric(horizontal: 85, vertical: 11.0),
                  child: Container(
                    decoration: BoxDecoration(),
                    child: CustomButton(
                      Languages.of(context)!.message,
                      onTap: () => bloc.add(ClickMessageEvent()),
                      cardShape: 5,
                      isTrailing: true,
                      leadingWidget: CircleAvatar(
                        radius: 13,
                        backgroundColor: ColorResource.colorFFFFFF,
                        child: CustomText('2',
                            fontSize: FontSize.twelve,
                            lineHeight: 1,
                            color: ColorResource.colorEA6D48,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal),
                      ),
                    ),
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
        isScrollControlled: true,
        backgroundColor: ColorResource.colorFFFFFF,
        shape: RoundedRectangleBorder(
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
                              fontSize: FontSize.fourteen,
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.normal,
                            ),
                            Spacer(),
                            GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Image.asset(ImageResource.close))
                          ],
                        ),
                        SizedBox(height: 60),
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
                          // onTap: () => pickImage(source, cameraDialogueContext)
                          trailingWidget:
                              Image.asset(ImageResource.capturImage),
                        ),
                        SizedBox(height: 20),
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
                              Image.asset(ImageResource.uploadPhoto),
                        ),
                      ],
                    ),
                  ),
                )));
  }

  launguageBottomSheet() {
    showModalBottomSheet(
        context: context,
        isDismissible: false,
        isScrollControlled: true,
        backgroundColor: ColorResource.colorFFFFFF,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        builder: (BuildContext context) => StatefulBuilder(
            builder: (BuildContext buildContext, StateSetter setState) =>
                LanguageBottomSheetScreen(bloc: bloc)));
  }

  messageShowBottomSheet() {
    showModalBottomSheet(
        context: context,
        isDismissible: false,
        isScrollControlled: true,
        backgroundColor: ColorResource.colorFFFFFF,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        builder: (BuildContext context) => StatefulBuilder(
            builder: (BuildContext buildContext, StateSetter setState) =>
                Container(
                  height: MediaQuery.of(context).size.height * 0.87,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              'MESSAGE'.toUpperCase(),
                              fontSize: FontSize.fourteen,
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.normal,
                            ),
                            Spacer(),
                            GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Image.asset(ImageResource.close))
                          ],
                        ),
                        SizedBox(height: 60),
                      ],
                    ),
                  ),
                )));
  }

  void notificationShowBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isDismissible: false,
        isScrollControlled: true,
        backgroundColor: ColorResource.colorFFFFFF,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        builder: (BuildContext context) => StatefulBuilder(
            builder: (BuildContext buildContext, StateSetter setState) =>
                NotificationBottomSheetScreen(bloc: bloc)));
  }
}
