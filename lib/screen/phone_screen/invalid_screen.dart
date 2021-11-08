// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'package:flutter/material.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/models/select_clip_model.dart';
import 'package:origa/screen/phone_screen/bloc/phone_bloc.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/string_resource.dart';
import 'package:origa/widgets/custom_button.dart';
import 'package:origa/widgets/custom_text.dart';

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
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    List<SelectedClipModel> selectedClipList = [
      SelectedClipModel(Languages.of(context)!.doesNotExist.toUpperCase()),
      SelectedClipModel(Languages.of(context)!.incorrectNumber.toUpperCase()),
      SelectedClipModel(Languages.of(context)!.numberNotWorking.toUpperCase()),
      SelectedClipModel(Languages.of(context)!.notOperational.toUpperCase()),
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
                      CustomText(
                        Languages.of(context)!.remarks,
                        color: ColorResource.color666666,
                        fontWeight: FontWeight.w400,
                        fontSize: FontSize.twelve,
                        fontStyle: FontStyle.normal,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: TextFormField(
                          focusNode: widget.bloc.invalidRemarksFocusNode,
                          controller: widget.bloc.invalidRemarksController,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: CustomButton(
                              StringResource.addNewContact.toUpperCase(),
                              textColor: ColorResource.colorFFFFFF,
                              borderColor: ColorResource.color23375A,
                              fontSize: FontSize.twelve,
                              cardShape: 75,
                              buttonBackgroundColor: ColorResource.color23375A,
                            ),
                          ),
                          SizedBox(height: 11),
                          Expanded(
                            child: CustomButton(
                              Languages.of(context)!.otherFeedBack,
                              fontSize: FontSize.twelve,
                              textColor: ColorResource.color23375A,
                              borderColor: ColorResource.color23375A,
                              cardShape: 75,
                              buttonBackgroundColor: ColorResource.colorFFFFFF,
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
        ),
      ),
    );
  }

  List<Widget> _buildSelectedClip(List<SelectedClipModel> list) {
    List<Widget> widgets = [];
    list.forEach((element) {
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
