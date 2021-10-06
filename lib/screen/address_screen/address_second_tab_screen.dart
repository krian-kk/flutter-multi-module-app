// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'package:flutter/material.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/screen/address_screen/bloc/address_bloc.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/utils/string_resource.dart';
import 'package:origa/widgets/custom_button.dart';
import 'package:origa/widgets/custom_text.dart';

class AddressSecondTabScreen extends StatelessWidget {
  const AddressSecondTabScreen({
    Key? key,
    required this.context,
    required this.bloc,
  }) : super(key: key);

  final BuildContext context;
  final AddressBloc bloc;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Wrap(
                    spacing: 10,
                    children: [
                      //-------------------------------------------------------------------------------------------------
                      // ListView.builder(
                      //     physics: NeverScrollableScrollPhysics(),
                      //     shrinkWrap: true,
                      //     itemCount: 3,
                      //     itemBuilder: (context, i) {
                      //       return SizedBox(
                      //         width: 20,
                      //         child: CustomButton(
                      //           'LEFT MESSAGE',
                      //           textColor: ColorResource.color000000,
                      //           borderColor: ColorResource.colorE7E7E7,
                      //           buttonBackgroundColor:
                      //               ColorResource.colorFFB800.withOpacity(0.67),
                      //         ),
                      //       );
                      //     }),
                      Container(
                        width: 139,
                        child: CustomButton(
                          'LEFT MESSAGE',
                          textColor: ColorResource.color000000,
                          borderColor: ColorResource.colorE7E7E7,
                          buttonBackgroundColor:
                              ColorResource.colorFFB800.withOpacity(0.67),
                        ),
                      ),
                      Container(
                        width: 162,
                        child: CustomButton(
                          'DOOR LOCKED',
                          buttonBackgroundColor: ColorResource.colorE7E7E7,
                          borderColor: ColorResource.colorE7E7E7,
                          textColor: ColorResource.color000000,
                        ),
                      ),
                      Container(
                        width: 171,
                        child: CustomButton(
                          'ENTRY RESTRICTED',
                          textColor: ColorResource.color000000,
                          borderColor: ColorResource.colorE7E7E7,
                          buttonBackgroundColor: ColorResource.colorE7E7E7,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 25),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: CustomText('NEXT ACTION DATE*')),
                  Container(
                    width: (MediaQuery.of(context).size.width - 62) / 2,
                    child: TextField(
                      //controller: loanDurationController,
                      decoration: new InputDecoration(
                          suffixIcon: GestureDetector(
                              onTap: () {},
                              child: const Icon(Icons.calendar_today)),
                          labelText: StringResource.loanDuration,
                          focusColor: ColorResource.colorE5EAF6,
                          labelStyle:
                              new TextStyle(color: const Color(0xFF424242))),
                    ),
                  ),
                  SizedBox(height: 27),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: CustomText('REMARKS*')),
                  Container(
                    width: double.infinity,
                    child: TextField(
                      //controller: loanDurationController,
                      decoration: new InputDecoration(
                          labelText: 'Write your remarks here',
                          focusColor: ColorResource.colorE5EAF6,
                          labelStyle:
                              new TextStyle(color: const Color(0xFF424242))),
                    ),
                  ),
                  TextField(),
                  SizedBox(height: 19),
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
            padding: EdgeInsets.symmetric(horizontal: 85, vertical: 11.0),
            child: Container(
              decoration: BoxDecoration(),
              child: CustomButton(
                Languages.of(context)!.done.toUpperCase(),
                fontSize: FontSize.sixteen,
                fontWeight: FontWeight.w600,
                // onTap: () => bloc.add(ClickMessageEvent()),
                cardShape: 5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
