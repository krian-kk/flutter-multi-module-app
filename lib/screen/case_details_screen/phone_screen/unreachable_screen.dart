// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'package:flutter/material.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/models/payment_mode_button_model.dart';
import 'package:origa/models/select_clip_model.dart';
import 'package:origa/screen/case_details_screen/bloc/case_details_bloc.dart';
import 'package:origa/screen/case_details_screen/bottom_sheet_screen/other_feed_back_bottom_sheet.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/utils/string_resource.dart';
import 'package:origa/widgets/bottomsheet_appbar.dart';
import 'package:origa/widgets/custom_read_only_text_field.dart';
import 'package:origa/widgets/custom_text.dart';
import 'package:intl/intl.dart';

class PhoneUnreachableScreen extends StatefulWidget {
  const PhoneUnreachableScreen({
    Key? key,
    required this.context,
    required this.bloc,
  }) : super(key: key);

  final BuildContext context;
  final CaseDetailsBloc bloc;

  @override
  State<PhoneUnreachableScreen> createState() => _PhoneUnreachableScreenState();
}

class _PhoneUnreachableScreenState extends State<PhoneUnreachableScreen> {
  // TextEditingController nextActionDateController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  String selectedOptionBottomSheetButton = '';

  @override
  void initState() {
    widget.bloc.phoneUnreachableNextActionDateController.text =
        DateFormat('dd-MM-yyyy').format(DateTime.now()).toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<SelectedClipModel> selectedClipList = [
      SelectedClipModel(Languages.of(context)!.lineBusy.toUpperCase()),
      SelectedClipModel(Languages.of(context)!.switchOff.toUpperCase()),
      SelectedClipModel(Languages.of(context)!.rnr.toUpperCase()),
      SelectedClipModel(Languages.of(context)!.outOfNetwork.toUpperCase()),
      SelectedClipModel(Languages.of(context)!.disConnecting.toUpperCase()),
    ];
    List<OptionBottomSheetButtonModel> optionBottomSheetButtonList = [
      OptionBottomSheetButtonModel(
          Languages.of(context)!.addNewContact, StringResource.addNewContact),
      OptionBottomSheetButtonModel(
          Languages.of(context)!.otherFeedBack, StringResource.otherFeedback),
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
                      SizedBox(height: 25),
                      CustomText(
                        Languages.of(context)!.nextActionDate.toUpperCase(),
                        color: ColorResource.color666666,
                        fontSize: FontSize.twelve,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                      ),
                      SizedBox(
                        width: (MediaQuery.of(context).size.width - 62) / 2,
                        child: CustomReadOnlyTextField(
                          '',
                          widget.bloc.phoneUnreachableNextActionDateController,
                          focusNode: widget
                              .bloc.phoneUnreachableNextActionDateFocusNode,
                          isReadOnly: true,
                          onTapped: () => pickDate(
                              context,
                              widget.bloc
                                  .phoneUnreachableNextActionDateController),
                          suffixWidget: ImageIcon(
                            AssetImage(ImageResource.calendar),
                            color: ColorResource.colorC4C4C4,
                          ),
                          onEditing: () {
                            widget.bloc.phoneUnreachableNextActionDateFocusNode
                                .unfocus();
                            widget.bloc.phoneUnreachableRemarksFocusNode
                                .requestFocus();
                          },
                        ),
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
                          focusNode:
                              widget.bloc.phoneUnreachableRemarksFocusNode,
                          controller:
                              widget.bloc.phoneUnreachableRemarksController,
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
                      Wrap(
                        spacing: 15,
                        runSpacing: 8,
                        children: _buildOptionBottomSheetOpenButton(
                          optionBottomSheetButtonList,
                          context,
                        ),
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Expanded(
                      //       child: CustomButton(
                      //         StringResource.addNewContact.toUpperCase(),
                      //         textColor: ColorResource.colorFFFFFF,
                      //         borderColor: ColorResource.color23375A,
                      //         cardShape: 75,
                      //         buttonBackgroundColor: ColorResource.color23375A,
                      //       ),
                      //     ),
                      //     SizedBox(height: 11),
                      //     Expanded(
                      //       child: CustomButton(
                      //         Languages.of(context)!.otherFeedBack,
                      //         textColor: ColorResource.color23375A,
                      //         borderColor: ColorResource.color23375A,
                      //         cardShape: 75,
                      //         buttonBackgroundColor: ColorResource.colorFFFFFF,
                      //       ),
                      //     ),
                      //   ],
                      // ),
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

  List<Widget> _buildOptionBottomSheetOpenButton(
      List<OptionBottomSheetButtonModel> list, BuildContext context) {
    List<Widget> widgets = [];
    for (var element in list) {
      widgets.add(InkWell(
        onTap: () {
          setState(() {
            selectedOptionBottomSheetButton = element.title;
          });

          openBottomSheet(
            context,
            element.stringResourceValue,
          );
        },
        child: Container(
          height: 45,
          decoration: BoxDecoration(
              color: element.title == selectedOptionBottomSheetButton
                  ? ColorResource.color23375A
                  : ColorResource.colorFFFFFF,
              border: Border.all(color: ColorResource.color23375A, width: 0.5),
              borderRadius: BorderRadius.all(Radius.circular(50.0))),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 11),
            child: CustomText(
              element.title.toString().toUpperCase(),
              color: element.title == selectedOptionBottomSheetButton
                  ? ColorResource.colorFFFFFF
                  : ColorResource.color23375A,
              fontWeight: FontWeight.w700,
              // lineHeight: 1,
              fontSize: FontSize.thirteen,
              fontStyle: FontStyle.normal,
            ),
          ),
        ),
      ));
    }
    return widgets;
  }

  openBottomSheet(BuildContext buildContext, String cardTitle) {
    showModalBottomSheet(
      isScrollControlled: true,
      enableDrag: false,
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
          case StringResource.otherFeedback:
            return CustomOtherFeedBackBottomSheet(
                Languages.of(context)!.otherFeedBack, widget.bloc);
          case StringResource.addNewContact:
            return SizedBox(
                height: MediaQuery.of(context).size.height * 0.89,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    BottomSheetAppbar(
                        title:
                            Languages.of(context)!.addNewContact.toUpperCase(),
                        padding: EdgeInsets.fromLTRB(23, 16, 15, 5)),
                    Expanded(child: Center(child: CircularProgressIndicator())),
                  ],
                ));
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

  Future pickDate(
      BuildContext context, TextEditingController controller) async {
    final newDate = await showDatePicker(
        context: context,
        initialDatePickerMode: DatePickerMode.year,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(DateTime.now().year + 5),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              textTheme: TextTheme(
                subtitle1: TextStyle(fontSize: 10.0),
                headline1: TextStyle(fontSize: 8.0),
              ),
              colorScheme: ColorScheme.light(
                primary: ColorResource.color23375A,
                onPrimary: ColorResource.colorFFFFFF,
                onSurface: ColorResource.color23375A,
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  primary: ColorResource.color23375A,
                ),
              ),
            ),
            child: child!,
          );
        });

    if (newDate == null) return null;
    String formattedDate = DateFormat('dd-MM-yyyy').format(newDate);
    setState(() {
      controller.text = formattedDate;
    });
  }

  List<Widget> _buildSelectedClip(List<SelectedClipModel> list) {
    List<Widget> widgets = [];
    for (var element in list) {
      widgets.add(InkWell(
        onTap: () {
          widget.bloc.phoneSelectedUnreadableClip = element.clipTitle;
          setState(() {});
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 11),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: element.clipTitle == widget.bloc.phoneSelectedUnreadableClip
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
    }
    return widgets;
  }
}
