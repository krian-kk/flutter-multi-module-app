import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:origa/http/api_repository.dart';
import 'package:origa/http/httpurls.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/models/company_branch_post_model.dart';
import 'package:origa/screen/dashboard/bloc/dashboard_bloc.dart';
import 'package:origa/utils/app_utils.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/constants.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/utils/string_resource.dart';
import 'package:origa/widgets/custom_button.dart';
import 'package:origa/widgets/custom_read_only_text_field.dart';

class CompanyBranch extends StatefulWidget {
  final DashboardBloc bloc;
  final String? caseId;
  final String? mode;
  final String? custname;
  const CompanyBranch(this.bloc, {this.caseId, this.mode, this.custname});

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

  List uploadFileLists = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
                          var requestBodyData = CompanyBranchDepositPostModel(
                            // caseId: widget.caseId,
                            caseIds: ['618e382004d8d040ac18841b'],
                            deposition: Deposition(
                              companyBranchName: 'Branch Name mandatory',
                              companyBranchLocation: 'Location mandatory',
                              recptAmount: '27577',
                              deptAmount: '27577',
                              reference: 'mandatory',
                              // imageLocation: [],
                              mode: 'Company Branch',
                              depositDate: '2021-11-16T03:24:48.584Z',
                              status: 'deposited',
                            ),
                          );

                          print("--------company branch--------");
                          print(jsonEncode(requestBodyData));

                          widget.bloc.add(PostCompanyDepositDataEvent(
                              postData: requestBodyData));

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
                            Languages.of(context)!.branchName,
                            branchNameController,
                            validationRules: ['required'],
                            isLabel: true,
                            isEnable: true,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 13),
                          child: CustomReadOnlyTextField(
                            Languages.of(context)!.branchLocation,
                            branchLocationController,
                            validationRules: ['required'],
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
                                  validationRules: ['required'],
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
                                  validationRules: ['required'],
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
    });
  }
}
