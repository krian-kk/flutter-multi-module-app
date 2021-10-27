// ignore_for_file: unnecessary_new, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/models/customer_not_met_model.dart';
import 'package:origa/screen/address_screen/customer_met_screen.dart';
import 'package:origa/screen/address_screen/customer_not_met_screen.dart';
import 'package:origa/screen/address_screen/event_details_bottom_sheet.dart';
import 'package:origa/screen/address_screen/invalid_screen.dart';
import 'package:origa/screen/address_screen/bloc/address_bloc.dart';
import 'package:origa/utils/app_utils.dart';
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

class _AddressScreenState extends State<AddressScreen>
    with SingleTickerProviderStateMixin {
  late AddressBloc bloc;
  late TabController _controller;

  @override
  void initState() {
    bloc = AddressBloc()..add(AddressInitialEvent());
    super.initState();
    _controller = TabController(vsync: this, length: 3);
    _controller.addListener(_handleTabSelection);
  }

  _handleTabSelection() {
    if (_controller.indexIsChanging) {
      setState(() {});
    }
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
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.transparent,
        // backgroundColor: ColorResource.colorF7F8FA,
        body: DefaultTabController(
          length: 3,
          child: Container(
            decoration: new BoxDecoration(
                color: ColorResource.colorFFFFFF,
                boxShadow: [
                  new BoxShadow(
                    color: ColorResource.colorCACACA.withOpacity(.25),
                    blurRadius: 20.0,
                    offset: Offset(1.0, 1.0),
                  ),
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
                                          color: ColorResource.colorBEC4CF,
                                          borderRadius: new BorderRadius.all(
                                              new Radius.circular(75.0))),
                                      child: Row(
                                        children: [
                                          Image.asset(ImageResource.direction),
                                          SizedBox(width: 12),
                                          CustomText(
                                            Languages.of(context)!.viewMap,
                                            fontSize: FontSize.fourteen,
                                            fontWeight: FontWeight.w700,
                                            color: ColorResource.color23375A,
                                          )
                                        ],
                                      )))),
                          SizedBox(width: 40),
                          Expanded(
                              child: CustomButton(
                            Languages.of(context)!.eventDetails,
                            onTap: () => openEventDetailsBottomSheet(context),
                            textColor: ColorResource.color23375A,
                            borderColor: ColorResource.color23375A,
                            buttonBackgroundColor: ColorResource.colorFFFFFF,
                          ))
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom:
                              BorderSide(color: ColorResource.colorD8D8D8))),
                  child: TabBar(
                    isScrollable: true,
                    controller: _controller,
                    indicatorColor: ColorResource.colorD5344C,
                    labelStyle: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: ColorResource.color23375A,
                        fontSize: FontSize.fourteen,
                        fontStyle: FontStyle.normal),
                    indicatorWeight: 5.0,
                    labelColor: ColorResource.color23375A,
                    unselectedLabelColor: ColorResource.colorC4C4C4,
                    onTap: (index) {
                      bloc.customerNotMetNextActionDateFocusNode.unfocus();
                      bloc.customerNotMetRemarksFocusNode.unfocus();
                      bloc.invalidRemarksFocusNode.unfocus();
                    },
                    // ignore: prefer_const_literals_to_create_immutables
                    tabs: [
                      Tab(text: Languages.of(context)!.customerMet),
                      Tab(text: Languages.of(context)!.customerNotMet),
                      Tab(text: Languages.of(context)!.invalid)
                    ],
                  ),
                ),
                BlocListener<AddressBloc, AddressState>(
                  bloc: bloc,
                  listener: (context, state) {},
                  child: BlocBuilder<AddressBloc, AddressState>(
                    bloc: bloc,
                    builder: (context, state) {
                      return Expanded(
                          child: SingleChildScrollView(
                        // physics: NeverScrollableScrollPhysics(),
                        child: Column(
                          children: [
                            Column(children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.65,
                                child: TabBarView(
                                  controller: _controller,
                                  physics: NeverScrollableScrollPhysics(),
                                  children: [
                                    CustomerMetScreen(
                                        bloc: bloc, context: context),
                                    CustomerNotMetScreen(
                                        context: context, bloc: bloc),
                                    AddressInvalidScreen(
                                        context: context, bloc: bloc),
                                  ],
                                ),
                              ),
                            ])
                          ],
                        ),
                      ));
                    },
                  ),
                )
              ],
            ),
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
                  padding: EdgeInsets.symmetric(horizontal: 85, vertical: 11.0),
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
                        child: CustomButton(
                          Languages.of(context)!.submit.toUpperCase(),
                          fontSize: FontSize.sixteen,
                          fontWeight: FontWeight.w600,
                          onTap: () {
                            if (_controller.index == 1) {
                              if ((bloc.customerNotMetNextActionDateController ==
                                          '' ||
                                      bloc.customerNotMetNextActionDateController
                                          .text.isEmpty) ||
                                  (bloc.customerNotMetRemarksController.text ==
                                          '' ||
                                      bloc.customerNotMetRemarksController.text
                                          .isEmpty)) {
                                AppUtils.showSnackBar(
                                    context,
                                    'All are the Required Field Please Enter Any Text!'
                                        .toUpperCase(),
                                    true);
                              } else {
                                print('Successfull');
                              }
                            } else {
                              print(bloc.customerNotMetRemarksController.text);
                            }
                          },
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
            Languages.of(context)!.eventDetails.toUpperCase(), bloc);
      },
    );
  }
}
