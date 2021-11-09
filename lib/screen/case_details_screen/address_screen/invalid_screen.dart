// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'package:flutter/material.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/models/select_clip_model.dart';
import 'package:origa/screen/case_details_screen/bloc/case_details_bloc.dart';
import 'package:origa/screen/case_details_screen/bottom_sheet_screen/capture_image_bottom_sheet.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/utils/string_resource.dart';
import 'package:origa/widgets/custom_button.dart';
import 'package:origa/widgets/custom_text.dart';

class AddressInvalidScreen extends StatefulWidget {
  const AddressInvalidScreen(
      {Key? key, required this.context, required this.bloc})
      : super(key: key);

  final BuildContext context;
  final CaseDetailsBloc bloc;

  @override
  State<AddressInvalidScreen> createState() => _AddressInvalidScreenState();
}

class _AddressInvalidScreenState extends State<AddressInvalidScreen> {
  final formKey = GlobalKey<FormState>();

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
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Form(
        key: formKey,
        autovalidate: true,
        child: Column(
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
                        child: TextFormField(
                          controller:
                              widget.bloc.addressInvalidRemarksController,
                          focusNode: widget.bloc.addressInvalidRemarksFocusNode,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          decoration: new InputDecoration(
                              hintText:
                                  Languages.of(context)!.writeYourRemarksHere,
                              focusColor: ColorResource.colorE5EAF6,
                              labelStyle: new TextStyle(
                                  color: const Color(0xFF424242))),
                        ),
                      ),
                      // TextField(),
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
                        onTap: () => openBottomSheet(
                            context, StringResource.captureImage),
                        // onTap: () => pickImage(source, cameraDialogueContext)
                        trailingWidget: Image.asset(ImageResource.capturImage),
                      ),
                      SizedBox(height: 20),
                      Wrap(
                        spacing: 15,
                        children: [
                          SizedBox(
                            width: 179,
                            child: CustomButton(
                              StringResource.addNewContact.toUpperCase(),
                              buttonBackgroundColor: ColorResource.color23375A,
                              borderColor: ColorResource.color23375A,
                              textColor: ColorResource.colorFFFFFF,
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
                          SizedBox(
                            width: 165,
                            child: CustomButton(
                              Languages.of(context)!
                                  .otherFeedBack
                                  .toUpperCase(),
                              // onTap: () => openBottomSheet(
                              //     context, StringResource.otherFeedback),
                              cardShape: 75,
                              fontSize: FontSize.twelve,
                              textColor: ColorResource.color23375A,
                              borderColor: ColorResource.color23375A,
                              buttonBackgroundColor: ColorResource.colorFFFFFF,
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 120)
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  openBottomSheet(BuildContext buildContext, String cardTitle) {
    showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: false,
      context: buildContext,
      backgroundColor: ColorResource.colorFFFFFF,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (BuildContext context) {
        switch (cardTitle) {
          case StringResource.captureImage:
            return CustomCaptureImageBottomSheet(
                Languages.of(context)!.captureImage);
          default:
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
        }
      },
    );
  }

  List<Widget> _buildSelectedClip(List<SelectedClipModel> list) {
    List<Widget> widgets = [];
    for (var element in list) {
      widgets.add(InkWell(
        onTap: () {
          widget.bloc.addressSelectedCustomerNotMetClip = element.clipTitle;
          setState(() {});
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 11),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: element.clipTitle ==
                    widget.bloc.addressSelectedCustomerNotMetClip
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
    }
    return widgets;
  }
}
