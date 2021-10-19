// ignore_for_file: unnecessary_new, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/models/customer_not_met_model.dart';
import 'package:origa/screen/phone_screen/bloc/phone_bloc.dart';
import 'package:origa/screen/phone_screen/connected_screen.dart';
import 'package:origa/screen/phone_screen/invalid_screen.dart';
import 'package:origa/screen/phone_screen/unreachable_screen.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/utils/string_resource.dart';
import 'package:origa/widgets/custom_appbar.dart';
import 'package:origa/widgets/custom_button.dart';
import 'package:origa/widgets/custom_text.dart';

class PhoneScreen extends StatefulWidget {
  PhoneScreen({Key? key}) : super(key: key);

  @override
  _PhoneScreenState createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen>
    with SingleTickerProviderStateMixin {
  late PhoneBloc bloc;
  late TabController _controller;
  int currentIndex = 0;

  _handleTabSelection() {
    if (_controller.indexIsChanging) {
      setState(() {
        currentIndex = _controller.index;
      });
    }
  }

  @override
  void initState() {
    bloc = PhoneBloc()..add(PhoneInitialEvent());
    super.initState();
    _controller = TabController(vsync: this, length: 3);
    _controller.addListener(_handleTabSelection);
  }

  @override
  Widget build(BuildContext context) {
    List<CustomerMetNotButtonModel> customerMetNotButtonList = [
      CustomerMetNotButtonModel(Languages.of(context)!.leftMessage),
      CustomerMetNotButtonModel(Languages.of(context)!.doorLocked),
      CustomerMetNotButtonModel(Languages.of(context)!.entryRestricted),
    ];
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: ColorResource.colorF7F8FA,
        body: Column(
          children: [
            CustomAppbar(
              titleString: Languages.of(context)!.caseDetials,
              titleSpacing: 21,
              iconEnumValues: IconEnum.back,
              onItemSelected: (value) {
                if (value == 'IconEnum.back') {
                  Navigator.pop(context);
                  Navigator.pop(context);
                }
              },
            ),
            BlocListener<PhoneBloc, PhoneState>(
              bloc: bloc,
              listener: (context, state) {},
              child: BlocBuilder<PhoneBloc, PhoneState>(
                bloc: bloc,
                builder: (context, state) {
                  return Expanded(
                      child: Container(
                    decoration: new BoxDecoration(
                        color: ColorResource.colorFFFFFF,
                        boxShadow: [
                          new BoxShadow(
                              color: ColorResource.colorCACACA.withOpacity(.25),
                              blurRadius: 30.0,
                              offset: Offset(1.0, 1.0)),
                        ],
                        borderRadius: new BorderRadius.vertical(
                            top: Radius.circular(30))),
                    width: double.infinity,
                    child: SingleChildScrollView(
                      physics: NeverScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(22, 26, 22, 0),
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
                                        Image.asset(ImageResource.activePerson),
                                        GestureDetector(
                                            onTap: () => Navigator.pop(context),
                                            child: Image.asset(
                                                ImageResource.close))
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
                                  children: [
                                    Expanded(
                                        child: SizedBox(
                                            width: 10,
                                            child: Container(
                                                decoration: new BoxDecoration(
                                                    color: ColorResource
                                                        .colorBEC4CF,
                                                    borderRadius:
                                                        new BorderRadius.all(
                                                            new Radius.circular(
                                                                75.0))),
                                                child: Row(
                                                  children: [
                                                    Image.asset(
                                                        ImageResource.phone),
                                                    SizedBox(width: 12),
                                                    CustomText(
                                                      Languages.of(context)!
                                                          .call,
                                                      fontSize:
                                                          FontSize.fourteen,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: ColorResource
                                                          .color23375A,
                                                    )
                                                  ],
                                                )))),
                                    SizedBox(width: 67),
                                    Expanded(
                                        child: CustomButton(
                                      Languages.of(context)!.eventDetails,
                                      textColor: ColorResource.color23375A,
                                      borderColor: ColorResource.color23375A,
                                      buttonBackgroundColor:
                                          ColorResource.colorFFFFFF,
                                    ))
                                  ],
                                )
                              ],
                            ),
                          ),
                          Column(children: [
                            Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: ColorResource.colorD8D8D8))),
                              child: TabBar(
                                controller: _controller,
                                physics: NeverScrollableScrollPhysics(),
                                isScrollable: true,
                                indicatorColor: ColorResource.colorD5344C,
                                labelStyle: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: ColorResource.color23375A,
                                    fontSize: FontSize.fourteen,
                                    fontStyle: FontStyle.normal),
                                indicatorWeight: 5.0,
                                labelColor: ColorResource.color23375A,
                                unselectedLabelColor: ColorResource.colorC4C4C4,
                                // ignore: prefer_const_literals_to_create_immutables
                                // tabs: [
                                //   Tab(text: StringResource.connected),
                                //   Tab(text: StringResource.unreachable),
                                //   Tab(text: StringResource.invalid)
                                // ],
                                tabs: [
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.27,
                                      child:
                                          Tab(text: StringResource.connected)),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.27,
                                      child: Tab(
                                          text: StringResource.unreachable)),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.22,
                                      child: Tab(text: StringResource.invalid))
                                ],
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.65,
                              child: TabBarView(
                                physics: NeverScrollableScrollPhysics(),
                                controller: _controller,
                                children: [
                                  PhoneFirstTapScreen(
                                      bloc: bloc, context: context),
                                  PhoneSecondTabScreen(
                                      bloc: bloc, context: context),
                                  PhoneThirdTabScreen(
                                      bloc: bloc, context: context),
                                ],
                              ),
                            ),
                          ])
                        ],
                      ),
                    ),
                  ));
                },
              ),
            )
          ],
        ),
        bottomNavigationBar: currentIndex == 0
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
                  padding: EdgeInsets.symmetric(horizontal: 85, vertical: 11.0),
                  child: Container(
                    decoration: BoxDecoration(),
                    child: CustomButton(
                      Languages.of(context)!.done.toUpperCase(),
                      fontSize: FontSize.sixteen,
                      fontWeight: FontWeight.w600,
                      onTap: () {},
                      cardShape: 5,
                    ),
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
                            color: ColorResource.colorEA6D48,
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.normal,
                            fontSize: FontSize.sixteen,
                          ))),
                      SizedBox(width: 25),
                      Container(
                        width: 191,
                        decoration: BoxDecoration(),
                        child: CustomButton(
                          Languages.of(context)!.submit.toUpperCase(),
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
}
