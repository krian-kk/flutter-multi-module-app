import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/router.dart';
import 'package:origa/screen/add_address_screen/add_address_screen.dart';
import 'package:origa/screen/call_customer_screen/call_customer_bottom_sheet.dart';
import 'package:origa/screen/capture_image_screen/capture_image_bottom_sheet.dart';
import 'package:origa/screen/case_details_screen/address_details_bottomsheet_screen.dart';
import 'package:origa/screen/case_details_screen/address_screen/address_screen.dart';
import 'package:origa/screen/case_details_screen/bloc/case_details_bloc.dart';
import 'package:origa/screen/case_details_screen/call_details_bottom_sheet_screen.dart';
import 'package:origa/screen/case_details_screen/phone_screen/phone_screen.dart';
import 'package:origa/screen/collection_screen/collections_bottom_sheet.dart';
import 'package:origa/screen/dispute_screen/dispute_bottom_sheet.dart';
import 'package:origa/screen/event_details_screen/event_details_bottom_sheet.dart';
import 'package:origa/screen/map_view_bottom_sheet_screen/map_view_bottom_sheet_screen.dart';
import 'package:origa/screen/other_feed_back_screen/other_feed_back_bottom_sheet.dart';
import 'package:origa/screen/ots_screen/ots_bottom_sheet.dart';
import 'package:origa/screen/ptp_screen/ptp_bottom_sheet.dart';
import 'package:origa/screen/remainder_screen/remainder_bottom_sheet.dart';
import 'package:origa/screen/repo_screen/repo_bottom_sheet.dart';
import 'package:origa/screen/rtp_screen/rtp_bottom_sheet.dart';
import 'package:origa/utils/app_utils.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/constants.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/widgets/bottomsheet_appbar.dart';
import 'package:origa/widgets/custom_appbar.dart';
import 'package:origa/widgets/custom_loan_user_details.dart';
import 'package:origa/widgets/custom_read_only_text_field.dart';
import 'package:origa/widgets/custom_text.dart';

class CaseDetailsScreen extends StatefulWidget {
  final dynamic paramValues;
  const CaseDetailsScreen({Key? key, this.paramValues}) : super(key: key);

  @override
  _CaseDetailsScreenState createState() => _CaseDetailsScreenState();
}

class _CaseDetailsScreenState extends State<CaseDetailsScreen> {
  late CaseDetailsBloc bloc;
  late StreamSubscription subscription;

