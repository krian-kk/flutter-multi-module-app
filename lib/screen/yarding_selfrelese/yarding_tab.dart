import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/models/yarding_post_model.dart';
import 'package:origa/screen/dashboard/bloc/dashboard_bloc.dart';
import 'package:origa/singleton.dart';
import 'package:origa/utils/app_utils.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/utils/pick_date_time_utils.dart';
import 'package:origa/widgets/custom_button.dart';
import 'package:origa/widgets/custom_loading_widget.dart';
import 'package:origa/widgets/custom_read_only_text_field.dart';

class YardingTab extends StatefulWidget {
  const YardingTab(this.bloc, {Key? key, this.id, this.custname})
      : super(key: key);
  final DashboardBloc bloc;
  final String? id;
  final String? custname;

  @override
  _YardingTabState createState() => _YardingTabState();
}

class _YardingTabState extends State<YardingTab> {
  late TextEditingController yardNameController = TextEditingController();
  late TextEditingController dateController = TextEditingController();
  late TextEditingController timeController = TextEditingController();
  late TextEditingController remarksController = TextEditingController();

  FocusNode yardNameFocusNode = FocusNode();
  FocusNode dateFocusNode = FocusNode();
  FocusNode timeFocusNode = FocusNode();
  FocusNode remarksFocusNode = FocusNode();

  final _formKey = GlobalKey<FormState>();

  List<File> uploadFileLists = [];

  bool isSubmited = true;

  @override
  void initState() {
    super.initState();
    setState(() {
      dateController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
    });
  }

  getFiles() async {
    final FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result != null) {
      uploadFileLists = result.paths.map((path) => File(path!)).toList();
    } else {
      AppUtils.showToast(
        Languages.of(context)!.canceled,
        gravity: ToastGravity.CENTER,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      return BlocListener<DashboardBloc, DashboardState>(
        bloc: widget.bloc,
        listener: (context, state) {
          if (state is DisableRSYardingSubmitBtnState) {
            setState(() => isSubmited = false);
          }
          if (state is EnableRSYardingSubmitBtnState) {
            setState(() => isSubmited = true);
          }
        },
        child: BlocBuilder<DashboardBloc, DashboardState>(
          bloc: widget.bloc,
          builder: (context, state) {
            return Scaffold(
              backgroundColor: ColorResource.colorffffff,
              bottomNavigationBar: Container(
                height: 66,
                decoration: const BoxDecoration(
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
                          cardShape: 5,
                          buttonBackgroundColor: ColorResource.colorffffff,
                          borderColor: ColorResource.colorffffff,
                          onTap: () => Navigator.pop(context),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: CustomButton(
                          isSubmited
                              ? Languages.of(context)!.submit.toUpperCase()
                              : null,
                          isLeading: !isSubmited,
                          trailingWidget: CustomLoadingWidget(
                            gradientColors: [
                              ColorResource.colorFFFFFF,
                              ColorResource.colorFFFFFF.withOpacity(0.7),
                            ],
                          ),
                          fontSize: FontSize.sixteen,
                          cardShape: 5,
                          onTap: isSubmited
                              ? () async {
                                  if (_formKey.currentState!.validate()) {
                                    // if (uploadFileLists.isEmpty) {
                                    //   AppUtils.showToast(
                                    //     Constants.uploadDepositSlip,
                                    //     gravity: ToastGravity.CENTER,
                                    //   );
                                    // } else {
                                    final requestBodyData = YardingPostModel(
                                        // id: widget.id!,
                                        id: widget.id.toString(),
                                        contractor:
                                            Singleton.instance.contractor!,
                                        repo: Repo(
                                          yard: yardNameController.text,
                                          date: dateController.text,
                                          time: timeController.text,
                                          remarks: remarksController.text,
                                          imageLocation: [],
                                        ));
                                    debugPrint(
                                        'requestBodyData for yarding tab ---> ${jsonEncode(requestBodyData)}');
                                    widget.bloc.add(PostYardingDataEvent(
                                        postData: requestBodyData,
                                        fileData: uploadFileLists));
                                  }
                                  // }
                                }
                              : () {},
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: SingleChildScrollView(
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 13),
                                child: CustomReadOnlyTextField(
                                  Languages.of(context)!.yardName,
                                  yardNameController,
                                  validationRules: const ['required'],
                                  isLabel: true,
                                  focusNode: yardNameFocusNode,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 13),
                                child: CustomReadOnlyTextField(
                                  Languages.of(context)!.date,
                                  dateController,
                                  validationRules: const ['required'],
                                  isLabel: true,
                                  isReadOnly: true,
                                  onTapped: () => PickDateAndTimeUtils.pickDate(
                                      context, (newDate, followUpDate) {
                                    if (newDate != null) {
                                      setState(() {
                                        dateController.text = newDate;
                                      });
                                    }
                                  }),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 13),
                                child: CustomReadOnlyTextField(
                                  Languages.of(context)!.time,
                                  timeController,
                                  validationRules: const ['required'],
                                  isLabel: true,
                                  isReadOnly: true,
                                  onTapped: () => PickDateAndTimeUtils.pickTime(
                                      context, (newTime) {
                                    if (newTime != null) {
                                      setState(() {
                                        timeController.text = newTime;
                                      });
                                    }
                                  }),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 13),
                                child: CustomReadOnlyTextField(
                                  Languages.of(context)!.remark,
                                  remarksController,
                                  focusNode: remarksFocusNode,
                                  // validationRules: const ['required'],
                                  isLabel: true,
                                ),
                              ),
                              const SizedBox(
                                height: 7,
                              ),
                              CustomButton(
                                Languages.of(context)!.uploadDepositSlip,
                                fontWeight: FontWeight.w700,
                                fontSize: FontSize.sixteen,
                                buttonBackgroundColor:
                                    ColorResource.color23375A,
                                cardShape: 50,
                                isLeading: true,
                                trailingWidget:
                                    SvgPicture.asset(ImageResource.upload),
                                onTap: () {
                                  getFiles();
                                },
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
          },
        ),
      );
    });
  }
}
