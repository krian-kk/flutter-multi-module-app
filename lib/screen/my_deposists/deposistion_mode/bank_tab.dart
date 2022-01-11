import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/models/bank_deposit_post_model.dart';
import 'package:origa/screen/dashboard/bloc/dashboard_bloc.dart';
import 'package:origa/singleton.dart';
import 'package:origa/utils/app_utils.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/constants.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/utils/string_resource.dart';
import 'package:origa/widgets/custom_button.dart';
import 'package:origa/widgets/custom_read_only_text_field.dart';

class BankTab extends StatefulWidget {
  final DashboardBloc bloc;
  final List<String>? caseIds;
  final String? mode;
  final String? custname;
  const BankTab(this.bloc, {Key? key, this.caseIds, this.mode, this.custname})
      : super(key: key);

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

  final _formKey = GlobalKey<FormState>();
  List uploadFileLists = [];

  DateTime now = DateTime.now();

  bool isSubmited = true;

  @override
  void initState() {
    super.initState();
  }

  getFiles() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(allowMultiple: true, type: FileType.any);
    if (result != null) {
      uploadFileLists =
          result.files.map((path) => path.path.toString()).toList();
    } else {
      AppUtils.showToast(StringResource.canceled, gravity: ToastGravity.CENTER);
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
                                  if (uploadFileLists.isEmpty) {
                                    AppUtils.showToast(
                                      Constants.uploadDepositSlip,
                                      gravity: ToastGravity.CENTER,
                                    );
                                  } else {
                                    var requestBodyData = BankDepositPostModel(
                                        // caseId: widget.caseId,
                                        caseIds: widget.caseIds as List<String>,
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
                                          imageLocation:
                                              uploadFileLists as List<String>,
                                          mode: widget.mode.toString(),
                                          depositDate:
                                              DateTime.now().toString(),
                                          status: 'deposited',
                                        ));

                                    widget.bloc.add(PostBankDepositDataEvent(
                                        postData: requestBodyData));

                                    // Map<String, dynamic> postResult =
                                    //     await APIRepository.apiRequest(APIRequestType.POST,
                                    //     HttpUrl.bankDeposit,
                                    //         requestBodydata: jsonEncode(requestBodyData));
                                    // if (postResult['success']) {
                                    //   AppUtils.topSnackBar(context, StringResource.successfullySubmitted);
                                    //   Navigator.pop(context);
                                    // }
                                  }
                                }
                              }
                            : () {},
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
                                isEnable: true,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 13),
                              child: CustomReadOnlyTextField(
                                Languages.of(context)!.branchName,
                                branchController,
                                validationRules: const ['required'],
                                isLabel: true,
                                isEnable: true,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 13),
                              child: CustomReadOnlyTextField(
                                Languages.of(context)!.ifscCode,
                                ifscCodeController,
                                validationRules: const ['required'],
                                isLabel: true,
                                isEnable: true,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 13),
                              child: CustomReadOnlyTextField(
                                Languages.of(context)!.accNumber,
                                accNoController,
                                validationRules: const ['required'],
                                isLabel: true,
                                isEnable: true,
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
                                      isEnable: true,
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
                                      isEnable: true,
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
