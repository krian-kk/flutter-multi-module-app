// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'package:flutter/material.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/models/select_clip_model.dart';
import 'package:origa/screen/address_screen/bloc/address_bloc.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/widgets/custom_button.dart';
import 'package:origa/widgets/custom_read_only_text_field.dart';
import 'package:origa/widgets/custom_text.dart';
import 'package:intl/intl.dart';

List<SelectedClipModel> selectedClipList = [
  SelectedClipModel('LEFT MESSAGE'),
  SelectedClipModel('DOOR LOCKED'),
  SelectedClipModel('ENTRY RESTRICTED'),
];

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
  TextEditingController loanDurationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loanDurationController.text = '21-09-2021';
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
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
                      loanDurationController,
                      suffixWidget: GestureDetector(
                        onTap: () => pickDate(context, loanDurationController),
                        child: ImageIcon(
                          AssetImage(ImageResource.calendar),
                        ),
                      ),
                    ),
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
                      Container(
    child: new ConstrainedBox(
        constraints: BoxConstraints(
            maxHeight: 300.0,
        ),
        child: TextField(
          style: TextStyle(
              decoration: TextDecoration.underline,
              ),
                    maxLines: null,
                ),
            ),
        ),
                  SizedBox(
                    width: double.infinity,
                    child: TextField(
                      //controller: loanDurationController,
                      // keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.newline,
                        minLines: 1,
                        maxLines: 5,
                      decoration: new InputDecoration(
                          labelText: 'Write your remarks here',
                          focusColor: ColorResource.colorE5EAF6,
                          labelStyle:
                              new TextStyle(color: const Color(0xFF424242))),
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
                    // onTap: () => pickImage(source, cameraDialogueContext)
                    trailingWidget: Image.asset(ImageResource.capturImage),
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
