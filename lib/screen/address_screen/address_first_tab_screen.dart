// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'package:flutter/material.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/screen/address_screen/bloc/address_bloc.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/utils/string_resource.dart';
import 'package:origa/widgets/custom_button.dart';
import 'package:origa/widgets/custom_read_only_text_field.dart';
import 'package:origa/widgets/custom_text.dart';

class AddressFirstTapScreen extends StatelessWidget {
  const AddressFirstTapScreen({
    Key? key,
    required this.bloc,
    required this.context,
  }) : super(key: key);

  final AddressBloc bloc;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(14, 0, 14, 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  GridView.builder(
                    itemCount: bloc.customerMetGridList.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3),
                    itemBuilder: (BuildContext context, int innerIndex) {
                      return Padding(
                        padding: const EdgeInsets.all(4.5),
                        child: GestureDetector(
                          onTap: () {
                            switch (
                                bloc.customerMetGridList[innerIndex].title) {
                              case StringResource.ptp:
                                openBottomSheet(context);
                                break;
                              default:
                            }
                          },
                          child: Container(
                            decoration: new BoxDecoration(
                                color: ColorResource.colorF8F9FB,
                                boxShadow: [
                                  BoxShadow(
                                    color: ColorResource.color000000
                                        .withOpacity(0.2),
                                    blurRadius: 2.0,
                                    offset: Offset(1.0,
                                        1.0), // shadow direction: bottom right
                                  )
                                ],
                                borderRadius: new BorderRadius.all(
                                    Radius.circular(10.0))),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                Image.asset(
                                    bloc.customerMetGridList[innerIndex].icon),
                                SizedBox(height: 8),
                                CustomText(
                                  bloc.customerMetGridList[innerIndex].title,
                                  color: ColorResource.color000000,
                                  fontSize: FontSize.twelve,
                                  fontWeight: FontWeight.w700,
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 30),
                  // Container(
                  //   decoration: new BoxDecoration(
                  //       color: ColorResource.colorF7F8FA,
                  //       borderRadius: new BorderRadius.all(Radius.circular(10.0))),
                  //   width: double.infinity,
                  //   height: 150,
                  //   child: Padding(
                  //     padding: const EdgeInsets.symmetric(
                  //         horizontal: 10.0, vertical: 19.0),
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       children: [
                  //         Column(
                  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //           children: [
                  //             Container(
                  //                 width: 150,
                  //                 height: 50,
                  //                 child: CustomButton(
                  //                   'REPO',
                  //                 )),
                  //             Container(
                  //                 width: 150,
                  //                 height: 50,
                  //                 child: CustomButton(
                  //                   'Add Contact',
                  //                 )),
                  //           ],
                  //         ),
                  //         Container(
                  //           height: 110,
                  //           width: 150,
                  //           decoration: new BoxDecoration(
                  //               color: ColorResource.color23375A,
                  //               borderRadius:
                  //                   new BorderRadius.all(Radius.circular(5.0))),
                  //           child: Column(
                  //             crossAxisAlignment: CrossAxisAlignment.center,
                  //             mainAxisAlignment: MainAxisAlignment.center,
                  //             children: [
                  //               Image.asset(ImageResource.captureImage),
                  //               SizedBox(height: 5),
                  //               CustomText(
                  //                 'CAPTURE \nIMAGE',
                  //                 textAlign: TextAlign.center,
                  //                 color: ColorResource.colorFFFFFF,
                  //                 fontSize: FontSize.sixteen,
                  //                 fontWeight: FontWeight.w600,
                  //               )
                  //             ],
                  //           ),
                  //         )
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  CustomButton(
                    Languages.of(context)!.captureImage.toUpperCase(),
                    cardShape: 75.0,
                    textColor: ColorResource.color23375A,
                    fontSize: FontSize.sixteen,
                    fontWeight: FontWeight.w700,
                    padding: 15.0,
                    borderColor: ColorResource.colorBEC4CF,
                    buttonBackgroundColor: ColorResource.colorBEC4CF,
                    isLeading: true,
                    // onTap: () => pickImage(source, cameraDialogueContext)
                    trailingWidget: Image.asset(ImageResource.capturImage),
                  ),
                  SizedBox(height: 20),
                  Wrap(
                    spacing: 15,
                    children: [
                      SizedBox(
                        width: 165,
                        child: CustomButton(
                          'ADD New contact',
                          textColor: ColorResource.color23375A,
                          borderColor: ColorResource.color23375A,
                          cardShape: 75,
                          buttonBackgroundColor: ColorResource.colorFFFFFF,
                        ),
                      ),
                      SizedBox(
                        width: 157,
                        child: CustomButton(
                          'Event Details',
                          textColor: ColorResource.color23375A,
                          borderColor: ColorResource.color23375A,
                          cardShape: 75,
                          buttonBackgroundColor: ColorResource.colorFFFFFF,
                        ),
                      ),
                      SizedBox(
                        width: 165,
                        child: CustomButton(
                          'OTHER FEEDBACK',
                          cardShape: 75,
                          textColor: ColorResource.color23375A,
                          borderColor: ColorResource.color23375A,
                          buttonBackgroundColor: ColorResource.colorFFFFFF,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
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
            padding: EdgeInsets.symmetric(horizontal: 0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 191,
                  child: CustomButton(
                    Languages.of(context)!.done.toUpperCase(),
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
      ],
    );
  }

  openBottomSheet(BuildContext buildContext) {
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
        switch ('1') {
          case '1':
            return CustomPtpBottomSheet();
          case '2':
            return CustomPtpBottomSheet();
          default:
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
        }
      },
    );
  }
}

class CustomPtpBottomSheet extends StatelessWidget {
  CustomPtpBottomSheet({
    Key? key,
  }) : super(key: key);

  TextEditingController ptpDateControlller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.88,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(23, 16, 15, 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText('Ptp'),
                GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Image.asset(ImageResource.close))
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      decoration: new BoxDecoration(
                          color: ColorResource.colorF7F8FA,
                          // ignore: unnecessary_new
                          borderRadius:
                              new BorderRadius.all(Radius.circular(10.0))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 14),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomText(
                              'DEBASISH PATNAIK',
                              fontWeight: FontWeight.w700,
                              fontSize: FontSize.fourteen,
                              fontStyle: FontStyle.normal,
                            ),
                            SizedBox(height: 7),
                            CustomText(
                              'TVSF_BFRT6458922993',
                              fontWeight: FontWeight.w400,
                              fontSize: FontSize.fourteen,
                              fontStyle: FontStyle.normal,
                            ),
                            SizedBox(height: 17),
                            CustomText(
                              'Overdue Amount',
                              fontWeight: FontWeight.w400,
                              fontSize: FontSize.twelve,
                              fontStyle: FontStyle.normal,
                            ),
                            SizedBox(height: 9),
                            CustomText(
                              '397553.67',
                              fontWeight: FontWeight.w700,
                              fontSize: FontSize.twentyFour,
                              fontStyle: FontStyle.normal,
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 11),
                    Row(
                      children: [
                        Flexible(
                            child: CustomReadOnlyTextField(
                          'PTP Date*',
                          ptpDateControlller,
                          isLabel: true,
                        )),
                        SizedBox(width: 7),
                        Flexible(
                            child: CustomReadOnlyTextField(
                          'PTP Date*',
                          ptpDateControlller,
                          isLabel: true,
                        ))
                      ],
                    ),
                    SizedBox(height: 15),
                    Flexible(
                        child: CustomReadOnlyTextField(
                      'PTP Date*',
                      ptpDateControlller,
                      isLabel: true,
                    )),
                    SizedBox(height: 15),
                    CustomText('Payment Mode'),
                    SizedBox(height: 3),
                    Row(
                      children: [
                        Flexible(
                          child: Container(
                            width: double.infinity,
                            height: 50,
                            decoration: new BoxDecoration(
                                color: ColorResource.color23375A,
                                boxShadow: [
                                  BoxShadow(
                                    color: ColorResource.color000000
                                        .withOpacity(0.2),
                                    blurRadius: 2.0,
                                    offset: Offset(1.0,
                                        1.0), // shadow direction: bottom right
                                  )
                                ],
                                borderRadius: new BorderRadius.all(
                                    Radius.circular(50.0))),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 20,
                                    backgroundColor: ColorResource.colorFFFFFF,
                                    child: Center(
                                      child: Image.asset(ImageResource.money),
                                    ),
                                  ),
                                  SizedBox(width: 7),
                                  CustomText('PICK-UP',
                                      color: ColorResource.colorFFFFFF)
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 18),
                        Flexible(
                          child: Container(
                            width: double.infinity,
                            height: 50,
                            decoration: new BoxDecoration(
                                color: ColorResource.color23375A,
                                boxShadow: [
                                  BoxShadow(
                                    color: ColorResource.color000000
                                        .withOpacity(0.2),
                                    blurRadius: 2.0,
                                    offset: Offset(1.0,
                                        1.0), // shadow direction: bottom right
                                  )
                                ],
                                borderRadius: new BorderRadius.all(
                                    Radius.circular(50.0))),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 20,
                                    backgroundColor: ColorResource.colorFFFFFF,
                                    child: Center(
                                      child: Image.asset(ImageResource.money),
                                    ),
                                  ),
                                  SizedBox(width: 7),
                                  CustomText('PICK-UP',
                                      color: ColorResource.colorFFFFFF)
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 21),
                    CustomReadOnlyTextField(
                      'Reference*',
                      ptpDateControlller,
                      isLabel: true,
                    ),
                    SizedBox(height: 20),
                    CustomReadOnlyTextField(
                      'Reference*',
                      ptpDateControlller,
                      isLabel: true,
                    ),
                    SizedBox(height: 15)
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.1,
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
                      width: 95, child: Center(child: CustomText('CANCEL'))),
                  SizedBox(width: 25),
                  Container(
                    width: 191,
                    decoration: BoxDecoration(),
                    child: CustomButton(
                      'submit'.toUpperCase(),
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
        ],
      ),
    );
  }
}
