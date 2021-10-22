// ignore_for_file: prefer_const_constructors, unnecessary_new, must_be_immutable, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/screen/address_screen/bloc/address_bloc.dart';
import 'package:origa/screen/address_screen/capture_image_bottom_sheet.dart';
import 'package:origa/screen/address_screen/collections_bottom_sheet.dart';
import 'package:origa/screen/address_screen/dispute_bottom_sheet.dart';
import 'package:origa/screen/address_screen/other_feed_back_bottom_sheet.dart';
import 'package:origa/screen/address_screen/ots_bottom_sheet.dart';
import 'package:origa/screen/address_screen/ptp_bottom_sheet.dart';
import 'package:origa/screen/address_screen/remainder_bottom_sheet.dart';
import 'package:origa/screen/address_screen/repo_bottom_sheet.dart';
import 'package:origa/screen/address_screen/rtp_bottom_sheet.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/utils/string_resource.dart';
import 'package:origa/widgets/custom_button.dart';
import 'package:origa/widgets/custom_text.dart';

class CustomerMetScreen extends StatefulWidget {
  const CustomerMetScreen({
    Key? key,
    required this.bloc,
    required this.context,
  }) : super(key: key);

  final AddressBloc bloc;
  final BuildContext context;

  @override
  State<CustomerMetScreen> createState() => _CustomerMetScreenState();
}

class _CustomerMetScreenState extends State<CustomerMetScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(14, 0, 14, 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  GridView.builder(
                    itemCount: widget.bloc.customerMetGridList.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3),
                    itemBuilder: (BuildContext context, int innerIndex) {
                      return Padding(
                        padding: const EdgeInsets.all(4.5),
                        child: GestureDetector(
                          onTap: () {
                            switch (widget
                                .bloc.customerMetGridList[innerIndex].title) {
                              case StringResource.ptp:
                                openBottomSheet(context, StringResource.ptp,);
                                break;
                              case StringResource.rtp:
                                openBottomSheet(context, StringResource.rtp);
                                break;
                              case StringResource.dispute:
                                openBottomSheet(
                                    context, StringResource.dispute);
                                break;
                              case StringResource.remainder:
                                openBottomSheet(
                                    context, StringResource.remainder);
                                break;
                              case StringResource.collections:
                                openBottomSheet(
                                    context, StringResource.collections);
                                break;
                              case StringResource.ots:
                                openBottomSheet(context, StringResource.ots);
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
                                Image.asset(widget
                                    .bloc.customerMetGridList[innerIndex].icon),
                                SizedBox(height: 8),
                                CustomText(
                                  widget.bloc.customerMetGridList[innerIndex]
                                      .title,
                                  color: ColorResource.color000000,
                                  fontSize: FontSize.twelve,
                                  fontWeight: FontWeight.w700,
                                  fontStyle: FontStyle.normal,
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 30),
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
                    onTap: () =>
                        openBottomSheet(context, StringResource.captureImage),
                    trailingWidget: Image.asset(ImageResource.capturImage),
                  ),
                  SizedBox(height: 20),
                  Wrap(
                    spacing: 11,
                    runSpacing: 4,
                    children: [
                      SizedBox(
                        width: 165,
                        child: CustomButton(
                          Languages.of(context)!.addNewContact.toUpperCase(),
                          textColor: ColorResource.color23375A,
                          borderColor: ColorResource.color23375A,
                          fontSize: FontSize.twelve,
                          cardShape: 75,
                          buttonBackgroundColor: ColorResource.colorFFFFFF,
                        ),
                      ),
                      SizedBox(
                        width: 157,
                        child: CustomButton(
                          Languages.of(context)!.repo.toUpperCase(),
                          onTap: () =>
                              openBottomSheet(context, StringResource.repo),
                          textColor: ColorResource.color23375A,
                          borderColor: ColorResource.color23375A,
                          fontSize: FontSize.twelve,
                          fontWeight: FontWeight.w700,
                          cardShape: 75,
                          buttonBackgroundColor: ColorResource.colorFFFFFF,
                        ),
                      ),
                      SizedBox(
                        width: 165,
                        child: CustomButton(
                          Languages.of(context)!.otherFeedBack.toUpperCase(),
                          onTap: () => openBottomSheet(
                              context, StringResource.otherFeedback),
                          cardShape: 75,
                          fontSize: FontSize.twelve,
                          textColor: ColorResource.color23375A,
                          borderColor: ColorResource.color23375A,
                          buttonBackgroundColor: ColorResource.colorFFFFFF,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 30)
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

  openBottomSheet(BuildContext buildContext, String cardTitle) {
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
        switch (cardTitle) {
          case StringResource.ptp:
            return CustomPtpBottomSheet(Languages.of(context)!.ptp);
          case StringResource.rtp:
            return CustomRtpBottomSheet(Languages.of(context)!.rtp);
          case StringResource.dispute:
            return CustomDisputeBottomSheet(Languages.of(context)!.dispute);
          case StringResource.remainder:
            return CustomRemainderBottomSheet(
                Languages.of(context)!.remainderCb);
          case StringResource.collections:
            return CustomCollectionsBottomSheet(
                Languages.of(context)!.collections);
          case StringResource.ots:
            return CustomOtsBottomSheet(Languages.of(context)!.ots);
          case StringResource.repo:
            return CustomRepoBottomSheet(Languages.of(context)!.repo);
          case StringResource.captureImage:
            return CustomCaptureImageBottomSheet(
                Languages.of(context)!.captureImage);
          case StringResource.otherFeedback:
            return CustomOtherFeedBackBottomSheet(
                Languages.of(context)!.otherFeedBack, widget.bloc);
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
