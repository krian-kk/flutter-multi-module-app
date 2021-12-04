import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:origa/http/api_repository.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/models/unreachable_post_model/unreachable_post_model.dart';
import 'package:origa/screen/case_details_screen/bloc/case_details_bloc.dart';
import 'package:origa/screen/case_details_screen/phone_screen/connected_screen.dart';
import 'package:origa/screen/case_details_screen/phone_screen/invalid_screen.dart';
import 'package:origa/screen/case_details_screen/phone_screen/unreachable_screen.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/utils/string_resource.dart';
import 'package:origa/widgets/custom_button.dart';
import 'package:origa/widgets/custom_text.dart';

class PhoneScreen extends StatefulWidget {
  final CaseDetailsBloc bloc;
  final int index;
  const PhoneScreen({Key? key, required this.bloc, required this.index})
      : super(key: key);

  @override
  _PhoneScreenState createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  _handleTabSelection() {
    if (_controller.indexIsChanging) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = TabController(vsync: this, length: 3);
    _controller.addListener(_handleTabSelection);
  }

  @override
  Widget build(BuildContext context) {
    // List<CustomerMetNotButtonModel> customerMetNotButtonList = [
    //   CustomerMetNotButtonModel(Languages.of(context)!.leftMessage),
    //   CustomerMetNotButtonModel(Languages.of(context)!.doorLocked),
    //   CustomerMetNotButtonModel(Languages.of(context)!.entryRestricted),
    // ];
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
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(30))),
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomText(
                            widget.bloc.offlineCaseDetailsValue
                                .callDetails![widget.index]['cType']
                                .toString()
                                .toUpperCase(),
                            fontWeight: FontWeight.w700,
                            fontSize: FontSize.fourteen,
                            fontStyle: FontStyle.normal,
                            color: ColorResource.color23375A,
                          ),
                          Wrap(
                            spacing: 27,
                            children: [
                              SvgPicture.asset(ImageResource.activePerson),
                              GestureDetector(
                                onTap: () => Navigator.pop(context),
                                child: Container(
                                  padding: const EdgeInsets.all(2),
                                  child: SvgPicture.asset(ImageResource.close),
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
                            widget.bloc.offlineCaseDetailsValue
                                .callDetails![widget.index]['value']
                                .toString()
                                .toUpperCase(),
                            fontWeight: FontWeight.w400,
                            fontSize: FontSize.fourteen,
                            fontStyle: FontStyle.normal,
                            color: ColorResource.color23375A,
                          ),
                        ),
                      ),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: GestureDetector(
                            //================================================
                            // onTap: () {
                            //   widget.bloc.add(ClickCallCustomerEvent());
                            // },
                            child: SizedBox(
                                width: 10,
                                child: InkWell(
                                  onTap: () => widget.bloc.add(
                                      ClickOpenBottomSheetEvent(
                                          StringResource.callCustomer)),
                                  child: Container(
                                      decoration: const BoxDecoration(
                                          color: ColorResource.colorBEC4CF,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(75.0))),
                                      child: Row(
                                        children: [
                                          Image.asset(ImageResource.phone),
                                          const SizedBox(width: 12),
                                          CustomText(
                                            StringResource.call.toUpperCase(),
                                            fontSize: FontSize.fourteen,
                                            fontWeight: FontWeight.w700,
                                            color: ColorResource.color23375A,
                                          )
                                        ],
                                      )),
                                )),
                          )),
                          const SizedBox(width: 40),
                          Expanded(
                              child: SizedBox(
                            height: 50,
                            child: CustomButton(
                              Languages.of(context)!.eventDetails,
                              onTap: () => widget.bloc.add(
                                  ClickOpenBottomSheetEvent(
                                      StringResource.eventDetails)),
                              fontSize: FontSize.twelve,
                              textColor: ColorResource.color23375A,
                              borderColor: ColorResource.color23375A,
                              buttonBackgroundColor: ColorResource.colorFFFFFF,
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
                          bottom:
                              BorderSide(color: ColorResource.colorD8D8D8))),
                  child: TabBar(
                    controller: _controller,
                    physics: const NeverScrollableScrollPhysics(),
                    isScrollable: true,
                    indicatorColor: ColorResource.colorD5344C,
                    onTap: (index) {
                      widget.bloc.phoneUnreachableNextActionDateFocusNode
                          .unfocus();
                      widget.bloc.phoneUnreachableRemarksFocusNode.unfocus();
                      widget.bloc.phoneInvalidRemarksFocusNode.unfocus();
                    },
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
                          height: MediaQuery.of(context).size.height * 0.65,
                          child: TabBarView(
                            physics: const NeverScrollableScrollPhysics(),
                            controller: _controller,
                            children: [
                              PhoneConnectedScreen(
                                  bloc: widget.bloc, context: context),
                              PhoneUnreachableScreen(
                                  bloc: widget.bloc, context: context),
                              PhonenInvalidScreen(
                                  bloc: widget.bloc, context: context),
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
                        color: ColorResource.color000000.withOpacity(.25),
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
                            onTap: () => Navigator.pop(context),
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
                        color: ColorResource.color000000.withOpacity(.25),
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
                              Languages.of(context)!.cancel.toUpperCase(),
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
                                  Languages.of(context)!.submit.toUpperCase(),
                                  // isEnabled: (bloc.selectedUnreadableClip == ''),
                                  fontSize: FontSize.sixteen,
                                  fontWeight: FontWeight.w600,
                                  onTap: () {
                                    if (widget.bloc.phoneUnreachableFormKey
                                            .currentState!
                                            .validate() &&
                                        widget.bloc
                                                .phoneSelectedUnreadableClip !=
                                            '') {
                                      if (widget.bloc
                                              .phoneSelectedUnreadableClip ==
                                          Languages.of(context)!.lineBusy) {
                                        unreachableButtonClick(
                                          'TC : Line Busy',
                                          '618e382004d8d040ac18841b',
                                          'TELEVT007',
                                          'https://devapi.instalmint.com/v1/agent/case-details-events/lineBusy?userType=TELECALLER',
                                        );
                                      } else if (widget.bloc
                                              .phoneSelectedUnreadableClip ==
                                          Languages.of(context)!.switchOff) {
                                        unreachableButtonClick(
                                          'TC : Switch Off',
                                          '618e382004d8d040ac18841b',
                                          'TELEVT007',
                                          'https://devapi.instalmint.com/v1/agent/case-details-events/switchOff?userType=TELECALLER',
                                        );
                                      } else if (widget.bloc
                                              .phoneSelectedUnreadableClip ==
                                          Languages.of(context)!.rnr) {
                                        unreachableButtonClick(
                                          'TC : RNR',
                                          '618e382004d8d040ac18841b',
                                          'TELEVT011',
                                          'https://devapi.instalmint.com/v1/agent/case-details-events/RNR?userType=TELECALLER',
                                        );
                                      } else if (widget.bloc
                                              .phoneSelectedUnreadableClip ==
                                          Languages.of(context)!.outOfNetwork) {
                                        unreachableButtonClick(
                                          'TC : Out Of Network',
                                          '618e382004d8d040ac18841b',
                                          'TELEVT007',
                                          'https://devapi.instalmint.com/v1/agent/case-details-events/outOfNetwork?userType=TELECALLER',
                                        );
                                      } else if (widget.bloc
                                              .phoneSelectedUnreadableClip ==
                                          Languages.of(context)!
                                              .disConnecting) {
                                        unreachableButtonClick(
                                          'TC : Disconnecting',
                                          '618e382004d8d040ac18841b',
                                          'TELEVT011',
                                          'https://devapi.instalmint.com/v1/agent/case-details-events/disconnecting?userType=TELECALLER',
                                        );
                                      }
                                    }
                                  },
                                  cardShape: 5,
                                )
                              : CustomButton(
                                  Languages.of(context)!.submit.toUpperCase(),
                                  fontSize: FontSize.sixteen,
                                  fontWeight: FontWeight.w600,
                                  onTap: () {
                                    if (widget.bloc.phoneInvalidFormKey
                                            .currentState!
                                            .validate() &&
                                        widget.bloc.phoneSelectedInvalidClip !=
                                            '') {
                                      // if (widget
                                      //         .bloc.phoneSelectedInvalidClip ==
                                      //     Languages.of(context)!.doesNotExist) {
                                      //   unreachableButtonClick(
                                      //     'TC : Does Not Exist',
                                      //     '618e382004d8d040ac18841b',
                                      //     'TELEVT008',
                                      //     'https://devapi.instalmint.com/v1/agent/case-details-events/doesNotExist?userType=TELECALLER',
                                      //     'AWAITING CONTACT',
                                      //   );
                                      // }
                                      // else if (widget.bloc
                                      //         .phoneSelectedUnreadableClip ==
                                      //     Languages.of(context)!.switchOff) {
                                      //   unreachableButtonClick(
                                      //     'TC : Switch Off',
                                      //     '618e382004d8d040ac18841b',
                                      //     'TELEVT007',
                                      //     'https://devapi.instalmint.com/v1/agent/case-details-events/switchOff?userType=TELECALLER',
                                      //     'REVIEW',
                                      //   );
                                      // } else if (widget.bloc
                                      //         .phoneSelectedUnreadableClip ==
                                      //     Languages.of(context)!.rnr) {
                                      //   unreachableButtonClick(
                                      //     'TC : RNR',
                                      //     '618e382004d8d040ac18841b',
                                      //     'TELEVT011',
                                      //     'https://devapi.instalmint.com/v1/agent/case-details-events/RNR?userType=TELECALLER',
                                      //     'REVIEW',
                                      //   );
                                      // } else if (widget.bloc
                                      //         .phoneSelectedUnreadableClip ==
                                      //     Languages.of(context)!.outOfNetwork) {
                                      //   unreachableButtonClick(
                                      //     'TC : Out Of Network',
                                      //     '618e382004d8d040ac18841b',
                                      //     'TELEVT007',
                                      //     'https://devapi.instalmint.com/v1/agent/case-details-events/outOfNetwork?userType=TELECALLER',
                                      //     'REVIEW',
                                      //   );
                                      // } else if (widget.bloc
                                      //         .phoneSelectedUnreadableClip ==
                                      //     Languages.of(context)!
                                      //         .disConnecting) {
                                      //   unreachableButtonClick(
                                      //     'TC : Disconnecting',
                                      //     '618e382004d8d040ac18841b',
                                      //     'TELEVT011',
                                      //     'https://devapi.instalmint.com/v1/agent/case-details-events/disconnecting?userType=TELECALLER',
                                      //     'REVIEW',
                                      //   );
                                      // }
                                    }
                                  },
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

  unreachableButtonClick(
    String eventType,
    String caseId,
    String eventCode,
    String urlString,
  ) async {
    var requestBodyData = UnReachablePostModel(
      eventType: eventType,
      caseId: caseId,
      eventCode: eventCode,
      eventAttr: EventAttr(
          followUpPriority: 'REVIEW',
          remarks: widget.bloc.phoneUnreachableRemarksController.text,
          nextActionDate:
              widget.bloc.phoneUnreachableNextActionDateController.text),
      contact: Contact(),
    );
    Map<String, dynamic> postResult = await APIRepository.apiRequest(
      APIRequestType.POST,
      urlString,
      requestBodydata: jsonEncode(requestBodyData),
    );
    setState(() {
      widget.bloc.phoneUnreachableNextActionDateController.text = '';
      widget.bloc.phoneUnreachableRemarksController.text = '';
      widget.bloc.phoneSelectedUnreadableClip = '';
    });
    if (await postResult['success']) {
      Navigator.pop(context);
    }
  }
}
