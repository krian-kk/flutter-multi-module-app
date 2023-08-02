import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/models/self_release_post_model.dart';
import 'package:origa/singleton.dart';
import 'package:origa/src/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:origa/utils/app_utils.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/utils/pick_date_time_utils.dart';
import 'package:origa/utils/string_resource.dart';
import 'package:origa/widgets/custom_button.dart';
import 'package:origa/widgets/custom_loading_widget.dart';
import 'package:origa/widgets/custom_read_only_text_field.dart';

class SelfReleaseTab extends StatefulWidget {
  const SelfReleaseTab(this.bloc, {Key? key, this.id, this.custname})
      : super(key: key);
  final DashboardBloc bloc;
  final String? id;
  final String? custname;

  @override
  _SelfReleaseTabState createState() => _SelfReleaseTabState();
}

class _SelfReleaseTabState extends State<SelfReleaseTab> {
  late TextEditingController dateController = TextEditingController();
  late TextEditingController timeController = TextEditingController();
  late TextEditingController remarksController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool isSubmit = true;

  List<File> uploadFileLists = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      dateController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
    });
    // var currentDateTime = DateTime.now();
    // String currentDate = DateFormat('dd-MM-yyyy').format(currentDateTime);
    // setState(() {
    //   dateController.text = currentDate;
    // });
  }

  getFiles() async {
    final FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result != null) {
      uploadFileLists = result.paths.map((path) => File(path!)).toList();
      AppUtils.showToast(StringResource.fileUploadMessage);
    } else {
      AppUtils.showToast(Languages.of(context)!.canceled);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      return BlocListener<DashboardBloc, DashboardState>(
        bloc: widget.bloc,
        listener: (context, state) {
          if (state is DisableRSSelfReleaseSubmitBtnState) {
            setState(() => isSubmit = false);
          }
          if (state is EnableRSSelfReleaseSubmitBtnState) {
            setState(() => isSubmit = true);
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
                          isSubmit
                              ? Languages.of(context)!.submit.toUpperCase()
                              : null,
                          isLeading: !isSubmit,
                          trailingWidget: CustomLoadingWidget(
                            gradientColors: [
                              ColorResource.colorFFFFFF,
                              ColorResource.colorFFFFFF.withOpacity(0.7),
                            ],
                          ),
                          fontSize: FontSize.sixteen,
                          cardShape: 5,
                          onTap: isSubmit
                              ? () async {
                                  if (_formKey.currentState!.validate()) {
                                    // if (uploadFileLists.isEmpty) {
                                    //   AppUtils.showToast(
                                    //     Constants.uploadDepositSlip,
                                    //     gravity: ToastGravity.CENTER,
                                    //   );
                                    // } else {
                                    final requestBodyData =
                                        SelfReleasePostModel(
                                            id: widget.id.toString(),
                                            contractor:
                                                Singleton.instance.contractor!,
                                            repo: Repo(
                                              date: dateController.text,
                                              time: timeController.text,
                                              remarks: remarksController.text,
                                              imageLocation: [],
                                            ));
                                    widget.bloc.add(PostSelfReleaseDataEvent(
                                      postData: requestBodyData,
                                      fileData: uploadFileLists,
                                    ));
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
                                  // validationRules: const ['required'],
                                  isLabel: true,
                                ),
                              ),
                              const SizedBox(height: 7),
                              CustomButton(
                                Languages.of(context)!.upload,
                                fontWeight: FontWeight.w700,
                                fontSize: FontSize.sixteen,
                                buttonBackgroundColor:
                                    ColorResource.color23375A,
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
          },
        ),
      );
    });
  }
}
