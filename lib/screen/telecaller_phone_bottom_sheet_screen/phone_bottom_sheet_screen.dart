import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/screen/allocation/bloc/allocation_bloc.dart';
import 'package:origa/screen/case_details_screen/bloc/case_details_bloc.dart';
import 'package:origa/screen/collection_screen/collections_bottom_sheet.dart';
import 'package:origa/screen/dispute_screen/dispute_bottom_sheet.dart';
import 'package:origa/screen/other_feed_back_screen/other_feed_back_bottom_sheet.dart';
import 'package:origa/screen/ots_screen/ots_bottom_sheet.dart';
import 'package:origa/screen/ptp_screen/ptp_bottom_sheet.dart';
import 'package:origa/screen/remainder_screen/remainder_bottom_sheet.dart';
import 'package:origa/screen/rtp_screen/rtp_bottom_sheet.dart';
import 'package:origa/screen/telecaller_phone_bottom_sheet_screen/bloc/telecaller_phone_bloc.dart';
import 'package:origa/screen/telecaller_phone_bottom_sheet_screen/telecaller_phone_connected_screen.dart';
import 'package:origa/screen/telecaller_phone_bottom_sheet_screen/telecaller_phone_invalid_screen.dart';
import 'package:origa/screen/telecaller_phone_bottom_sheet_screen/telecaller_unreachable_screen.dart';
import 'package:origa/singleton.dart';
import 'package:origa/utils/app_utils.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/constant_event_values.dart';
import 'package:origa/utils/constants.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/widgets/bottomsheet_appbar.dart';
import 'package:origa/widgets/custom_button.dart';
import 'package:origa/widgets/custom_loading_widget.dart';
import 'package:origa/widgets/custom_loan_user_details.dart';
import 'package:origa/widgets/custom_text.dart';
import 'package:origa/widgets/health_status_widget.dart';

class TelecallerPhoneScreen extends StatefulWidget {
  final String caseId;
  final dynamic contactValue;
  final String? userName;
  final String? userId;
  final dynamic userAmount;
  const TelecallerPhoneScreen({
    Key? key,
    required this.caseId,
    this.contactValue,
    required this.userId,
    required this.userName,
    required this.userAmount,
  }) : super(key: key);

  @override
  _TelecallerPhoneScreenState createState() => _TelecallerPhoneScreenState();
}

