// ignore_for_file: prefer_const_constructors, unnecessary_new, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/screen/case_details_screen/address_details_bottomsheet_screen.dart';
import 'package:origa/screen/case_details_screen/bloc/case_details_bloc.dart';
import 'package:origa/screen/case_details_screen/call_details_bottom_sheet_screen.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/utils/string_resource.dart';
import 'package:origa/widgets/custom_appbar.dart';
import 'package:origa/widgets/custom_button.dart';
import 'package:origa/widgets/custom_read_only_text_field.dart';
import 'package:origa/widgets/custom_text.dart';
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
      backgroundColor: ColorResource.colorF7F8FA,
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
                backgroundColor: ColorResource.colorF7F8FA,
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
                                  Stack(
                                    children: [
                                      Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Container(
                                          decoration: new BoxDecoration(
                                              color: ColorResource.colorD4F5CF,
                                              borderRadius:
                                                  new BorderRadius.all(
                                                      Radius.circular(10.0))),
                                          margin: EdgeInsets.only(top: 10),
                                          width: double.infinity,
                                          child: Padding(
                                            padding: const EdgeInsets.all(15.0),
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
                                                  color:
                                                      ColorResource.color333333,
                                                ),
                                                const SizedBox(height: 11),
                                                CustomText(
                                                  Languages.of(context)!
                                                      .accountNo,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: FontSize.twelve,
                                                  lineHeight: 1,
                                                  fontStyle: FontStyle.normal,
                                                  color:
                                                      ColorResource.color666666,
                                                ),
                                                const SizedBox(height: 7),
                                                CustomText(
                                                  'TVSF_BFRT6524869550',
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: FontSize.fourteen,
                                                  lineHeight: 1,
                                                  fontStyle: FontStyle.normal,
                                                  color:
                                                      ColorResource.color333333,
                                                ),
                                                const SizedBox(height: 13),
                                                CustomText(
                                                  Languages.of(context)!
                                                      .overdueAmount,
                                                  fontWeight: FontWeight.w400,
                                                  lineHeight: 1,
                                                  fontSize: FontSize.twelve,
                                                  fontStyle: FontStyle.normal,
                                                  color:
                                                      ColorResource.color666666,
                                                ),
                                                const SizedBox(height: 7),
                                                CustomText(
                                                  '397553.67',
                                                  fontWeight: FontWeight.w700,
                                                  lineHeight: 1,
                                                  fontSize: FontSize.twentyFour,
                                                  fontStyle: FontStyle.normal,
                                                  color:
                                                      ColorResource.color333333,
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
                                            borderRadius: new BorderRadius.all(
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
                                  const SizedBox(height: 16),
                                  CustomReadOnlyTextField(
                                    Languages.of(context)!.loanAmount,
                                    loanAmountController,
                                    isLabel: true,
                                    isEnable: false,
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    children: [
                                      Flexible(
                                        child: SizedBox(
                                          child: CustomReadOnlyTextField(
                                            Languages.of(context)!.loanDuration,
                                            loanDurationController,
                                            isLabel: true,
                                            isEnable: false,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 22),
                                      Flexible(
                                        child: SizedBox(
                                          child: CustomReadOnlyTextField(
                                            Languages.of(context)!.pos,
                                            posController,
                                            isLabel: true,
                                            isEnable: false,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    children: [
                                      Flexible(
                                        child: CustomReadOnlyTextField(
                                          Languages.of(context)!.schemeCode,
                                          schemeCodeController,
                                          isLabel: true,
                                          isEnable: false,
                                        ),
                                      ),
                                      const SizedBox(width: 22),
                                      Flexible(
                                        child: CustomReadOnlyTextField(
                                          Languages.of(context)!.emiStartDate,
                                          emiStartStateController,
                                          isLabel: true,
                                          isEnable: false,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 15),
                                  CustomReadOnlyTextField(
                                    Languages.of(context)!.bankName,
                                    bankNameController,
                                    isLabel: true,
                                    isEnable: false,
                                  ),
                                  SizedBox(height: 17),
                                  CustomReadOnlyTextField(
                                    Languages.of(context)!.product,
                                    productController,
                                    isLabel: true,
                                    isEnable: false,
                                  ),
                                  SizedBox(height: 17),
                                  CustomReadOnlyTextField(
                                    Languages.of(context)!.batchNo,
                                    batchNoController,
                                    isLabel: true,
                                    isEnable: false,
                                  ),
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
                                                    flex: 2,
                                                    child: Container(
                                                      child: CustomButton(
                                                        Languages.of(context)!
                                                            .sendSms,
                                                        borderColor:
                                                            ColorResource
                                                                .color23375A,
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
                                                  SizedBox(width: 5),
                                                  Expanded(
                                                    flex: 3,
                                                    child: Container(
                                                      child: CustomButton(
                                                        StringResource
                                                            .sendWHATSAPP,
                                                        borderColor:
                                                            ColorResource
                                                                .color23375A,
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
                                    Languages.of(context)!.otherLoanOf,
                                    color: ColorResource.color101010,
                                    fontSize: FontSize.sixteen,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  CustomText(
                                    Languages.of(context)!.debasishPatnaik,
                                    color: ColorResource.color333333,
                                    fontSize: FontSize.fourteen,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w700,
                                  ),
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
                                                          .accountNo,
                                                      color: ColorResource
                                                          .color666666,
                                                      fontSize: FontSize.twelve,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                    SizedBox(height: 5),
                                                    CustomText(
                                                      'TVSF_BFRT6458922993',
                                                      color: ColorResource
                                                          .color333333,
                                                      fontSize:
                                                          FontSize.fourteen,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                    SizedBox(height: 11),
                                                    CustomText(
                                                      StringResource
                                                          .overdueAmount,
                                                      color: ColorResource
                                                          .color666666,
                                                      fontSize: FontSize.twelve,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                    SizedBox(height: 5),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        CustomText(
                                                          '408559.17',
                                                          color: ColorResource
                                                              .color333333,
                                                          fontSize:
                                                              FontSize.fourteen,
                                                          fontStyle:
                                                              FontStyle.normal,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                        ),
                                                        Row(
                                                          children: [
                                                            CustomText(
                                                              Languages.of(
                                                                      context)!
                                                                  .view,
                                                              color: ColorResource
                                                                  .color23375A,
                                                              fontSize: FontSize
                                                                  .fourteen,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .normal,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
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
                  height: MediaQuery.of(context).size.height * 0.15,
                  decoration: new BoxDecoration(
                      color: ColorResource.colorFFFFFF,
                      borderRadius: new BorderRadius.only(
                          topLeft: Radius.circular(28.0),
                          topRight: Radius.circular(28.0))),
                  child: Padding(
                    padding: const EdgeInsets.all(21.0),
                    child: Align(
                      alignment: Alignment.center,
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
                AddressDetailsBottomSheetScreen(bloc: bloc)));
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
                CallDetailsBottomSheetScreen(bloc: bloc)));
  }
}
