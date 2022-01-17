import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/models/payment_mode_button_model.dart';
import 'package:origa/models/select_clip_model.dart';
import 'package:origa/screen/case_details_screen/bloc/case_details_bloc.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/constant_event_values.dart';
import 'package:origa/utils/constants.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
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
  final CaseDetailsBloc bloc;

  @override
  State<CustomerNotMetScreen> createState() => _CustomerNotMetScreenState();
}

class _CustomerNotMetScreenState extends State<CustomerNotMetScreen> {
  String selectedOptionBottomSheetButton = '';

  @override
  void initState() {
    super.initState();
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

    List<OptionBottomSheetButtonModel> optionBottomSheetButtonList = [
      // OptionBottomSheetButtonModel(
      //     Languages.of(context)!.addNewContact, Constants.addNewContact),
      OptionBottomSheetButtonModel(Languages.of(context)!.repo, Constants.repo),
    ];
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Form(
        key: widget.bloc.addressCustomerNotMetFormKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Scaffold(
                resizeToAvoidBottomInset: true,
                body: SingleChildScrollView(
                  // reverse: MediaQuery.of(context).viewInsets.bottom != 0,
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
                        const SizedBox(height: 25),
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
                            widget.bloc
                                .addressCustomerNotMetNextActionDateController,
                            focusNode:
                                widget.bloc.addressInvalidRemarksFocusNode,
                            isReadOnly: true,
                            validationRules: const ['required'],
                            onTapped: () => pickDate(
                                context,
                                widget.bloc
                                    .addressCustomerNotMetNextActionDateController),
                            suffixWidget: SvgPicture.asset(
                              ImageResource.calendar,
                              fit: BoxFit.scaleDown,
                            ),
                            onEditing: () {
                              widget.bloc
                                  .addressCustomerNotMetNextActionDateFocusNode
                                  .unfocus();
                              widget.bloc.addressCustomerNotMetRemarksFocusNode
                                  .requestFocus();
                            },
                          ),
                        ),
                        const SizedBox(height: 27),
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
                            controller: widget
                                .bloc.addressCustomerNotMetRemarksController,
                            focusNode: widget
                                .bloc.addressCustomerNotMetRemarksFocusNode,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                hintText:
                                    Languages.of(context)!.writeYourRemarksHere,
                                focusColor: ColorResource.colorE5EAF6,
                                labelStyle:
                                    const TextStyle(color: Color(0xFF424242))),
                          ),
                        ),
                        const SizedBox(height: 19),
                        CustomButton(
                          Languages.of(context)!.captureImage.toUpperCase(),
                          cardShape: 75.0,
                          textColor: ColorResource.color23375A,
                          fontSize: FontSize.sixteen,
                          onTap: () =>
                              widget.bloc.add(ClickOpenBottomSheetEvent(
                            Constants.captureImage,
                            widget.bloc.caseDetailsAPIValue.result
                                ?.addressDetails,
                            false,
                            health: ConstantEventValues.healthOne,
                          )),
                          fontWeight: FontWeight.w700,
                          padding: 15.0,
                          borderColor: ColorResource.colorBEC4CF,
                          buttonBackgroundColor: ColorResource.colorBEC4CF,
                          isLeading: true,
                          trailingWidget:
                              SvgPicture.asset(ImageResource.captureImage),
                        ),
                        const SizedBox(height: 20),
                        Wrap(
                          spacing: 15,
                          runSpacing: 8,
                          children: _buildOptionBottomSheetOpenButton(
                            optionBottomSheetButtonList,
                            context,
                          ),
                        ),
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

  List<Widget> _buildOptionBottomSheetOpenButton(
      List<OptionBottomSheetButtonModel> list, BuildContext context) {
    List<Widget> widgets = [];
    for (var element in list) {
      widgets.add(InkWell(
        onTap: () {
          setState(() {
            selectedOptionBottomSheetButton = element.title;
          });
          print("customer not met iscall ===> false");
          widget.bloc.add(
            ClickOpenBottomSheetEvent(
              element.stringResourceValue,
              widget.bloc.caseDetailsAPIValue.result?.addressDetails,
              false,
              health: ConstantEventValues.healthOne,
            ),
          );
        },
        child: Container(
          height: 45,
          decoration: BoxDecoration(
              color: element.title == selectedOptionBottomSheetButton
                  ? ColorResource.color23375A
                  : ColorResource.colorFFFFFF,
              border: Border.all(color: ColorResource.color23375A, width: 0.5),
              borderRadius: const BorderRadius.all(Radius.circular(50.0))),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 11),
            child: CustomText(
              element.title.toString().toUpperCase(),
              color: element.title == selectedOptionBottomSheetButton
                  ? ColorResource.colorFFFFFF
                  : ColorResource.color23375A,
              fontWeight: FontWeight.w700,
              fontSize: FontSize.thirteen,
              fontStyle: FontStyle.normal,
            ),
          ),
        ),
      ));
    }
    return widgets;
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
              textTheme: const TextTheme(
                subtitle1: TextStyle(fontSize: 10.0),
                headline1: TextStyle(fontSize: 8.0),
              ),
              colorScheme: const ColorScheme.light(
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
    String formattedDate = DateFormat('yyyy-MM-dd').format(newDate);
    setState(() {
      controller.text = formattedDate;
      widget.bloc.addressCustomerNotMetSelectedDate = newDate.toString();
    });
  }
}
