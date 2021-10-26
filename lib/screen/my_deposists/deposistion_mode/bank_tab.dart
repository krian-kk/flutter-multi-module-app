import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/screen/dashboard/bloc/dashboard_bloc.dart';
import 'package:origa/screen/dashboard/case_list_widget.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/utils/string_resource.dart';
import 'package:origa/widgets/bottomsheet_appbar.dart';
import 'package:origa/widgets/custom_button.dart';
import 'package:origa/widgets/custom_read_only_text_field.dart';
import 'package:origa/widgets/custom_text.dart';

class BankTab extends StatefulWidget {
  // final DashboardBloc bloc;
  // BankTab(this.bloc, {Key? key}) : super(key: key);

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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bankNameController.text = 'TVS';
    branchController.text = '2W';
    ifscCodeController.text = 'HAR_50CASES-16102020_015953';
    receiptController.text = '100';
    depositController.text = '100';
    referenceController.text = '100';
  }
  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
     builder: (BuildContext context, StateSetter setState) {
       return Scaffold(
         backgroundColor: ColorResource.colorffffff,
         body: Column(
           // ignore: prefer_const_literals_to_create_immutables
           children: [
             Expanded(
               child: Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                 child: SingleChildScrollView(
                   child: Column(
                     children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 13),
                        child: CustomReadOnlyTextField(
                          Languages.of(context)!.bankName,
                          bankNameController,
                          isLabel: true,
                          isEnable: false,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 13),
                        child: CustomReadOnlyTextField(
                          Languages.of(context)!.branchName,
                          branchController,
                          isLabel: true,
                          isEnable: false,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 13),
                        child: CustomReadOnlyTextField(
                          Languages.of(context)!.ifscCode,
                          ifscCodeController,
                          isLabel: true,
                          isEnable: false,
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
                                isLabel: true,
                                isEnable: false,
                              ),
                            ),
                            const SizedBox(width: 7,),
                             Expanded(
                               flex: 1,
                               child: CustomReadOnlyTextField(
                                Languages.of(context)!.depositAmount,
                                depositController,
                                isLabel: true,
                                isEnable: false,
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
                          isLabel: true,
                          isEnable: false,
                        ),
                      ),
                      const SizedBox(height: 7,),
                      CustomButton(
                        Languages.of(context)!.uploadDepositSlip,
                        fontWeight: FontWeight.w700,
                        fontSize: FontSize.sixteen,
                        buttonBackgroundColor: ColorResource.color23375A,
                        cardShape: 50,
                        isLeading: true,
                        trailingWidget: Image.asset(ImageResource.upload),
                      )
                     ],
                   ),
                 ),
               ),
             )
           ],
         ),
       );
     }
    );
  }
}