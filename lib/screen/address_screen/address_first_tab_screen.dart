// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'package:flutter/material.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/screen/address_screen/bloc/address_bloc.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/widgets/custom_button.dart';
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
              // ignore: unnecessary_new
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
}
