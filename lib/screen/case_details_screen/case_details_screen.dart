import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:origa/http/api_repository.dart';
import 'package:origa/http/httpurls.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/models/allocation_templates/allocation_templates.dart';
import 'package:origa/models/audio_convertion_model.dart';
import 'package:origa/models/case_details_api_model/result.dart';
import 'package:origa/models/case_details_navigation_model.dart';
import 'package:origa/models/event_details_model/result.dart';
import 'package:origa/models/play_audio_model.dart';
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
import 'package:origa/screen/login_conected/login_connected.dart';
import 'package:origa/screen/not_eligible/not_eligible.dart';
import 'package:origa/screen/not_intrested/not_intrested.dart';
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
import 'package:origa/utils/date_formate_utils.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/utils/skeleton.dart';
import 'package:origa/widgets/bottomsheet_appbar.dart';
import 'package:origa/widgets/case_status_widget.dart';
import 'package:origa/widgets/custom_appbar.dart';
import 'package:origa/widgets/custom_loading_widget.dart';
import 'package:origa/widgets/custom_loan_user_details.dart';
import 'package:origa/widgets/custom_read_only_text_field.dart';
import 'package:origa/widgets/custom_text.dart';
import 'package:origa/widgets/eventdetail_status.dart';
import 'package:path_provider/path_provider.dart';

import '../../widgets/case_detail_expand_list_wiget.dart';
import 'check_whatsapp_button_enable.dart';

class CaseDetailsScreen extends StatefulWidget {
  const CaseDetailsScreen(
      {Key? key, this.paramValues, required this.allocationBloc})
      : super(key: key);
  final dynamic paramValues;
  final AllocationBloc allocationBloc;

  @override
  _CaseDetailsScreenState createState() => _CaseDetailsScreenState();
}

class _CaseDetailsScreenState extends State<CaseDetailsScreen> {
  late CaseDetailsBloc bloc;
  late StreamSubscription<dynamic> subscription;

