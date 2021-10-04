// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:origa/base/base_state.dart';
import 'package:origa/languages/app_languages.dart';
//import 'package:origa/base/base_state.dart';
import 'package:origa/models/customer_met_model.dart';
import 'package:origa/screen/case_details_screen/bloc/case_details_bloc.dart';
import 'package:origa/screen/search_allocation_details_screen/search_allocation_details_screen.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/utils/string_resource.dart';
import 'package:origa/widgets/custom_appbar.dart';
import 'package:origa/widgets/custom_button.dart';
import 'package:origa/widgets/custom_text.dart';
import 'package:origa/widgets/custom_textfield.dart';
import 'package:url_launcher/url_launcher.dart';

class CaseDetailsScreen extends StatefulWidget {
  CaseDetailsScreen({Key? key}) : super(key: key);

  @override
  _CaseDetailsScreenState createState() => _CaseDetailsScreenState();
}

class _CaseDetailsScreenState extends State<CaseDetailsScreen> {
  late CaseDetailsBloc bloc;
  late TextEditingController bankNameController = TextEditingController();
  late TextEditingController emiStartStateController = TextEditingController();
  late TextEditingController loanAmountController = TextEditingController();
  late TextEditingController loanDurationController = TextEditingController();
  late TextEditingController posController = TextEditingController();
  late TextEditingController schemeCodeController = TextEditingController();
  late TextEditingController productController = TextEditingController();
  late TextEditingController batchNoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    bloc = CaseDetailsBloc()..add(CaseDetailsInitialEvent());

