// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:origa/screen/profile_screen.dart/bloc/profile_bloc.dart';
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
      setState(() => this.image = imageTemporary);
    } on PlatformException catch (e) {
      'error';
    }
    Navigator.pop(cameraDialogueContext);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      bloc: bloc,
      listener: (context, state) {},
      child: BlocBuilder<ProfileBloc, ProfileState>(
        bloc: bloc,
        builder: (context, state) {
          if (state is ProfileLoadedState) {
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
                                    onTap: () {
                                      profileImageShowBottomSheet();
                                    },
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
                                    StringResource.homeAddress.toUpperCase(),
                                    fontSize: FontSize.fourteen,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w700,
                                    color: ColorResource.color101010,
                                  ),
                                  CustomText(
                                    StringResource.markAsHome,
                                    fontSize: FontSize.twelve,
                                    isUnderLine: true,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w700,
                                    color: ColorResource.color101010,
                                  ),
                                ],
                              ),
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
                                              onTap: () {
                                                switch (bloc
                                                    .profileNavigationList[
                                                        index]
                                                    .title) {
                                                  case 'Notification':
                                                    break;
                                                  case 'Change language':
                                                    launguageBottomSheet();
                                                    break;
                                                  case 'Change Password':
                                                    break;
                                                }
                                              },
                                              child: Row(
                                                children: [
                                                  CustomText(
                                                    bloc
                                                        .profileNavigationList[
                                                            index]
                                                        .title
                                                        .toUpperCase(),
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
                      Container(
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
                            StringResource.logout.toUpperCase(),
                            fontSize: FontSize.twelve,
                            color: ColorResource.color23375A,
                            fontWeight: FontWeight.w700,
                            lineHeight: 1,
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
                    child: CustomButton(
                      StringResource.message,
                      onTap: () => messageShowBottomSheet(),
                      cardShape: 5,
                      isTrailing: true,
                      leadingWidget: CircleAvatar(
                        radius: 13,
                        backgroundColor: ColorResource.colorFFFFFF,
                        child: CustomText('2',
                            fontSize: FontSize.twelve,
                            lineHeight: 1,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal),
                      ),
                    ),
                  ),
                ),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
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
                Container(
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
                              'Add a PROFILE PHOTO'.toUpperCase(),
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
                          'CAPTURE IMAGE',
                          cardShape: 75.0,
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
                          'UPLOAD PHOTO',
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
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.87,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText(
                                    StringResource.launguage.toUpperCase(),
                                    fontSize: FontSize.fourteen,
                                    fontWeight: FontWeight.w700,
                                    fontStyle: FontStyle.normal,
                                    color: ColorResource.color23375A,
                                  ),
                                  Spacer(),
                                  GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Image.asset(ImageResource.close))
                                ],
                              ),
                              SizedBox(height: 14),
                              CustomText(
                                StringResource.defaultLaunguage.toUpperCase(),
                                fontWeight: FontWeight.w700,
                                fontSize: FontSize.twelve,
                                fontStyle: FontStyle.normal,
                                color: ColorResource.color23375A,
                              ),
                              SizedBox(height: 6),
                              Container(
                                width: double.infinity,
                                margin: EdgeInsets.symmetric(vertical: 5.0),
                                decoration: new BoxDecoration(
                                    color: ColorResource.colorF8F9FB,
                                    borderRadius: new BorderRadius.all(
                                        Radius.circular(10.0))),
                                child: ListTile(
                                  title: CustomText(
                                    StringResource.english,
                                    lineHeight: 1,
                                    fontSize: FontSize.fourteen,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  leading: true
                                      ? Image.asset(ImageResource.radioOn)
                                      : Image.asset(ImageResource.radioOff),
                                ),
                              ),
                              SizedBox(height: 17),
                              CustomText(
                                StringResource.defaultLaunguage.toUpperCase(),
                                fontWeight: FontWeight.w700,
                                fontSize: FontSize.twelve,
                                fontStyle: FontStyle.normal,
                                color: ColorResource.color23375A,
                              ),
                              SizedBox(height: 6),
                              Container(
                                width: double.infinity,
                                margin: EdgeInsets.symmetric(vertical: 5.0),
                                decoration: new BoxDecoration(
                                    color: ColorResource.colorF8F9FB,
                                    borderRadius: new BorderRadius.all(
                                        Radius.circular(10.0))),
                                child: ListTile(
                                  title: CustomText(
                                    StringResource.hindi,
                                    lineHeight: 1,
                                    fontSize: FontSize.fourteen,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  leading: false
                                      ? Image.asset(ImageResource.radioOn)
                                      : Image.asset(ImageResource.radioOff),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                margin: EdgeInsets.symmetric(vertical: 5.0),
                                decoration: new BoxDecoration(
                                    color: ColorResource.colorF8F9FB,
                                    borderRadius: new BorderRadius.all(
                                        Radius.circular(10.0))),
                                child: ListTile(
                                  title: CustomText(
                                    StringResource.tamil,
                                    lineHeight: 1,
                                    fontSize: FontSize.fourteen,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  leading: false
                                      ? Image.asset(ImageResource.radioOn)
                                      : Image.asset(ImageResource.radioOff),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                margin: EdgeInsets.symmetric(vertical: 5.0),
                                decoration: new BoxDecoration(
                                    color: ColorResource.colorF8F9FB,
                                    borderRadius: new BorderRadius.all(
                                        Radius.circular(10.0))),
                                child: ListTile(
                                  title: CustomText(
                                    StringResource.kannadam,
                                    lineHeight: 1,
                                    fontSize: FontSize.fourteen,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  leading: false
                                      ? Image.asset(ImageResource.radioOn)
                                      : Image.asset(ImageResource.radioOff),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        decoration: new BoxDecoration(
                          color: ColorResource.colorFFFFFF,
                          boxShadow: [
                            BoxShadow(
                              color: ColorResource.color000000.withOpacity(0.2),
                              blurRadius: 2.0,
                              offset: Offset(
                                  1.0, 1.0), // shadow direction: bottom right
                            )
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 85, vertical: 11.0),
                          child: Container(
                            decoration: new BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: ColorResource.color000000
                                      .withOpacity(0.2),
                                  blurRadius: 2.0,
                                  offset: Offset(1.0,
                                      1.0), // shadow direction: bottom right
                                )
                              ],
                            ),
                            child: CustomButton(
                              StringResource.okay.toUpperCase(),
                              onTap: () => messageShowBottomSheet(),
                              cardShape: 5,
                              leadingWidget: CircleAvatar(
                                radius: 13,
                                backgroundColor: ColorResource.colorFFFFFF,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )));
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
}
