// ignore_for_file: unnecessary_new, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/models/customer_not_met_model.dart';
import 'package:origa/screen/address_screen/address_first_tab_screen.dart';
import 'package:origa/screen/address_screen/address_second_tab_screen.dart';
import 'package:origa/screen/address_screen/address_third_tab_screen.dart';
import 'package:origa/screen/address_screen/bloc/address_bloc.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/utils/string_resource.dart';
import 'package:origa/widgets/custom_appbar.dart';
import 'package:origa/widgets/custom_button.dart';
import 'package:origa/widgets/custom_text.dart';

class AddressScreen extends StatefulWidget {
  AddressScreen({Key? key}) : super(key: key);

  @override
  _AddressScreenState createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  late AddressBloc bloc;

  @override
  void initState() {
    bloc = AddressBloc()..add(AddressInitialEvent());
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
                }
              },
            ),
            BlocListener<AddressBloc, AddressState>(
              bloc: bloc,
              listener: (context, state) {},
              child: BlocBuilder<AddressBloc, AddressState>(
                bloc: bloc,
                builder: (context, state) {
                  return Expanded(
                      child: Container(
                    decoration: new BoxDecoration(
                        color: ColorResource.colorFFFFFF,
                        boxShadow: [
                          new BoxShadow(
                            color: ColorResource.colorCACACA.withOpacity(.25),
                            blurRadius: 2.0,
                            offset: Offset(1.0, 1.0),
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
                                      'ADDRESS 01',
                                      fontWeight: FontWeight.w700,
                                      fontSize: FontSize.fourteen,
                                      fontStyle: FontStyle.normal,
                                      color: ColorResource.color23375A,
                                    ),
                                    Wrap(
                                      spacing: 27,
                                      children: [
                                        Image.asset(ImageResource.activePerson),
                                        Image.asset(ImageResource.close)
                                      ],
                                    )
                                  ],
                                ),
                                Flexible(
                                  child: SizedBox(
                                    width: 255,
                                    child: CustomText(
                                      '2/345, 6th Main Road Gomathipuram, Madurai - 625032',
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
                                                    Image.asset(ImageResource
                                                        .direction),
                                                    SizedBox(width: 12),
                                                    CustomText(
                                                      Languages.of(context)!
                                                          .viewMap,
                                                      fontSize:
                                                          FontSize.fourteen,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: ColorResource
                                                          .color23375A,
                                                    )
                                                  ],
                                                )))),
                                    SizedBox(width: 40),
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
                                    Tab(text: StringResource.customerMet),
                                    Tab(text: StringResource.customerNotMet),
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
                                    AddressFirstTapScreen(
                                        bloc: bloc, context: context),
                                    AddressSecondTabScreen(
                                        context: context, bloc: bloc),
                                    AddressThirdTabScreen(
                                        context: context, bloc: bloc),
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
        // bottomNavigationBar: Container(
        //   height: MediaQuery.of(context).size.height * 0.12,
        //   decoration: BoxDecoration(
        //     color: ColorResource.colorFFFFFF,
        //     boxShadow: [
        //       new BoxShadow(
        //         color: ColorResource.color000000.withOpacity(.25),
        //         blurRadius: 2.0,
        //         offset: Offset(1.0, 1.0),
        //       ),
        //     ],
        //   ),
        //   width: double.infinity,
        //   child: Padding(
        //     padding: EdgeInsets.symmetric(horizontal: 85, vertical: 11.0),
        //     child: Container(
        //       decoration: BoxDecoration(),
        //       child: CustomButton(
        //         Languages.of(context)!.done.toUpperCase(),
        //         fontSize: FontSize.sixteen,
        //         fontWeight: FontWeight.w600,
        //         // onTap: () => bloc.add(ClickMessageEvent()),
        //         cardShape: 5,
        //       ),
        //     ),
        //   ),
        // ),
      ),
    );
  }
}
