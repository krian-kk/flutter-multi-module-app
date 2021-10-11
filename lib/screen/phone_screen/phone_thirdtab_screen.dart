// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'package:flutter/material.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/models/select_clip_model.dart';
import 'package:origa/screen/phone_screen/bloc/phone_bloc.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/widgets/custom_button.dart';
import 'package:origa/widgets/custom_text.dart';

List<SelectedClipModel> selectedClipList = [
  SelectedClipModel('DOES NOT EXIST'),
  SelectedClipModel('INCORRECT NUMBER'),
  SelectedClipModel('NUMBER NOT WORKING'),
  SelectedClipModel('NOT OPERATIONAL'),
];

class PhoneThirdTabScreen extends StatefulWidget {
  const PhoneThirdTabScreen(
      {Key? key, required this.context, required this.bloc})
      : super(key: key);

  final BuildContext context;
  final PhoneBloc bloc;

  @override
  State<PhoneThirdTabScreen> createState() => _PhoneThirdTabScreenState();
}

class _PhoneThirdTabScreenState extends State<PhoneThirdTabScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Wrap(
                    runSpacing: 10,
                    spacing: 10,
                    children: _buildSelectedClip(),
                  ),
                  SizedBox(height: 27),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: CustomText('REMARKS*')),
                  Container(
                    width: double.infinity,
                    child: TextField(
                      //controller: loanDurationController,
                      decoration: new InputDecoration(
                          labelText: 'Write your remarks here',
                          focusColor: ColorResource.colorE5EAF6,
                          labelStyle:
                              new TextStyle(color: const Color(0xFF424242))),
                    ),
                  ),
                  TextField(),
                  SizedBox(height: 19),
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
                    // onTap: () => pickImage(source, cameraDialogueContext)
                    trailingWidget: Image.asset(ImageResource.capturImage),
                  ),
                  SizedBox(height: 20),
                  Wrap(
                    spacing: 15,
                    children: [
                      Container(
                        width: 165,
                        child: CustomButton(
                          'ADD New contact',
                          buttonBackgroundColor: ColorResource.colorFFFFFF,
                          borderColor: ColorResource.color23375A,
                          textColor: ColorResource.color23375A,
                          fontSize: FontSize.twelve,
                          fontWeight: FontWeight.w700,
                          cardShape: 75,
                        ),
                      ),
                      Container(
                        width: 157,
                        child: CustomButton(
                          'REPO',
                          buttonBackgroundColor: ColorResource.colorFFFFFF,
                          borderColor: ColorResource.color23375A,
                          textColor: ColorResource.color23375A,
                          fontSize: FontSize.twelve,
                          fontWeight: FontWeight.w700,
                          cardShape: 75,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: ColorResource.colorFFFFFF,
            boxShadow: [
              new BoxShadow(
                color: ColorResource.color000000.withOpacity(.25),
                blurRadius: 2.0,
                offset: Offset(1.0, 1.0),
              ),
            ],
          ),
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 85, vertical: 11.0),
            child: Container(
              decoration: BoxDecoration(),
              child: CustomButton(
                Languages.of(context)!.done.toUpperCase(),
                fontSize: FontSize.sixteen,
                fontWeight: FontWeight.w600,
                // onTap: () => bloc.add(ClickMessageEvent()),
                cardShape: 5,
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildSelectedClip() {
    List<Widget> widgets = [];
    selectedClipList.forEach((element) {
      widgets.add(InkWell(
        onTap: () {
          widget.bloc.selectedInvalidClip = element.clipTitle;
          setState(() {});
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 11),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: element.clipTitle == widget.bloc.selectedInvalidClip
                ? ColorResource.colorF1BCC4
                : ColorResource.colorE7E7E7,
          ),
          child: CustomText(
            element.clipTitle,
            color: ColorResource.color000000,
            fontSize: FontSize.fourteen,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w700,
          ),
        ),
      ));
    });
    return widgets;
  }
}