  @override
  void initState() {
    super.initState();
    bloc = CaseDetailsBloc(widget.allocationBloc)
      ..add(CaseDetailsInitialEvent(
          paramValues: widget.paramValues, context: context));

    getFileDirectory();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(
          context,
          <String, dynamic>{
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
        return Future<bool>(() => false);
      },
      child: Scaffold(
        backgroundColor: ColorResource.colorF7F8FA,
        body: BlocListener<CaseDetailsBloc, CaseDetailsState>(
          bloc: bloc,
          listener: (BuildContext context, CaseDetailsState state) {
            debugPrint(state.toString());
            if (state is PostDataApiSuccessState) {
              bloc.translateTextAddressInvalid = '';
              bloc.translateTextCustomerNotMet = '';
              bloc.translateTextUnReachable = '';
              bloc.translateTextPhoneInvalid = '';
              AppUtils.topSnackBar(context, Constants.eventUpdatedSuccess);
            }
            if (state is CaseDetailsLoadedState) {
              setState(() {});
            }
            if (state is UpdateSuccessfullState) {
              setState(() {});
            }
            if (state is ClickMainAddressBottomSheetState) {
              addressBottomSheet(context, bloc, state.i,
                  addressModel: state.addressModel);
            }
            if (state is ClickMainCallBottomSheetState) {
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
              // AppUtils.noInternetSnackbar(context);
            }
            if (state is CallCaseDetailsState) {
              Navigator.pushNamed(context, AppRoutes.caseDetailsScreen,
                  arguments: CaseDetailsNaviagationModel(
                    state.paramValues,
                    allocationBloc: widget.allocationBloc,
                  ));
            }
            if (state is PushAndPOPNavigationCaseDetailsState) {
              Navigator.pushNamed(context, AppRoutes.caseDetailsScreen,
                  arguments: CaseDetailsNaviagationModel(
                    state.paramValues,
                    allocationBloc: widget.allocationBloc,
                  ));
            }

            if (state is SendSMSloadState) {
              bloc.isSendSMSloading = !bloc.isSendSMSloading;
            }

            if (state is SendWhatsappLoadState) {
              bloc.isSendWhatsappLoading = !bloc.isSendWhatsappLoading;
            }

            if (state is UpdateRefUrlState) {
              bloc.isGeneratePaymentLinkLoading = false;
              bloc.caseDetailsAPIValue.result?.caseDetails?.repaymentInfo
                  ?.refUrl = state.refUrl;
              setState(() {});
            }

            if (state is TriggerEventDetailsState) {
              setState(() {
                bloc.displayEventDetail = state.eventListData;
                bloc.isEventDetailLoading = false;
              });
            }
          },
          child: BlocBuilder<CaseDetailsBloc, CaseDetailsState>(
            bloc: bloc,
            builder: (BuildContext context, CaseDetailsState state) {
              bool showVisit = false;
              String? key = Singleton
                  .instance.contractorInformations?.result?.googleMapsApiKey;
              if (key?.isEmpty == false) {
                showVisit = true;
              }
              if (state is CaseDetailsLoadingState) {
                return const SkeletonLoading();
                // ignore: dead_code
                return const CustomLoadingWidget();
              } else {
                return Scaffold(
                  backgroundColor: ColorResource.colorF7F8FA,
                  body: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: CustomAppbar(
                          backgroundColor: ColorResource.colorF7F8FA,
                          titleString: Languages.of(context)!.caseDetials,
                          titleSpacing: 10,
                          iconEnumValues: IconEnum.back,
                          onItemSelected: (dynamic value) {
                            if (value == 'IconEnum.back') {
                              Navigator.pop(
                                context,
                                <String, dynamic>{
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
                      Container(
                          padding:
                          const EdgeInsets.fromLTRB(20.0, 0, 20.0, 13.0),
                          color: ColorResource.colorF7F8FA,
                          child: caseInfo()),
                      Container(
                          padding: const EdgeInsets.fromLTRB(0.0, 0, 0.0, 5.0),
                          color: ColorResource.colorF7F8FA,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    if (!bloc.isBasicInfo) {
                                      setState(() {
                                        bloc.isBasicInfo = !bloc.isBasicInfo;
                                      });
                                    }
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        top: bloc.isBasicInfo ? 0 : 3),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: bloc.isBasicInfo
                                              ? ColorResource.colorD5344C
                                              : ColorResource.colorC4C4C4,
                                          width: bloc.isBasicInfo ? 5.0 : 1.0,
                                        ),
                                      ),
                                    ),
                                    child: Padding(
                                      padding:
                                      const EdgeInsets.only(bottom: 13),
                                      child: CustomText(
                                        Languages.of(context)!.basicInfo,
                                        fontWeight: FontWeight.w700,
                                        color: bloc.isBasicInfo
                                            ? ColorResource.color23375A
                                            : ColorResource.colorC4C4C4,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    if (bloc.isBasicInfo) {
                                      setState(() {
                                        bloc.isBasicInfo = !bloc.isBasicInfo;
                                      });
                                      bloc.add(TriggerEventDetailsEvent());
                                    }
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        top: bloc.isBasicInfo ? 3 : 0),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: bloc.isBasicInfo
                                              ? ColorResource.colorC4C4C4
                                              : ColorResource.colorD5344C,
                                          width: bloc.isBasicInfo ? 1.0 : 5.0,
                                        ),
                                      ),
                                    ),
                                    child: Padding(
                                      padding:
                                      const EdgeInsets.only(bottom: 13),
                                      child: CustomText(
                                        Languages.of(context)!.eventDetailsInfo,
                                        fontWeight: FontWeight.w700,
                                        color: bloc.isBasicInfo
                                            ? ColorResource.colorC4C4C4
                                            : ColorResource.color23375A,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                      bloc.isNoInternetAndServerError
                          ? Expanded(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
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
                        child: bloc.isBasicInfo
                            ? basicInfo()
                            : eventDetails(),
                      ),
                    ],
                  ),
                  bottomNavigationBar: bloc.isNoInternetAndServerError
                      ? const SizedBox()
                      : Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
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
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                bloc.userType == 'FIELDAGENT'
                                    ? GestureDetector(
                                    onTap: () {
                                      debugPrint("");
                                      bloc.add(
                                        EventDetailsEvent(
                                            Constants.addressDetails,
                                            const <dynamic>[],
                                            false),
                                      );
                                      if (!bloc.isBasicInfo) {
                                        setState(() {
                                          bloc.isBasicInfo =
                                          !bloc.isBasicInfo;
                                        });
                                      }
                                    },
                                    child: Container(
                                      height: 50,
                                      width: (MediaQuery
                                          .of(context)
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
                                          children: <Widget>[
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
                                            const SizedBox(width: 10),
                                            Expanded(
                                                child: CustomText(
                                                  Languages.of(context)!
                                                      .visit
                                                      .toString()
                                                      .toUpperCase(),
                                                  fontSize:
                                                  FontSize.twelve,
                                                  lineHeight: 1,
                                                  fontWeight:
                                                  FontWeight.w700,
                                                  color: ColorResource
                                                      .color23375A,
                                                ))
                                          ],
                                        ),
                                      ),
                                    ))
                                    : const SizedBox(),
                                SizedBox(
                                    width: bloc.userType == 'FIELDAGENT'
                                        ? 20
                                        : 0),
                                GestureDetector(
                                  onTap: () {
                                    bloc.add(EventDetailsEvent(
                                        Constants.callDetails,
                                        const <dynamic>[],
                                        true));

                                    if (!bloc.isBasicInfo) {
                                      setState(() {
                                        bloc.isBasicInfo =
                                        !bloc.isBasicInfo;
                                      });
                                    }
                                  },
                                  child: Container(
                                    height: 50,
                                    width: (MediaQuery
                                        .of(context)
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
                                        children: <Widget>[
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
                                          const SizedBox(width: 10),
                                          Expanded(
                                              child: CustomText(
                                                Languages.of(context)!
                                                    .call
                                                    .toUpperCase(),
                                                fontSize: FontSize.twelve,
                                                fontWeight: FontWeight.w700,
                                                lineHeight: 1,
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

  Widget caseInfo() {
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.bottomCenter,
          child: CustomLoanUserDetails(
            userName: bloc.caseDetailsAPIValue.result?.caseDetails?.cust ?? '_',
            userId: bloc.caseDetailsAPIValue.result?.caseDetails?.accNo ?? '_',
            userAmount:
            bloc.caseDetailsAPIValue.result?.caseDetails?.due?.toDouble() ??
                0,
            isAccountNo: true,
            color: ColorResource.colorD4F5CF,
            marginTop: 10,
          ),
        ),
        // Here check userType base on show case status
        if (Singleton.instance.usertype == Constants.fieldagent)
          bloc.caseDetailsAPIValue.result?.caseDetails?.collSubStatus == 'new'
              ? Padding(
            padding: const EdgeInsets.only(left: 10),
            child: CaseStatusWidget.satusTextWidget(
              context,
              text: Languages.of(context)!.new_,
              width: 55,
            ),
          )
              : Padding(
            padding: const EdgeInsets.only(left: 10),
            child: caseStatusWidget(
                text: bloc.caseDetailsAPIValue.result?.caseDetails
                    ?.collSubStatus),
          ),

        if (Singleton.instance.usertype == Constants.telecaller)
          bloc.caseDetailsAPIValue.result?.caseDetails?.telSubStatus == 'new'
              ? Padding(
            padding: const EdgeInsets.only(left: 10),
            child: CaseStatusWidget.satusTextWidget(
              context,
              text: Languages.of(context)!.new_,
              width: 55,
            ),
          )
              : Padding(
            padding: const EdgeInsets.only(left: 10),
            child: caseStatusWidget(
                text: bloc.caseDetailsAPIValue.result?.caseDetails
                    ?.telSubStatus),
          ),
      ],
    );
  }

  Widget basicInfo() {
    Map<String, dynamic>? caseResult =
        bloc.caseDetailsAPIValue.result?.bucketedCaseData ?? {};
    // Map<String?, Map<String, String>> caseFieldMap =
    //     <String?, Map<String, String>>{};
    List<String> contactTemplate = [];
    bloc.caseDetailsAPIValue.result?.availableAddContacts?.forEach((element) {
      contactTemplate.add(element.cName ?? '');
    });
    Singleton.instance.availableAddContacts = contactTemplate;
    List<Widget> widgetlist = [];
    AllocationTemplateConfig? allocationTemplateConfig =
        Singleton.instance.allocationTemplateConfig;

    caseResult.forEach((caseResultKey, caseResultValue) {
      Map<String, dynamic> keyData = caseResult[caseResultKey];
      String title = '';
      // caseResult.keys.forEach((element) {
      //   if (element == 'attributeDetails') {
      //     title = element.toString();
      //   }
      // });
      if (keyData.isNotEmpty) {
        switch (caseResultKey) {
          case 'attributeDetails':
            title = Languages
                .of(context)
                ?.attributeDetails ?? '';
            break;
          case 'customerDetails':
            title = Languages
                .of(context)
                ?.customerDetails ?? '';
            break;
          case 'loanDetails':
            title = Languages
                .of(context)
                ?.loanDetails ?? '';
            break;
          case 'customerContactDetails':
            title = Languages
                .of(context)
                ?.customerContactDetails ?? '';
            break;
          case 'allocationDetails':
            title = Languages
                .of(context)
                ?.allocationDetails ?? '';
            break;
          case 'repaymentDetails':
            title = Languages
                .of(context)
                ?.repaymentInformation ?? '';
            break;
          case 'assetDetails':
            title = Languages
                .of(context)
                ?.assetDetails ?? '';
            break;
          case 'derivedVariables':
            title = 'Derived Variables';
            break;
          default:
            {}
            break;
        }
        List<Widget> childWidgets;
        childWidgets = [];
        bool shouldShowSection = false;
        keyData.forEach((key, value) {
          String keyName = '';
          allocationTemplateConfig?.fields?.forEach((template) {
            String? templateKey = template.key;
            if (templateKey?.contains('repayment.') == true) {
              templateKey = templateKey?.replaceAll('repayment.', '');
            }
            if (templateKey == key) {
              keyName = template.csvName.toString();
            }
          });
          if (keyName.isEmpty) {
            keyName = key.toUpperCase().toString();
          }
          if (value
              .toString()
              .isNotEmpty && shouldShowSection == false) {
            shouldShowSection = true;
          }
          if (keyName.contains('REF_URL') == false) {
            childWidgets.add(ListOfCaseDetails.textFieldView(
                title: keyName.toString(), value: value.toString()));
          }
        });
        if (caseResultKey == 'repaymentDetails') {
          // childWidgets.add(getSmsButton());
          childWidgets.add(repaymentInfo());
          if (Singleton.instance.contractorInformations?.result
              ?.showSendRepaymentInfo ==
              true) {
            shouldShowSection = true;
          }
        }
        if (shouldShowSection) {
          widgetlist.add(ListOfCaseDetails.listOfDetails(context,
              title: title, bloc: bloc, child: childWidgets));
        }
        widgetlist
            .add(const Padding(padding: EdgeInsets.symmetric(vertical: 4)));
      }
    });
    if (bloc.caseDetailsAPIValue.result?.otherLoanDetails?.isNotEmpty == true) {
      widgetlist.add(getOtherLoanDetails());
    }
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 0, 20, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: widgetlist,
        ),
      ),
    );
    // return SingleChildScrollView(
    //     child: Padding(
    //         padding: const EdgeInsets.fromLTRB(20.0, 0, 20, 20),
    //         child: Column(
    //           mainAxisSize: MainAxisSize.min,
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: <Widget>[
    //             const SizedBox(height: 15),
    //             ListOfCaseDetails.listOfDetails(context,
    //                 bloc: bloc,
    //                 isLoanDetails: true,
    //                 isInitialExpand: true,
    //                 title: Languages.of(context)!.loanDetails),
    //             const SizedBox(height: 20),
    //             ListOfCaseDetails.listOfDetails(context,
    //                 bloc: bloc,
    //                 isCustomerDetails: true,
    //                 title: Languages.of(context)!.agentDetails),
    //             const SizedBox(height: 20),
    //             ListOfCaseDetails.listOfDetails(context,
    //                 bloc: bloc,
    //                 isRepaymentDetails: true,
    //                 repaymentDetailsWidget: repaymentInfo(),
    //                 title: Languages.of(context)!.repaymentInformation),
    //             const SizedBox(height: 20),
    //             if (bloc.caseDetailsAPIValue.result?.caseDetails?.attr !=
    //                     null &&
    //                 bloc.caseDetailsAPIValue.result?.caseDetails?.attr!
    //                         .length !=
    //                     0)
    //               Column(
    //                 children: [
    //                   ListOfCaseDetails.listOfDetails(context,
    //                       bloc: bloc,
    //                       isAttributeDetails: true,
    //                       title: Languages.of(context)!.attributeDetails),
    //                   const SizedBox(height: 20),
    //                 ],
    //               ),
    //             ListOfCaseDetails.listOfDetails(context,
    //                 bloc: bloc,
    //                 isCustomerContactDetails: true,
    //                 title: Languages.of(context)!.contactDetails),
    //             const SizedBox(height: 20),
    //             ListOfCaseDetails.listOfDetails(context,
    //                 bloc: bloc,
    //                 isAuditDetails: true,
    //                 title: Languages.of(context)!.auditDetails),
    //             const SizedBox(height: 27),
    //             CustomText(
    //               Languages.of(context)!.otherLoanOf,
    //               color: ColorResource.color101010,
    //               fontSize: FontSize.sixteen,
    //               fontWeight: FontWeight.w700,
    //             ),
    //             ListView.builder(
    //                 physics: const NeverScrollableScrollPhysics(),
    //                 padding: EdgeInsets.zero,
    //                 shrinkWrap: true,
    //                 itemCount: bloc.caseDetailsAPIValue.result?.otherLoanDetails
    //                         ?.length ??
    //                     0,
    //                 itemBuilder: (BuildContext context, int index) {
    //                   return Column(
    //                     mainAxisSize: MainAxisSize.min,
    //                     children: <Widget>[
    //                       const SizedBox(height: 10),
    //                       GestureDetector(
    //                         onTap: () {
    //                           if (bloc.caseDetailsAPIValue.result!
    //                               .otherLoanDetails![index].canAccess!) {
    //                             bloc.add(ClickPushAndPOPCaseDetailsEvent(
    //                                 paramValues: <String, dynamic>{
    //                                   'caseID': bloc.caseDetailsAPIValue.result
    //                                       ?.otherLoanDetails![index].caseId,
    //                                   'isAddress': true
    //                                 }));
    //                           } else {
    //                             AppUtils.showErrorToast(
    //                                 Constants.caseNotAllocated);
    //                           }
    //                         },
    //                         child: Container(
    //                           width: double.infinity,
    //                           decoration: BoxDecoration(
    //                               boxShadow: <BoxShadow>[
    //                                 BoxShadow(
    //                                   color: ColorResource.color000000
    //                                       .withOpacity(.25),
    //                                   blurRadius: 2.0,
    //                                   offset: const Offset(1.0, 1.0),
    //                                 ),
    //                               ],
    //                               border: Border.all(
    //                                   color: ColorResource.colorDADADA,
    //                                   width: 0.5),
    //                               color: ColorResource.colorF7F8FA,
    //                               borderRadius: const BorderRadius.all(
    //                                   Radius.circular(10.0))),
    //                           child: Padding(
    //                             padding: const EdgeInsets.symmetric(
    //                                 horizontal: 20, vertical: 12),
    //                             child: Column(
    //                               mainAxisSize: MainAxisSize.min,
    //                               crossAxisAlignment: CrossAxisAlignment.start,
    //                               children: <Widget>[
    //                                 CustomText(
    //                                   Languages.of(context)!
    //                                           .bankName
    //                                           .replaceAll('*', '') +
    //                                       ': ' +
    //                                       bloc
    //                                           .caseDetailsAPIValue
    //                                           .result!
    //                                           .otherLoanDetails![index]
    //                                           .bankName!,
    //                                   color: ColorResource.color666666,
    //                                   fontSize: FontSize.twelve,
    //                                 ),
    //                                 CustomText(
    //                                   Languages.of(context)!.accountNo +
    //                                       ': ' +
    //                                       bloc.caseDetailsAPIValue.result!
    //                                           .otherLoanDetails![index].accNo!,
    //                                   color: ColorResource.color666666,
    //                                   fontSize: FontSize.twelve,
    //                                 ),
    //                                 const SizedBox(height: 5),
    //                                 CustomText(
    //                                   bloc
    //                                               .caseDetailsAPIValue
    //                                               .result
    //                                               ?.otherLoanDetails![index]
    //                                               .cust !=
    //                                           null
    //                                       ? bloc.caseDetailsAPIValue.result!
    //                                           .otherLoanDetails![index].cust!
    //                                           .toUpperCase()
    //                                       : '_',
    //                                   color: ColorResource.color333333,
    //                                   fontWeight: FontWeight.w700,
    //                                 ),
    //                                 const SizedBox(height: 11),
    //                                 CustomText(
    //                                   Languages.of(context)!.overdueAmount,
    //                                   color: ColorResource.color666666,
    //                                   fontSize: FontSize.twelve,
    //                                 ),
    //                                 const SizedBox(height: 5),
    //                                 Row(
    //                                   mainAxisAlignment:
    //                                       MainAxisAlignment.spaceBetween,
    //                                   children: <Widget>[
    //                                     CustomText(
    //                                       bloc.caseDetailsAPIValue.result
    //                                               ?.otherLoanDetails![index].due
    //                                               .toString() ??
    //                                           '_',
    //                                       color: ColorResource.color333333,
    //                                       fontWeight: FontWeight.w700,
    //                                     ),
    //                                     Row(
    //                                       children: <Widget>[
    //                                         CustomText(
    //                                           Languages.of(context)!.view,
    //                                           color: ColorResource.color23375A,
    //                                           fontWeight: FontWeight.w700,
    //                                         ),
    //                                         const SizedBox(width: 10),
    //                                         SvgPicture.asset(
    //                                             ImageResource.forwardArrow)
    //                                       ],
    //                                     )
    //                                   ],
    //                                 ),
    //                               ],
    //                             ),
    //                           ),
    //                         ),
    //                       ),
    //                       const SizedBox(height: 5),
    //                     ],
    //                   );
    //                 }),
    //           ],
    //         )));
  }

  Widget getOtherLoanDetails() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          Languages.of(context)!.otherLoanOf,
          color: ColorResource.color101010,
          fontSize: FontSize.sixteen,
          fontWeight: FontWeight.w700,
        ),
        ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount:
            bloc.caseDetailsAPIValue.result?.otherLoanDetails?.length ?? 0,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      if (bloc.caseDetailsAPIValue.result!
                          .otherLoanDetails![index].canAccess!) {
                        bloc.add(ClickPushAndPOPCaseDetailsEvent(
                            paramValues: <String, dynamic>{
                              'caseID': bloc.caseDetailsAPIValue.result
                                  ?.otherLoanDetails![index].caseId,
                              'isAddress': true
                            }));
                      } else {
                        AppUtils.showErrorToast(Constants.caseNotAllocated);
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: ColorResource.color000000.withOpacity(.25),
                              blurRadius: 2.0,
                              offset: const Offset(1.0, 1.0),
                            ),
                          ],
                          border: Border.all(
                              color: ColorResource.colorDADADA, width: 0.5),
                          color: ColorResource.colorF7F8FA,
                          borderRadius:
                          const BorderRadius.all(Radius.circular(10.0))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 12),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            CustomText(
                              Languages.of(context)!
                                  .bankName
                                  .replaceAll('*', '') +
                                  ': ' +
                                  bloc.caseDetailsAPIValue.result!
                                      .otherLoanDetails![index].bankName!,
                              color: ColorResource.color666666,
                              fontSize: FontSize.twelve,
                            ),
                            CustomText(
                              Languages.of(context)!.accountNo +
                                  ': ' +
                                  bloc.caseDetailsAPIValue.result!
                                      .otherLoanDetails![index].accNo!,
                              color: ColorResource.color666666,
                              fontSize: FontSize.twelve,
                            ),
                            const SizedBox(height: 5),
                            CustomText(
                              bloc.caseDetailsAPIValue.result
                                  ?.otherLoanDetails![index].cust !=
                                  null
                                  ? bloc.caseDetailsAPIValue.result!
                                  .otherLoanDetails![index].cust!
                                  .toUpperCase()
                                  : '_',
                              color: ColorResource.color333333,
                              fontWeight: FontWeight.w700,
                            ),
                            const SizedBox(height: 11),
                            CustomText(
                              Languages.of(context)!.overdueAmount,
                              color: ColorResource.color666666,
                              fontSize: FontSize.twelve,
                            ),
                            const SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                CustomText(
                                  bloc.caseDetailsAPIValue.result
                                      ?.otherLoanDetails![index].due
                                      .toString() ??
                                      '_',
                                  color: ColorResource.color333333,
                                  fontWeight: FontWeight.w700,
                                ),
                                Row(
                                  children: <Widget>[
                                    CustomText(
                                      Languages.of(context)!.view,
                                      color: ColorResource.color23375A,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    const SizedBox(width: 10),
                                    SvgPicture.asset(ImageResource.forwardArrow)
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
    );
  }

  Widget getSmsButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Singleton.instance.contractorInformations?.result
            ?.showSendRepaymentInfo ==
            false
            ? const SizedBox()
            : bloc.isSendSMSloading
            ? Container(
          margin: const EdgeInsets.only(left: 50),
          height: 37,
          width: 37,
          decoration: BoxDecoration(
              color: ColorResource.color23375A,
              borderRadius: BorderRadius.circular(25)),
          child: const CustomLoadingWidget(
            radius: 11,
            strokeWidth: 2,
          ),
        )
            : GestureDetector(
          onTap: () async {
            if (ConnectivityResult.none !=
                await Connectivity().checkConnectivity()) {
              if (!bloc.isSendSMSloading) {
                bloc.add(SendSMSEvent(context,
                    type: Constants.repaymentInfoType));
              }
            } else {
              AppUtils.noInternetSnackbar(context);
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 15, vertical: 11.2),
            decoration: BoxDecoration(
              color: ColorResource.color23375A,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: ColorResource.colorECECEC),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SvgPicture.asset(ImageResource.sms),
                const SizedBox(width: 7),
                CustomText(Languages.of(context)!.sendSMS,
                    fontSize: FontSize.eleven,
                    fontWeight: FontWeight.w700,
                    lineHeight: 1.3,
                    color: ColorResource.colorffffff),
              ],
            ),
          ),
        ),
        const SizedBox(width: 30),
        CheckWhatsappButtonEnable.checkWAbutton(
            whatsappTemplate: Singleton.instance.contractorInformations
                ?.result?.repaymentWhatsappTemplate,
            whatsappTemplateName: Singleton.instance.contractorInformations
                ?.result?.sendRepaymentInfoWhatsappTemplateName,
            whatsappKey: bloc.campaingnConfigModel.result?.whatsappApiKey)
        // Singleton.instance.contractorInformations?.result
        //             ?.hideSendRepaymentInfoWhatsappButton ==
        //         false
            ? bloc.isSendWhatsappLoading
            ? Container(
          margin: const EdgeInsets.only(right: 50),
          height: 37,
          width: 37,
          decoration: BoxDecoration(
              color: ColorResource.color23375A,
              borderRadius: BorderRadius.circular(25)),
          child: const CustomLoadingWidget(
            radius: 11,
            strokeWidth: 2,
          ),
        )
            : Flexible(
          child: GestureDetector(
            onTap: () {
              bloc.add(SendWhatsAppEvent(context,
                  caseID: bloc.caseDetailsAPIValue.result!
                      .caseDetails!.caseId!));
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 15, vertical: 11.2),
              decoration: BoxDecoration(
                color: ColorResource.color23375A,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: ColorResource.colorECECEC),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    ImageResource.whatsApp,
                    height: 17,
                  ),
                  const SizedBox(width: 7),
                  Expanded(
                    child: CustomText(
                        Languages.of(context)!.sendWhatsapp,
                        fontSize: FontSize.eleven,
                        fontWeight: FontWeight.w700,
                        lineHeight: 1.3,
                        color: ColorResource.colorffffff),
                  ),
                ],
              ),
            ),
          ),
        )
            : bloc.isGeneratePaymentLink
            ? bloc.isGeneratePaymentLinkLoading
            ? Container(
          margin: const EdgeInsets.only(right: 50),
          height: 37,
          width: 37,
          decoration: BoxDecoration(
              color: ColorResource.color23375A,
              borderRadius: BorderRadius.circular(25)),
          child: const CustomLoadingWidget(
            radius: 11,
            strokeWidth: 2,
          ),
        )
            : Flexible(
          child: GestureDetector(
            onTap: () async {
              if (await Connectivity().checkConnectivity() !=
                  ConnectivityResult.none) {
                setState(() {
                  bloc.isGeneratePaymentLinkLoading = true;
                });
              } else {
                AppUtils.noInternetSnackbar(context);
              }
              bloc.add(GeneratePaymenLinktEvent(context,
                  caseID: bloc.caseDetailsAPIValue.result!
                      .caseDetails!.caseId!));
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 15, vertical: 13),
              decoration: BoxDecoration(
                color: ColorResource.color23375A,
                borderRadius: BorderRadius.circular(8),
                border:
                Border.all(color: ColorResource.colorECECEC),
              ),
              child: CustomText(
                  Languages.of(context)!
                      .generatePaymentLink
                      .toUpperCase(),
                  fontSize: FontSize.eleven,
                  fontWeight: FontWeight.w700,
                  // isSingleLine: true,
                  lineHeight: 1.3,
                  color: ColorResource.colorffffff),
            ),
          ),
        )
            : const SizedBox(),
      ],
    );
  }

  Widget eventDetails() {
    if (bloc.isEventDetailLoading) {
      return const Center(child: CustomLoadingWidget());
    }
    return MediaQuery.removeViewPadding(
      context: context,
      removeTop: true,
      child: ListView.builder(
        // shrinkWrap: true,
          itemCount: bloc.displayEventDetail.length,
          itemBuilder: (BuildContext context, int monthIndex) {
            return ListTileTheme(
                contentPadding: const EdgeInsets.all(0),
                minVerticalPadding: 0,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: ColorResource.color666666),
                  borderRadius: BorderRadius.circular(65.0),
                ),
                tileColor: ColorResource.colorF7F8FA,
                selectedTileColor: ColorResource.colorE5E5E5,
                selectedColor: ColorResource.colorE5E5E5,
                child: Theme(
                  data: Theme.of(context)
                      .copyWith(dividerColor: Colors.transparent),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(13, 15, 13, 0),
                    child: ExpansionTile(
                        initiallyExpanded: monthIndex == selectedMonth,
                        key: const ObjectKey('firstExpansionTile'),
                        iconColor: ColorResource.color000000,
                        collapsedIconColor: ColorResource.color000000,
                        onExpansionChanged: (e) {
                          //Your code
                          if (e) {
                            setState(() {
                              // Duration(seconds:  20000);
                              selectedMonth = monthIndex;
                            });
                          } else {
                            setState(() {
                              selectedMonth = -1;
                            });
                          }
                        },
                        tilePadding: const EdgeInsetsDirectional.only(
                            start: 20, end: 20),
                        expandedCrossAxisAlignment: CrossAxisAlignment.start,
                        expandedAlignment: Alignment.centerLeft,
                        title: CustomText(
                          bloc.displayEventDetail[monthIndex].month ?? '',
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                        children: [
                          ListView.builder(
                              shrinkWrap: true,
                              controller: secondlistScrollController,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: bloc.displayEventDetail[monthIndex]
                                  .eventList?.length ??
                                  0,
                              itemBuilder: (BuildContext context, int index) {
                                // final dynamic listVal = bloc
                                //     .eventDetailsAPIValues
                                //     .result![monthIndex]
                                //     .eventList
                                //     ?.reversed
                                //     .toList();

                                bloc.displayEventDetail[monthIndex].eventList
                                    ?.forEach(
                                        (EvnetDetailsResultsModel element) {
                                      bloc.eventDetailsPlayAudioModel
                                          .add(EventDetailsPlayAudioModel());
                                    });
                                final dynamic value = bloc
                                    .displayEventDetail[monthIndex]
                                    .eventList!
                                    .reversed
                                    .toList();
                                return expandList(value, index);
                              }),
                        ]),
                  ),
                ));
          }),
    );
  }

  Widget extraTextField(
      {required String title, required TextEditingController controller}) {
    return controller.text != '-'
        ? Padding(
      padding: const EdgeInsets.only(top: 16),
      child: CustomReadOnlyTextField(
        title,
        controller,
        isLabel: true,
        isEnable: false,
      ),
    )
        : const SizedBox();
  }

  void phoneBottomSheet(BuildContext buildContext, CaseDetailsBloc bloc, int i,
      bool isCallFromCaseDetails,
      {String? callId}) {
    showCupertinoModalPopup(
        context: buildContext,
        builder: (BuildContext context) {
          return PhoneScreen(
            bloc: bloc,
            index: i,
            isCallFromCaseDetails: isCallFromCaseDetails,
            callId: callId,
            customerLoanUserWidget: CustomLoanUserDetails(
              userName:
              bloc.caseDetailsAPIValue.result?.caseDetails?.cust ?? '',
              userId: '${bloc.caseDetailsAPIValue.result?.caseDetails?.agrRef}',
              userAmount: bloc.caseDetailsAPIValue.result?.caseDetails?.due
                  ?.toDouble() ??
                  0.0,
            ),
          );
        });
  }

  void addressBottomSheet(BuildContext buildContext, CaseDetailsBloc bloc,
      int i,
      {dynamic addressModel}) {
    showCupertinoModalPopup(
        context: buildContext,
        builder: (BuildContext context) {
          return SizedBox(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.89,
              child: AddressScreen(
                bloc: bloc,
                index: i,
                addressModel: addressModel,
              ));
        });
  }

  openBottomSheet(BuildContext buildContext, String cardTitle,
      List<dynamic> list, bool? isCall,
      {String? health,
        String? selectedContact,
        required bool isCallFromCallDetails,
        String? callId}) {
    debugPrint('callTitle---->$cardTitle');
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
                '${bloc.caseDetailsAPIValue.result?.caseDetails?.agrRef}',
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
                '${bloc.caseDetailsAPIValue.result?.caseDetails?.agrRef}',
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
                '${bloc.caseDetailsAPIValue.result?.caseDetails?.agrRef}',
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
                '${bloc.caseDetailsAPIValue.result?.caseDetails?.agrRef}',
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
                '${bloc.caseDetailsAPIValue.result?.caseDetails?.agrRef}',
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
                '${bloc.caseDetailsAPIValue.result?.caseDetails?.agrRef}',
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
                '${bloc.caseDetailsAPIValue.result?.caseDetails
                    ?.bankName} / ${bloc.caseDetailsAPIValue.result?.caseDetails
                    ?.agrRef}',
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
                '${bloc.caseDetailsAPIValue.result?.caseDetails
                    ?.bankName} / ${bloc.caseDetailsAPIValue.result?.caseDetails
                    ?.agrRef}',
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
                '${bloc.caseDetailsAPIValue.result?.caseDetails
                    ?.bankName} / ${bloc.caseDetailsAPIValue.result?.caseDetails
                    ?.agrRef}',
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
                '${bloc.caseDetailsAPIValue.result?.caseDetails
                    ?.bankName} / ${bloc.caseDetailsAPIValue.result?.caseDetails
                    ?.agrRef}',
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
            final List<String> s1 = <String>[];
            bloc.caseDetailsAPIValue.result?.callDetails
                ?.forEach((dynamic element) {
              if (element['cType'].contains('mobile')) {
                if (!(s1.contains(element['value']))) {
                  s1.add(element['value']);
                }
              } else {}
            });
            return CallCustomerBottomSheet(
              caseDetailsAPIValue: bloc.caseDetailsAPIValue,
              customerLoanUserWidget: CustomLoanUserDetails(
                userName:
                bloc.caseDetailsAPIValue.result?.caseDetails?.cust ?? '',
                userId:
                '${bloc.caseDetailsAPIValue.result?.caseDetails
                    ?.bankName} / ${bloc.caseDetailsAPIValue.result?.caseDetails
                    ?.agrRef}',
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
              bloc.caseDetailsAPIValue.result?.caseDetails?.cust ?? '',
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
                '${bloc.caseDetailsAPIValue.result?.caseDetails
                    ?.bankName} / ${bloc.caseDetailsAPIValue.result?.caseDetails
                    ?.agrRef}',
                userAmount: bloc.caseDetailsAPIValue.result?.caseDetails?.due
                    ?.toDouble() ??
                    0.0,
              ),
            );
        // this events only visible based on contractor
          case Constants.notInterested:
            return CustomNotIntrestedBottomSheet(
              Languages.of(context)!.notInterested,
              caseId: bloc.caseId.toString(),
              customerLoanUserWidget: CustomLoanUserDetails(
                userName:
                bloc.caseDetailsAPIValue.result?.caseDetails?.cust ?? '',
                userId:
                '${bloc.caseDetailsAPIValue.result?.caseDetails
                    ?.bankName} / ${bloc.caseDetailsAPIValue.result?.caseDetails
                    ?.agrRef}',
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

          case Constants.notEligible:
            return CustomNotEligibleBottomSheet(
              Languages.of(context)!.notEligible,
              caseId: bloc.caseId.toString(),
              customerLoanUserWidget: CustomLoanUserDetails(
                userName:
                bloc.caseDetailsAPIValue.result?.caseDetails?.cust ?? '',
                userId:
                '${bloc.caseDetailsAPIValue.result?.caseDetails
                    ?.bankName} / ${bloc.caseDetailsAPIValue.result?.caseDetails
                    ?.agrRef}',
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

          case Constants.login:
            return CustomLoginConnectedBottomSheet(
              Languages.of(context)!.login,
              caseId: bloc.caseId.toString(),
              customerLoanUserWidget: CustomLoanUserDetails(
                userName:
                bloc.caseDetailsAPIValue.result?.caseDetails?.cust ?? '',
                userId:
                '${bloc.caseDetailsAPIValue.result?.caseDetails
                    ?.bankName} / ${bloc.caseDetailsAPIValue.result?.caseDetails
                    ?.agrRef}',
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

          default:
            return SizedBox(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.89,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const <Widget>[
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

  Widget repaymentInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                GestureDetector(
                  onTap: () async {
                    final String urlValue = bloc.caseDetailsAPIValue.result
                        ?.caseDetails?.repaymentInfo?.refUrl ??
                        '';
                    await Clipboard.setData(ClipboardData(text: urlValue))
                        .then((_) {
                      AppUtils.showToast('Payment Link copied to clipboard');
                    });
                  },
                  child: ListOfCaseDetails.textFieldView(
                      title: Languages.of(context)!.referenceUrl,
                      value: bloc.caseDetailsAPIValue.result?.caseDetails
                          ?.repaymentInfo?.refUrl ??
                          '-'),
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Singleton.instance.contractorInformations?.result
                        ?.showSendRepaymentInfo ==
                        false
                        ? const SizedBox()
                        : bloc.isSendSMSloading
                        ? Container(
                      margin: const EdgeInsets.only(left: 50),
                      height: 37,
                      width: 37,
                      decoration: BoxDecoration(
                          color: ColorResource.color23375A,
                          borderRadius: BorderRadius.circular(25)),
                      child: const CustomLoadingWidget(
                        radius: 11,
                        strokeWidth: 2,
                      ),
                    )
                        : GestureDetector(
                      onTap: () async {
                        if (ConnectivityResult.none !=
                            await Connectivity()
                                .checkConnectivity()) {
                          if (!bloc.isSendSMSloading) {
                            bloc.add(SendSMSEvent(context,
                                type: Constants.repaymentInfoType));
                          }
                        } else {
                          AppUtils.noInternetSnackbar(context);
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 11.2),
                        decoration: BoxDecoration(
                          color: ColorResource.color23375A,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              color: ColorResource.colorECECEC),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            SvgPicture.asset(ImageResource.sms),
                            const SizedBox(width: 7),
                            CustomText(Languages.of(context)!.sendSMS,
                                fontSize: FontSize.eleven,
                                fontWeight: FontWeight.w700,
                                lineHeight: 1.3,
                                color: ColorResource.colorffffff),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 30),
                    CheckWhatsappButtonEnable.checkWAbutton(
                        whatsappTemplate: Singleton
                            .instance
                            .contractorInformations
                            ?.result
                            ?.repaymentWhatsappTemplate,
                        whatsappTemplateName: Singleton
                            .instance
                            .contractorInformations
                            ?.result
                            ?.sendRepaymentInfoWhatsappTemplateName,
                        whatsappKey: bloc
                            .campaingnConfigModel.result?.whatsappApiKey)
                    // Singleton.instance.contractorInformations?.result
                    //             ?.hideSendRepaymentInfoWhatsappButton ==
                    //         false
                        ? bloc.isSendWhatsappLoading
                        ? Container(
                      margin: const EdgeInsets.only(right: 50),
                      height: 37,
                      width: 37,
                      decoration: BoxDecoration(
                          color: ColorResource.color23375A,
                          borderRadius: BorderRadius.circular(25)),
                      child: const CustomLoadingWidget(
                        radius: 11,
                        strokeWidth: 2,
                      ),
                    )
                        : Flexible(
                      child: GestureDetector(
                        onTap: () {
                          bloc.add(SendWhatsAppEvent(context,
                              caseID: bloc.caseDetailsAPIValue.result!
                                  .caseDetails!.caseId!));
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 11.2),
                          decoration: BoxDecoration(
                            color: ColorResource.color23375A,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color: ColorResource.colorECECEC),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SvgPicture.asset(
                                ImageResource.whatsApp,
                                height: 17,
                              ),
                              const SizedBox(width: 7),
                              Expanded(
                                child: CustomText(
                                    Languages.of(context)!
                                        .sendWhatsapp,
                                    fontSize: FontSize.eleven,
                                    fontWeight: FontWeight.w700,
                                    lineHeight: 1.3,
                                    color: ColorResource.colorffffff),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                        : bloc.isGeneratePaymentLink
                        ? bloc.isGeneratePaymentLinkLoading
                        ? Container(
                      margin: const EdgeInsets.only(right: 50),
                      height: 37,
                      width: 37,
                      decoration: BoxDecoration(
                          color: ColorResource.color23375A,
                          borderRadius:
                          BorderRadius.circular(25)),
                      child: const CustomLoadingWidget(
                        radius: 11,
                        strokeWidth: 2,
                      ),
                    )
                        : Flexible(
                      child: GestureDetector(
                        onTap: () async {
                          if (await Connectivity()
                              .checkConnectivity() !=
                              ConnectivityResult.none) {
                            setState(() {
                              bloc.isGeneratePaymentLinkLoading =
                              true;
                            });
                          } else {
                            AppUtils.noInternetSnackbar(context);
                          }
                          bloc.add(GeneratePaymenLinktEvent(
                              context,
                              caseID: bloc.caseDetailsAPIValue
                                  .result!.caseDetails!.caseId!));
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 13),
                          decoration: BoxDecoration(
                            color: ColorResource.color23375A,
                            borderRadius:
                            BorderRadius.circular(8),
                            border: Border.all(
                                color: ColorResource.colorECECEC),
                          ),
                          child: CustomText(
                              Languages.of(context)!
                                  .generatePaymentLink
                                  .toUpperCase(),
                              fontSize: FontSize.eleven,
                              fontWeight: FontWeight.w700,
                              // isSingleLine: true,
                              lineHeight: 1.3,
                              color: ColorResource.colorffffff),
                        ),
                      ),
                    )
                        : const SizedBox(),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                CheckWhatsappButtonEnable.checkWAbutton(
                    whatsappTemplate: Singleton
                        .instance
                        .contractorInformations
                        ?.result
                        ?.repaymentWhatsappTemplate,
                    whatsappTemplateName: Singleton
                        .instance
                        .contractorInformations
                        ?.result
                        ?.sendRepaymentInfoWhatsappTemplateName,
                    whatsappKey:
                    bloc.campaingnConfigModel.result?.whatsappApiKey)
                // Singleton.instance.contractorInformations?.result
                //             ?.hideSendRepaymentInfoWhatsappButton ==
                //         false
                    ? bloc.isGeneratePaymentLink
                    ? bloc.isGeneratePaymentLinkLoading
                    ? Container(
                  margin: const EdgeInsets.only(right: 50),
                  height: 37,
                  width: 37,
                  decoration: BoxDecoration(
                      color: ColorResource.color23375A,
                      borderRadius: BorderRadius.circular(25)),
                  child: const CustomLoadingWidget(
                    radius: 11,
                    strokeWidth: 2,
                  ),
                )
                    : Flexible(
                  child: GestureDetector(
                    onTap: () async {
                      if (await Connectivity()
                          .checkConnectivity() !=
                          ConnectivityResult.none) {
                        setState(() {
                          bloc.isGeneratePaymentLinkLoading =
                          true;
                        });
                      } else {
                        AppUtils.noInternetSnackbar(context);
                      }
                      bloc.add(GeneratePaymenLinktEvent(context,
                          caseID: bloc.caseDetailsAPIValue.result!
                              .caseDetails!.caseId!));
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 13),
                      decoration: BoxDecoration(
                        color: ColorResource.color23375A,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                            color: ColorResource.colorECECEC),
                      ),
                      child: CustomText(
                          Languages.of(context)!
                              .generatePaymentLink
                              .toUpperCase(),
                          fontSize: FontSize.eleven,
                          fontWeight: FontWeight.w700,
                          lineHeight: 1.3,
                          color: ColorResource.colorffffff),
                    ),
                  ),
                )
                    : const SizedBox()
                    : const SizedBox(),
              ],
            )
          ],
        ),
      ],
    );
  }

  //Event Details Widgets

  getFileDirectory() async {
    final String dir = ((await getApplicationDocumentsDirectory()).path) +
        '/TemporaryAudioFile.wav';
    setState(() {
      filePath = dir;
    });
  }

  String filePath = '';
  AudioConvertModel audioConvertyData = AudioConvertModel();

  static const MethodChannel platform = MethodChannel('recordAudioChannel');

  ScrollController secondlistScrollController = ScrollController();
  int selectedMonth = 0;

  playAudio(String? audioPath, int index) async {
    setState(() {
      bloc.eventDetailsPlayAudioModel[index].loadingAudio = true;
    });
    final Map<String, dynamic> postResult = await APIRepository.apiRequest(
      APIRequestType.post,
      HttpUrl.getAudioFile,
      requestBodydata: <String, dynamic>{'pathOfFile': audioPath},
    );
    if (postResult[Constants.success]) {
      final AudioConvertModel audioConvertyData =
      AudioConvertModel.fromJson(postResult['data']);
      final String base64 = const Base64Encoder()
          .convert(List<int>.from(audioConvertyData.result!.body!.data!));

      final Uint8List audioBytes = const Base64Codec().decode(base64);
      await File(filePath).writeAsBytes(audioBytes);
      await platform.invokeMethod('playRecordAudio',
          <String, dynamic>{'filePath': filePath}).then((dynamic value) {
        if (value) {
          setState(
                  () =>
              bloc.eventDetailsPlayAudioModel[index].isPlaying = true);
          setState(() =>
          bloc.eventDetailsPlayAudioModel[index].loadingAudio = false);
        }
      });
      await platform.invokeMethod('completeRecordAudio',
          <String, dynamic>{'filePath': filePath}).then((dynamic value) {
        if (value != null) {
          setState(() {
            bloc.eventDetailsPlayAudioModel[index].isPlaying = false;
            bloc.eventDetailsPlayAudioModel[index].isPaused = false;
          });
        }
      });
    } else {
      AppUtils.showErrorToast("Did't get audio file");
    }
    setState(() => bloc.eventDetailsPlayAudioModel[index].loadingAudio = false);
  }

  stopAudio(int index) async {
    await platform.invokeMethod('stopPlayingAudio',
        <String, dynamic>{'filePath': filePath}).then((dynamic value) {
      if (value) {
        setState(() {
          bloc.eventDetailsPlayAudioModel[index].isPlaying = false;
          bloc.eventDetailsPlayAudioModel[index].isPaused = false;
        });
      }
    });
  }

  pauseAudio(int index) async {
    await platform.invokeMethod('pausePlayingAudio',
        <String, dynamic>{'filePath': filePath}).then((dynamic value) {
      if (value) {
        setState(() {
          bloc.eventDetailsPlayAudioModel[index].isPaused = true;
        });
      }
    });
  }

  resumeAudio(int index) async {
    await platform.invokeMethod('resumePlayingAudio',
        <String, dynamic>{'filePath': filePath}).then((dynamic value) {
      if (value) {
        setState(() {
          bloc.eventDetailsPlayAudioModel[index].isPaused = false;
        });
      }
    });
    await platform.invokeMethod('completeRecordAudio',
        <String, dynamic>{'filePath': filePath}).then((dynamic value) {
      if (value != null) {
        setState(() {
          bloc.eventDetailsPlayAudioModel[index].isPlaying = false;
          bloc.eventDetailsPlayAudioModel[index].isPaused = false;
        });
      }
    });
  }

  expandList(List<EvnetDetailsResultsModel> expandedList, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // const SizedBox(
        //   height: 15,
        // ),
        Container(
          margin: const EdgeInsets.only(top: 15, left: 8, right: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: ColorResource.colorF4E8E4,
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 3, 14, 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                if (expandedList[index].createdAt != null)
                  Row(
                    children: [
                      CustomText(
                        DateFormateUtils.followUpDateFormate(
                            expandedList[index].createdAt.toString()),
                        fontSize: FontSize.seventeen,
                        fontWeight: FontWeight.w700,
                        color: ColorResource.color000000,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      EventDetailsAppStatus.eventDetailAppStatus(
                          expandedList[index].eventAttr!.appStatus ?? '')
                    ],
                  ),
                CustomText(
                  expandedList[index].eventType.toString().toUpperCase(),
                  fontWeight: FontWeight.w700,
                  color: ColorResource.color000000,
                ),
                CustomText(
                  '${expandedList[index].eventModule}',
                  fontWeight: FontWeight.w700,
                  color: ColorResource.color000000,
                ),
                if (expandedList[index].createdBy != null)
                  CustomText(
                    '${Languages.of(context)!.agent} : ${expandedList[index]
                        .createdBy}',
                    fontWeight: FontWeight.w700,
                    color: ColorResource.color000000,
                  ),
                if (
                // expandedList[index].eventType?.toLowerCase() ==
                //       Constants.ptp.toLowerCase() &&
                expandedList[index].eventAttr?.ptpAmount != null)
                  CustomText(
                    '${Languages.of(context)!.ptpAmount.replaceAll(
                        '*', '')} : ${expandedList[index].eventAttr?.ptpAmount
                        .toString()}',
                    fontWeight: FontWeight.w700,
                    color: ColorResource.color000000,
                  ),
                if (expandedList[index].eventAttr?.date != null)
                  CustomText(
                    expandedList[index].eventType == 'RECEIPT' ||
                        expandedList[index].eventType == 'TC : RECEIPT'
                        ? '${Languages.of(context)!.date.replaceAll(
                        '*', '')} : ${DateFormateUtils2.followUpDateFormate2(
                        expandedList[index].eventAttr!.date.toString())}'
                        : '${Languages.of(context)!.followUpDate.replaceAll(
                        '*', '')} : ${DateFormateUtils2.followUpDateFormate2(
                        expandedList[index].eventAttr!.date.toString())}',
                    fontWeight: FontWeight.w700,
                    color: ColorResource.color000000,
                  ),
                if (expandedList[index].eventAttr?.time != null)
                  CustomText(
                    '${Languages.of(context)!.time.replaceAll(
                        '*', '')} : ${expandedList[index].eventAttr?.time
                        .toString()}',
                    fontWeight: FontWeight.w700,
                    color: ColorResource.color000000,
                  ),
                if (expandedList[index].eventAttr?.mode != null)
                  CustomText(
                    '${Languages.of(context)!.paymentMode.replaceAll(
                        '*', '')} : ${expandedList[index].eventAttr?.mode
                        .toString()}',
                    fontWeight: FontWeight.w700,
                    color: ColorResource.color000000,
                  ),
                if (expandedList[index].eventAttr?.remarks != null)
                  CustomText(
                    '${Languages.of(context)!.remarks.replaceAll(
                        '*', '')} : ${expandedList[index].eventAttr?.remarks
                        .toString()}',
                    fontWeight: FontWeight.w700,
                    color: ColorResource.color000000,
                  ),
                if (expandedList[index].eventAttr?.amountCollected != null)
                  CustomText(
                    '${Languages.of(context)!.amountCollected.replaceAll(
                        '*', '')}: ${expandedList[index].eventAttr
                        ?.amountCollected.toString()}',
                    fontWeight: FontWeight.w700,
                    color: ColorResource.color000000,
                  ),
                if (expandedList[index].eventAttr?.reminderDate != null)
                  CustomText(
                    '${Languages.of(context)!.followUpDate.replaceAll(
                        '*', '')} : ${DateFormateUtils2.followUpDateFormate2(
                        expandedList[index].eventAttr?.reminderDate
                            .toString() ?? '')}',
                    fontWeight: FontWeight.w700,
                    color: ColorResource.color000000,
                  ),
                if (expandedList[index].eventAttr?.chequeRefNo != null)
                  CustomText(
                    '${Languages.of(context)!.refCheque.replaceAll('*', '')
                        .toLowerCase()
                        .replaceAll('r', 'R')} : ${expandedList[index].eventAttr
                        ?.chequeRefNo.toString()}',
                    fontWeight: FontWeight.w700,
                    color: ColorResource.color000000,
                  ),
                if (expandedList[index].eventAttr?.amntOts != null)
                  CustomText(
                    'OTS ${Languages.of(context)!
                        .amount} : ${expandedList[index].eventAttr?.amntOts
                        .toString()}',
                    fontWeight: FontWeight.w700,
                    color: ColorResource.color000000,
                  ),
                if (expandedList[index].eventAttr?.nextActionDate != null)
                  CustomText(
                    '${Languages.of(context)!.followUpDate.replaceAll(
                        '*', '')} : ${DateFormateUtils2.followUpDateFormate2(
                        expandedList[index].eventAttr?.nextActionDate
                            .toString() ?? '')}',
                    fontWeight: FontWeight.w700,
                    color: ColorResource.color000000,
                  ),
                if (expandedList[index].eventAttr?.actionDate != null)
                  CustomText(
                    '${Languages.of(context)!.followUpDate.replaceAll(
                        '*', '')} : ${DateFormateUtils2.followUpDateFormate2(
                        expandedList[index].eventAttr?.actionDate.toString() ??
                            '')}',
                    fontWeight: FontWeight.w700,
                    color: ColorResource.color000000,
                  ),
                if (expandedList[index].eventAttr?.reasons != null)
                  CustomText(
                    '${Languages.of(context)!.rtpDenialReason.replaceAll(
                        '*', '')} : ${expandedList[index].eventAttr?.reasons
                        .toString() ?? ''}',
                    fontWeight: FontWeight.w700,
                    color: ColorResource.color000000,
                  ),
                if (expandedList[index].eventAttr?.disputereasons != null)
                  CustomText(
                    '${Languages.of(context)!.disputeReason.replaceAll(
                        '*', '')} : ${expandedList[index].eventAttr
                        ?.disputereasons.toString() ?? ''}',
                    fontWeight: FontWeight.w700,
                    color: ColorResource.color000000,
                  ),
                if (expandedList[index].eventAttr?.remarkOts != null)
                  CustomText(
                    '${Languages.of(context)!.remarks.replaceAll(
                        '*', '')} : ${expandedList[index].eventAttr?.remarkOts
                        .toString()}',
                    fontWeight: FontWeight.w700,
                    color: ColorResource.color000000,
                  ),
                if (expandedList[index].eventType == Constants.repo)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (expandedList[index].eventAttr?.modelMake != null)
                        CustomText(
                          '${Languages.of(context)!.modelMake.replaceAll(
                              '*', '')} : ${expandedList[index].eventAttr!
                              .modelMake}',
                          fontWeight: FontWeight.w700,
                          color: ColorResource.color000000,
                        ),
                      if (expandedList[index].eventAttr?.chassisNo != null)
                        CustomText(
                          '${Languages.of(context)!.chassisNo.replaceAll(
                              '*', '')} : ${expandedList[index].eventAttr!
                              .chassisNo}',
                          fontWeight: FontWeight.w700,
                          color: ColorResource.color000000,
                        ),
                      if (expandedList[index].eventAttr?.vehicleRegNo != null)
                        CustomText(
                          '${Languages.of(context)!
                              .vehicleRegistrationNo} : ${expandedList[index]
                              .eventAttr!.vehicleRegNo}',
                          fontWeight: FontWeight.w700,
                          color: ColorResource.color000000,
                        ),
                      if (expandedList[index].eventAttr?.dealerName != null)
                        CustomText(
                          '${Languages.of(context)!
                              .dealerName} : ${expandedList[index].eventAttr!
                              .dealerName}',
                          fontWeight: FontWeight.w700,
                          color: ColorResource.color000000,
                        ),
                      if (expandedList[index].eventAttr?.dealerAddress != null)
                        CustomText(
                          '${Languages.of(context)!
                              .dealerAddress} : ${expandedList[index].eventAttr!
                              .dealerAddress}',
                          fontWeight: FontWeight.w700,
                          color: ColorResource.color000000,
                        ),
                      if (expandedList[index].eventAttr?.ref1 != null)
                        CustomText(
                          '${Languages.of(context)!
                              .referenceOneName} ${expandedList[index]
                              .eventAttr!.ref1}',
                          fontWeight: FontWeight.w700,
                          color: ColorResource.color000000,
                        ),
                      if (expandedList[index].eventAttr?.ref1No != null)
                        CustomText(
                          '${Languages.of(context)!
                              .referenceOneNo}: ${expandedList[index].eventAttr!
                              .ref1No}',
                          fontWeight: FontWeight.w700,
                          color: ColorResource.color000000,
                        ),
                      if (expandedList[index].eventAttr?.ref2 != null)
                        CustomText(
                          '${Languages.of(context)!
                              .referenceTwoName}: ${expandedList[index]
                              .eventAttr!.ref2}',
                          fontWeight: FontWeight.w700,
                          color: ColorResource.color000000,
                        ),
                      if (expandedList[index].eventAttr?.ref2No != null)
                        CustomText(
                          '${Languages.of(context)!
                              .referenceTwoNo}: ${expandedList[index].eventAttr!
                              .ref2No}',
                          fontWeight: FontWeight.w700,
                          color: ColorResource.color000000,
                        ),
                      if (expandedList[index]
                          .eventAttr
                          ?.vehicleIdentificationNo !=
                          null)
                        CustomText(
                          '${Languages.of(context)!
                              .vehicleIdentificationNo}: ${expandedList[index]
                              .eventAttr!.vehicleIdentificationNo}',
                          fontWeight: FontWeight.w700,
                          color: ColorResource.color000000,
                        ),
                      if (expandedList[index].eventAttr?.batteryID != null)
                        CustomText(
                          '${Languages.of(context)!
                              .batterId}: ${expandedList[index].eventAttr!
                              .batteryID}',
                          fontWeight: FontWeight.w700,
                          color: ColorResource.color000000,
                        ),
                    ],
                  ),
                if (expandedList[index].eventAttr?.reginalText != null &&
                    expandedList[index].eventAttr?.translatedText != null &&
                    expandedList[index].eventAttr?.audioS3Path != null)
                  remarkS2TaudioWidget(
                    reginalText: expandedList[index].eventAttr?.reginalText,
                    translatedText:
                    expandedList[index].eventAttr?.translatedText,
                    audioPath: expandedList[index].eventAttr?.audioS3Path,
                    index: index,
                  ),
                appStatus(expandedList[index].eventAttr!.appStatus ?? ''),
                if (expandedList[index].eventAttr?.imageLocation?.isEmpty ==
                    false)
                  SizedBox(
                    height: 200,
                    child: Image.memory(
                      base64Decode(
                          expandedList[index].eventAttr?.imageLocation?[0] ??
                              ''),
                      fit: BoxFit.fitWidth,
                    ),
                  )
              ],
            ),
          ),
        ),
      ],
    );
  }

  appStatus(status) {
    Widget? returnWidget;
    switch (status) {
      case 'approved':
        returnWidget = appStatusText(ColorResource.green, 'Approved');
        break;
      case 'new':
        returnWidget = appStatusText(ColorResource.orange, 'Awaiting Approval');
        break;
      case 'pending':
        returnWidget = appStatusText(ColorResource.orange, 'Awaiting Approval');
        break;
      case 'rejected':
        returnWidget = appStatusText(ColorResource.red, 'Rejected');
        break;
      default:
        returnWidget = const SizedBox();
        break;
    }
    return returnWidget;
  }

  Widget appStatusText(Color color, String value) {
    return Padding(
      padding: const EdgeInsets.only(top: 13),
      child: CustomText(
        value,
        color: color,
        fontWeight: FontWeight.w500,
        fontSize: FontSize.sixteen,
      ),
    );
  }

  remarkS2TaudioWidget({
    String? reginalText,
    String? translatedText,
    String? audioPath,
    required int index,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 9),
        Row(
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                  color: ColorResource.color23375A,
                  borderRadius: BorderRadius.all(Radius.circular(60.0))),
              height: 40,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 11,
                  ),
                  child: CustomText(
                    Languages.of(context)!.remarksRecording,
                    color: ColorResource.colorFFFFFF,
                    lineHeight: 1,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            GestureDetector(
              onTap: () {
                bloc.eventDetailsPlayAudioModel[index].isPlaying
                    ? stopAudio(index)
                    : playAudio(audioPath, index);
              },
              child: CircleAvatar(
                backgroundColor: ColorResource.color23375A,
                radius: 20,
                child: Center(
                  child: bloc.eventDetailsPlayAudioModel[index].loadingAudio
                      ? CustomLoadingWidget(
                    radius: 11,
                    strokeWidth: 3.0,
                    gradientColors: <Color>[
                      ColorResource.colorFFFFFF,
                      ColorResource.colorFFFFFF.withOpacity(0.7),
                    ],
                  )
                      : Icon(
                    bloc.eventDetailsPlayAudioModel[index].isPlaying
                        ? Icons.stop
                        : Icons.play_arrow,
                    color: ColorResource.colorFFFFFF,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            if (bloc.eventDetailsPlayAudioModel[index].isPlaying)
              GestureDetector(
                onTap: () {
                  bloc.eventDetailsPlayAudioModel[index].isPaused
                      ? resumeAudio(index)
                      : pauseAudio(index);
                },
                child: CircleAvatar(
                  backgroundColor: ColorResource.color23375A,
                  radius: 20,
                  child: Center(
                    child: Icon(
                      bloc.eventDetailsPlayAudioModel[index].isPaused
                          ? Icons.play_arrow
                          : Icons.pause,
                      color: ColorResource.colorFFFFFF,
                    ),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 12),
        const CustomText(
          Constants.reginalText,
          fontWeight: FontWeight.w700,
          color: ColorResource.color000000,
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 13),
          decoration: const BoxDecoration(
              color: ColorResource.colorF7F8FA,
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          child: CustomText(
            reginalText!,
            color: ColorResource.color000000,
            lineHeight: 1,
          ),
        ),
        const SizedBox(height: 12),
        const CustomText(
          Constants.translatedText,
          fontWeight: FontWeight.w700,
          color: ColorResource.color000000,
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 13),
          decoration: const BoxDecoration(
              color: ColorResource.colorF7F8FA,
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          child: CustomText(
            translatedText!,
            color: ColorResource.color000000,
            lineHeight: 1,
          ),
        ),
      ],
    );
  }
}
