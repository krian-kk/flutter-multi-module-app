import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:languages/app_languages.dart';
import 'package:origa/models/bank_deposit_post_model.dart';
import 'package:origa/singleton.dart';
import 'package:origa/src/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:origa/utils/app_utils.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/constants.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/utils/string_resource.dart';
import 'package:origa/widgets/custom_button.dart';
import 'package:origa/widgets/custom_dialog.dart';
import 'package:origa/widgets/custom_loading_widget.dart';
import 'package:origa/widgets/custom_read_only_text_field.dart';
import 'package:origa/widgets/object_id_widget.dart';

class BankTab extends StatefulWidget {
  const BankTab(this.bloc,
      {Key? key,
      this.selectedCaseIds,
      this.mode,
      this.custname,
      this.receiptAmt})
      : super(key: key);
  final DashboardBloc bloc;
  final List<String>? selectedCaseIds;
  final String? mode;
  final String? custname;
  final double? receiptAmt;

  @override
  _BankTabState createState() => _BankTabState();
}

class _BankTabState extends State<BankTab> {
  late TextEditingController bankNameController = TextEditingController();
  late TextEditingController branchController = TextEditingController();
  late TextEditingController ifscCodeController = TextEditingController();
  late TextEditingController receiptController = TextEditingController();
  late TextEditingController depositController = TextEditingController();
  late TextEditingController referenceController = TextEditingController();
  late TextEditingController accNoController = TextEditingController();

  FocusNode bankNameFocusNode = FocusNode();
  FocusNode branchNameFocusNode = FocusNode();
  FocusNode ifscCodeFocusNode = FocusNode();
  FocusNode accNoFocusNode = FocusNode();
  FocusNode receiptAmountFocusNode = FocusNode();
  FocusNode depositAmountFocusNode = FocusNode();
  FocusNode referenceFocusNode = FocusNode();

  final _formKey = GlobalKey<FormState>();
  List<File> uploadFileLists = [];

  DateTime now = DateTime.now();

  bool isSubmited = true;

  @override
  void initState() {
    super.initState();
    setState(() {
      receiptController.text = widget.receiptAmt.toString();
    });
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
    return BlocListener<DashboardBloc, DashboardState>(
      bloc: widget.bloc,
      listener: (context, state) {
        if (state is DisableMDBankSubmitBtnState) {
          setState(() => isSubmited = false);
        }
        if (state is EnableMDBankSubmitBtnState) {
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

                                  final id = ObjectIdWidget();
                                  final requestBodyData = BankDepositPostModel(
                                      ids: widget.selectedCaseIds!.length == 1
                                          ? [...widget.selectedCaseIds!, '$id']
                                          : widget.selectedCaseIds!,
                                      contractor:
                                          Singleton.instance.contractor ?? '',
                                      deposition: Deposition(
                                        bankName: bankNameController.text,
                                        bankBranch: branchController.text,
                                        ifscCode: ifscCodeController.text,
                                        accNumber: accNoController.text,
                                        recptAmount: receiptController.text,
                                        deptAmount: depositController.text,
                                        reference: referenceController.text,
                                        imageLocation: [],
                                        mode: widget.mode.toString(),
                                        depositDate: DateTime.now().toString(),
                                        status: 'deposited',
                                      ));

                                  debugPrint(
                                      'requestBodyData for bank tab ----> ${jsonEncode(requestBodyData)}');

                                  if (double.parse(receiptController.text) ==
                                      double.parse(depositController.text)) {
                                    widget.bloc.add(PostBankDepositDataEvent(
                                      postData: requestBodyData,
                                      fileData: uploadFileLists,
                                      context: context,
                                    ));
                                  } else {
                                    await DialogUtils.showDialog(
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
                                          widget.bloc
                                              .add(PostBankDepositDataEvent(
                                            postData: requestBodyData,
                                            fileData: uploadFileLists,
                                            context: context,
                                          ));
                                        });
                                  }

                                  // Map<String, dynamic> postResult =
                                  //     await APIRepository.apiRequest(APIRequestType.post,
                                  //     HttpUrl.bankDeposit,
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
                                Languages.of(context)!.bankName,
                                bankNameController,
                                validationRules: const ['required'],
                                isLabel: true,
                                focusNode: bankNameFocusNode,
                                onEditing: () =>
                                    branchNameFocusNode.requestFocus(),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 13),
                              child: CustomReadOnlyTextField(
                                Languages.of(context)!.branchName,
                                branchController,
                                validationRules: const ['required'],
                                isLabel: true,
                                focusNode: branchNameFocusNode,
                                onEditing: () =>
                                    ifscCodeFocusNode.requestFocus(),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 13),
                              child: CustomReadOnlyTextField(
                                Languages.of(context)!.ifscCode,
                                ifscCodeController,
                                textCapitalization:
                                    TextCapitalization.characters,
                                validationRules: const ['required'],
                                isLabel: true,
                                focusNode: ifscCodeFocusNode,
                                onEditing: () => accNoFocusNode.requestFocus(),
                                inputformaters: [
                                  LengthLimitingTextInputFormatter(11),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 13),
                              child: CustomReadOnlyTextField(
                                Languages.of(context)!.accNumber,
                                accNoController,
                                validationRules: const ['required'],
                                isLabel: true,
                                focusNode: accNoFocusNode,
                                onEditing: () =>
                                    depositAmountFocusNode.requestFocus(),
                                keyBoardType: TextInputType.number,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 13),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: CustomReadOnlyTextField(
                                      Languages.of(context)!.receiptAmount,
                                      receiptController,
                                      validationRules: const ['required'],
                                      isLabel: true,
                                      isReadOnly: true,
                                      isEnable: false,
                                      focusNode: receiptAmountFocusNode,
                                      keyBoardType: TextInputType.number,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 7,
                                  ),
                                  Expanded(
                                    child: CustomReadOnlyTextField(
                                      Languages.of(context)!.depositAmount,
                                      depositController,
                                      validationRules: const ['required'],
                                      isLabel: true,
                                      focusNode: depositAmountFocusNode,
                                      keyBoardType: TextInputType.number,
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
                              buttonBackgroundColor: ColorResource.color23375A,
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
  }
}
