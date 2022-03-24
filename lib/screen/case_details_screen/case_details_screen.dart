import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/models/case_details_navigation_model.dart';
import 'package:origa/router.dart';
import 'package:origa/screen/add_address_screen/add_address_screen.dart';
import 'package:origa/screen/allocation/bloc/allocation_bloc.dart';
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
import 'package:origa/screen/other_feed_back_screen/other_feed_back_bottom_sheet.dart';
import 'package:origa/screen/ots_screen/ots_bottom_sheet.dart';
import 'package:origa/screen/ptp_screen/ptp_bottom_sheet.dart';
import 'package:origa/screen/remainder_screen/remainder_bottom_sheet.dart';
import 'package:origa/screen/repo_screen/repo_bottom_sheet.dart';
import 'package:origa/screen/rtp_screen/rtp_bottom_sheet.dart';
import 'package:origa/singleton.dart';
import 'package:origa/utils/app_utils.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/constant_event_values.dart';
import 'package:origa/utils/constants.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/widgets/bottomsheet_appbar.dart';
import 'package:origa/widgets/custom_appbar.dart';
import 'package:origa/widgets/custom_button.dart';
import 'package:origa/widgets/custom_loading_widget.dart';
import 'package:origa/widgets/custom_loan_user_details.dart';
import 'package:origa/widgets/custom_read_only_text_field.dart';
import 'package:origa/widgets/custom_text.dart';

import '../../widgets/case_status_widget.dart';
import '../../widgets/custom_dialog.dart';

class CaseDetailsScreen extends StatefulWidget {
  final dynamic paramValues;
  final AllocationBloc allocationBloc;

  const CaseDetailsScreen(
      {Key? key, this.paramValues, required this.allocationBloc})
      : super(key: key);

  @override
  _CaseDetailsScreenState createState() => _CaseDetailsScreenState();
}

class _CaseDetailsScreenState extends State<CaseDetailsScreen> {
  late CaseDetailsBloc bloc;
  late StreamSubscription subscription;

