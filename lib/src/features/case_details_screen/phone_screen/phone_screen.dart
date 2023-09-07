import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/models/contractor_information_model.dart';
import 'package:origa/models/update_health_model.dart';
import 'package:origa/screen/case_details_screen/phone_screen/connected_screen.dart';
import 'package:origa/screen/case_details_screen/phone_screen/invalid_screen.dart';
import 'package:origa/screen/case_details_screen/phone_screen/unreachable_screen.dart';
import 'package:origa/singleton.dart';
import 'package:origa/src/features/case_details_screen/bloc/case_details_bloc.dart';
import 'package:origa/utils/app_utils.dart';
import 'package:origa/utils/call_status_utils.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/constants.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/widgets/custom_button.dart';
import 'package:origa/widgets/custom_cancel_button.dart';
import 'package:origa/widgets/custom_loading_widget.dart';
import 'package:origa/widgets/custom_text.dart';
import 'package:origa/widgets/health_status_widget.dart';

class PhoneScreen extends StatefulWidget {
  const PhoneScreen(
      {Key? key,
      required this.bloc,
      required this.index,
      this.isCallFromCaseDetails = false,
      this.callId,
      this.customerLoanUserWidget})
      : super(key: key);
  final CaseDetailsBloc bloc;
  final bool isCallFromCaseDetails;
  final int index;
  final String? callId;
  final Widget? customerLoanUserWidget;

  @override
  _PhoneScreenState createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

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
    widget.bloc.add(PhoneBottomSheetInitialEvent(
      context: context,
      isCallFromCaseDetails: widget.isCallFromCaseDetails,
      callId: widget.callId,
    ));
    // bloc = PhoneScreenBloc()
    //   ..add(PhoneScreenBottomSheetIntialEvent(
    //       context: context, caseDetailsBloc: widget.bloc));
    _controller = TabController(vsync: this, length: 3);
    _controller.addListener(_handleTabSelection);