class _TelecallerPhoneScreenState extends State<TelecallerPhoneScreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  late TelecallerPhoneBloc bloc;

  bool isSubmitFirst = true;
  bool isSubmitSecond = true;

  _handleTabSelection() {
    if (_controller.indexIsChanging) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();

    bloc = TelecallerPhoneBloc()
      ..add(TelecallerInitialPhoneEvent(
          context, widget.caseId, widget.contactValue));
    _controller = TabController(vsync: this, length: 3);
    _controller.addListener(_handleTabSelection);

    // widget.bloc.add(UpdateHealthStatusEvent(context,
    //     selectedHealthIndex: widget.index,
    //     tabIndex: _controller.index,
    //     currentHealth: widget.bloc.caseDetailsAPIValue.result
    //         ?.callDetails![widget.index]['health']));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TelecallerPhoneBloc, TelecallerPhoneState>(
      bloc: bloc,
      listener: (context, state) {
        if (state is TcDisableUnreachableBtnState) {
          setState(() => isSubmitFirst = false);
        }
        if (state is TcEnableUnreachableBtnState) {
          setState(() => isSubmitFirst = true);
        }
        if (state is DisablePhoneInvalidBtnState) {
          setState(() => isSubmitSecond = false);
        }
        if (state is EnablePhoneInvalidBtnState) {
          setState(() => isSubmitSecond = true);
        }
        if (state is PostDataApiSuccessState) {
          AppUtils.topSnackBar(context, Constants.eventUpdatedSuccess);
          // Navigator.pop(context);
        }
        if (state is TcClickOpenBottomSheetState) {
          print('djd');
          openBottomSheet(context, state.title, state.list, state.isCall,
              health: state.health);
        }

        // if (state is UpdateHealthStatusState) {
        //   print(
        //       "data of new health ==> ${Singleton.instance.updateHealthStatus}");
        //   UpdateHealthStatusModel data = UpdateHealthStatusModel.fromJson(
        //       Map<String, dynamic>.from(Singleton.instance.updateHealthStatus));

        //   setState(() {
        //     switch (data.tabIndex) {
        //       case 0:
        //         widget.bloc.caseDetailsAPIValue.result
        //             ?.callDetails![data.selectedHealthIndex!]['health'] = '2';
        //         break;
        //       case 1:
        //         widget.bloc.caseDetailsAPIValue.result
        //             ?.callDetails![data.selectedHealthIndex!]['health'] = '1';
        //         break;
        //       case 2:
        //         widget.bloc.caseDetailsAPIValue.result
        //             ?.callDetails![data.selectedHealthIndex!]['health'] = '0';
        //         break;
        //       default:
        //         widget.bloc.caseDetailsAPIValue.result
        //                 ?.callDetails![data.selectedHealthIndex!]['health'] =
        //             data.currentHealth;
        //         break;
        //     }
        //   });
        // }
      },
      child: BlocBuilder<TelecallerPhoneBloc, TelecallerPhoneState>(
        bloc: bloc,
        builder: (context, state) {
          if (state is TelecallerPhoneLoadingState) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.89,
              child: Scaffold(
                  backgroundColor: Colors.transparent,
                  body: Container(
                    decoration: BoxDecoration(
                        color: ColorResource.colorFFFFFF,
                        boxShadow: [
                          BoxShadow(
                              color: ColorResource.colorCACACA.withOpacity(.25),
                              blurRadius: 30.0,
                              offset: const Offset(1.0, 1.0)),
                        ],
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(30))),
                    width: double.infinity,
                    child: const CustomLoadingWidget(),
                  )),
            );
          } else {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.89,
              child: MediaQuery.removePadding(
                context: context,
                removeBottom: true,
                removeTop: true,
                child: Scaffold(
                  backgroundColor: Colors.transparent,
                  body: Container(
                    decoration: BoxDecoration(
                        color: ColorResource.colorFFFFFF,
                        boxShadow: [
                          BoxShadow(
                              color: ColorResource.colorCACACA.withOpacity(.25),
                              blurRadius: 30.0,
                              offset: const Offset(1.0, 1.0)),
                        ],
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(30))),
                    width: double.infinity,
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.fromLTRB(22, 26, 22, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CustomText(
                                    'mobile'.toUpperCase(),
                                    fontWeight: FontWeight.w700,
                                    fontSize: FontSize.fourteen,
                                    fontStyle: FontStyle.normal,
                                    color: ColorResource.color23375A,
                                  ),
                                  Wrap(
                                    spacing: 27,
                                    children: [
                                      // SvgPicture.asset(ImageResource.activePerson),
                                      ShowHealthStatus.healthStatus(
                                          // widget
                                          //     .bloc.isAutoCalling
                                          // ?
                                          '0'
                                          // : widget
                                          //         .bloc
                                          //         .caseDetailsAPIValue
                                          //         .result
                                          //         ?.callDetails![widget.index]
                                          //     ['health']
                                          ),
                                      GestureDetector(
                                        onTap: () => Navigator.pop(context),
                                        child: Container(
                                          padding: const EdgeInsets.all(2),
                                          child: SvgPicture.asset(
                                              ImageResource.close),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Flexible(
                                child: SizedBox(
                                  width: 255,
                                  child: CustomText(
                                    bloc.contactValue?.value ?? '_',
                                    fontWeight: FontWeight.w400,
                                    fontSize: FontSize.fourteen,
                                    fontStyle: FontStyle.normal,
                                    color: ColorResource.color23375A,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      child: SizedBox(
                                          width: 10,
                                          child: InkWell(
                                            // onTap: () => widget.bloc.add(
                                            //     ClickOpenBottomSheetEvent(
                                            //         Constants.callCustomer,
                                            //         widget
                                            //             .bloc
                                            //             .caseDetailsAPIValue
                                            //             .result
                                            //             ?.callDetails,
                                            //         false)),
                                            child: Container(
                                                decoration: const BoxDecoration(
                                                    color: ColorResource
                                                        .colorBEC4CF,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                75.0))),
                                                child: Row(
                                                  children: [
                                                    CircleAvatar(
                                                      backgroundColor:
                                                          ColorResource
                                                              .color23375A,
                                                      radius: 20,
                                                      child: Center(
                                                        child: SvgPicture.asset(
                                                          ImageResource.phone,
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 12),
                                                    CustomText(
                                                      Languages.of(context)!
                                                          .call
                                                          .toUpperCase(),
                                                      fontSize:
                                                          FontSize.fourteen,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: ColorResource
                                                          .color23375A,
                                                    )
                                                  ],
                                                )),
                                          ))),
                                  const SizedBox(width: 40),
                                  Expanded(
                                      child: SizedBox(
                                    height: 45,
                                    child: CustomButton(
                                      // Languages.of(context)!.eventDetails,
                                      null,
                                      isTrailing: true,
                                      leadingWidget: CustomText(
                                        Languages.of(context)!.eventDetails,
                                        fontSize: FontSize.twelve,
                                        color: ColorResource.color23375A,
                                        lineHeight: 1,
                                        fontWeight: FontWeight.w700,
                                        fontStyle: FontStyle.normal,
                                      ),
                                      // onTap: () => widget.bloc.add(
                                      //     ClickOpenBottomSheetEvent(
                                      //         Constants.eventDetails,
                                      //         widget.bloc.caseDetailsAPIValue
                                      //             .result?.callDetails,
                                      //         false)),
                                      borderColor: ColorResource.color23375A,
                                      buttonBackgroundColor:
                                          ColorResource.colorFFFFFF,
                                    ),
                                  ))
                                ],
                              )
                            ],
                          ),
                        ),
                        Container(
                          decoration: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: ColorResource.colorD8D8D8))),
                          child: TabBar(
                            controller: _controller,
                            physics: const NeverScrollableScrollPhysics(),
                            isScrollable: true,
                            indicatorColor: ColorResource.colorD5344C,
                            // onTap: (index) {
                            //   // change address health status based on selected tab customer met / customer not met / invalid
                            //   widget.bloc.add(UpdateHealthStatusEvent(context,
                            //       selectedHealthIndex: widget.index,
                            //       tabIndex: index,
                            //       currentHealth: widget
                            //           .bloc
                            //           .caseDetailsAPIValue
                            //           .result
                            //           ?.callDetails![widget.index]['health']));

                            //   widget
                            //       .bloc.phoneUnreachableNextActionDateFocusNode
                            //       .unfocus();
                            //   widget.bloc.phoneUnreachableRemarksFocusNode
                            //       .unfocus();
                            //   widget.bloc.phoneInvalidRemarksFocusNode
                            //       .unfocus();
                            // },
                            labelStyle: const TextStyle(
                                fontWeight: FontWeight.w700,
                                color: ColorResource.color23375A,
                                fontSize: FontSize.fourteen,
                                fontStyle: FontStyle.normal),
                            indicatorWeight: 5.0,
                            labelColor: ColorResource.color23375A,
                            unselectedLabelColor: ColorResource.colorC4C4C4,
                            tabs: [
                              Tab(text: Languages.of(context)!.connected),
                              Tab(text: Languages.of(context)!.unreachable),
                              Tab(text: Languages.of(context)!.invalid)
                            ],
                          ),
                        ),
                        Expanded(
                            child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Column(children: [
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.65,
                                  child: TabBarView(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    controller: _controller,
                                    children: [
                                      TelecallerPhoneConnectedScreen(
                                          bloc: bloc, context: context),
                                      TelecallerPhoneUnreachableScreen(
                                          bloc: bloc, context: context),
                                      TelecallerPhonenInvalidScreen(
                                          bloc: bloc, context: context),
                                    ],
                                  ),
                                ),
                              ])
                            ],
                          ),
                        ))
                      ],
                    ),
                  ),
                  bottomNavigationBar: _controller.index == 0
                      ? Container(
                          height: 75,
                          decoration: BoxDecoration(
                            color: ColorResource.colorFFFFFF,
                            boxShadow: [
                              BoxShadow(
                                color:
                                    ColorResource.color000000.withOpacity(.25),
                                blurRadius: 2.0,
                                offset: const Offset(1.0, 1.0),
                              ),
                            ],
                          ),
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 11.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 190,
                                  child: CustomButton(
                                    Languages.of(context)!.done.toUpperCase(),
                                    fontSize: FontSize.sixteen,
                                    fontWeight: FontWeight.w600,
                                    // onTap: () {
                                    //   if (widget.bloc.isAutoCalling) {
                                    //     widget.bloc.allocationBloc
                                    //         .add(StartCallingEvent(
                                    //       customerIndex: widget.bloc
                                    //               .paramValue['customerIndex'] +
                                    //           1,
                                    //       phoneIndex: 0,
                                    //       isIncreaseCount: true,
                                    //     ));
                                    //   }
                                    //   Navigator.pop(context);
                                    // },
                                    cardShape: 5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Container(
                          height: 75,
                          decoration: BoxDecoration(
                            color: ColorResource.colorFFFFFF,
                            boxShadow: [
                              BoxShadow(
                                color:
                                    ColorResource.color000000.withOpacity(.25),
                                blurRadius: 2.0,
                                offset: const Offset(1.0, 1.0),
                              ),
                            ],
                          ),
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                    width: 95,
                                    child: Center(
                                        child: CustomText(
                                      Languages.of(context)!
                                          .cancel
                                          .toUpperCase(),
                                      onTap: () => Navigator.pop(context),
                                      color: ColorResource.colorEA6D48,
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FontStyle.normal,
                                      fontSize: FontSize.sixteen,
                                    ))),
                                const SizedBox(width: 25),
                                SizedBox(
                                  width: 191,
                                  child: _controller.index == 1
                                      ? CustomButton(
                                          isSubmitFirst
                                              ? Languages.of(context)!
                                                  .submit
                                                  .toUpperCase()
                                              : null,
                                          isLeading: !isSubmitFirst,
                                          trailingWidget: CustomLoadingWidget(
                                            gradientColors: [
                                              ColorResource.colorFFFFFF,
                                              ColorResource.colorFFFFFF
                                                  .withOpacity(0.7),
                                            ],
                                          ),
                                          fontSize: FontSize.sixteen,
                                          fontWeight: FontWeight.w600,
                                          onTap: isSubmitFirst
                                              ? () {
                                                  if (bloc
                                                      .phoneUnreachableFormKey
                                                      .currentState!
                                                      .validate()) {
                                                    if (bloc.phoneSelectedUnreadableClip !=
                                                        '') {
                                                      bloc.add(
                                                          ClickTcPhoneUnreachableSubmitedButtonEvent(
                                                              context));
                                                    } else {
                                                      AppUtils.showToast(Constants
                                                          .pleaseSelectOptions);
                                                    }
                                                  }
                                                }
                                              : () {},
                                          cardShape: 5,
                                        )
                                      : CustomButton(
                                          isSubmitSecond
                                              ? Languages.of(context)!
                                                  .submit
                                                  .toUpperCase()
                                              : null,
                                          isLeading: !isSubmitSecond,
                                          trailingWidget: CustomLoadingWidget(
                                            gradientColors: [
                                              ColorResource.colorFFFFFF,
                                              ColorResource.colorFFFFFF
                                                  .withOpacity(0.7),
                                            ],
                                          ),
                                          fontSize: FontSize.sixteen,
                                          fontWeight: FontWeight.w600,
                                          onTap: isSubmitSecond
                                              ? () {
                                                  bloc.add(
                                                      ClickTcPhoneInvalidButtonEvent(
                                                          context));
                                                }
                                              : () {},
                                          cardShape: 5,
                                        ),
                                ),
                              ],
                            ),
                          ),
                        ),
                ),
              ),
            );
          }
        },
      ),
    );
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
          top: Radius.circular(30),
        ),
      ),
      builder: (BuildContext context) {
        Map<String, dynamic> paramValues = Map<String, dynamic>.from(
            jsonDecode(jsonEncode(bloc.contactValue)) as Map<String, dynamic>);
        switch (cardTitle) {
          case Constants.ptp:
            return CustomPtpBottomSheet(
              Languages.of(context)!.ptp,
              caseId: bloc.caseId.toString(),
              customerLoanUserWidget: CustomLoanUserDetails(
                userName: widget.userName ?? '',
                userId: widget.userId ?? '',
                userAmount: widget.userAmount?.toDouble() ?? 0.0,
              ),
              userType: Singleton.instance.usertype!,
              postValue: paramValues,
              isCall: isCall,
              bloc: CaseDetailsBloc(AllocationBloc()),
            );
          case Constants.rtp:
            return CustomRtpBottomSheet(
              Languages.of(context)!.rtp,
              caseId: bloc.caseId.toString(),
              customerLoanUserWidget: const CustomLoanUserDetails(
                userName:
                    // bloc.caseDetailsAPIValue.result?.caseDetails?.cust ??
                    '',
                userId: 'jdkjd',
                // '${bloc.caseDetailsAPIValue.result?.caseDetails?.bankName} / ${bloc.caseDetailsAPIValue.result?.caseDetails?.agrRef}',
                userAmount:
                    //  bloc.caseDetailsAPIValue.result?.caseDetails?.due
                    //         ?.toDouble() ??
                    0.0,
              ),
              userType: Singleton.instance.usertype!,
              postValue: paramValues,
              isCall: isCall,
              bloc: CaseDetailsBloc(AllocationBloc()),
              // bloc: widget.bloc,
            );
          case Constants.dispute:
            return CustomDisputeBottomSheet(
              Languages.of(context)!.dispute,
              caseId: bloc.caseId.toString(),
              customerLoanUserWidget: const CustomLoanUserDetails(
                userName:
                    // bloc.caseDetailsAPIValue.result?.caseDetails?.cust ??
                    '',
                userId: 'jdkjd',
                // '${bloc.caseDetailsAPIValue.result?.caseDetails?.bankName} / ${bloc.caseDetailsAPIValue.result?.caseDetails?.agrRef}',
                userAmount:
                    //  bloc.caseDetailsAPIValue.result?.caseDetails?.due
                    //         ?.toDouble() ??
                    0.0,
              ),
              userType: Singleton.instance.usertype!,
              postValue: paramValues,
              isCall: isCall,
              bloc: CaseDetailsBloc(AllocationBloc()),
            );
          case Constants.remainder:
            return CustomRemainderBottomSheet(
              Languages.of(context)!.remainderCb,
              caseId: bloc.caseId.toString(),
              customerLoanUserWidget: const CustomLoanUserDetails(
                userName:
                    // bloc.caseDetailsAPIValue.result?.caseDetails?.cust ??
                    '',
                userId: 'jdkjd',
                // '${bloc.caseDetailsAPIValue.result?.caseDetails?.bankName} / ${bloc.caseDetailsAPIValue.result?.caseDetails?.agrRef}',
                userAmount:
                    //  bloc.caseDetailsAPIValue.result?.caseDetails?.due
                    //         ?.toDouble() ??
                    0.0,
              ),
              userType: Singleton.instance.usertype!,
              postValue: paramValues,

              isCall: isCall,
              bloc: CaseDetailsBloc(AllocationBloc()),
              // eventCode: bloc.eventCode,
            );
          case Constants.collections:
            return CustomCollectionsBottomSheet(
              Languages.of(context)!.collections,
              caseId: bloc.caseId.toString(),
              customerLoanUserWidget: const CustomLoanUserDetails(
                userName:
                    // bloc.caseDetailsAPIValue.result?.caseDetails?.cust ??
                    '',
                userId: 'jdkjd',
                // '${bloc.caseDetailsAPIValue.result?.caseDetails?.bankName} / ${bloc.caseDetailsAPIValue.result?.caseDetails?.agrRef}',
                userAmount:
                    //  bloc.caseDetailsAPIValue.result?.caseDetails?.due
                    //         ?.toDouble() ??
                    0.0,
              ),
              isCall: isCall,
              userType: Singleton.instance.usertype!,
              postValue: paramValues,
              bloc: CaseDetailsBloc(AllocationBloc()),
              custName:
                  // bloc.caseDetailsAPIValue.result?.caseDetails?.cust ??
                  '',
            );
          case Constants.ots:
            return CustomOtsBottomSheet(
              Languages.of(context)!.ots,
              customerLoanUserWidget: const CustomLoanUserDetails(
                userName:
                    // bloc.caseDetailsAPIValue.result?.caseDetails?.cust ??
                    '',
                userId: 'jdkjd',
                // '${bloc.caseDetailsAPIValue.result?.caseDetails?.bankName} / ${bloc.caseDetailsAPIValue.result?.caseDetails?.agrRef}',
                userAmount:
                    //  bloc.caseDetailsAPIValue.result?.caseDetails?.due
                    //         ?.toDouble() ??
                    0.0,
              ),
              caseId: bloc.caseId.toString(),
              userType: Singleton.instance.usertype!,
              isCall: isCall,
              postValue: paramValues,
              bloc: CaseDetailsBloc(AllocationBloc()),
            );

          case Constants.otherFeedback:
            return CustomOtherFeedBackBottomSheet(
              Languages.of(context)!.otherFeedBack,
              CaseDetailsBloc(AllocationBloc()),
              caseId: bloc.caseId.toString(),
              customerLoanUserWidget: const CustomLoanUserDetails(
                userName:
                    // bloc.caseDetailsAPIValue.result?.caseDetails?.cust ??
                    '',
                userId: 'jdkjd',
                // '${bloc.caseDetailsAPIValue.result?.caseDetails?.bankName} / ${bloc.caseDetailsAPIValue.result?.caseDetails?.agrRef}',
                userAmount:
                    //  bloc.caseDetailsAPIValue.result?.caseDetails?.due
                    //         ?.toDouble() ??
                    0.0,
              ),
              userType: Singleton.instance.usertype!,
              postValue: paramValues,
              isCall: isCall,
              health: health ?? ConstantEventValues.healthTwo,
            );
          case Constants.eventDetails:
          // return CustomEventDetailsBottomSheet(
          //   Languages.of(context)!.eventDetails,
          //   bloc,
          //   customeLoanUserWidget: CustomLoanUserDetails(
          //     userName:
          //         bloc.caseDetailsAPIValue.result?.caseDetails?.cust ?? '',
          //     userId:
          //         '${bloc.caseDetailsAPIValue.result?.caseDetails?.bankName} / ${bloc.caseDetailsAPIValue.result?.caseDetails?.agrRef}',
          //     userAmount: bloc.caseDetailsAPIValue.result?.caseDetails?.due
          //             ?.toDouble() ??
          //         0.0,
          //   ),
          // );
          case Constants.addressDetails:
          // return AddressDetailsBottomSheetScreen(bloc: bloc);
          case Constants.callDetails:
          // return CallDetailsBottomSheetScreen(bloc: bloc);
          case Constants.callCustomer:
          // List<String> s1 = [];
          // bloc.caseDetailsAPIValue.result?.callDetails?.forEach((element) {
          //   if (element['cType'].contains('mobile')) {
          //     if (!(s1.contains(element['value']))) {
          //       s1.add(element['value']);
          //     }
          //   } else {}
          // });

          // return CallCustomerBottomSheet(
          //   customerLoanUserWidget: CustomLoanUserDetails(
          //     userName:
          //         bloc.caseDetailsAPIValue.result?.caseDetails?.cust ?? '',
          //     userId:
          //         '${bloc.caseDetailsAPIValue.result?.caseDetails?.bankName} / ${bloc.caseDetailsAPIValue.result?.caseDetails?.agrRef}',
          //     userAmount: bloc.caseDetailsAPIValue.result?.caseDetails?.due
          //             ?.toDouble() ??
          //         0.0,
          //   ),
          //   listOfMobileNo: s1,
          //   userType: bloc.userType.toString(),
          //   caseId: bloc.caseId.toString(),
          //   sid: bloc.caseDetailsAPIValue.result!.caseDetails!.id.toString(),
          // );

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
}