  @override
  void initState() {
    super.initState();

    bloc = CaseDetailsBloc()
      ..add(CaseDetailsInitialEvent(
          paramValues: widget.paramValues, context: context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResource.colorF7F8FA,
      body: BlocListener<CaseDetailsBloc, CaseDetailsState>(
        bloc: bloc,
        listener: (context, state) {
          if (state is PostDataApiSuccessState) {
            AppUtils.topSnackBar(context, Constants.eventUpdatedSuccess);
            Navigator.pop(context);
          }
          if (state is ClickMainAddressBottomSheetState) {
            Navigator.pop(context);
            addressBottomSheet(context, bloc, state.i);
          }
          if (state is ClickMainCallBottomSheetState) {
            Navigator.pop(context);
            phoneBottomSheet(context, bloc, state.i);
          }
          if (state is ClickOpenBottomSheetState) {
            openBottomSheet(context, state.title, state.list, state.isCall,
                health: state.health);
          }
          if (state is NoInternetState) {
            AppUtils.noInternetSnackbar(context);
          }
          if (state is CallCaseDetailsState) {
            Navigator.pushNamed(context, AppRoutes.caseDetailsScreen,
                arguments: state.paramValues);
          }
          if (state is PushAndPOPNavigationCaseDetailsState) {
            Navigator.pushReplacementNamed(context, AppRoutes.caseDetailsScreen,
                arguments: state.paramValues);
          }
        },
        child: BlocBuilder<CaseDetailsBloc, CaseDetailsState>(
          bloc: bloc,
          builder: (context, state) {
            if (state is CaseDetailsLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Scaffold(
                backgroundColor: ColorResource.colorF7F8FA,
                body: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: CustomAppbar(
                        titleString: Languages.of(context)!.caseDetials,
                        titleSpacing: 10,
                        iconEnumValues: IconEnum.back,
                        onItemSelected: (value) {
                          if (value == 'IconEnum.back') {
                            Navigator.pop(context);
                          }
                        },
                      ),
                    ),
                    bloc.isNoInternetAndServerError
                        ? Expanded(
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomText(bloc.noInternetAndServerErrorMsg!),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        bloc.add(CaseDetailsInitialEvent(
                                            paramValues: widget.paramValues,
                                            context: context));
                                      },
                                      icon: const Icon(Icons.refresh)),
                                ],
                              ),
                            ),
                          )
                        : Expanded(
                            child: SingleChildScrollView(
                                child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        20.0, 0, 20, 20),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Stack(
                                          children: [
                                            Align(
                                              alignment: Alignment.bottomCenter,
                                              child: CustomLoanUserDetails(
                                                userName: bloc
                                                        .caseDetailsAPIValue
                                                        .result
                                                        ?.caseDetails
                                                        ?.cust ??
                                                    '_',
                                                userId: bloc
                                                        .caseDetailsAPIValue
                                                        .result
                                                        ?.caseDetails
                                                        ?.accNo ??
                                                    '_',
                                                userAmount: bloc
                                                        .caseDetailsAPIValue
                                                        .result
                                                        ?.caseDetails
                                                        ?.due
                                                        ?.toDouble() ??
                                                    0,
                                                isAccountNo: true,
                                                color:
                                                    ColorResource.colorD4F5CF,
                                                marginTop: 10,
                                              ),
                                            ),
                                            if (bloc
                                                    .caseDetailsAPIValue
                                                    .result
                                                    ?.caseDetails
                                                    ?.collSubStatus ==
                                                'new')
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    left: 12),
                                                width: 55,
                                                height: 18,
                                                decoration: const BoxDecoration(
                                                    color: ColorResource
                                                        .colorD5344C,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                30.0))),
                                                child: Center(
                                                  child: CustomText(
                                                    Languages.of(context)!.new_,
                                                    color: ColorResource
                                                        .colorFFFFFF,
                                                    lineHeight: 1,
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
                                                  Languages.of(context)!
                                                      .loanDuration,
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
                                                Languages.of(context)!
                                                    .schemeCode,
                                                bloc.schemeCodeController,
                                                isLabel: true,
                                                isEnable: false,
                                              ),
                                            ),
                                            const SizedBox(width: 22),
                                            Flexible(
                                              child: CustomReadOnlyTextField(
                                                Languages.of(context)!
                                                    .emiStartDate,
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
                                                  color:
                                                      ColorResource.colorDADADA,
                                                  width: 0.5),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(10.0))),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                margin:
                                                    const EdgeInsets.all(6.0),
                                                width: double.infinity,
                                                height: 97,
                                                decoration: const BoxDecoration(
                                                    color: ColorResource
                                                        .colorF7F8FA,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10.0))),
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 15.0),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      CustomText(
                                                        Languages.of(context)!
                                                            .beneficiaryDetails,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize:
                                                            FontSize.twelve,
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        color: ColorResource
                                                            .color666666,
                                                      ),
                                                      const SizedBox(height: 9),
                                                      CustomText(
                                                        bloc
                                                                .caseDetailsAPIValue
                                                                .result
                                                                ?.caseDetails
                                                                ?.repaymentInfo
                                                                ?.benefeciaryAccName ??
                                                            '-',
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: ColorResource
                                                            .color333333,
                                                        fontSize:
                                                            FontSize.fourteen,
                                                        fontStyle:
                                                            FontStyle.normal,
                                                      ),
                                                      const SizedBox(height: 7),
                                                      CustomText(
                                                        bloc
                                                                .caseDetailsAPIValue
                                                                .result
                                                                ?.caseDetails
                                                                ?.repaymentInfo
                                                                ?.repaymentIfscCode ??
                                                            '-',
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: ColorResource
                                                            .color333333,
                                                        fontSize:
                                                            FontSize.fourteen,
                                                        fontStyle:
                                                            FontStyle.normal,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 20.0,
                                                        vertical: 12.0),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    CustomText(
                                                      Languages.of(context)!
                                                          .repaymentBankName,
                                                      fontSize: FontSize.twelve,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      color: ColorResource
                                                          .color666666,
                                                    ),
                                                    const SizedBox(height: 4),
                                                    CustomText(
                                                      bloc
                                                              .caseDetailsAPIValue
                                                              .result
                                                              ?.caseDetails
                                                              ?.repaymentInfo
                                                              ?.repayBankName ??
                                                          '-',
                                                      fontSize:
                                                          FontSize.fourteen,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: ColorResource
                                                          .color333333,
                                                    ),
                                                    const SizedBox(height: 10),
                                                    CustomText(
                                                      Languages.of(context)!
                                                          .referenceLender,
                                                      fontSize: FontSize.twelve,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      color: ColorResource
                                                          .color666666,
                                                    ),
                                                    const SizedBox(height: 4),
                                                    CustomText(
                                                      bloc
                                                              .caseDetailsAPIValue
                                                              .result
                                                              ?.caseDetails
                                                              ?.repaymentInfo
                                                              ?.refLender ??
                                                          '-',
                                                      fontSize:
                                                          FontSize.fourteen,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: ColorResource
                                                          .color333333,
                                                    ),
                                                    const SizedBox(height: 10),
                                                    CustomText(
                                                      Languages.of(context)!
                                                          .referenceUrl,
                                                      fontSize: FontSize.twelve,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      color: ColorResource
                                                          .color666666,
                                                    ),
                                                    const SizedBox(height: 4),
                                                    CustomText(
                                                      bloc
                                                              .caseDetailsAPIValue
                                                              .result
                                                              ?.caseDetails
                                                              ?.repaymentInfo
                                                              ?.refUrl ??
                                                          '-',
                                                      fontSize:
                                                          FontSize.fourteen,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: ColorResource
                                                          .color333333,
                                                    ),
                                                    // const SizedBox(height: 12),
                                                    // Row(
                                                    //   mainAxisAlignment:
                                                    //       MainAxisAlignment
                                                    //           .spaceBetween,
                                                    //   children: [
                                                    //     Container(
                                                    //       padding: const EdgeInsets
                                                    //               .symmetric(
                                                    //           horizontal: 10,
                                                    //           vertical: 10),
                                                    //       decoration: BoxDecoration(
                                                    //         color: ColorResource
                                                    //             .color23375A,
                                                    //         borderRadius:
                                                    //             BorderRadius.circular(
                                                    //                 10),
                                                    //         border: Border.all(
                                                    //             color: ColorResource
                                                    //                 .colorECECEC,
                                                    //             width: 1.0),
                                                    //       ),
                                                    //       child: Row(
                                                    //         mainAxisSize:
                                                    //             MainAxisSize.min,
                                                    //         children: [
                                                    //           SvgPicture.asset(
                                                    //               ImageResource
                                                    //                   .whatsApp),
                                                    //           const SizedBox(
                                                    //               width: 5),
                                                    //           CustomText(
                                                    //               StringResource
                                                    //                   .sendSms
                                                    //                   .toUpperCase(),
                                                    //               lineHeight: 1.0,
                                                    //               color: ColorResource
                                                    //                   .colorffffff),
                                                    //         ],
                                                    //       ),
                                                    //     ),
                                                    //     const SizedBox(width: 10),
                                                    //     Container(
                                                    //       padding: const EdgeInsets
                                                    //               .symmetric(
                                                    //           horizontal: 10,
                                                    //           vertical: 10),
                                                    //       decoration: BoxDecoration(
                                                    //         color: ColorResource
                                                    //             .color23375A,
                                                    //         borderRadius:
                                                    //             BorderRadius.circular(
                                                    //                 10),
                                                    //         border: Border.all(
                                                    //             color: ColorResource
                                                    //                 .colorECECEC,
                                                    //             width: 1.0),
                                                    //       ),
                                                    //       child: Row(
                                                    //         mainAxisSize:
                                                    //             MainAxisSize.min,
                                                    //         children: [
                                                    //           SvgPicture.asset(
                                                    //               ImageResource
                                                    //                   .whatsApp),
                                                    //           const SizedBox(
                                                    //               width: 5),
                                                    //           CustomText(
                                                    //             StringResource
                                                    //                 .sendWhatsapp
                                                    //                 .toUpperCase(),
                                                    //             lineHeight: 1.0,
                                                    //             color: ColorResource
                                                    //                 .colorffffff,
                                                    //           ),
                                                    //         ],
                                                    //       ),
                                                    //     )
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
                                          bloc.caseDetailsAPIValue.result
                                                  ?.caseDetails?.cust
                                                  ?.toUpperCase() ??
                                              '', //--------------- doubt -----------
                                          color: ColorResource.color333333,
                                          fontSize: FontSize.fourteen,
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.w700,
                                        ),
                                        ListView.builder(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            padding: EdgeInsets.zero,
                                            shrinkWrap: true,
                                            itemCount: bloc
                                                    .caseDetailsAPIValue
                                                    .result
                                                    ?.otherLoanDetails
                                                    ?.length ??
                                                0,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  const SizedBox(height: 10),
                                                  GestureDetector(
                                                    onTap: () => bloc.add(
                                                        ClickPushAndPOPCaseDetailsEvent(
                                                            paramValues: {
                                                          'caseID': bloc
                                                              .caseDetailsAPIValue
                                                              .result
                                                              ?.otherLoanDetails![
                                                                  index]
                                                              .caseId,
                                                          'isAddress': true
                                                        })),
                                                    child: Container(
                                                      width: double.infinity,
                                                      decoration: BoxDecoration(
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: ColorResource
                                                                  .color000000
                                                                  .withOpacity(
                                                                      .25),
                                                              blurRadius: 2.0,
                                                              offset:
                                                                  const Offset(
                                                                      1.0, 1.0),
                                                            ),
                                                          ],
                                                          border: Border.all(
                                                              color: ColorResource
                                                                  .colorDADADA,
                                                              width: 0.5),
                                                          color: ColorResource
                                                              .colorF7F8FA,
                                                          borderRadius:
                                                              const BorderRadius
                                                                      .all(
                                                                  Radius.circular(
                                                                      10.0))),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 20,
                                                                vertical: 12),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            CustomText(
                                                              Languages.of(
                                                                      context)!
                                                                  .accountNo,
                                                              color: ColorResource
                                                                  .color666666,
                                                              fontSize: FontSize
                                                                  .twelve,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .normal,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            ),
                                                            const SizedBox(
                                                                height: 5),
                                                            CustomText(
                                                              bloc
                                                                      .caseDetailsAPIValue
                                                                      .result
                                                                      ?.otherLoanDetails![
                                                                          index]
                                                                      .cust!
                                                                      .toUpperCase() ??
                                                                  '_', // ----------- doubt ---------------
                                                              color: ColorResource
                                                                  .color333333,
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
                                                                height: 11),
                                                            CustomText(
                                                              Languages.of(
                                                                      context)!
                                                                  .overdueAmount,
                                                              color: ColorResource
                                                                  .color666666,
                                                              fontSize: FontSize
                                                                  .twelve,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .normal,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            ),
                                                            const SizedBox(
                                                                height: 5),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                CustomText(
                                                                  bloc
                                                                          .caseDetailsAPIValue
                                                                          .result
                                                                          ?.otherLoanDetails![
                                                                              index]
                                                                          .due
                                                                          .toString() ??
                                                                      '_',
                                                                  color: ColorResource
                                                                      .color333333,
                                                                  fontSize: FontSize
                                                                      .fourteen,
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .normal,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    CustomText(
                                                                      Languages.of(
                                                                              context)!
                                                                          .view,
                                                                      color: ColorResource
                                                                          .color23375A,
                                                                      fontSize:
                                                                          FontSize
                                                                              .fourteen,
                                                                      fontStyle:
                                                                          FontStyle
                                                                              .normal,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700,
                                                                    ),
                                                                    const SizedBox(
                                                                        width:
                                                                            10),
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
                bottomNavigationBar: bloc.isNoInternetAndServerError
                    ? const SizedBox()
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: double.infinity,
                            decoration: const BoxDecoration(
                                color: ColorResource.colorFFFFFF,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(28.0),
                                    topRight: Radius.circular(28.0))),
                            child: Padding(
                              padding: const EdgeInsets.all(21.0),
                              child: Align(
                                alignment: Alignment.center,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    bloc.userType == 'FIELDAGENT'
                                        ? GestureDetector(
                                            onTap: () => bloc.add(
                                                ClickOpenBottomSheetEvent(
                                                    Constants.addressDetails,
                                                    const [],
                                                    false)),
                                            child: Container(
                                              height: 50,
                                              width: (MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      62) /
                                                  2,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: ColorResource
                                                          .color23375A,
                                                      width: 0.5),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(
                                                              10.0))),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10.0,
                                                        vertical: 5.0),
                                                child: Row(
                                                  children: [
                                                    Image.asset(ImageResource
                                                        .direction),
                                                    const SizedBox(width: 8),
                                                    Expanded(
                                                        child: CustomText(
                                                      Languages.of(context)!
                                                          .addressDetails
                                                          .toString()
                                                          .toUpperCase()
                                                          .replaceAll(
                                                              ' ', '\n'),
                                                      fontSize: FontSize.twelve,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      color: ColorResource
                                                          .color23375A,
                                                    ))
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )
                                        : const SizedBox(),
                                    SizedBox(
                                        width: bloc.userType == 'FIELDAGENT'
                                            ? 20
                                            : 0),
                                    GestureDetector(
                                      onTap: () => bloc.add(
                                          ClickOpenBottomSheetEvent(
                                              Constants.callDetails,
                                              const [],
                                              false)),
                                      child: Container(
                                        height: 50,
                                        width:
                                            (MediaQuery.of(context).size.width -
                                                    62) /
                                                2,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color:
                                                    ColorResource.color23375A,
                                                width: 0.5),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(10.0))),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10.0, vertical: 5.0),
                                          child: Row(
                                            children: [
                                              Image.asset(ImageResource.phone),
                                              const SizedBox(width: 8),
                                              Expanded(
                                                  child: CustomText(
                                                Languages.of(context)!
                                                    .callDetails
                                                    .toUpperCase()
                                                    .toString()
                                                    .replaceAll(' ', ' \n'),
                                                fontSize: FontSize.twelve,
                                                fontWeight: FontWeight.w700,
                                                fontStyle: FontStyle.normal,
                                                color:
                                                    ColorResource.color23375A,
                                              ))
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
              );
            }
          },
        ),
      ),
    );
  }

  void phoneBottomSheet(
      BuildContext buildContext, CaseDetailsBloc bloc, int i) {
    showCupertinoModalPopup(
        context: buildContext,
        builder: (BuildContext context) {
          return PhoneScreen(bloc: bloc, index: i);
          // return SizedBox(
          //     height: MediaQuery.of(context).size.height * 0.89,
          //     child: PhoneScreen(bloc: bloc));
        });
  }

  void addressBottomSheet(
      BuildContext buildContext, CaseDetailsBloc bloc, int i) {
    showCupertinoModalPopup(
        context: buildContext,
        builder: (BuildContext context) {
          return SizedBox(
              height: MediaQuery.of(context).size.height * 0.89,
              child: AddressScreen(bloc: bloc, index: i));
        });
  }

  openBottomSheet(
      BuildContext buildContext, String cardTitle, List list, bool? isCall,
      {String? health}) {
    showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
      context: buildContext,
      backgroundColor: ColorResource.colorFFFFFF,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (BuildContext context) {
        switch (cardTitle) {
          case Constants.ptp:
            return CustomPtpBottomSheet(
              Languages.of(context)!.ptp,
              caseId: bloc.caseId.toString(),
              customerLoanUserWidget: CustomLoanUserDetails(
                userName:
                    bloc.caseDetailsAPIValue.result?.caseDetails?.cust ?? '',
                userId:
                    bloc.caseDetailsAPIValue.result?.caseDetails?.caseId ?? '',
                userAmount: bloc.caseDetailsAPIValue.result?.caseDetails?.due
                        ?.toDouble() ??
                    0.0,
              ),
              userType: bloc.userType.toString(),
              postValue: list[bloc.indexValue!],
              isCall: isCall,
            );
          case Constants.rtp:
            return CustomRtpBottomSheet(
              Languages.of(context)!.rtp,
              caseId: bloc.caseId.toString(),
              customerLoanUserWidget: CustomLoanUserDetails(
                userName:
                    bloc.caseDetailsAPIValue.result?.caseDetails?.cust ?? '',
                userId:
                    bloc.caseDetailsAPIValue.result?.caseDetails?.caseId ?? '',
                userAmount: bloc.caseDetailsAPIValue.result?.caseDetails?.due
                        ?.toDouble() ??
                    0.0,
              ),
              userType: bloc.userType.toString(),
              postValue: list[bloc.indexValue!],
              isCall: isCall,
            );
          case Constants.dispute:
            return CustomDisputeBottomSheet(
              Languages.of(context)!.dispute,
              caseId: bloc.caseId.toString(),
              customerLoanUserWidget: CustomLoanUserDetails(
                userName:
                    bloc.caseDetailsAPIValue.result?.caseDetails?.cust ?? '',
                userId:
                    bloc.caseDetailsAPIValue.result?.caseDetails?.caseId ?? '',
                userAmount: bloc.caseDetailsAPIValue.result?.caseDetails?.due
                        ?.toDouble() ??
                    0.0,
              ),
              userType: bloc.userType.toString(),
              postValue: list[bloc.indexValue!],
              isCall: isCall,
            );
          case Constants.remainder:
            return CustomRemainderBottomSheet(
              Languages.of(context)!.remainderCb,
              caseId: bloc.caseId.toString(),
              customerLoanUserWidget: CustomLoanUserDetails(
                userName:
                    bloc.caseDetailsAPIValue.result?.caseDetails?.cust ?? '',
                userId:
                    bloc.caseDetailsAPIValue.result?.caseDetails?.caseId ?? '',
                userAmount: bloc.caseDetailsAPIValue.result?.caseDetails?.due
                        ?.toDouble() ??
                    0.0,
              ),
              userType: bloc.userType.toString(),
              postValue: list[bloc.indexValue!],

              isCall: isCall,
              // eventCode: bloc.eventCode,
            );
          case Constants.collections:
            return CustomCollectionsBottomSheet(
              Languages.of(context)!.collections,
              caseId: bloc.caseId.toString(),
              customerLoanUserWidget: CustomLoanUserDetails(
                userName:
                    bloc.caseDetailsAPIValue.result?.caseDetails?.cust ?? '',
                userId:
                    bloc.caseDetailsAPIValue.result?.caseDetails?.caseId ?? '',
                userAmount: bloc.caseDetailsAPIValue.result?.caseDetails?.due
                        ?.toDouble() ??
                    0.0,
              ),
              isCall: isCall,
              // eventCode: bloc.eventCode,
              userType: bloc.userType.toString(),
              postValue: list[bloc.indexValue!],
            );
          case Constants.ots:
            return CustomOtsBottomSheet(
              Languages.of(context)!.ots,
              customerLoanUserWidget: CustomLoanUserDetails(
                userName:
                    bloc.caseDetailsAPIValue.result?.caseDetails?.cust ?? '',
                userId:
                    bloc.caseDetailsAPIValue.result?.caseDetails?.caseId ?? '',
                userAmount: bloc.caseDetailsAPIValue.result?.caseDetails?.due
                        ?.toDouble() ??
                    0.0,
              ),
              caseId: bloc.caseId.toString(),
              userType: bloc.userType.toString(),
              isCall: isCall,
              postValue: list[bloc.indexValue!],
            );
          case Constants.repo:
            return CustomRepoBottomSheet(
              Languages.of(context)!.repo,
              caseId: bloc.caseId.toString(),
              customerLoanUserWidget: CustomLoanUserDetails(
                userName:
                    bloc.caseDetailsAPIValue.result?.caseDetails?.cust ?? '',
                userId:
                    bloc.caseDetailsAPIValue.result?.caseDetails?.caseId ?? '',
                userAmount: bloc.caseDetailsAPIValue.result?.caseDetails?.due
                        ?.toDouble() ??
                    0.0,
              ),
              userType: bloc.userType.toString(),
              postValue: list[bloc.indexValue!],
            );
          case Constants.captureImage:
            return CustomCaptureImageBottomSheet(
              Languages.of(context)!.captureImage,
              customerLoanUserDetailsWidget: CustomLoanUserDetails(
                userName:
                    bloc.caseDetailsAPIValue.result?.caseDetails?.cust ?? '',
                userId:
                    bloc.caseDetailsAPIValue.result?.caseDetails?.caseId ?? '',
                userAmount: bloc.caseDetailsAPIValue.result?.caseDetails?.due
                        ?.toDouble() ??
                    0.0,
              ),
              bloc: bloc,
            );
          case Constants.otherFeedback:
            return CustomOtherFeedBackBottomSheet(
              Languages.of(context)!.otherFeedBack,
              bloc,
              caseId: bloc.caseId.toString(),
              customerLoanUserWidget: CustomLoanUserDetails(
                userName:
                    bloc.caseDetailsAPIValue.result?.caseDetails?.cust ?? '',
                userId:
                    bloc.caseDetailsAPIValue.result?.caseDetails?.caseId ?? '',
                userAmount: bloc.caseDetailsAPIValue.result?.caseDetails?.due
                        ?.toDouble() ??
                    0.0,
              ),
              health: health ?? '2',
              userType: bloc.userType.toString(),
              postValue: list[bloc.indexValue!],
              isCall: isCall,
            );
          case Constants.eventDetails:
            return CustomEventDetailsBottomSheet(
              Languages.of(context)!.eventDetails,
              bloc,
              customeLoanUserWidget: CustomLoanUserDetails(
                userName:
                    bloc.caseDetailsAPIValue.result?.caseDetails?.cust ?? '',
                userId:
                    bloc.caseDetailsAPIValue.result?.caseDetails?.caseId ?? '',
                userAmount: bloc.caseDetailsAPIValue.result?.caseDetails?.due
                        ?.toDouble() ??
                    0.0,
              ),
            );
          case Constants.addressDetails:
            return AddressDetailsBottomSheetScreen(bloc: bloc);
          case Constants.callDetails:
            return CallDetailsBottomSheetScreen(bloc: bloc);
          case Constants.callCustomer:
            List<dynamic> l1 = [];
            bloc.caseDetailsAPIValue.result?.callDetails?.forEach((element) {
              if (element['cType'] == 'mobile') {
                l1.add(element);
              }
            });

            return CallCustomerBottomSheet(
              customerLoanUserWidget: CustomLoanUserDetails(
                userName:
                    bloc.caseDetailsAPIValue.result?.caseDetails?.cust ?? '',
                userId:
                    bloc.caseDetailsAPIValue.result?.caseDetails?.caseId ?? '',
                userAmount: bloc.caseDetailsAPIValue.result?.caseDetails?.due
                        ?.toDouble() ??
                    0.0,
              ),
              listOfMobileNo: l1,
              userType: bloc.userType.toString(),
              caseId: bloc.caseId.toString(),
              sid: bloc.caseDetailsAPIValue.result!.caseDetails!.id.toString(),
            );
          case Constants.addNewContact:
            return AddNewContactBottomSheet(
              customerLoanUserWidget: CustomLoanUserDetails(
                userName:
                    bloc.caseDetailsAPIValue.result?.caseDetails?.cust ?? '',
                userId:
                    bloc.caseDetailsAPIValue.result?.caseDetails?.caseId ?? '',
                userAmount: bloc.caseDetailsAPIValue.result?.caseDetails?.due
                        ?.toDouble() ??
                    0.0,
              ),
            );
          case Constants.viewMap:
            return MapViewBottomSheetScreen(
                title: Languages.of(context)!.viewMap,
                agentLocation:
                    bloc.caseDetailsAPIValue.result?.caseDetails?.pincode);
          default:
            return SizedBox(
                height: MediaQuery.of(context).size.height * 0.89,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    BottomSheetAppbar(
                        title: '', padding: EdgeInsets.fromLTRB(23, 16, 15, 5)),
                    Expanded(child: Center(child: CircularProgressIndicator())),
                  ],
                ));
        }
      },
    );
  }
}
