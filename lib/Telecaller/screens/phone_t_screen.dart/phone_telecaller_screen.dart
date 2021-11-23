import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:origa/Telecaller/screens/phone_t_screen.dart/bloc/phone_telecaller_bloc.dart';
import 'package:origa/Telecaller/screens/phone_t_screen.dart/phone_connected_t_screen.dart';
import 'package:origa/Telecaller/screens/phone_t_screen.dart/phone_invalid_telecaller_screen.dart';
import 'package:origa/Telecaller/screens/phone_t_screen.dart/phone_unreachable_t_screen.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/utils/string_resource.dart';
import 'package:origa/widgets/custom_appbar.dart';
import 'package:origa/widgets/custom_button.dart';
import 'package:origa/widgets/custom_text.dart';

class PhoneTelecallerScreen extends StatefulWidget {
  const PhoneTelecallerScreen({Key? key}) : super(key: key);

  @override
  _PhoneTelecallerScreenState createState() => _PhoneTelecallerScreenState();
}

class _PhoneTelecallerScreenState extends State<PhoneTelecallerScreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  late PhoneTelecallerBloc bloc;

  _handleTabSelection() {
    if (_controller.indexIsChanging) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    bloc = PhoneTelecallerBloc()..add(PhoneTelecallerInitialEvent());
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
      bottom: false,
      top: false,
      child: Scaffold(
        backgroundColor: ColorResource.colorF7F8FA,
        // backgroundColor: Colors.transparent,
        body: BlocListener<PhoneTelecallerBloc, PhoneTelecallerState>(
          bloc: bloc,
          listener: (context, state) {},
          child: BlocBuilder<PhoneTelecallerBloc, PhoneTelecallerState>(
            bloc: bloc,
            builder: (context, state) {
              if (state is PhoneTelecallerLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Container(
                  width: double.infinity,
                  child: Column(
                    children: [
                      CustomAppbar(
                        titleString: Languages.of(context)!.caseDetials,
                        titleSpacing: 21,
                        iconEnumValues: IconEnum.back,
                        onItemSelected: (value) {
                          if (value == 'IconEnum.back') {
                            Navigator.pop(context);
                          }
                        },
                      ),
                      Flexible(
                        child: Container(
                          decoration: BoxDecoration(
                              color: ColorResource.colorFFFFFF,
                              boxShadow: [
                                BoxShadow(
                                    color: ColorResource.colorCACACA
                                        .withOpacity(.25),
                                    blurRadius: 30.0,
                                    offset: const Offset(1.0, 1.0)),
                              ],
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(30))),
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(22, 26, 22, 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                                            SvgPicture.asset(
                                                ImageResource.activePerson),
                                            InkWell(
                                                onTap: () =>
                                                    Navigator.pop(context),
                                                child: SvgPicture.asset(
                                                    ImageResource.close))
                                          ],
                                        )
                                      ],
                                    ),
                                    const Flexible(
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
                                          // onTap: () => callCustomerBottomSheet(context),
                                          child: SizedBox(
                                              width: 10,
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
                                                      Image.asset(
                                                          ImageResource.phone),
                                                      const SizedBox(width: 12),
                                                      CustomText(
                                                        StringResource.call
                                                            .toUpperCase(),
                                                        fontSize:
                                                            FontSize.fourteen,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: ColorResource
                                                            .color23375A,
                                                      )
                                                    ],
                                                  ))),
                                        )),
                                        const SizedBox(width: 40),
                                        Expanded(
                                            child: SizedBox(
                                          height: 50,
                                          child: CustomButton(
                                            Languages.of(context)!.eventDetails,
                                            // onTap: () => openEventDetailsBottomSheet(context),
                                            fontSize: FontSize.twelve,
                                            textColor:
                                                ColorResource.color23375A,
                                            borderColor:
                                                ColorResource.color23375A,
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
                                  onTap: (index) {
                                    bloc.phoneUnreachableNextActionDateFocusNode
                                        .unfocus();
                                    bloc.phoneUnreachableRemarksFocusNode
                                        .unfocus();
                                    bloc.phoneInvalidRemarksFocusNode.unfocus();
                                  },
                                  labelStyle: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: ColorResource.color23375A,
                                      fontSize: FontSize.fourteen,
                                      fontStyle: FontStyle.normal),
                                  indicatorWeight: 5.0,
                                  labelColor: ColorResource.color23375A,
                                  unselectedLabelColor:
                                      ColorResource.colorC4C4C4,
                                  tabs: [
                                    Tab(text: Languages.of(context)!.connected),
                                    Tab(
                                        text:
                                            Languages.of(context)!.unreachable),
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
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.65,
                                        child: TabBarView(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          controller: _controller,
                                          children: [
                                            PhoneConnectedTelecallerScreen(
                                                bloc: bloc, context: context),
                                            PhoneUnreachableTelecallerScreen(
                                                bloc: bloc, context: context),
                                            PhonenInvalidTelecallerScreen(
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
                      ),
                    ],
                  ),
                );
              }
            },
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        child: SizedBox(
                            width: 95,
                            child: Center(
                                child: CustomText(
                              Languages.of(context)!.cancel.toUpperCase(),
                              color: ColorResource.colorEA6D48,
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.normal,
                              fontSize: FontSize.sixteen,
                            ))),
                      ),
                      const SizedBox(width: 25),
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

  // callCustomerBottomSheet(BuildContext buildContext) {
  //   showModalBottomSheet(
  //       enableDrag: false,
  //       context: buildContext,
  //       isScrollControlled: true,
  //       isDismissible: false,
  //       backgroundColor: ColorResource.colorFFFFFF,
  //       shape: const RoundedRectangleBorder(
  //         borderRadius: BorderRadius.vertical(
  //           top: Radius.circular(20),
  //         ),
  //       ),
  //       builder: (BuildContext context) {
  //         return SizedBox(
  //           height: MediaQuery.of(context).size.height * 0.89,
  //           child: const CallCustomerBottomSheet(),
  //         );
  //       });
  // }

  // openEventDetailsBottomSheet(BuildContext buildContext) {
  //   showModalBottomSheet(
  //     enableDrag: false,
  //     isScrollControlled: true,
  //     isDismissible: false,
  //     context: buildContext,
  //     backgroundColor: ColorResource.colorFFFFFF,
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(
  //         top: Radius.circular(20),
  //       ),
  //     ),
  //     builder: (BuildContext context) {
  //       return CustomEventDetailsBottomSheet(
  //           Languages.of(context)!.eventDetails.toUpperCase(), widget.bloc);
  //     },
  //   );
  // }
}
