import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:objectid/objectid.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/models/company_branch_post_model.dart';
import 'package:origa/screen/dashboard/bloc/dashboard_bloc.dart';
import 'package:origa/singleton.dart';
import 'package:origa/utils/app_utils.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/constants.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/widgets/custom_button.dart';
import 'package:origa/widgets/custom_dialog.dart';
import 'package:origa/widgets/custom_read_only_text_field.dart';

class CompanyBranch extends StatefulWidget {
  final DashboardBloc bloc;
  final List<String>? selected_case_Ids;
  final String? mode;
  final String? custname;
  final double? receiptAmt;
  const CompanyBranch(this.bloc,
      {Key? key,
      this.selected_case_Ids,
      this.mode,
      this.custname,
      this.receiptAmt})
      : super(key: key);

  @override
  _CompanyBranchState createState() => _CompanyBranchState();
}

class _CompanyBranchState extends State<CompanyBranch> {
  late TextEditingController branchNameController = TextEditingController();
  late TextEditingController branchLocationController = TextEditingController();
  late TextEditingController receiptController = TextEditingController();
  late TextEditingController depositController = TextEditingController();
  late TextEditingController referenceController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool isSubmited = true;

  List<File> uploadFileLists = [];

  FocusNode branchNameFocusNode = FocusNode();
  FocusNode branchLocationFocusNode = FocusNode();
  FocusNode receiptAmountFocusNode = FocusNode();
  FocusNode depositAmountFocusNode = FocusNode();
  FocusNode referenceFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    setState(() {
      receiptController.text = widget.receiptAmt.toString();
    });
  }

  getFiles() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(allowMultiple: true, type: FileType.image);
    if (result != null) {
      uploadFileLists = result.paths.map((path) => File(path!)).toList();
    } else {
      AppUtils.showToast('Canceled', gravity: ToastGravity.CENTER);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      return BlocListener<DashboardBloc, DashboardState>(
        bloc: widget.bloc,
        listener: (context, state) {
          if (state is DisableMDCompanyBranchSubmitBtnState) {
            setState(() => isSubmited = false);
          }
          if (state is EnableMDCompanyBranchSubmitBtnState) {
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
                          isSubmited
                              ? Languages.of(context)!.submit.toUpperCase()
                              : null,
                          isLeading: !isSubmited,
                          trailingWidget: const Center(
                            child: CircularProgressIndicator(
                              color: ColorResource.colorFFFFFF,
                            ),
                          ),
                          fontSize: FontSize.sixteen,
                          fontWeight: FontWeight.w600,
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
                                    final id = ObjectId();
                                    var requestBodyData =
                                        CompanyBranchDepositPostModel(
                                      caseIds:
                                          widget.selected_case_Ids!.length == 1
                                              ? [
                                                  ...widget.selected_case_Ids!,
                                                  '$id'
                                                ]
                                              : widget.selected_case_Ids!,
                                      contractor:
                                          Singleton.instance.contractor ?? "",
                                      deposition: Deposition(
                                        companyBranchName:
                                            branchNameController.text,
                                        companyBranchLocation:
                                            branchLocationController.text,
                                        recptAmount: receiptController.text,
                                        deptAmount: depositController.text,
                                        reference: referenceController.text,
                                        imageLocation: [''],
                                        mode: widget.mode.toString(),
                                        depositDate: DateTime.now().toString(),
                                        status: 'deposited',
                                      ),
                                    );

                                    if (double.parse(receiptController.text) ==
                                        double.parse(depositController.text)) {
                                      widget.bloc
                                          .add(PostCompanyDepositDataEvent(
                                        postData: requestBodyData,
                                        fileData: uploadFileLists,
                                        context: context,
                                      ));
                                    } else {
                                      print(
                                          double.parse(receiptController.text));
                                      print(
                                          double.parse(depositController.text));
                                      DialogUtils.showDialog(
                                          buildContext: context,
                                          title: Constants
                                              .bankReceiptAmountDoesntMatch,
                                          description: '',
                                          okBtnText: Languages.of(context)!
                                              .submit
                                              .toUpperCase(),
                                          cancelBtnText: Languages.of(context)!
                                              .cancel
                                              .toUpperCase(),
                                          okBtnFunction: (val) async {
                                            Navigator.pop(context);
                                            widget.bloc.add(
                                                PostCompanyDepositDataEvent(
                                              postData: requestBodyData,
                                              fileData: uploadFileLists,
                                              context: context,
                                            ));
                                          });
                                    }

                                    // Map<String, dynamic> postResult =
                                    //     await APIRepository.apiRequest(APIRequestType.POST,
                                    //     HttpUrl.companyBranchDeposit,
                                    //         requestBodydata: jsonEncode(requestBodyData));
                                    // if (postResult['success']) {
                                    //   AppUtils.topSnackBar(context, StringResource.successfullySubmitted);
                                    //   Navigator.pop(context);
                                    // }
                                  }
                                }
                              // }
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
                                  Languages.of(context)!.branchName,
                                  branchNameController,
                                  validationRules: const ['required'],
                                  isLabel: true,
                                  focusNode: branchNameFocusNode,
                                  onEditing: () =>
                                      branchLocationFocusNode.requestFocus(),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 13),
                                child: CustomReadOnlyTextField(
                                  Languages.of(context)!.branchLocation,
                                  branchLocationController,
                                  validationRules: const ['required'],
                                  isLabel: true,
                                  focusNode: branchLocationFocusNode,
                                  onEditing: () =>
                                      depositAmountFocusNode.requestFocus(),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 13),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: CustomReadOnlyTextField(
                                        Languages.of(context)!.receiptAmount,
                                        receiptController,
                                        validationRules: const ['required'],
                                        isLabel: true,
                                        isReadOnly: true,
                                        isEnable: false,
                                        focusNode: receiptAmountFocusNode,
                                        onEditing: () => depositAmountFocusNode
                                            .requestFocus(),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 7,
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: CustomReadOnlyTextField(
                                        Languages.of(context)!.depositAmount,
                                        depositController,
                                        validationRules: const ['required'],
                                        isLabel: true,
                                        keyBoardType: TextInputType.number,
                                        focusNode: depositAmountFocusNode,
                                        onEditing: () =>
                                            referenceFocusNode.requestFocus(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 13),
                                child: CustomReadOnlyTextField(
                                  Languages.of(context)!.reference,
                                  referenceController,
                                  validationRules: const ['required'],
                                  isLabel: true,
                                  focusNode: referenceFocusNode,
                                  onEditing: () => referenceFocusNode.unfocus(),
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
