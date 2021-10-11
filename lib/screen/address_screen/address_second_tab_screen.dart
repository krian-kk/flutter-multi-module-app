// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'package:flutter/material.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/models/select_clip_model.dart';
import 'package:origa/screen/address_screen/bloc/address_bloc.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/utils/string_resource.dart';
import 'package:origa/widgets/custom_button.dart';
import 'package:origa/widgets/custom_text.dart';

List<SelectedClipModel> selectedClipList = [
  SelectedClipModel('LEFT MESSAGE'),
  SelectedClipModel('DOOR LOCKED'),
  SelectedClipModel('ENTRY RESTRICTED'),
];

class AddressSecondTabScreen extends StatefulWidget {
  const AddressSecondTabScreen({
    Key? key,
    required this.context,
    required this.bloc,
  }) : super(key: key);

  final BuildContext context;
  final AddressBloc bloc;

  @override
  State<AddressSecondTabScreen> createState() => _AddressSecondTabScreenState();
}

class _AddressSecondTabScreenState extends State<AddressSecondTabScreen> {
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
                  SizedBox(height: 25),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: CustomText('NEXT ACTION DATE*')),
                  Container(
                    width: (MediaQuery.of(context).size.width - 62) / 2,
                    child: TextField(
                      //controller: loanDurationController,
                      decoration: new InputDecoration(
                          suffixIcon: GestureDetector(
                              onTap: () {},
                              child: const Icon(Icons.calendar_today)),
                          labelText: StringResource.loanDuration,
                          focusColor: ColorResource.colorE5EAF6,
                          labelStyle:
                              new TextStyle(color: const Color(0xFF424242))),
                    ),
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
                ],
              ),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: ColorResource.colorFFFFFF,
            boxShadow: [
              // ignore: unnecessary_new
              new BoxShadow(
                color: ColorResource.color000000.withOpacity(.25),
                blurRadius: 2.0,
                offset: Offset(1.0, 1.0),
              ),
            ],
          ),
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 95, child: Center(child: CustomText('CANCEL'))),
                SizedBox(width: 25),
                Container(
                  width: 191,
                  decoration: BoxDecoration(),
                  child: CustomButton(
                    'submit'.toUpperCase(),
                    fontSize: FontSize.sixteen,
                    fontWeight: FontWeight.w600,
                    // onTap: () => bloc.add(ClickMessageEvent()),
                    cardShape: 5,
                  ),
                ),
              ],
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
                ? ColorResource.colorFFB800.withOpacity(0.67)
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
