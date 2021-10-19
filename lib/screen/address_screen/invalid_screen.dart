// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'package:flutter/material.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/models/select_clip_model.dart';
import 'package:origa/screen/address_screen/bloc/address_bloc.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/widgets/custom_button.dart';
import 'package:origa/widgets/custom_text.dart';

class AddressInvalidScreen extends StatefulWidget {
  const AddressInvalidScreen(
      {Key? key, required this.context, required this.bloc})
      : super(key: key);

  final BuildContext context;
  final AddressBloc bloc;

  @override
  State<AddressInvalidScreen> createState() => _AddressInvalidScreenState();
}

class _AddressInvalidScreenState extends State<AddressInvalidScreen> {
  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    List<SelectedClipModel> selectedClipList = [
      SelectedClipModel(Languages.of(context)!.wrongAddress),
      SelectedClipModel(Languages.of(context)!.shifted),
      SelectedClipModel(Languages.of(context)!.addressNotFound),
    ];
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
                    children: _buildSelectedClip(selectedClipList),
                  ),
                  SizedBox(height: 27),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: CustomText(
                        Languages.of(context)!.remarks.toUpperCase(),
                        color: ColorResource.color666666,
                        fontSize: FontSize.twelve,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                      )),
                  SizedBox(
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
                      SizedBox(
                        width: 165,
                        child: CustomButton(
                          Languages.of(context)!.addNewContact.toUpperCase(),
                          buttonBackgroundColor: ColorResource.colorFFFFFF,
                          borderColor: ColorResource.color23375A,
                          textColor: ColorResource.color23375A,
                          fontSize: FontSize.twelve,
                          fontWeight: FontWeight.w700,
                          cardShape: 75,
                        ),
                      ),
                      SizedBox(
                        width: 157,
                        child: CustomButton(
                          Languages.of(context)!.repo.toUpperCase(),
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
                  SizedBox(height: 120)
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildSelectedClip(List<SelectedClipModel> list) {
    List<Widget> widgets = [];
    list.forEach((element) {
      widgets.add(InkWell(
        onTap: () {
          widget.bloc.selectedCustomerNotMetClip = element.clipTitle;
          setState(() {});
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 11),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: element.clipTitle == widget.bloc.selectedCustomerNotMetClip
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
