import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:origa/http/api_repository.dart';
import 'package:origa/http/httpurls.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/models/self_release_post_model.dart';
import 'package:origa/screen/dashboard/bloc/dashboard_bloc.dart';
import 'package:origa/utils/app_utils.dart';
import 'package:origa/utils/constants.dart';
import 'package:origa/widgets/case_list_widget.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/utils/string_resource.dart';
import 'package:origa/widgets/bottomsheet_appbar.dart';
import 'package:origa/widgets/custom_button.dart';
import 'package:origa/widgets/custom_read_only_text_field.dart';
import 'package:origa/widgets/custom_text.dart';
import 'package:intl/intl.dart';

class SelfReleaseTab extends StatefulWidget {
  final DashboardBloc bloc;
  final String? caseId;
  final String? custname;
  SelfReleaseTab(this.bloc, {this.caseId, this.custname});

  @override
  _SelfReleaseTabState createState() => _SelfReleaseTabState();
}

class _SelfReleaseTabState extends State<SelfReleaseTab> {
  late TextEditingController dateController = TextEditingController();
  late TextEditingController timeController = TextEditingController();
  late TextEditingController remarksController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  List uploadFileLists = [];

  @override
  void initState() {
    super.initState();
    // var currentDateTime = DateTime.now();
    // String currentDate = DateFormat('dd-MM-yyyy').format(currentDateTime);
    // setState(() {
    //   dateController.text = currentDate;
    // });
  }

  getFiles() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(allowMultiple: true, type: FileType.any);
    if (result != null) {
      uploadFileLists =
          result.files.map((path) => path.path.toString()).toList();
      print(uploadFileLists);
    } else {
      // User canceled the picker
      AppUtils.showToast('Canceled', gravity: ToastGravity.CENTER);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      return Scaffold(
        backgroundColor: ColorResource.colorffffff,
        bottomNavigationBar: Container(
          height: 66,
          decoration: BoxDecoration(
              border: Border(
                  top: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.13)))),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(13, 5, 20, 5),
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: CustomButton(
                    Languages.of(context)!.cancel.toUpperCase(),
                    fontSize: FontSize.sixteen,
                    textColor: ColorResource.colorEA6D48,
                    fontWeight: FontWeight.w600,
                    cardShape: 5,
                    buttonBackgroundColor: ColorResource.colorffffff,
                    borderColor: ColorResource.colorffffff,
                    onTap: () => Navigator.pop(context),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: CustomButton(
                    Languages.of(context)!.submit.toUpperCase(),
                    fontSize: FontSize.sixteen,
                    fontWeight: FontWeight.w600,
                    cardShape: 5,
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        if (uploadFileLists.isEmpty) {
                          AppUtils.showToast(
                            Constants.uploadDepositSlip,
                            gravity: ToastGravity.CENTER,
                          );
                        } else {
                          var requestBodyData = SelfReleasePostModel(
                              caseId: "61932bce3e29eb34b4149841",
                              repo: Repo(
                                date: dateController.text,
                                time: timeController.text,
                                remarks: remarksController.text,
                                imageLocation: uploadFileLists as List<String>,
                              ));
                          widget.bloc.add(PostSelfreleaseDataEvent(
                              postData: requestBodyData));
                        }
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Column(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 13),
                          child: CustomReadOnlyTextField(
                            Languages.of(context)!.date,
                            dateController,
                            validationRules: ['required'],
                            isLabel: true,
                            isEnable: true,
                            onTapped: () => pickDate(context, dateController),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 13),
                          child: CustomReadOnlyTextField(
                            Languages.of(context)!.time,
                            timeController,
                            validationRules: ['required'],
                            isLabel: true,
                            isEnable: true,
                            onTapped: () => pickTime(context, timeController),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 13),
                          child: CustomReadOnlyTextField(
                            Languages.of(context)!.remark,
                            remarksController,
                            validationRules: ['required'],
                            isLabel: true,
                            isEnable: true,
                          ),
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        CustomButton(
                          Languages.of(context)!.uploadDepositSlip,
                          fontWeight: FontWeight.w700,
                          fontSize: FontSize.sixteen,
                          buttonBackgroundColor: ColorResource.color23375A,
                          cardShape: 50,
                          isLeading: true,
                          trailingWidget:
                              SvgPicture.asset(ImageResource.upload),
                          onTap: () => getFiles(),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    });
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
      // _formKey.currentState!.validate();
    });
  }

  Future pickTime(
      BuildContext context, TextEditingController controller) async {
    const initialTime = TimeOfDay(hour: 9, minute: 0);
    final newTime = await showTimePicker(
        context: context,
        initialTime: initialTime,
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
    if (newTime == null) return;

    final hours = newTime.hour.toString().padLeft(2, '0');
    final minutes = newTime.minute.toString().padLeft(2, '0');
    setState(() {
      controller.text = '$hours:$minutes';
      // _formKey.currentState!.validate();
    });
  }
}
