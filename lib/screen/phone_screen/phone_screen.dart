// ignore_for_file: unnecessary_new, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/models/customer_not_met_model.dart';
import 'package:origa/screen/phone_screen/bloc/phone_bloc.dart';
import 'package:origa/screen/phone_screen/phone_firsttab_screen.dart';
import 'package:origa/screen/phone_screen/phone_secondtab_screen.dart';
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

class _PhoneScreenState extends State<PhoneScreen> {
  late PhoneBloc bloc;

  @override
  void initState() {
    bloc = PhoneBloc()..add(PhoneInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<CustomerMetNotButtonModel> customerMetNotButtonList = [
      CustomerMetNotButtonModel(ColorResource.colorFFB800.withOpacity(.67),
          Languages.of(context)!.leftMessage),
      CustomerMetNotButtonModel(
          ColorResource.colorE7E7E7, Languages.of(context)!.doorLocked),
      CustomerMetNotButtonModel(
          ColorResource.colorE7E7E7, Languages.of(context)!.entryRestricted),
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
                          ),
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
                                      'Event Details',
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
                          DefaultTabController(
                            length: 3,
                            // ignore: prefer_const_literals_to_create_immutables
                            child: Column(children: [
                              Container(
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: ColorResource.colorD8D8D8))),
                                child: TabBar(
                                  isScrollable: true,
                                  indicatorColor: ColorResource.colorD5344C,
                                  labelStyle: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: ColorResource.color23375A,
                                      fontSize: FontSize.fourteen,
                                      fontStyle: FontStyle.normal),
                                  indicatorWeight: 5.0,
                                  labelColor: ColorResource.color23375A,
                                  unselectedLabelColor:
                                      ColorResource.colorC4C4C4,
                                  // ignore: prefer_const_literals_to_create_immutables
                                  tabs: [
                                    Tab(text: StringResource.connected),
                                    Tab(text: StringResource.unreachable),
                                    Tab(text: StringResource.invalid)
                                  ],
                                  // tabs: [
                                  //   SizedBox(
                                  //       width: MediaQuery.of(context).size.width * 0.29,
                                  //       child: Tab(text: StringResource.customerMet)),
                                  //   SizedBox(
                                  //       width: MediaQuery.of(context).size.width * 0.29,
                                  //       child:
                                  //           Tab(text: StringResource.customerNotMet)),
                                  //   SizedBox(
                                  //       width: MediaQuery.of(context).size.width * 0.24,
                                  //       child: Tab(text: StringResource.invalid))
                                  // ],
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height - 275,
                                child: TabBarView(
                                  children: [
                                    PhoneFirstTapScreen(
                                        bloc: bloc, context: context),
                                    PhoneSecondTabScreen(
                                        bloc: bloc, context: context),
                                    PhoneFirstTapScreen(
                                        bloc: bloc, context: context),
                                  ],
                                ),
                              ),
                            ]),
                          )
                        ],
                      ),
                    ),
                  ));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