    widget.bloc.add(UpdateHealthStatusEvent(context,
        selectedHealthIndex: widget.index,
        tabIndex: _controller.index,
        currentHealth: widget
            .bloc.caseDetailsAPIValue.callDetails![widget.index]['health']));
    /* if agent doesn't get the call from VOIP -> after 30 seconds it'll
    move next index of number (maybe next case or nex number of current case)  */
    if (widget.bloc.isAutoCalling) {
      Future<void>.delayed(const Duration(seconds: 30), () {
        debugPrint('Screen Navigate after 30 sec--> ');
        autoCallingTriggering();
      });
    }
  }

  Future<void> autoCallingTriggering() async {
    if (await CallCustomerStatus.callStatusCheckForAutoJump(
        callId: widget.bloc.paramValue['callId'], context: context)) {
      // widget.bloc.allocationBloc.add(StartCallingEvent(
      //   customerIndex: widget.bloc.paramValue['customerIndex'] + 1,
      //   phoneIndex: 0,
      //   isIncreaseCount: true,
      // ));
      AppUtils.showToast(
        'Call will connect next customer/next number',
      );
      Navigator.pop(context);
    }
  }

  Future<bool> willPopCallback() async {
    return widget.bloc.isAutoCalling
        ? false
        : !(Singleton.instance.startCalling ?? true)
            ? false
            : true;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CaseDetailsBloc, CaseDetailsState>(
      bloc: widget.bloc,
      listener: (BuildContext context, CaseDetailsState state) {
        if (state is DisableUnreachableBtnState) {
          setState(() => isSubmitFirst = false);
        }
        if (state is EnableUnreachableBtnState) {
          setState(() => isSubmitFirst = true);
        }
        if (state is DisablePhoneInvalidBtnState) {
          setState(() => isSubmitSecond = false);
        }
        if (state is EnablePhoneInvalidBtnState) {
          setState(() => isSubmitSecond = true);
        }

        if (state is UpdateHealthStatusState) {
          final UpdateHealthStatusModel data = UpdateHealthStatusModel.fromJson(
              Map<String, dynamic>.from(Singleton.instance.updateHealthStatus));

          setState(() {
            switch (data.tabIndex) {
              case 0:
                widget.bloc.caseDetailsAPIValue
                    .callDetails![data.selectedHealthIndex!]['health'] = '2';
                break;
              case 1:
                widget.bloc.caseDetailsAPIValue
                    .callDetails![data.selectedHealthIndex!]['health'] = '1';
                break;
              case 2:
                widget.bloc.caseDetailsAPIValue
                    .callDetails![data.selectedHealthIndex!]['health'] = '0';
                break;
              default:
                widget.bloc.caseDetailsAPIValue
                        .callDetails![data.selectedHealthIndex!]['health'] =
                    data.currentHealth;
                break;
            }
          });
        }
      },
      child: BlocBuilder<CaseDetailsBloc, CaseDetailsState>(
        bloc: widget.bloc,
        builder: (BuildContext context, CaseDetailsState state) {
          if (state is CaseDetailsLoadingState ||
              state is PhoneBottomSheetLoadingState) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.89,
              child: Scaffold(
                  backgroundColor: Colors.transparent,
                  body: Container(
                    decoration: BoxDecoration(
                        color: ColorResource.colorFFFFFF,
                        boxShadow: <BoxShadow>[
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
            String cKey = widget.bloc.caseDetailsAPIValue
                    .callDetails![widget.index]['cType']
                    .toString() ??
                '_';
            String value = widget.bloc.caseDetailsAPIValue
                    .callDetails![widget.index]['value']
                    .toString() ??
                '_';
            debugPrint(cKey);
            final ContractorResult? informationModel =
                Singleton.instance.contractorInformations?.result;
            if (informationModel?.cloudTelephony == true &&
                informationModel?.contactMasking == true &&
                (cKey == 'mobile' || cKey == 'phone')) {
              value = value.replaceRange(2, 7, "XXXXX");
            }
            return WillPopScope(
              onWillPop: willPopCallback,
              child: SizedBox(
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
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color:
                                    ColorResource.colorCACACA.withOpacity(.25),
                                blurRadius: 30.0,
                                offset: const Offset(1.0, 1.0)),
                          ],
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(30))),
                      width: double.infinity,
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.fromLTRB(22, 26, 22, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    CustomText(
                                      widget.bloc.isAutoCalling
                                          ? 'mobile'.toUpperCase()
                                          : widget
                                                  .bloc
                                                  .caseDetailsAPIValue
                                                  .callDetails![widget.index]
                                                      ['cType']
                                                  .toString()
                                                  .toUpperCase() ??
                                              '_',
                                      fontWeight: FontWeight.w700,
                                      color: ColorResource.color23375A,
                                    ),
                                    Wrap(
                                      spacing: 27,
                                      children: <Widget>[
                                        ShowHealthStatus.healthStatus(widget
                                                .bloc
                                                .caseDetailsAPIValue
                                                .callDetails![widget.index]
                                            ['health']),
                                        if (!(widget.bloc.isAutoCalling))
                                          GestureDetector(
                                            onTap: () {
                                              if (widget.bloc.isAutoCalling) {
                                                if (!(Singleton.instance
                                                        .startCalling ??
                                                    true)) {
                                                  Navigator.pop(context);
                                                }
                                              } else {
                                                Navigator.pop(context);
                                              }
                                            },
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
                                      value.toString(),
                                      color: ColorResource.color23375A,
                                    ),
                                  ),
                                ),
                                widget.bloc.isAutoCalling
                                    ? const SizedBox(
                                        height: 10.0,
                                      )
                                    : const SizedBox(),
                                Visibility(
                                    visible: widget.bloc.isAutoCalling,
                                    child: widget.customerLoanUserWidget ??
                                        const SizedBox()),
                                widget.bloc.isAutoCalling
                                    ? const SizedBox(
                                        height: 10.0,
                                      )
                                    : const SizedBox(),
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                        child: SizedBox(
                                            width: 10,
                                            child: InkWell(
                                              onTap: () => widget.bloc.add(
                                                  EventDetailsEvent(
                                                      Constants.callCustomer,
                                                      widget
                                                          .bloc
                                                          .caseDetailsAPIValue
                                                          .callDetails,
                                                      false,
                                                      seleectedContactNumber:
                                                          widget
                                                              .bloc
                                                              .caseDetailsAPIValue
                                                              .callDetails![
                                                                  widget.index]
                                                                  ['value']
                                                              .toString())),
                                              child: Container(
                                                  decoration: const BoxDecoration(
                                                      color: ColorResource
                                                          .colorBEC4CF,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  75.0))),
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
                                                            ImageResource.phone,
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(width: 12),
                                                      CustomText(
                                                        Languages.of(context)!
                                                            .call
                                                            .toUpperCase(),
                                                        lineHeight: 1,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: ColorResource
                                                            .color23375A,
                                                      )
                                                    ],
                                                  )),
                                            ))),
                                    ConstrainedBox(
                                      constraints: const BoxConstraints(
                                        minWidth: 10,
                                        maxWidth: 30,
                                      ),
                                    ),
                                    Expanded(
                                        child: SizedBox(
                                      height: 45,
                                      child: CustomButton(
                                        null,
                                        isTrailing: true,
                                        leadingWidget: CustomText(
                                          Languages.of(context)!.eventDetails,
                                          fontSize: FontSize.twelve,
                                          color: ColorResource.color23375A,
                                          lineHeight: 1,
                                          fontWeight: FontWeight.w700,
                                        ),
                                        onTap: () => widget.bloc.add(
                                            EventDetailsEvent(
                                                Constants.eventDetails,
                                                widget.bloc.caseDetailsAPIValue
                                                    .callDetails,
                                                false)),
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
                            width: MediaQuery.of(context).size.width,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: ColorResource.colorD8D8D8))),
                            child: TabBar(
                              controller: _controller,
                              isScrollable: true,
                              indicatorColor: ColorResource.colorD5344C,
                              onTap: (int index) {
                                // change address health status based on selected tab customer met / customer not met / invalid
                                widget.bloc.add(UpdateHealthStatusEvent(context,
                                    selectedHealthIndex: widget.index,
                                    tabIndex: index,
                                    currentHealth: widget
                                        .bloc
                                        .caseDetailsAPIValue
                                        .callDetails![widget.index]['health']));

                                widget.bloc
                                    .phoneUnreachableNextActionDateFocusNode
                                    .unfocus();
                                widget.bloc.phoneUnreachableRemarksFocusNode
                                    .unfocus();
                                widget.bloc.phoneInvalidRemarksFocusNode
                                    .unfocus();
                              },
                              labelStyle: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: ColorResource.color23375A,
                                  fontSize: FontSize.fourteen,
                                  fontStyle: FontStyle.normal),
                              indicatorWeight: 5.0,
                              labelColor: ColorResource.color23375A,
                              unselectedLabelColor: ColorResource.colorC4C4C4,
                              tabs: <Widget>[
                                Tab(text: Languages.of(context)!.connected),
                                Tab(text: Languages.of(context)!.unreachable),
                                Tab(text: Languages.of(context)!.invalid)
                              ],
                            ),
                          ),
                          Expanded(
                              child: SingleChildScrollView(
                            child: Column(
                              children: <Widget>[
                                Column(children: <Widget>[
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.65,
                                    child: TabBarView(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      controller: _controller,
                                      children: <Widget>[
                                        PhoneConnectedScreen(
                                          bloc: widget.bloc,
                                          context: context,
                                          isCallFromCaseDetails:
                                              widget.isCallFromCaseDetails,
                                          callId: widget.callId,
                                        ),
                                        PhoneUnreachableScreen(
                                          bloc: widget.bloc,
                                          context: context,
                                          isCallFromCaseDetails:
                                              widget.isCallFromCaseDetails,
                                          callId: widget.callId,
                                        ),
                                        PhonenInvalidScreen(
                                          bloc: widget.bloc,
                                          context: context,
                                          isCallFromCaseDetails:
                                              widget.isCallFromCaseDetails,
                                          callId: widget.callId,
                                        ),
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
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  color: ColorResource.color000000
                                      .withOpacity(.25),
                                  blurRadius: 2.0,
                                  offset: const Offset(1.0, 1.0),
                                ),
                              ],
                            ),
                            width: double.infinity,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 11.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(
                                    width: 190,
                                    child: CustomButton(
                                      Languages.of(context)!.done.toUpperCase(),
                                      onTap: () async {
                                        if (widget.bloc.isAutoCalling) {
                                          if (await CallCustomerStatus
                                              .callStatusCheck(
                                                  callId: widget.bloc
                                                      .paramValue['callId'],
                                                  context: context)) {
                                            // widget.bloc.allocationBloc
                                            //     .add(StartCallingEvent(
                                            //   customerIndex:
                                            //       widget.bloc.paramValue[
                                            //               'customerIndex'] +
                                            //           1,
                                            //   phoneIndex: 0,
                                            //   isIncreaseCount: true,
                                            // ));
                                            Navigator.pop(context);
                                          }
                                        } else {
                                          Navigator.pop(context);
                                        }
                                      },
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
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  color: ColorResource.color000000
                                      .withOpacity(.25),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Singleton.instance.startCalling ?? false
                                      ? const SizedBox()
                                      : Expanded(
                                          child:
                                              CustomCancelButton.cancelButton(
                                                  context),
                                        ),
                                  SizedBox(
                                      width: Singleton.instance.startCalling ??
                                              false
                                          ? 0
                                          : 25),
                                  Singleton.instance.startCalling ?? false
                                      ? SizedBox(
                                          width:
                                              Singleton.instance.startCalling ??
                                                      false
                                                  ? 150
                                                  : 191,
                                          child: _controller.index == 1
                                              ? CustomButton(
                                                  isSubmitFirst
                                                      ? Languages.of(context)!
                                                              .stop
                                                              .toUpperCase() +
                                                          ' & \n' +
                                                          Languages.of(context)!
                                                              .submit
                                                              .toUpperCase()
                                                      : null,
                                                  isLeading: !isSubmitFirst,
                                                  trailingWidget:
                                                      CustomLoadingWidget(
                                                    gradientColors: <Color>[
                                                      ColorResource.colorFFFFFF,
                                                      ColorResource.colorFFFFFF
                                                          .withOpacity(0.7),
                                                    ],
                                                  ),
                                                  isRemoveExtraPadding: true,
                                                  fontSize: FontSize.ten,
                                                  onTap: isSubmitFirst
                                                      ? () async {
                                                          if (await AppUtils
                                                              .checkGPSConnection(
                                                                  context)) {
                                                            if (await AppUtils
                                                                .checkLocationPermission(
                                                                    context)) {
                                                              if (widget
                                                                  .bloc
                                                                  .phoneUnreachableFormKey
                                                                  .currentState!
                                                                  .validate()) {
                                                                if (widget.bloc
                                                                        .phoneSelectedUnreadableClip !=
                                                                    '') {
                                                                  widget.bloc.add(
                                                                      ClickPhoneUnreachableSubmitedButtonEvent(
                                                                    context,
                                                                    autoCallingStopAndSubmit:
                                                                        false,
                                                                  ));
                                                                } else {
                                                                  AppUtils
                                                                      .showToast(
                                                                    Languages.of(
                                                                            context)!
                                                                        .pleaseSelectOptions,
                                                                  );
                                                                }
                                                              }
                                                            }
                                                          }
                                                        }
                                                      : () {},
                                                  cardShape: 5,
                                                )
                                              : CustomButton(
                                                  isSubmitSecond
                                                      ? Languages.of(context)!
                                                              .stop
                                                              .toUpperCase() +
                                                          ' & \n' +
                                                          Languages.of(context)!
                                                              .submit
                                                              .toUpperCase()
                                                      : null,
                                                  isLeading: !isSubmitSecond,
                                                  trailingWidget:
                                                      CustomLoadingWidget(
                                                    gradientColors: <Color>[
                                                      ColorResource.colorFFFFFF,
                                                      ColorResource.colorFFFFFF
                                                          .withOpacity(0.7),
                                                    ],
                                                  ),
                                                  onTap: isSubmitSecond
                                                      ? () async {
                                                          if (await AppUtils
                                                              .checkGPSConnection(
                                                                  context)) {
                                                            if (await AppUtils
                                                                .checkLocationPermission(
                                                                    context)) {
                                                              widget.bloc.add(
                                                                  ClickPhoneInvalidButtonEvent(
                                                                context,
                                                                autoCallingStopAndSubmit:
                                                                    false,
                                                              ));
                                                            }
                                                          }
                                                        }
                                                      : () {},
                                                  cardShape: 5,
                                                ),
                                        )
                                      : const SizedBox(),
                                  SizedBox(
                                    width:
                                        Singleton.instance.startCalling ?? false
                                            ? 150
                                            : 191,
                                    child: _controller.index == 1
                                        ? CustomButton(
                                            isSubmitFirst
                                                ? Languages.of(context)!
                                                    .submit
                                                    .toUpperCase()
                                                : null,
                                            isLeading: !isSubmitFirst,
                                            trailingWidget: CustomLoadingWidget(
                                              gradientColors: <Color>[
                                                ColorResource.colorFFFFFF,
                                                ColorResource.colorFFFFFF
                                                    .withOpacity(0.7),
                                              ],
                                            ),
                                            onTap: isSubmitFirst
                                                ? () async {
                                                    if (await AppUtils
                                                        .checkGPSConnection(
                                                            context)) {
                                                      if (await AppUtils
                                                          .checkLocationPermission(
                                                              context)) {
                                                        if (widget.bloc
                                                                .isRecordUnReachable ==
                                                            Constants.process) {
                                                          AppUtils.showToast(
                                                              'Stop the Record then Submit');
                                                        } else if (widget.bloc
                                                                .isRecordUnReachable ==
                                                            Constants.stop) {
                                                          AppUtils.showToast(
                                                              'Please wait audio is converting');
                                                        } else {
                                                          if (widget.bloc
                                                                  .isRecordUnReachable ==
                                                              Constants
                                                                  .submit) {
                                                            setState(() => widget
                                                                    .bloc
                                                                    .phoneUnreachableRemarksController
                                                                    .text =
                                                                widget.bloc
                                                                    .translateTextUnReachable);
                                                            setState(() => widget
                                                                    .bloc
                                                                    .isTranslateUnReachable =
                                                                false);
                                                          }
                                                          if (widget
                                                              .bloc
                                                              .phoneUnreachableFormKey
                                                              .currentState!
                                                              .validate()) {
                                                            if (widget.bloc
                                                                    .phoneSelectedUnreadableClip !=
                                                                '') {
                                                              widget.bloc.add(
                                                                  ClickPhoneUnreachableSubmitedButtonEvent(
                                                                context,
                                                                isCallFromCaseDetails:
                                                                    widget
                                                                        .isCallFromCaseDetails,
                                                                callId: widget
                                                                    .callId,
                                                              ));
                                                            } else {
                                                              AppUtils
                                                                  .showToast(
                                                                Languages.of(
                                                                        context)!
                                                                    .pleaseSelectOptions,
                                                              );
                                                            }
                                                          }
                                                        }
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
                                              gradientColors: <Color>[
                                                ColorResource.colorFFFFFF,
                                                ColorResource.colorFFFFFF
                                                    .withOpacity(0.7),
                                              ],
                                            ),
                                            onTap: isSubmitSecond
                                                ? () async {
                                                    if (await AppUtils
                                                        .checkGPSConnection(
                                                            context)) {
                                                      if (await AppUtils
                                                          .checkLocationPermission(
                                                              context)) {
                                                        if (widget.bloc
                                                                .isRecordPhoneInvalid ==
                                                            Constants.process) {
                                                          AppUtils.showToast(
                                                              'Stop the Record then Submit');
                                                        } else if (widget.bloc
                                                                .isRecordPhoneInvalid ==
                                                            Constants.stop) {
                                                          AppUtils.showToast(
                                                              'Please wait audio is converting');
                                                        } else {
                                                          if (widget.bloc
                                                                  .isRecordPhoneInvalid ==
                                                              Constants
                                                                  .submit) {
                                                            setState(() => widget
                                                                    .bloc
                                                                    .phoneInvalidRemarksController
                                                                    .text =
                                                                widget.bloc
                                                                    .translateTextPhoneInvalid);
                                                            setState(() => widget
                                                                    .bloc
                                                                    .isTranslatePhoneInvalid =
                                                                false);
                                                          }
                                                          if (widget
                                                              .bloc
                                                              .phoneInvalidFormKey
                                                              .currentState!
                                                              .validate()) {
                                                            if (widget.bloc
                                                                    .phoneSelectedInvalidClip !=
                                                                '') {
                                                              widget.bloc.add(
                                                                  ClickPhoneInvalidButtonEvent(
                                                                context,
                                                                isCallFromCaseDetails:
                                                                    widget
                                                                        .isCallFromCaseDetails,
                                                                callId: widget
                                                                    .callId,
                                                              ));
                                                            } else {
                                                              AppUtils
                                                                  .showToast(
                                                                Languages.of(
                                                                        context)!
                                                                    .pleaseSelectOptions,
                                                              );
                                                            }
                                                          }
                                                        }
                                                      }
                                                    }
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
              ),
            );
          }
        },
      ),
    );
  }
}
