// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'package:flutter/material.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/models/select_clip_model.dart';
import 'package:origa/screen/address_screen/bloc/address_bloc.dart';
import 'package:origa/screen/address_screen/capture_image_bottom_sheet.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/utils/string_resource.dart';
import 'package:origa/widgets/custom_button.dart';
import 'package:origa/widgets/custom_read_only_text_field.dart';
import 'package:origa/widgets/custom_text.dart';
import 'package:intl/intl.dart';

class CustomerNotMetScreen extends StatefulWidget {
  const CustomerNotMetScreen({
    Key? key,
    required this.context,
    required this.bloc,
  }) : super(key: key);

  final BuildContext context;
  final AddressBloc bloc;

  @override
  State<CustomerNotMetScreen> createState() => _CustomerNotMetScreenState();
}

class _CustomerNotMetScreenState extends State<CustomerNotMetScreen> {
  // TextEditingController nextActionDateController = TextEditingController();
  // TextEditingController remarksController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  // late FocusNode nextActionDateFocusNode;
  // late FocusNode remarksFocusNode;

  @override
  void initState() {
    super.initState();
    widget.bloc.customerNotMetNextActionDateController.text =
        DateFormat('dd-MM-yyyy').format(DateTime.now()).toString();
    // nextActionDateFocusNode = FocusNode();
    // remarksFocusNode = FocusNode();
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<SelectedClipModel> selectedClipList = [
      SelectedClipModel(Languages.of(context)!.leftMessage.toUpperCase()),
      SelectedClipModel(Languages.of(context)!.doorLocked.toUpperCase()),
      SelectedClipModel(Languages.of(context)!.entryRestricted.toUpperCase()),
    ];
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Form(
        key: formKey,
        autovalidate: true,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                body: SingleChildScrollView(
                  reverse: MediaQuery.of(context).viewInsets.bottom != 0,
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
                            widget.bloc.customerNotMetNextActionDateController,
                            focusNode: widget.bloc.invalidRemarksFocusNode,
                            isReadOnly: true,
                            onTapped: () => pickDate(
                                context,
                                widget.bloc
                                    .customerNotMetNextActionDateController),
                            suffixWidget: ImageIcon(
                              AssetImage(ImageResource.calendar),
                              color: ColorResource.colorC4C4C4,
                            ),
                            // validationRules: ['required'],
                            onEditing: () {
                              widget.bloc.customerNotMetNextActionDateFocusNode
                                  .unfocus();
                              widget.bloc.customerNotMetRemarksFocusNode
                                  .requestFocus();
                            },
                          ),
                        ),
                        SizedBox(height: 27),
                        Align(
                            alignment: Alignment.bottomLeft,
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
                            // keyboardType: TextInputType.multiline,
                            // minLines: 2,
                            controller:
                                widget.bloc.customerNotMetRemarksController,
                            focusNode:
                                widget.bloc.customerNotMetRemarksFocusNode,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                            // maxLines: null,
                            // onFieldSubmitted: (s) {
                            //   remarksFocusNode.unfocus();
                            // },
                            // onChanged: (S) {
                            //   remarksFocusNode.unfocus();
                            // },
                            // textInputAction: TextInputAction.newline,
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
                          onTap: () => openBottomSheet(
                              context, StringResource.captureImage),
                          fontWeight: FontWeight.w700,
                          padding: 15.0,
                          borderColor: ColorResource.colorBEC4CF,
                          buttonBackgroundColor: ColorResource.colorBEC4CF,
                          isLeading: true,
                          // onTap: () => pickImage(source, cameraDialogueContext)
                          trailingWidget:
                              Image.asset(ImageResource.capturImage),
                        ),
                        SizedBox(height: 20),
                        Wrap(
                          spacing: 15,
                          children: [
                            SizedBox(
                              width: 165,
                              child: CustomButton(
                                StringResource.addNewContact.toUpperCase(),
                                buttonBackgroundColor:
                                    ColorResource.color23375A,
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
                                buttonBackgroundColor:
                                    ColorResource.colorFFFFFF,
                                borderColor: ColorResource.color23375A,
                                textColor: ColorResource.color23375A,
                                fontSize: FontSize.twelve,
                                fontWeight: FontWeight.w700,
                                cardShape: 75,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 120),
                      ],
                    ),
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
}
