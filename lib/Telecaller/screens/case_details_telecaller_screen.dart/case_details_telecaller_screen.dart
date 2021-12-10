import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:origa/Telecaller/screens/case_details_telecaller_screen.dart/bloc/casedetails_telecaller_bloc.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/widgets/bottomsheet_appbar.dart';
import 'package:origa/widgets/custom_loan_user_details.dart';
import 'package:origa/widgets/custom_read_only_text_field.dart';
import 'package:origa/widgets/custom_text.dart';

class CaseDetailsTelecallerScreen extends StatefulWidget {
  const CaseDetailsTelecallerScreen({Key? key}) : super(key: key);

  @override
  _CaseDetailsTelecallerScreenState createState() =>
      _CaseDetailsTelecallerScreenState();
}

class _CaseDetailsTelecallerScreenState
    extends State<CaseDetailsTelecallerScreen> {
  late CasedetailsTelecallerBloc bloc;
  late StreamSubscription subscription;

  @override
  void initState() {
    super.initState();
    // subscription =
    //     Connectivity().onConnectivityChanged.listen(showConnectivitySnackBar);

    bloc = CasedetailsTelecallerBloc()
      ..add(CaseDetailsTelecallerInitialEvent());
    // getConnectivty();
  }

  // getConnectivty() async {
  //   final result = await Connectivity().checkConnectivity();
  // }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height * 0.88,
        child: Column(
          children: [
            BottomSheetAppbar(
                title: Languages.of(context)!.caseDetials.toUpperCase(),
                padding: const EdgeInsets.all(21)),
            BlocListener<CasedetailsTelecallerBloc, CasedetailsTelecallerState>(
              bloc: bloc,
              listener: (context, state) {},
              child: BlocBuilder<CasedetailsTelecallerBloc,
                  CasedetailsTelecallerState>(
                bloc: bloc,
                builder: (context, state) {
                  if (state is CaseDetailsTelecallerLoadingState) {
                    return const Expanded(
                      child: Center(child: CircularProgressIndicator()),
                    );
                  } else {
                    return Expanded(
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
                                        child: CustomLoanUserDetails(
                                          userName: bloc.caseDetailsResult
                                                  .result?.caseDetails?.cust ??
                                              '',
                                          userId: bloc.caseDetailsResult.result
                                                  ?.caseDetails?.accNo ??
                                              '',
                                          userAmount: bloc.caseDetailsResult
                                                  .result?.caseDetails?.due
                                                  ?.toDouble() ??
                                              0.0,
                                          isAccountNo: true,
                                          color: ColorResource.colorD4F5CF,
                                          marginTop: 10,
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(left: 12),
                                        width: 55,
                                        height: 18,
                                        decoration: const BoxDecoration(
                                            color: ColorResource.colorD5344C,
                                            borderRadius: BorderRadius.all(
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
                                    bloc.loanAmountController,
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
                                            bloc.loanDurationController,
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
                                            bloc.posController,
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
                                          bloc.schemeCodeController,
                                          isLabel: true,
                                          isEnable: false,
                                        ),
                                      ),
                                      const SizedBox(width: 22),
                                      Flexible(
                                        child: CustomReadOnlyTextField(
                                          Languages.of(context)!.emiStartDate,
                                          bloc.emiStartDateController,
                                          isLabel: true,
                                          isEnable: false,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 15),
                                  CustomReadOnlyTextField(
                                    Languages.of(context)!.bankName,
                                    bloc.bankNameController,
                                    isLabel: true,
                                    isEnable: false,
                                  ),
                                  const SizedBox(height: 17),
                                  CustomReadOnlyTextField(
                                    Languages.of(context)!.product,
                                    bloc.productController,
                                    isLabel: true,
                                    isEnable: false,
                                  ),
                                  const SizedBox(height: 17),
                                  CustomReadOnlyTextField(
                                    Languages.of(context)!.batchNo,
                                    bloc.batchNoController,
                                    isLabel: true,
                                    isEnable: false,
                                  ),
                                  const SizedBox(height: 23),
                                  CustomText(
                                    Languages.of(context)!.repaymentInfo,
                                    fontSize: FontSize.sixteen,
                                    fontWeight: FontWeight.w700,
                                    fontStyle: FontStyle.normal,
                                  ),
                                  const SizedBox(height: 5),
                                  Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: ColorResource.colorFFFFFF,
                                        border: Border.all(
                                            color: ColorResource.colorDADADA,
                                            width: 0.5),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10.0))),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.all(6.0),
                                          width: double.infinity,
                                          height: 97,
                                          decoration: const BoxDecoration(
                                              color: ColorResource.colorF7F8FA,
                                              borderRadius: BorderRadius.all(
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
                                                  Languages.of(context)!
                                                      .beneficiaryDetails,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: FontSize.twelve,
                                                  fontStyle: FontStyle.normal,
                                                  color:
                                                      ColorResource.color666666,
                                                ),
                                                const SizedBox(height: 9),
                                                const CustomText(
                                                  'TVSF FINANCE',
                                                  fontWeight: FontWeight.w700,
                                                  color:
                                                      ColorResource.color333333,
                                                  fontSize: FontSize.fourteen,
                                                  fontStyle: FontStyle.normal,
                                                ),
                                                const SizedBox(height: 7),
                                                const CustomText(
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
                                              const CustomText(
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
                                              const CustomText(
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
                                              const CustomText(
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
                                                  Container(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 10,
                                                        vertical: 10),
                                                    decoration: BoxDecoration(
                                                      color: ColorResource
                                                          .color23375A,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      border: Border.all(
                                                          color: ColorResource
                                                              .colorECECEC,
                                                          width: 1.0),
                                                    ),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        SvgPicture.asset(
                                                            ImageResource
                                                                .whatsApp),
                                                        const SizedBox(
                                                            width: 5),
                                                        CustomText(
                                                            Languages.of(
                                                                    context)!
                                                                .sendSms
                                                                .toString()
                                                                .replaceAll(
                                                                    ' ', '\n')
                                                                .toUpperCase(),
                                                            lineHeight: 1.0,
                                                            color: ColorResource
                                                                .colorffffff),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Container(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 10,
                                                        vertical: 10),
                                                    decoration: BoxDecoration(
                                                      color: ColorResource
                                                          .color23375A,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      border: Border.all(
                                                          color: ColorResource
                                                              .colorECECEC,
                                                          width: 1.0),
                                                    ),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        SvgPicture.asset(
                                                            ImageResource
                                                                .whatsApp),
                                                        const SizedBox(
                                                            width: 5),
                                                        CustomText(
                                                          Languages.of(context)!
                                                              .sendWhatsapp
                                                              .toString()
                                                              .replaceAll(
                                                                  ' ', '\n')
                                                              .toUpperCase(),
                                                          lineHeight: 1.0,
                                                          color: ColorResource
                                                              .colorffffff,
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              )
                                              // Row(
                                              //   mainAxisAlignment:
                                              //       MainAxisAlignment
                                              //           .spaceBetween,
                                              //   children: [
                                              //     Expanded(
                                              //       flex: 2,
                                              //       child: CustomButton(
                                              //         StringResource.sendSms
                                              //             .toUpperCase(),
                                              //         fontSize: FontSize.twelve,
                                              //         borderColor: ColorResource
                                              //             .color23375A,
                                              //         onTap: () async {
                                              //           const uri =
                                              //               'sms:+39 348 060 888?body=hello%20there';
                                              //           if (await canLaunch(
                                              //               uri)) {
                                              //             await launch(uri);
                                              //           } else {
                                              //             const uri =
                                              //                 'sms:0039-222-060-888?body=hello%20there';
                                              //             if (await canLaunch(
                                              //                 uri)) {
                                              //               await launch(uri);
                                              //             } else {
                                              //               throw 'Could not launch $uri';
                                              //             }
                                              //           }
                                              //         },
                                              //         buttonBackgroundColor:
                                              //             ColorResource
                                              //                 .color23375A,
                                              //       ),
                                              //     ),
                                              //     const SizedBox(width: 5),
                                              //     Expanded(
                                              //       flex: 3,
                                              //       child: CustomButton(
                                              //         StringResource
                                              //             .sendWhatsapp
                                              //             .toUpperCase(),
                                              //         fontSize: FontSize.twelve,
                                              //         borderColor: ColorResource
                                              //             .color23375A,
                                              //         isLeading: true,
                                              //         trailingWidget:
                                              //             SvgPicture.asset(
                                              //                 ImageResource
                                              //                     .whatsApp),
                                              //         onTap: () async {
                                              //           const url =
                                              //               'https://wa.me/?text=Origa';

                                              //           await launch(url);
                                              //         },
                                              //         buttonBackgroundColor:
                                              //             ColorResource
                                              //                 .color23375A,
                                              //       ),
                                              //     ),
                                              //   ],
                                              // )
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
                                    bloc.caseDetailsResult.result?.caseDetails
                                            ?.cust
                                            ?.toUpperCase() ??
                                        'DEBASISH PATNAIK', //--------------- doubt -----------
                                    color: ColorResource.color333333,
                                    fontSize: FontSize.fourteen,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: bloc.caseDetailsResult.result
                                              ?.otherLoanDetails?.length ??
                                          2,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Container(
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: ColorResource
                                                          .color000000
                                                          .withOpacity(.25),
                                                      blurRadius: 2.0,
                                                      offset: const Offset(
                                                          1.0, 1.0),
                                                    ),
                                                  ],
                                                  border: Border.all(
                                                      color: ColorResource
                                                          .colorDADADA,
                                                      width: 0.5),
                                                  color:
                                                      ColorResource.colorF7F8FA,
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(
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
                                                    const SizedBox(height: 5),
                                                    CustomText(
                                                      bloc
                                                              .caseDetailsResult
                                                              .result
                                                              ?.otherLoanDetails![
                                                                  index]
                                                              .cust
                                                              ?.toUpperCase() ??
                                                          'TVSF_BFRT6458922993', // ----------- doubt ---------------
                                                      color: ColorResource
                                                          .color333333,
                                                      fontSize:
                                                          FontSize.fourteen,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                    const SizedBox(height: 11),
                                                    CustomText(
                                                      Languages.of(context)!
                                                          .overdueAmount,
                                                      color: ColorResource
                                                          .color666666,
                                                      fontSize: FontSize.twelve,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                    const SizedBox(height: 5),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        CustomText(
                                                          bloc
                                                                  .caseDetailsResult
                                                                  .result
                                                                  ?.otherLoanDetails?[
                                                                      index]
                                                                  .due
                                                                  .toString() ??
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
                                                            SvgPicture.asset(
                                                                ImageResource
                                                                    .forwardArrow)
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
                    );
                  }
                },
              ),
            ),
          ],
        ));
  }

  void callDetailsShowBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        enableDrag: false,
        isDismissible: false,
        isScrollControlled: true,
        backgroundColor: ColorResource.colorFFFFFF,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        builder: (BuildContext context) => StatefulBuilder(
            builder: (BuildContext buildContext, StateSetter setState) =>
                // CallDetailsBottomSheetScreen(bloc: bloc)
                const SizedBox()));
  }
}