  @override
  void initState() {
    super.initState();
    bloc = CaseDetailsBloc(widget.allocationBloc)
      ..add(CaseDetailsInitialEvent(
          paramValues: widget.paramValues, context: context));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(
          context,
          {
            'isSubmit': bloc.isEventSubmited,
            'caseId': bloc.caseId!,
            'isSubmitForMyVisit': bloc.isSubmitedForMyVisits,
            'eventType': bloc.submitedEventType,
            'returnCaseAmount':
                bloc.caseDetailsAPIValue.result?.caseDetails?.due,
            'returnCollectionAmount': bloc.collectionAmount,
            'selectedClipValue': (Singleton.instance.usertype ==
                    Constants.telecaller)
                ? bloc.caseDetailsAPIValue.result?.caseDetails?.telSubStatus
                : bloc.caseDetailsAPIValue.result?.caseDetails?.collSubStatus,
            'followUpDate': bloc.changeFollowUpDate,
          },
        );
        return Future(() => false);
      },
      child: Scaffold(
        backgroundColor: ColorResource.colorF7F8FA,
        body: BlocListener<CaseDetailsBloc, CaseDetailsState>(
          bloc: bloc,
          listener: (context, state) {
            if (state is PostDataApiSuccessState) {
              AppUtils.topSnackBar(context, Constants.eventUpdatedSuccess);
            }
            if (state is CaseDetailsLoadedState) {
              setState(() {});
            }
            if (state is UpdateSuccessfullState) {
              setState(() {});
            }
            if (state is ClickMainAddressBottomSheetState) {
              addressBottomSheet(context, bloc, state.i);
            }
            if (state is ClickMainCallBottomSheetState) {
              debugPrint('$this ---> index in CaseDetailsScreen ${state.i} ');
              phoneBottomSheet(
                context,
                bloc,
                state.i,
                state.isCallFromCaseDetails,
                callId: state.callId,
              );
            }
            if (state is ClickOpenBottomSheetState) {
              openBottomSheet(
                context,
                state.title,
                state.list,
                state.isCall,
                health: state.health,
                selectedContact: state.selectedContactNumber,
                isCallFromCallDetails: state.isCallFromCallDetails,
                callId: state.callId,
              );
            }
            if (state is CDNoInternetState) {
              AppUtils.noInternetSnackbar(context);
            }
            if (state is CallCaseDetailsState) {
              Navigator.pushNamed(context, AppRoutes.caseDetailsScreen,
                  arguments: CaseDetailsNaviagationModel(
                    state.paramValues,
                    allocationBloc: widget.allocationBloc,
                  ));
            }
            if (state is PushAndPOPNavigationCaseDetailsState) {
              Navigator.pushReplacementNamed(
                  context, AppRoutes.caseDetailsScreen,
                  arguments: CaseDetailsNaviagationModel(
                    state.paramValues,
                    allocationBloc: widget.allocationBloc,
                  ));
            }

            if (state is SendSMSloadState) {
              bloc.isSendSMSloading = !bloc.isSendSMSloading;
              // Navigator.pop(context);
            }

            if (state is UpdateRefUrlState) {
              bloc.isGeneratePaymentLinkLoading = false;
              bloc.caseDetailsAPIValue.result?.caseDetails?.repaymentInfo
                  ?.refUrl = state.refUrl;
            }
          },
          child: BlocBuilder<CaseDetailsBloc, CaseDetailsState>(
            bloc: bloc,
            builder: (context, state) {
              if (state is CaseDetailsLoadingState) {
                return const CustomLoadingWidget();
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
                              Navigator.pop(
                                context,
                                {
                                  'isSubmit': bloc.isEventSubmited,
                                  'caseId': bloc.caseId!,
                                  'isSubmitForMyVisit':
                                      bloc.isSubmitedForMyVisits,
                                  'eventType': bloc.submitedEventType,
                                  'returnCaseAmount': bloc.caseDetailsAPIValue
                                      .result?.caseDetails?.due,
                                  'returnCollectionAmount':
                                      bloc.collectionAmount,
                                  'selectedClipValue':
                                      (Singleton.instance.usertype ==
                                              Constants.telecaller)
                                          ? bloc.caseDetailsAPIValue.result
                                              ?.caseDetails?.telSubStatus
                                          : bloc.caseDetailsAPIValue.result
                                              ?.caseDetails?.collSubStatus,
                                  'followUpDate': bloc.changeFollowUpDate,
                                },
                              );
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
                                    CustomText(
                                        bloc.noInternetAndServerErrorMsg!),
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
                                                alignment:
                                                    Alignment.bottomCenter,
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
                                              // Here check userType base on show case status
                                              if (Singleton.instance.usertype ==
                                                  Constants.fieldagent)
                                                bloc
                                                            .caseDetailsAPIValue
                                                            .result
                                                            ?.caseDetails
                                                            ?.collSubStatus ==
                                                        'new'
                                                    ? Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 10),
                                                        child: CaseStatusWidget
                                                            .satusTextWidget(
                                                          context,
                                                          text: Languages.of(
                                                                  context)!
                                                              .new_,
                                                          width: 55,
                                                        ),
                                                      )
                                                    : Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 10),
                                                        child: caseStatusWidget(
                                                            text: bloc
                                                                .caseDetailsAPIValue
                                                                .result
                                                                ?.caseDetails
                                                                ?.collSubStatus),
                                                      ),

                                              if (Singleton.instance.usertype ==
                                                  Constants.telecaller)
                                                bloc
                                                            .caseDetailsAPIValue
                                                            .result
                                                            ?.caseDetails
                                                            ?.telSubStatus ==
                                                        'new'
                                                    ? Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 10),
                                                        child: CaseStatusWidget
                                                            .satusTextWidget(
                                                          context,
                                                          text: Languages.of(
                                                                  context)!
                                                              .new_,
                                                          width: 55,
                                                        ),
                                                      )
                                                    : Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 10),
                                                        child: caseStatusWidget(
                                                            text: bloc
                                                                .caseDetailsAPIValue
                                                                .result
                                                                ?.caseDetails
                                                                ?.telSubStatus),
                                                      ),
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
                                                  child:
                                                      CustomReadOnlyTextField(
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
                                                  child:
                                                      CustomReadOnlyTextField(
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
                                            Languages.of(context)!
                                                .repaymentInfo,
                                            fontSize: FontSize.sixteen,
                                            fontWeight: FontWeight.w700,
                                            fontStyle: FontStyle.normal,
                                          ),
                                          const SizedBox(height: 5),
                                          Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                                color:
                                                    ColorResource.colorFFFFFF,
                                                border: Border.all(
                                                    color: ColorResource
                                                        .colorDADADA,
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
                                                        const SizedBox(
                                                            height: 9),
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
                                                        const SizedBox(
                                                            height: 7),
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
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 20.0,
                                                      vertical: 12.0),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      CustomText(
                                                        Languages.of(context)!
                                                            .repaymentBankName,
                                                        fontSize:
                                                            FontSize.twelve,
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
                                                      const SizedBox(
                                                          height: 10),
                                                      CustomText(
                                                        Languages.of(context)!
                                                            .referenceLender,
                                                        fontSize:
                                                            FontSize.twelve,
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
                                                      const SizedBox(
                                                          height: 10),
                                                      CustomText(
                                                        Languages.of(context)!
                                                            .referenceUrl,
                                                        fontSize:
                                                            FontSize.twelve,
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
                                                      const SizedBox(
                                                          height: 15),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Singleton
                                                                      .instance
                                                                      .contractorInformations
                                                                      ?.result
                                                                      ?.hideSendRepaymentInfo ??
                                                                  false
                                                              ? const SizedBox()
                                                              : bloc.isSendSMSloading
                                                                  ? Container(
                                                                      margin: const EdgeInsets
                                                                              .only(
                                                                          left:
                                                                              50),
                                                                      height:
                                                                          37,
                                                                      width: 37,
                                                                      decoration: BoxDecoration(
                                                                          color: ColorResource
                                                                              .color23375A,
                                                                          borderRadius:
                                                                              BorderRadius.circular(25)),
                                                                      child:
                                                                          const CustomLoadingWidget(
                                                                        radius:
                                                                            11,
                                                                        strokeWidth:
                                                                            2,
                                                                      ),
                                                                    )
                                                                  : GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        if (!bloc
                                                                            .isSendSMSloading) {
                                                                          bloc.add(SendSMSEvent(
                                                                              context,
                                                                              type: Constants.repaymentInfoType));
                                                                        }
                                                                        // DialogUtils.showDialog(
                                                                        //     buildContext: context,
                                                                        //     title: Languages.of(context)!.reciptsAlertMesg,
                                                                        //     description: '',
                                                                        //     okBtnText: Languages.of(context)!.submit.toUpperCase(),
                                                                        //     cancelBtnText: Languages.of(context)!.cancel.toUpperCase(),
                                                                        //     okBtnFunction: (val) async {
                                                                        //       //  bloc
                                                                        //       //     .isSendSMSloading
                                                                        //       // ? const CustomLoadingWidget(
                                                                        //       //     radius:
                                                                        //       //         12,
                                                                        //       //     strokeWidth:
                                                                        //       //         2,
                                                                        //       //   )
                                                                        //       // :
                                                                        //       if (!bloc
                                                                        //           .isSendSMSloading) {
                                                                        //         bloc.add(SendSMSEvent(context,
                                                                        //             type: Constants.repaymentInfoType));
                                                                        //       }
                                                                        //     });
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        padding: const EdgeInsets.symmetric(
                                                                            horizontal:
                                                                                15,
                                                                            vertical:
                                                                                11.2),
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              ColorResource.color23375A,
                                                                          borderRadius:
                                                                              BorderRadius.circular(8),
                                                                          border: Border.all(
                                                                              color: ColorResource.colorECECEC,
                                                                              width: 1.0),
                                                                        ),
                                                                        child:
                                                                            Row(
                                                                          mainAxisSize:
                                                                              MainAxisSize.min,
                                                                          children: [
                                                                            SvgPicture.asset(ImageResource.sms),
                                                                            const SizedBox(width: 7),
                                                                            CustomText(Languages.of(context)!.sendSMS,
                                                                                fontSize: FontSize.twelve,
                                                                                fontWeight: FontWeight.w700,
                                                                                lineHeight: 1.0,
                                                                                color: ColorResource.colorffffff),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                          const SizedBox(
                                                              width: 10),
                                                          bloc.isGeneratePaymentLink
                                                              ? bloc.isGeneratePaymentLinkLoading
                                                                  ? Container(
                                                                      margin: const EdgeInsets
                                                                              .only(
                                                                          right:
                                                                              50),
                                                                      height:
                                                                          37,
                                                                      width: 37,
                                                                      decoration: BoxDecoration(
                                                                          color: ColorResource
                                                                              .color23375A,
                                                                          borderRadius:
                                                                              BorderRadius.circular(25)),
                                                                      child:
                                                                          const CustomLoadingWidget(
                                                                        radius:
                                                                            11,
                                                                        strokeWidth:
                                                                            2,
                                                                      ),
                                                                    )
                                                                  : Flexible(
                                                                      child:
                                                                          GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          setState(
                                                                              () {
                                                                            bloc.isGeneratePaymentLinkLoading =
                                                                                true;
                                                                          });
                                                                          bloc.add(
                                                                              GeneratePaymenLinktEvent(caseID: bloc.caseDetailsAPIValue.result!.caseDetails!.caseId!));
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          padding: const EdgeInsets.symmetric(
                                                                              horizontal: 15,
                                                                              vertical: 13),
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                ColorResource.color23375A,
                                                                            borderRadius:
                                                                                BorderRadius.circular(8),
                                                                            border:
                                                                                Border.all(color: ColorResource.colorECECEC, width: 1.0),
                                                                          ),
                                                                          child: CustomText(
                                                                              Languages.of(context)!.generatePaymentLink,
                                                                              fontSize: FontSize.twelve,
                                                                              fontWeight: FontWeight.w700,
                                                                              lineHeight: 1.0,
                                                                              color: ColorResource.colorffffff),
                                                                        ),
                                                                      ),
                                                                    )
                                                              : const SizedBox(),
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
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
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
                                                                        1.0,
                                                                        1.0),
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
                                                                  horizontal:
                                                                      20,
                                                                  vertical: 12),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
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
                                                                fontSize:
                                                                    FontSize
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
                                                                            .cust !=
                                                                        null
                                                                    ? bloc
                                                                        .caseDetailsAPIValue
                                                                        .result!
                                                                        .otherLoanDetails![
                                                                            index]
                                                                        .cust!
                                                                        .toUpperCase()
                                                                    : '_',
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
                                                                fontSize:
                                                                    FontSize
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
                                                                            ?.otherLoanDetails![index]
                                                                            .due
                                                                            .toString() ??
                                                                        '_',
                                                                    color: ColorResource
                                                                        .color333333,
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
                                                                  Row(
                                                                    children: [
                                                                      CustomText(
                                                                        Languages.of(context)!
                                                                            .view,
                                                                        color: ColorResource
                                                                            .color23375A,
                                                                        fontSize:
                                                                            FontSize.fourteen,
                                                                        fontStyle:
                                                                            FontStyle.normal,
                                                                        fontWeight:
                                                                            FontWeight.w700,
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
                                                    const SizedBox(height: 5),
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
                                                  EventDetailsEvent(
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
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10.0,
                                                      vertical: 5.0),
                                                  child: Row(
                                                    children: [
                                                      CircleAvatar(
                                                        backgroundColor:
                                                            ColorResource
                                                                .color23375A,
                                                        radius: 20,
                                                        child: Center(
                                                          child:
                                                              SvgPicture.asset(
                                                            ImageResource
                                                                .direction,
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(width: 8),
                                                      Expanded(
                                                          child: CustomText(
                                                        Languages.of(context)!
                                                            .addressDetails
                                                            .toString()
                                                            .toUpperCase()
                                                            .replaceAll(
                                                                ' ', '\n'),
                                                        fontSize:
                                                            FontSize.twelve,
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
                                            EventDetailsEvent(
                                                Constants.callDetails,
                                                const [],
                                                true)),
                                        child: Container(
                                          height: 50,
                                          width: (MediaQuery.of(context)
                                                      .size
                                                      .width -
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
                                                horizontal: 10.0,
                                                vertical: 5.0),
                                            child: Row(
                                              children: [
                                                CircleAvatar(
                                                  backgroundColor:
                                                      ColorResource.color23375A,
                                                  radius: 20,
                                                  child: Center(
                                                    child: SvgPicture.asset(
                                                      ImageResource.phone,
                                                    ),
                                                  ),
                                                ),
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
      ),
    );
  }

  void phoneBottomSheet(BuildContext buildContext, CaseDetailsBloc bloc, int i,
      bool isCallFromCaseDetails,
      {String? callId}) {
    debugPrint('$this ---> index $i ');
    showCupertinoModalPopup(
        context: buildContext,
        builder: (BuildContext context) {
          return PhoneScreen(
              bloc: bloc,
              index: i,
              isCallFromCaseDetails: isCallFromCaseDetails,
              callId: callId);
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
      {String? health,
      String? selectedContact,
      required bool isCallFromCallDetails,
      String? callId}) {
    showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
      context: buildContext,
      backgroundColor: ColorResource.colorFFFFFF,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
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
                    '${bloc.caseDetailsAPIValue.result?.caseDetails?.bankName} / ${bloc.caseDetailsAPIValue.result?.caseDetails?.agrRef}',
                userAmount: bloc.caseDetailsAPIValue.result?.caseDetails?.due
                        ?.toDouble() ??
                    0.0,
              ),
              userType: bloc.userType.toString(),
              postValue: list[bloc.indexValue!],
              isCall: isCall,
              bloc: bloc,
              isCallFromCaseDetails: isCallFromCallDetails,
              callId: callId,
            );
          case Constants.rtp:
            return CustomRtpBottomSheet(
              Languages.of(context)!.rtp,
              caseId: bloc.caseId.toString(),
              customerLoanUserWidget: CustomLoanUserDetails(
                userName:
                    bloc.caseDetailsAPIValue.result?.caseDetails?.cust ?? '',
                userId:
                    '${bloc.caseDetailsAPIValue.result?.caseDetails?.bankName} / ${bloc.caseDetailsAPIValue.result?.caseDetails?.agrRef}',
                userAmount: bloc.caseDetailsAPIValue.result?.caseDetails?.due
                        ?.toDouble() ??
                    0.0,
              ),
              userType: bloc.userType.toString(),
              postValue: list[bloc.indexValue!],
              isCall: isCall,
              bloc: bloc,
              isCallFromCaseDetails: isCallFromCallDetails,
              callId: callId,
            );
          case Constants.dispute:
            return CustomDisputeBottomSheet(
              Languages.of(context)!.dispute,
              caseId: bloc.caseId.toString(),
              customerLoanUserWidget: CustomLoanUserDetails(
                userName:
                    bloc.caseDetailsAPIValue.result?.caseDetails?.cust ?? '',
                userId:
                    '${bloc.caseDetailsAPIValue.result?.caseDetails?.bankName} / ${bloc.caseDetailsAPIValue.result?.caseDetails?.agrRef}',
                userAmount: bloc.caseDetailsAPIValue.result?.caseDetails?.due
                        ?.toDouble() ??
                    0.0,
              ),
              userType: bloc.userType.toString(),
              postValue: list[bloc.indexValue!],
              isCall: isCall,
              bloc: bloc,
              isCallFromCaseDetails: isCallFromCallDetails,
              callId: callId,
            );
          case Constants.remainder:
            return CustomRemainderBottomSheet(
              Languages.of(context)!.remainderCb,
              caseId: bloc.caseId.toString(),
              customerLoanUserWidget: CustomLoanUserDetails(
                userName:
                    bloc.caseDetailsAPIValue.result?.caseDetails?.cust ?? '',
                userId:
                    '${bloc.caseDetailsAPIValue.result?.caseDetails?.bankName} / ${bloc.caseDetailsAPIValue.result?.caseDetails?.agrRef}',
                userAmount: bloc.caseDetailsAPIValue.result?.caseDetails?.due
                        ?.toDouble() ??
                    0.0,
              ),
              userType: bloc.userType.toString(),
              postValue: list[bloc.indexValue!],
              isCall: isCall,
              bloc: bloc,
              isCallFromCaseDetails: isCallFromCallDetails,
              callId: callId,
            );
          case Constants.collections:
            return CustomCollectionsBottomSheet(
              Languages.of(context)!.collections,
              caseId: bloc.caseId.toString(),
              customerLoanUserWidget: CustomLoanUserDetails(
                userName:
                    bloc.caseDetailsAPIValue.result?.caseDetails?.cust ?? '',
                userId:
                    '${bloc.caseDetailsAPIValue.result?.caseDetails?.bankName} / ${bloc.caseDetailsAPIValue.result?.caseDetails?.agrRef}',
                userAmount: bloc.caseDetailsAPIValue.result?.caseDetails?.due
                        ?.toDouble() ??
                    0.0,
              ),
              isCall: isCall,
              userType: bloc.userType.toString(),
              postValue: list[bloc.indexValue!],
              bloc: bloc,
              custName:
                  bloc.caseDetailsAPIValue.result?.caseDetails?.cust ?? '',
              isCallFromCaseDetails: isCallFromCallDetails,
              callId: callId,
            );
          case Constants.ots:
            return CustomOtsBottomSheet(
              Languages.of(context)!.ots,
              customerLoanUserWidget: CustomLoanUserDetails(
                userName:
                    bloc.caseDetailsAPIValue.result?.caseDetails?.cust ?? '',
                userId:
                    '${bloc.caseDetailsAPIValue.result?.caseDetails?.bankName} / ${bloc.caseDetailsAPIValue.result?.caseDetails?.agrRef}',
                userAmount: bloc.caseDetailsAPIValue.result?.caseDetails?.due
                        ?.toDouble() ??
                    0.0,
              ),
              caseId: bloc.caseId.toString(),
              userType: bloc.userType.toString(),
              isCall: isCall,
              postValue: list[bloc.indexValue!],
              bloc: bloc,
              isCallFromCaseDetails: isCallFromCallDetails,
              callId: callId,
            );
          case Constants.repo:
            return CustomRepoBottomSheet(
              Languages.of(context)!.repo,
              caseId: bloc.caseId.toString(),
              customerLoanUserWidget: CustomLoanUserDetails(
                userName:
                    bloc.caseDetailsAPIValue.result?.caseDetails?.cust ?? '',
                userId:
                    '${bloc.caseDetailsAPIValue.result?.caseDetails?.bankName} / ${bloc.caseDetailsAPIValue.result?.caseDetails?.agrRef}',
                userAmount: bloc.caseDetailsAPIValue.result?.caseDetails?.due
                        ?.toDouble() ??
                    0.0,
              ),
              userType: bloc.userType.toString(),
              postValue: list[bloc.indexValue!],
              health: health ?? ConstantEventValues.healthTwo,
              bloc: bloc,
            );
          case Constants.captureImage:
            return CustomCaptureImageBottomSheet(
              Languages.of(context)!.captureImage,
              customerLoanUserDetailsWidget: CustomLoanUserDetails(
                userName:
                    bloc.caseDetailsAPIValue.result?.caseDetails?.cust ?? '',
                userId:
                    '${bloc.caseDetailsAPIValue.result?.caseDetails?.bankName} / ${bloc.caseDetailsAPIValue.result?.caseDetails?.agrRef}',
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
                    '${bloc.caseDetailsAPIValue.result?.caseDetails?.bankName} / ${bloc.caseDetailsAPIValue.result?.caseDetails?.agrRef}',
                userAmount: bloc.caseDetailsAPIValue.result?.caseDetails?.due
                        ?.toDouble() ??
                    0.0,
              ),
              userType: bloc.userType.toString(),
              postValue: list[bloc.indexValue!],
              isCall: isCall,
              health: health ?? ConstantEventValues.healthTwo,
              isCallFromCaseDetails: isCallFromCallDetails,
              callId: callId,
            );
          case Constants.eventDetails:
            return CustomEventDetailsBottomSheet(
              Languages.of(context)!.eventDetails,
              bloc,
              customeLoanUserWidget: CustomLoanUserDetails(
                userName:
                    bloc.caseDetailsAPIValue.result?.caseDetails?.cust ?? '',
                userId:
                    '${bloc.caseDetailsAPIValue.result?.caseDetails?.bankName} / ${bloc.caseDetailsAPIValue.result?.caseDetails?.agrRef}',
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
            List<String> s1 = [];
            bloc.caseDetailsAPIValue.result?.callDetails?.forEach((element) {
              if (element['cType'].contains('mobile')) {
                if (!(s1.contains(element['value']))) {
                  s1.add(element['value']);
                }
              } else {}
            });
            debugPrint('Index values--> ${bloc.indexValue}');
            return CallCustomerBottomSheet(
              caseDetailsAPIValue: bloc.caseDetailsAPIValue,
              customerLoanUserWidget: CustomLoanUserDetails(
                userName:
                    bloc.caseDetailsAPIValue.result?.caseDetails?.cust ?? '',
                userId:
                    '${bloc.caseDetailsAPIValue.result?.caseDetails?.bankName} / ${bloc.caseDetailsAPIValue.result?.caseDetails?.agrRef}',
                userAmount: bloc.caseDetailsAPIValue.result?.caseDetails?.due
                        ?.toDouble() ??
                    0.0,
              ),
              listOfMobileNo: s1,
              userType: bloc.userType.toString(),
              caseId: bloc.caseId != null
                  ? bloc.caseId!
                  : bloc.caseDetailsAPIValue.result!.caseDetails!.caseId!,
              custName:
                  bloc.caseDetailsAPIValue.result?.caseDetails?.cust ?? "",
              sid: bloc.caseDetailsAPIValue.result!.caseDetails!.id.toString(),
              contactNumber: selectedContact,
              isCallFromCallDetails: isCallFromCallDetails,
              caseDetailsBloc: bloc,
            );
          case Constants.addNewContact:
            return AddNewContactBottomSheet(
              customerLoanUserWidget: CustomLoanUserDetails(
                userName:
                    bloc.caseDetailsAPIValue.result?.caseDetails?.cust ?? '',
                userId:
                    '${bloc.caseDetailsAPIValue.result?.caseDetails?.bankName} / ${bloc.caseDetailsAPIValue.result?.caseDetails?.agrRef}',
                userAmount: bloc.caseDetailsAPIValue.result?.caseDetails?.due
                        ?.toDouble() ??
                    0.0,
              ),
            );
          default:
            return SizedBox(
                height: MediaQuery.of(context).size.height * 0.89,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    BottomSheetAppbar(
                        title: '', padding: EdgeInsets.fromLTRB(23, 16, 15, 5)),
                    Expanded(child: CustomLoadingWidget()),
                  ],
                ));
        }
      },
    );
  }

  Widget caseStatusWidget({String? text}) {
    return text != null
        ? Card(
            elevation: 0,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30.0))),
            color: CaseStatusWidget.getStatusColor(text),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 3.3),
              child: CustomText(
                text,
                color: ColorResource.colorFFFFFF,
                lineHeight: 1,
                fontSize: FontSize.ten,
                fontWeight: FontWeight.w700,
              ),
            ),
          )
        : const SizedBox();
  }
}