    loanAmountController.text = '67793';
    loanDurationController.text = '24';
    posController.text = '128974';
    schemeCodeController.text = '34';
    emiStartStateController.text = '08-09-2017';
    bankNameController.text = 'TVS';
    productController.text = '2W';
    batchNoController.text = 'HAR_50CASES-16102020_015953';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResource.colorE5E5E5,
      body: BlocListener<CaseDetailsBloc, CaseDetailsState>(
        bloc: bloc,
        listener: (context, state) {
          if (state is ClickAddressBottomSheetState) {
            addressDetailsShowBottomSheet(context);
          }
          if (state is ClickCallBottomSheetState) {
            callDetailsShowBottomSheet(context);
          }
        },
        child: BlocBuilder<CaseDetailsBloc, CaseDetailsState>(
          bloc: bloc,
          builder: (context, state) {
            if (state is CaseDetailsLoadingState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Scaffold(
                backgroundColor: ColorResource.colorE5E5E5,
                body: Column(
                  children: [
                    CustomAppbar(
                      titleString: Languages.of(context)!.caseDetials,
                      titleSpacing: 21,
                      iconEnumValues: IconEnum.back,

                      // showClose: true,

                      onItemSelected: (value) {
                        if (value == 'IconEnum.back') {
                          Navigator.pop(context);
                        }

                        // else if (value == 'close') {

                        // Navigator.pop(context);

                        // }
                      },
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                          child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(20.0, 0, 20, 20),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 12),
                                    height: 180,
                                    child: Stack(
                                      children: [
                                        Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Container(
                                            // ignore: unnecessary_new
                                            decoration: new BoxDecoration(
                                                color:
                                                    ColorResource.colorD4F5CF,
                                                borderRadius:
                                                    new BorderRadius.all(
                                                        Radius.circular(10.0))),
                                            width: double.infinity,

                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  CustomText(
                                                    'DEBASISH PATNAIK',
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: FontSize.fourteen,
                                                    fontStyle: FontStyle.normal,
                                                    color: ColorResource
                                                        .color333333,
                                                  ),
                                                  const SizedBox(height: 9),
                                                  CustomText(
                                                    Languages.of(context)!
                                                        .accountNo,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: FontSize.twelve,
                                                    fontStyle: FontStyle.normal,
                                                    color: ColorResource
                                                        .color666666,
                                                  ),
                                                  const SizedBox(height: 7),
                                                  CustomText(
                                                    'TVSF_BFRT6524869550',
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: FontSize.fourteen,
                                                    fontStyle: FontStyle.normal,
                                                    color: ColorResource
                                                        .color333333,
                                                  ),
                                                  const SizedBox(height: 11),
                                                  CustomText(
                                                    Languages.of(context)!
                                                        .overdueAmount,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: FontSize.twelve,
                                                    fontStyle: FontStyle.normal,
                                                    color: ColorResource
                                                        .color666666,
                                                  ),
                                                  const SizedBox(height: 7),
                                                  CustomText(
                                                    '397553.67',
                                                    fontWeight: FontWeight.w700,
                                                    fontSize:
                                                        FontSize.twentyFour,
                                                    fontStyle: FontStyle.normal,
                                                    color: ColorResource
                                                        .color333333,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(left: 12),
                                          width: 55,
                                          height: 18,
                                          decoration: new BoxDecoration(
                                              color: ColorResource.colorD5344C,
                                              borderRadius:
                                                  new BorderRadius.all(
                                                      Radius.circular(30.0))),
                                          child: Center(
                                            child: CustomText(
                                              Languages.of(context)!.new_,
                                              color: ColorResource.colorFFFFFF,
                                              fontSize: FontSize.ten,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  CustomTextField(
                                    Languages.of(context)!.loanAmount,
                                    loanAmountController,
                                    isLabel: true,
                                    isEnable: false,
                                  ),
                                  // CustomTextFormField(loanAmountController,
                                  //     StringResource.loanAmount),
                                  const SizedBox(height: 16),
                                  Row(
                                    children: [
                                      Container(
                                        width:
                                            (MediaQuery.of(context).size.width -
                                                    62) /
                                                2,
                                        child: CustomTextField(
                                          Languages.of(context)!.loanDuration,
                                          loanDurationController,
                                          isLabel: true,
                                          isEnable: false,
                                        ),

                                        // CustomTextFormField(
                                        //     loanDurationController,
                                        //     StringResource.loanDuration),
                                      ),
                                      const SizedBox(width: 22),
                                      Container(
                                        width:
                                            (MediaQuery.of(context).size.width -
                                                    62) /
                                                2,
                                        child: CustomTextField(
                                          Languages.of(context)!.pos,
                                          posController,
                                          isLabel: true,
                                          isEnable: false,
                                        ),

                                        // CustomTextFormField(
                                        //     posController, StringResource.pos),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    children: [
                                      Container(
                                        width:
                                            (MediaQuery.of(context).size.width -
                                                    62) /
                                                2,
                                        child: CustomTextField(
                                          Languages.of(context)!.schemeCode,
                                          schemeCodeController,
                                          isLabel: true,
                                          isEnable: false,
                                        ),

                                        // CustomTextFormField(
                                        //     schemeCodeController,
                                        //     StringResource.schemeCode),
                                      ),
                                      const SizedBox(width: 22),
                                      Container(
                                        width:
                                            (MediaQuery.of(context).size.width -
                                                    62) /
                                                2,
                                        child: CustomTextField(
                                          Languages.of(context)!.emiStartDate,
                                          emiStartStateController,
                                          isLabel: true,
                                          isEnable: false,
                                        ),

                                        // CustomTextFormField(
                                        //     emiStartStateController,
                                        //     StringResource.emiStartDate),
                                        // child: TextFormField(
                                        //   readOnly: true,
                                        //   initialValue: '08-09-2017',
                                        //   //controller: loanDurationController,
                                        //   decoration: new InputDecoration(
                                        //       labelText:
                                        //           StringResource.emiStartDate,
                                        //       focusColor: ColorResource.colorE5EAF6,
                                        //       labelStyle: new TextStyle(
                                        //           color: const Color(0xFF424242))),
                                        // ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 15),
                                  CustomTextField(
                                    Languages.of(context)!.bankName,
                                    bankNameController,
                                    isLabel: true,
                                    isEnable: false,
                                  ),
                                  // CustomTextFormField(bankNameController,
                                  //     StringResource.bankName),
                                  // TextFormField(
                                  //   initialValue: 'TVS',
                                  //   //controller: loanDurationController,
                                  //   readOnly: true,
                                  //   decoration: new InputDecoration(
                                  //       labelText: StringResource.bankName,
                                  //       focusColor: ColorResource.colorE5EAF6,
                                  //       labelStyle: new TextStyle(
                                  //           color: const Color(0xFF424242))),
                                  // ),
                                  SizedBox(height: 17),
                                  CustomTextField(
                                    Languages.of(context)!.product,
                                    productController,
                                    isLabel: true,
                                    isEnable: false,
                                  ),
                                  // CustomTextFormField(
                                  //     productController, StringResource.product),
                                  SizedBox(height: 17),
                                  CustomTextField(
                                    Languages.of(context)!.batchNo,
                                    batchNoController,
                                    isLabel: true,
                                    isEnable: false,
                                  ),
                                  // CustomTextFormField(
                                  //     batchNoController, StringResource.batchNo),
                                  // TextFormField(
                                  //   initialValue: 'HAR_50CASES-16102020_015953',
                                  //   //controller: loanDurationController,
                                  //   readOnly: true,
                                  //   decoration: new InputDecoration(
                                  //       labelText: StringResource.batchNo,
                                  //       focusColor: ColorResource.colorE5EAF6,
                                  //       labelStyle: new TextStyle(
                                  //           color: const Color(0xFF424242))),
                                  // ),
                                  SizedBox(height: 23),
                                  CustomText(
                                    Languages.of(context)!.repaymentInfo,
                                    fontSize: FontSize.sixteen,
                                    fontWeight: FontWeight.w700,
                                    fontStyle: FontStyle.normal,
                                  ),
                                  const SizedBox(height: 5),
                                  Container(
                                    width: double.infinity,
                                    decoration: new BoxDecoration(
                                        color: ColorResource.colorFFFFFF,
                                        border: Border.all(
                                            color: ColorResource.colorDADADA,
                                            width: 0.5),
                                        borderRadius: new BorderRadius.all(
                                            Radius.circular(10.0))),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.all(6.0),
                                          width: double.infinity,
                                          height: 97,
                                          decoration: new BoxDecoration(
                                              color: ColorResource.colorF7F8FA,
                                              borderRadius:
                                                  new BorderRadius.all(
                                                      Radius.circular(10.0))),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 15.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                CustomText(
                                                  StringResource
                                                      .beneficiaryDetails,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: FontSize.twelve,
                                                  fontStyle: FontStyle.normal,
                                                  color:
                                                      ColorResource.color666666,
                                                ),
                                                const SizedBox(height: 9),
                                                CustomText(
                                                  'TVSF FINANCE',
                                                  fontWeight: FontWeight.w700,
                                                  color:
                                                      ColorResource.color333333,
                                                  fontSize: FontSize.fourteen,
                                                  fontStyle: FontStyle.normal,
                                                ),
                                                const SizedBox(height: 7),
                                                CustomText(
                                                  'SBI_BFRT6458922993',
                                                  fontWeight: FontWeight.w700,
                                                  color:
                                                      ColorResource.color333333,
                                                  fontSize: FontSize.fourteen,
                                                  fontStyle: FontStyle.normal,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20.0, vertical: 12.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomText(
                                                Languages.of(context)!
                                                    .repaymentBankName,
                                                fontSize: FontSize.twelve,
                                                fontWeight: FontWeight.w400,
                                                fontStyle: FontStyle.normal,
                                                color:
                                                    ColorResource.color666666,
                                              ),
                                              const SizedBox(height: 4),
                                              CustomText(
                                                'Bank Name',
                                                fontSize: FontSize.fourteen,
                                                fontStyle: FontStyle.normal,
                                                fontWeight: FontWeight.w700,
                                                color:
                                                    ColorResource.color333333,
                                              ),
                                              const SizedBox(height: 10),
                                              CustomText(
                                                Languages.of(context)!
                                                    .referenceLender,
                                                fontSize: FontSize.twelve,
                                                fontWeight: FontWeight.w400,
                                                fontStyle: FontStyle.normal,
                                                color:
                                                    ColorResource.color666666,
                                              ),
                                              const SizedBox(height: 4),
                                              CustomText(
                                                'Name',
                                                fontSize: FontSize.fourteen,
                                                fontStyle: FontStyle.normal,
                                                fontWeight: FontWeight.w700,
                                                color:
                                                    ColorResource.color333333,
                                              ),
                                              const SizedBox(height: 10),
                                              CustomText(
                                                Languages.of(context)!
                                                    .referenceUrl,
                                                fontSize: FontSize.twelve,
                                                fontWeight: FontWeight.w400,
                                                fontStyle: FontStyle.normal,
                                                color:
                                                    ColorResource.color666666,
                                              ),
                                              const SizedBox(height: 4),
                                              CustomText(
                                                'URL',
                                                fontSize: FontSize.fourteen,
                                                fontStyle: FontStyle.normal,
                                                fontWeight: FontWeight.w700,
                                                color:
                                                    ColorResource.color333333,
                                              ),
                                              const SizedBox(height: 12),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    flex: 1,
                                                    child: Container(
                                                      child: CustomButton(
                                                        Languages.of(context)!
                                                            .sendSms,
                                                        onTap: () async {
                                                          const uri =
                                                              'sms:+39 348 060 888?body=hello%20there';
                                                          if (await canLaunch(
                                                              uri)) {
                                                            await launch(uri);
                                                          } else {
                                                            const uri =
                                                                'sms:0039-222-060-888?body=hello%20there';
                                                            if (await canLaunch(
                                                                uri)) {
                                                              await launch(uri);
                                                            } else {
                                                              throw 'Could not launch $uri';
                                                            }
                                                          }
                                                        },
                                                        buttonBackgroundColor:
                                                            ColorResource
                                                                .color23375A,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 10),
                                                  Expanded(
                                                    flex: 2,
                                                    child: Container(
                                                      child: CustomButton(
                                                        StringResource
                                                            .sendWHATSAPP,
                                                        isLeading: true,
                                                        trailingWidget:
                                                            Image.asset(
                                                                ImageResource
                                                                    .whatsApp),
                                                        onTap: () async {
                                                          const url =
                                                              "https://wa.me/?text=Hey buddy, try this super cool new app!";
                                                          if (await canLaunch(
                                                              url)) {
                                                            await launch(url);
                                                          } else {
                                                            throw 'Could not launch $url';
                                                          }
                                                        },
                                                        buttonBackgroundColor:
                                                            ColorResource
                                                                .color23375A,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 27),
                                  CustomText(
                                      Languages.of(context)!.otherLoanOf),
                                  CustomText(
                                      Languages.of(context)!.debasishPatnaik),
                                  SizedBox(height: 9),
                                  ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: 2,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Container(
                                              width: double.infinity,
                                              decoration: new BoxDecoration(
                                                  boxShadow: [
                                                    new BoxShadow(
                                                      color: ColorResource
                                                          .color000000
                                                          .withOpacity(.25),
                                                      blurRadius: 2.0,
                                                      offset: Offset(1.0, 1.0),
                                                    ),
                                                  ],
                                                  border: Border.all(
                                                      color: ColorResource
                                                          .colorDADADA,
                                                      width: 0.5),
                                                  color:
                                                      ColorResource.colorF7F8FA,
                                                  borderRadius:
                                                      new BorderRadius.all(
                                                          new Radius.circular(
                                                              10.0))),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 20,
                                                        vertical: 12),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    CustomText(
                                                        Languages.of(context)!
                                                            .accountNo),
                                                    SizedBox(height: 5),
                                                    CustomText(
                                                        'TVSF_BFRT6458922993'),
                                                    SizedBox(height: 11),
                                                    CustomText(StringResource
                                                        .overdueAmount),
                                                    SizedBox(height: 5),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        CustomText('408559.17'),
                                                        Row(
                                                          children: [
                                                            CustomText(
                                                              Languages.of(
                                                                      context)!
                                                                  .view,
                                                              color: ColorResource
                                                                  .color23375A,
                                                            ),
                                                            const SizedBox(
                                                                width: 10),
                                                            Image.asset(
                                                                ImageResource
                                                                    .viewShape)
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 20),
                                          ],
                                        );
                                      }),
                                ],
                              ))),
                    ),
                  ],
                ),
                bottomNavigationBar: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.16,
                  // ignore: unnecessary_new
                  decoration: new BoxDecoration(
                      color: ColorResource.colorFFFFFF,
                      // ignore: unnecessary_new
                      borderRadius: new BorderRadius.only(
                          topLeft: Radius.circular(48.0),
                          topRight: Radius.circular(48.0))),
                  child: Padding(
                    padding: const EdgeInsets.all(21.0),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () =>
                                  bloc.add(ClickAddressBottomSheetEvent()),
                              child: Container(
                                height: 50,
                                decoration: new BoxDecoration(
                                    border: Border.all(
                                        color: ColorResource.color23375A,
                                        width: 0.5),
                                    borderRadius: new BorderRadius.all(
                                        new Radius.circular(10.0))),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 5.0),
                                  child: Row(
                                    children: [
                                      Image.asset(ImageResource.direction),
                                      SizedBox(width: 8),
                                      Expanded(
                                          child: CustomText(
                                        'ADDRESS \nDETAILS',
                                        fontSize: FontSize.twelve,
                                        fontWeight: FontWeight.w700,
                                        fontStyle: FontStyle.normal,
                                        color: ColorResource.color23375A,
                                      ))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: GestureDetector(
                              onTap: () =>
                                  bloc.add(ClickCallBottomSheetEvent()),
                              child: Container(
                                height: 50,
                                decoration: new BoxDecoration(
                                    border: Border.all(
                                        color: ColorResource.color23375A,
                                        width: 0.5),
                                    borderRadius: new BorderRadius.all(
                                        new Radius.circular(10.0))),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 5.0),
                                  child: Row(
                                    children: [
                                      Image.asset(ImageResource.phone),
                                      SizedBox(width: 8),
                                      Expanded(
                                          child: CustomText(
                                        'CALL \nDETAILS',
                                        fontSize: FontSize.twelve,
                                        fontWeight: FontWeight.w700,
                                        fontStyle: FontStyle.normal,
                                        color: ColorResource.color23375A,
                                      ))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );

    // bottomNavigationBar: SizedBox.expand(
    //   child: DraggableScrollableSheet(
    //     initialChildSize: 1,
    //     minChildSize: 1,
    //     maxChildSize: 1,
    //     builder: (BuildContext context, ScrollController scrollController) {
    //       return CustomDraggableScrollableSheet(scrollController);
    //     },
    //   ),
    // )
  }

  void addressDetailsShowBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isDismissible: false,
        isScrollControlled: true,
        backgroundColor: ColorResource.colorFFFFFF,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        builder: (BuildContext context) => StatefulBuilder(
            builder: (BuildContext buildContext, StateSetter setState) =>
                Container(
                  height: MediaQuery.of(context).size.height * 0.87,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 21, vertical: 13),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              Languages.of(context)!
                                  .addressDetails
                                  .toUpperCase(),
                              fontSize: FontSize.fourteen,
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.normal,
                              color: ColorResource.color23375A,
                            ),
                            Spacer(),
                            GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Image.asset(ImageResource.close))
                          ],
                        ),
                        SizedBox(height: 12),
                        Container(
                          width: double.infinity,
                          decoration: new BoxDecoration(
                              color: ColorResource.colorF7F8FA,
                              // ignore: unnecessary_new
                              borderRadius:
                                  new BorderRadius.all(Radius.circular(10.0))),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 14),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CustomText(
                                  'DEBASISH PATNAIK',
                                  fontWeight: FontWeight.w700,
                                  fontSize: FontSize.fourteen,
                                  fontStyle: FontStyle.normal,
                                ),
                                SizedBox(height: 7),
                                CustomText(
                                  'TVSF_BFRT6458922993',
                                  fontWeight: FontWeight.w400,
                                  fontSize: FontSize.fourteen,
                                  fontStyle: FontStyle.normal,
                                ),
                                SizedBox(height: 17),
                                CustomText(
                                  'Overdue Amount',
                                  fontWeight: FontWeight.w400,
                                  fontSize: FontSize.twelve,
                                  fontStyle: FontStyle.normal,
                                ),
                                SizedBox(height: 9),
                                CustomText(
                                  '397553.67',
                                  fontWeight: FontWeight.w700,
                                  fontSize: FontSize.twentyFour,
                                  fontStyle: FontStyle.normal,
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 12),
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: bloc.multiAddressDetilsList.length,
                          itemBuilder: (context, i) {
                            return SizedBox(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CustomText(bloc
                                      .multiAddressDetilsList[i].title
                                      .toUpperCase()),
                                  SizedBox(height: 7),
                                  Container(
                                    width: double.infinity,
                                    decoration: new BoxDecoration(
                                        color: ColorResource.colorF8F9FB,
                                        borderRadius: new BorderRadius.all(
                                            new Radius.circular(10.0))),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 12, 12, 12),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Flexible(
                                                child: CustomText(
                                                  bloc.multiAddressDetilsList[i]
                                                      .address,
                                                  fontSize: FontSize.fourteen,
                                                  fontWeight: FontWeight.w400,
                                                  fontStyle: FontStyle.normal,
                                                  color:
                                                      ColorResource.color484848,
                                                ),
                                              ),
                                              Align(
                                                  alignment: Alignment.topRight,
                                                  child: Image.asset(
                                                      ImageResource.back)),
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Flexible(
                                                  child: SizedBox(
                                                      width: 150,
                                                      child: Container(
                                                          decoration: new BoxDecoration(
                                                              color: ColorResource
                                                                  .colorBEC4CF,
                                                              borderRadius:
                                                                  new BorderRadius
                                                                      .all(new Radius
                                                                          .circular(
                                                                      75.0))),
                                                          child: Row(
                                                            children: [
                                                              Image.asset(
                                                                  ImageResource
                                                                      .direction),
                                                              SizedBox(
                                                                  width: 12),
                                                              CustomText(
                                                                Languages.of(
                                                                        context)!
                                                                    .viewMap,
                                                                color: ColorResource
                                                                    .color23375A,
                                                              )
                                                            ],
                                                          )))),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  CustomText(
                                                    Languages.of(context)!.view,
                                                    lineHeight: 1,
                                                    color: ColorResource
                                                        .color23375A,
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Image.asset(
                                                      ImageResource.viewShape,
                                                      height: 20),
                                                  SizedBox(width: 10)
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                )));
  }

  void callDetailsShowBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isDismissible: false,
        isScrollControlled: true,
        backgroundColor: ColorResource.colorFFFFFF,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        builder: (BuildContext context) => StatefulBuilder(
            builder: (BuildContext buildContext, StateSetter setState) =>
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.87,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 21, vertical: 13),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              Languages.of(context)!.callDetails.toUpperCase(),
                              fontSize: FontSize.fourteen,
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.normal,
                              color: ColorResource.color23375A,
                            ),
                            Spacer(),
                            GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Image.asset(ImageResource.close))
                          ],
                        ),
                        SizedBox(height: 12),
                        Container(
                          width: double.infinity,
                          decoration: new BoxDecoration(
                              color: ColorResource.colorF7F8FA,
                              // ignore: unnecessary_new
                              borderRadius:
                                  new BorderRadius.all(Radius.circular(10.0))),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 14),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CustomText(
                                  'DEBASISH PATNAIK',
                                  fontWeight: FontWeight.w700,
                                  fontSize: FontSize.fourteen,
                                  fontStyle: FontStyle.normal,
                                ),
                                SizedBox(height: 7),
                                CustomText(
                                  'TVSF_BFRT6458922993',
                                  fontWeight: FontWeight.w400,
                                  fontSize: FontSize.fourteen,
                                  fontStyle: FontStyle.normal,
                                ),
                                SizedBox(height: 17),
                                CustomText(
                                  'Overdue Amount',
                                  fontWeight: FontWeight.w400,
                                  fontSize: FontSize.twelve,
                                  fontStyle: FontStyle.normal,
                                ),
                                SizedBox(height: 9),
                                CustomText(
                                  '397553.67',
                                  fontWeight: FontWeight.w700,
                                  fontSize: FontSize.twentyFour,
                                  fontStyle: FontStyle.normal,
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 12),
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: bloc.multiCallDetilsList.length,
                          itemBuilder: (context, i) {
                            return SizedBox(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CustomText(bloc.multiCallDetilsList[i].title
                                      .toUpperCase()),
                                  SizedBox(height: 7),
                                  Container(
                                    width: double.infinity,
                                    decoration: new BoxDecoration(
                                        color: ColorResource.colorF8F9FB,
                                        borderRadius: new BorderRadius.all(
                                            new Radius.circular(10.0))),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 12, 12, 12),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Flexible(
                                                child: CustomText(
                                                  bloc.multiCallDetilsList[i]
                                                      .mobileNo,
                                                  fontSize: FontSize.fourteen,
                                                  fontWeight: FontWeight.w400,
                                                  fontStyle: FontStyle.normal,
                                                  color:
                                                      ColorResource.color484848,
                                                ),
                                              ),
                                              Align(
                                                  alignment: Alignment.topRight,
                                                  child: Image.asset(
                                                      ImageResource.back)),
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Flexible(
                                                  child: SizedBox(
                                                      width: 150,
                                                      child: Container(
                                                          decoration: new BoxDecoration(
                                                              color: ColorResource
                                                                  .colorBEC4CF,
                                                              borderRadius:
                                                                  new BorderRadius
                                                                      .all(new Radius
                                                                          .circular(
                                                                      75.0))),
                                                          child: Row(
                                                            children: [
                                                              Image.asset(
                                                                  ImageResource
                                                                      .direction),
                                                              SizedBox(
                                                                  width: 12),
                                                              CustomText(
                                                                  Languages.of(
                                                                          context)!
                                                                      .call)
                                                            ],
                                                          )))),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  CustomText(
                                                    Languages.of(context)!.view,
                                                    lineHeight: 1,
                                                    color: ColorResource
                                                        .color23375A,
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Image.asset(
                                                      ImageResource.viewShape,
                                                      height: 20),
                                                  SizedBox(width: 10)
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                )));
  }
  // Widget CustomDraggableScrollableSheet(ScrollController scrollController) {
  //   return Container(
  //       decoration: new BoxDecoration(
  //           color: ColorResource.colorFFFFFF,
  //           borderRadius: new BorderRadius.only(
  //               topLeft: Radius.circular(30.0),
  //               topRight: Radius.circular(30.0))),
  //       child: Column(
  //         children: [
  //           Padding(
  //             padding:
  //                 const EdgeInsets.symmetric(horizontal: 0.0, vertical: 25.0),
  //             child: Column(
  //               mainAxisSize: MainAxisSize.min,
  //               children: [
  //                 ListTile(
  //                   trailing: Wrap(
  //                     spacing: 12, // space between two icons
  //                     children: <Widget>[
  //                       Icon(Icons.call), // icon-1
  //                       Image.asset(ImageResource.close) // icon-2
  //                     ],
  //                   ),
  //                   title: CustomText(
  //                       '2/345, 6th Main Road Gomathipuram, Madurai - 625032'),
  //                 ),
  //                 Padding(
  //                   padding: const EdgeInsets.symmetric(horizontal: 12.0),
  //                   child: Row(
  //                     children: [
  //                       Image.asset(ImageResource.checkOn),
  //                       SizedBox(width: 21),
  //                       Image.asset(ImageResource.checkOff),
  //                       Spacer(),
  //                       Row(
  //                         children: [
  //                           CustomText(StringResource.vIEW),
  //                           SizedBox(width: 10),
  //                           Image.asset(ImageResource.viewShape)
  //                         ],
  //                       )
  //                     ],
  //                   ),
  //                 )
  //               ],
  //             ),
  //           ),
  //           // ignore: prefer_const_constructors
  //           DefaultTabController(
  //             length: 3,
  //             // ignore: prefer_const_constructors
  //             child: Column(children: [
  //               TabBar(
  //                 isScrollable: true,
  //                 indicatorColor: ColorResource.colorD5344C,
  //                 indicatorWeight: 5.0,
  //                 labelColor: ColorResource.color23375A,
  //                 unselectedLabelColor: ColorResource.colorC4C4C4,
  //                 // ignore: prefer_const_literals_to_create_immutables
  //                 tabs: [
  //                   // ignore: prefer_const_constructors
  //                   Tab(text: StringResource.customerMet),
  //                   // ignore: prefer_const_constructors
  //                   Tab(text: StringResource.customerNotMet),
  //                   // ignore: prefer_const_constructors
  //                   Tab(text: StringResource.invalid)
  //                 ],
  //               ),
  //               SizedBox(
  //                 height: 300,
  //                 child: TabBarView(
  //                   children: [
  //                     firstTabView(),
  //                     secondTabView(),
  //                     firstTabView(),
  //                   ],
  //                 ),
  //               ),
  //             ]),
  //           )
  //         ],
  //       ));
  // }

  // Widget firstTabView() {
  //   return SingleChildScrollView(
  //     child: Padding(
  //       padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 21.0),
  //       child: Column(
  //         children: [
  //           GridView.builder(
  //             itemCount: bloc.customerMetList.length,
  //             shrinkWrap: true,
  //             physics: const NeverScrollableScrollPhysics(),
  //             gridDelegate:
  //                 SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
  //             itemBuilder: (BuildContext context, int innerIndex) {
  //               return Padding(
  //                 padding: const EdgeInsets.all(4.5),
  //                 child: Container(
  //                   decoration: new BoxDecoration(
  //                       color: ColorResource.colorF8F9FB,
  //                       boxShadow: [
  //                         BoxShadow(
  //                           color: ColorResource.color000000.withOpacity(0.2),
  //                           blurRadius: 2.0,
  //                           offset: Offset(
  //                               1.0, 1.0), // shadow direction: bottom right
  //                         )
  //                       ],
  //                       borderRadius:
  //                           new BorderRadius.all(Radius.circular(10.0))),
  //                   child: Column(
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     crossAxisAlignment: CrossAxisAlignment.center,
  //                     children: [
  //                       Image.asset(bloc.customerMetList[innerIndex].icon),
  //                       SizedBox(height: 8),
  //                       CustomText(
  //                         bloc.customerMetList[innerIndex].title,
  //                         color: ColorResource.color000000,
  //                         fontSize: FontSize.twelve,
  //                         fontWeight: FontWeight.w700,
  //                       )
  //                     ],
  //                   ),
  //                 ),
  //               );
  //             },
  //           ),
  //           SizedBox(height: 30),
  //           Container(
  //             decoration: new BoxDecoration(
  //                 color: ColorResource.colorF7F8FA,
  //                 borderRadius: new BorderRadius.all(Radius.circular(10.0))),
  //             width: double.infinity,
  //             height: 150,
  //             child: Padding(
  //               padding: const EdgeInsets.symmetric(
  //                   horizontal: 10.0, vertical: 19.0),
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   Column(
  //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                     children: [
  //                       Container(
  //                           width: 150,
  //                           height: 50,
  //                           child: CustomButton(
  //                             'REPO',
  //                           )),
  //                       Container(
  //                           width: 150,
  //                           height: 50,
  //                           child: CustomButton(
  //                             'Add Contact',
  //                           )),
  //                     ],
  //                   ),
  //                   Container(
  //                     height: 110,
  //                     width: 150,
  //                     decoration: new BoxDecoration(
  //                         color: ColorResource.color23375A,
  //                         borderRadius:
  //                             new BorderRadius.all(Radius.circular(5.0))),
  //                     child: Column(
  //                       crossAxisAlignment: CrossAxisAlignment.center,
  //                       mainAxisAlignment: MainAxisAlignment.center,
  //                       children: [
  //                         Image.asset(ImageResource.captureImage),
  //                         SizedBox(height: 5),
  //                         CustomText(
  //                           'CAPTURE \nIMAGE',
  //                           textAlign: TextAlign.center,
  //                           color: ColorResource.colorFFFFFF,
  //                           fontSize: FontSize.sixteen,
  //                           fontWeight: FontWeight.w600,
  //                         )
  //                       ],
  //                     ),
  //                   )
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // Widget secondTabView() {
  //   return SingleChildScrollView(
  //     child: Padding(
  //       padding: const EdgeInsets.all(18.0),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Wrap(
  //             children: [
  //               Padding(
  //                 padding: const EdgeInsets.fromLTRB(0, 5, 5, 5),
  //                 child: Container(
  //                   width: 139,
  //                   height: 40,
  //                   child: CustomButton(
  //                     'LEFT MESSAGE',
  //                     textColor: ColorResource.color000000,
  //                     buttonBackgroundColor:
  //                         ColorResource.colorFFB800.withOpacity(0.67),
  //                   ),
  //                 ),
  //               ),
  //               Padding(
  //                 padding: const EdgeInsets.fromLTRB(0, 5, 5, 5),
  //                 child: Container(
  //                   width: 162,
  //                   height: 40,
  //                   child: CustomButton(
  //                     'DOOR LOCKED',
  //                     buttonBackgroundColor: ColorResource.colorE7E7E7,
  //                     textColor: ColorResource.color000000,
  //                   ),
  //                 ),
  //               ),
  //               Padding(
  //                 padding: const EdgeInsets.fromLTRB(0, 5, 5, 5),
  //                 child: Container(
  //                   width: 171,
  //                   height: 40,
  //                   child: CustomButton(
  //                     'ENTRY RESTRICTED',
  //                     textColor: ColorResource.color000000,
  //                     buttonBackgroundColor: ColorResource.colorE7E7E7,
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //           SizedBox(height: 25),
  //           Align(
  //               alignment: Alignment.centerLeft,
  //               child: CustomText('NEXT ACTION DATE*')),
  //           Container(
  //             width: (MediaQuery.of(context).size.width - 62) / 2,
  //             child: TextField(
  //               controller: loanDurationController,
  //               decoration: new InputDecoration(
  //                   suffixIcon: GestureDetector(
  //                       onTap: () {}, child: const Icon(Icons.calendar_today)),
  //                   labelText: StringResource.loanDuration,
  //                   focusColor: ColorResource.colorE5EAF6,
  //                   labelStyle: new TextStyle(color: const Color(0xFF424242))),
  //             ),
  //           ),
  //           Container(
  //             decoration: new BoxDecoration(
  //                 color: ColorResource.colorF7F8FA,
  //                 borderRadius: new BorderRadius.all(Radius.circular(10.0))),
  //             width: double.infinity,
  //             height: 150,
  //             child: Padding(
  //               padding: const EdgeInsets.symmetric(
  //                   horizontal: 10.0, vertical: 19.0),
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   Column(
  //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                     children: [
  //                       Container(
  //                           width: 150,
  //                           height: 50,
  //                           child: CustomButton(
  //                             'REPO',
  //                           )),
  //                       Container(
  //                           width: 150,
  //                           height: 50,
  //                           child: CustomButton(
  //                             'Add Contact',
  //                           )),
  //                     ],
  //                   ),
  //                   Container(
  //                     height: 110,
  //                     width: 150,
  //                     decoration: new BoxDecoration(
  //                         color: ColorResource.color23375A,
  //                         borderRadius:
  //                             new BorderRadius.all(Radius.circular(5.0))),
  //                     child: Column(
  //                       crossAxisAlignment: CrossAxisAlignment.center,
  //                       mainAxisAlignment: MainAxisAlignment.center,
  //                       children: [
  //                         Image.asset(ImageResource.captureImage),
  //                         SizedBox(height: 5),
  //                         CustomText(
  //                           'CAPTURE \nIMAGE',
  //                           textAlign: TextAlign.center,
  //                           color: ColorResource.colorFFFFFF,
  //                           fontSize: FontSize.sixteen,
  //                           fontWeight: FontWeight.w600,
  //                         )
  //                       ],
  //                     ),
  //                   )
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
