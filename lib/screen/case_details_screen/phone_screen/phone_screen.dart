// ignore_for_file: unnecessary_new, prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/screen/case_details_screen/bloc/case_details_bloc.dart';
import 'package:origa/screen/case_details_screen/bottom_sheet_screen/event_details_bottom_sheet.dart';
import 'package:origa/screen/case_details_screen/phone_screen/call_customer_bottom_sheet.dart';
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
  PhoneScreen({Key? key, required this.bloc}) : super(key: key);

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
    return SafeArea(
      top: false,
      child: Scaffold(
        // backgroundColor: ColorResource.colorF7F8FA,
        backgroundColor: Colors.transparent,
        body: Container(
          decoration: new BoxDecoration(
              color: ColorResource.colorFFFFFF,
              boxShadow: [
                new BoxShadow(
                    color: ColorResource.colorCACACA.withOpacity(.25),
                    blurRadius: 30.0,
                    offset: Offset(1.0, 1.0)),
              ],
              borderRadius:
                  new BorderRadius.vertical(top: Radius.circular(30))),
          width: double.infinity,
          child: Column(
            children: [
              // CustomAppbar(
              //   titleString: Languages.of(context)!.caseDetials,
              //   titleSpacing: 21,
              //   iconEnumValues: IconEnum.back,
              //   onItemSelected: (value) {
              //     if (value == 'IconEnum.back') {
              //       Navigator.pop(context);
              //       Navigator.pop(context);
              //     }
              //   },
              // ),
              Padding(
                padding: const EdgeInsets.fromLTRB(22, 26, 22, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          'Phone Number 01'.toUpperCase(),
                          fontWeight: FontWeight.w700,
                          fontSize: FontSize.fourteen,
                          fontStyle: FontStyle.normal,
                          color: ColorResource.color23375A,
                        ),
                        Wrap(
                          spacing: 27,
                          children: [
                            Image.asset(ImageResource.activePerson),
                            GestureDetector(
                                onTap: () => Navigator.pop(context),
                                child: Image.asset(ImageResource.close))
                          ],
                        )
                      ],
                    ),
                    Flexible(
                      child: SizedBox(
                        width: 255,
                        child: CustomText(
                          '9841021453',
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
                          onTap: () => callCustomerBottomSheet(context),
                          child: SizedBox(
                              width: 10,
                              child: Container(
                                  decoration: new BoxDecoration(
                                      color: ColorResource.colorBEC4CF,
                                      borderRadius: new BorderRadius.all(
                                          new Radius.circular(75.0))),
                                  child: Row(
                                    children: [
                                      Image.asset(ImageResource.phone),
                                      SizedBox(width: 12),
                                      CustomText(
                                        StringResource.call.toUpperCase(),
                                        fontSize: FontSize.fourteen,
                                        fontWeight: FontWeight.w700,
                                        color: ColorResource.color23375A,
                                      )
                                    ],
                                  ))),
                        )),
                        SizedBox(width: 40),
                        Expanded(
                            child: SizedBox(
                          height: 50,
                          child: CustomButton(
                            Languages.of(context)!.eventDetails,
                            onTap: () => openEventDetailsBottomSheet(context),
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
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: ColorResource.colorD8D8D8))),
                child: TabBar(
                  controller: _controller,
                  physics: NeverScrollableScrollPhysics(),
                  isScrollable: true,
                  indicatorColor: ColorResource.colorD5344C,
                  onTap: (index) {
                    widget.bloc.phoneUnreachableNextActionDateFocusNode
                        .unfocus();
                    widget.bloc.phoneUnreachableRemarksFocusNode.unfocus();
                    widget.bloc.phoneInvalidRemarksFocusNode.unfocus();
                  },
                  labelStyle: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: ColorResource.color23375A,
                      fontSize: FontSize.fourteen,
                      fontStyle: FontStyle.normal),
                  indicatorWeight: 5.0,
                  labelColor: ColorResource.color23375A,
                  unselectedLabelColor: ColorResource.colorC4C4C4,
                  // ignore: prefer_const_literals_to_create_immutables
                  tabs: [
                    Tab(text: Languages.of(context)!.connected),
                    Tab(text: Languages.of(context)!.unreachable),
                    Tab(text: Languages.of(context)!.invalid)
                  ],
                  // tabs: [
                  //   SizedBox(
                  //       width: MediaQuery.of(context).size.width * 0.27,
                  //       child: Tab(text: Languages.of(context)!.connected)),
                  //   SizedBox(
                  //       width: MediaQuery.of(context).size.width * 0.27,
                  //       child: Tab(text: Languages.of(context)!.unreachable)),
                  //   SizedBox(
                  //       width: MediaQuery.of(context).size.width * 0.22,
                  //       child: Tab(text: Languages.of(context)!.invalid))
                  // ],
                ),
              ),

              Expanded(
                  child: SingleChildScrollView(
                // physics: NeverScrollableScrollPhysics(),
                child: Column(
                  children: [
                    Column(children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.65,
                        child: TabBarView(
                          physics: NeverScrollableScrollPhysics(),
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
                    new BoxShadow(
                      color: ColorResource.color000000.withOpacity(.25),
                      blurRadius: 2.0,
                      offset: Offset(1.0, 1.0),
                    ),
                  ],
                ),
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 11.0),
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
                    new BoxShadow(
                      color: ColorResource.color000000.withOpacity(.25),
                      blurRadius: 2.0,
                      offset: Offset(1.0, 1.0),
                    ),
                  ],
                ),
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5.0),
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
                      SizedBox(width: 25),
                      SizedBox(
                        width: 191,
                        child: _controller.index == 1
                            ? CustomButton(
                                Languages.of(context)!.submit.toUpperCase(),
                                // isEnabled: (bloc.selectedUnreadableClip == ''),
                                fontSize: FontSize.sixteen,
                                fontWeight: FontWeight.w600,
                                // onTap: () => bloc.add(ClickMessageEvent()),
                                cardShape: 5,
                              )
                            : CustomButton(
                                Languages.of(context)!.submit.toUpperCase(),
                                // isEnabled: (bloc.selectedInvalidClip != ''),
                                fontSize: FontSize.sixteen,
                                fontWeight: FontWeight.w600,
                                // onTap: () => bloc.add(ClickMessageEvent()),
                                cardShape: 5,
                              ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  void callCustomerBottomSheet(BuildContext buildContext) {
    showModalBottomSheet(
        context: buildContext,
        isScrollControlled: true,
        isDismissible: false,
        backgroundColor: ColorResource.colorFFFFFF,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        builder: (BuildContext context) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.89,
            child: CallCustomerBottomSheet(),
          );
        });
  }

  openEventDetailsBottomSheet(BuildContext buildContext) {
    showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: false,
      context: buildContext,
      backgroundColor: ColorResource.colorFFFFFF,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (BuildContext context) {
        return CustomEventDetailsBottomSheet(
            Languages.of(context)!.eventDetails.toUpperCase(), widget.bloc);
      },
    );
  }
}
